import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unveels/features/skin_tone_finder/presentation/cubit/stf_bloc.dart';
import 'package:unveels/features/skin_tone_finder/presentation/widgets/stf_empty_product.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/tone_tab_parsing.dart';
import 'stf_product_item_widget.dart';

class STFShadesWidget extends StatefulWidget {
  final Function()? onViewAll;

  const STFShadesWidget({
    super.key,
    this.onViewAll,
  });

  @override
  State<STFShadesWidget> createState() => _STFShadesWidgetState();
}

class _STFShadesWidgetState extends State<STFShadesWidget> {
  // ToneTab? _selectedToneTab;

  @override
  void initState() {
    super.initState();
  }

  void _refreshProduct() {
    context.read<StfBloc>().add(FetchProduct());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StfBloc, StfState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding,
            ),
            child: Column(
              children: [
                //tab
                Row(
                  children: [
                    Expanded(
                      child: _ToneTabItemWidget(
                        tab: ToneTab.values.first,
                        isSelected: state.activeTab == 0,
                        onTap: (value) {
                          context.read<StfBloc>().add(ChangeTabActive(0));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                      child: VerticalDivider(),
                    ),
                    Expanded(
                      child: _ToneTabItemWidget(
                        tab: ToneTab.values.last,
                        isSelected: state.activeTab == 1,
                        onTap: (value) {
                          context.read<StfBloc>().add(ChangeTabActive(1));
                        },
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //skin tone

          state.activeTab == 0
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          width: context.width / 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.horizontalPadding,
                              right: SizeConfig.horizontalPadding,
                            ),
                            child: _SkinToneItemWidget(
                              title: state.skinType ?? '',
                              color: const Color(0xFF8F4F36).withOpacity(
                                0.8,
                              ),
                              isSelected: true,
                              onTap: (value) {
                                // if (value != _selectedSkinTone) {
                                //   setState(() {
                                //     _selectedSkinTone = value;
                                //   });
                                // }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    state.matchedTones == null
                        ? const SizedBox()
                        : Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: state.matchedTones!.map((matchedTone) {
                              final isSelected = matchedTone["value"] ==
                                  state.selectToneSkinId;
                              final opacity = (1 -
                                  state.matchedTones!.indexOf(matchedTone) /
                                      10);

                              return _MatchedToneItemWidget(
                                title: matchedTone["label"] ?? "",
                                color: const Color(0xFFCB8B5E).withOpacity(
                                  opacity,
                                ),
                                isSelected: isSelected,
                                width: (context.width * 0.9) /
                                    state.matchedTones!.length,
                                onTap: (value) {
                                  final newValue = state.matchedTones!
                                      .where((e) => e['label'] == value)
                                      .map((e) => e['value'])
                                      .toList();
                                  print(newValue[0]);
                                  if (newValue.isNotEmpty) {
                                    context
                                        .read<StfBloc>()
                                        .add(UpdateSelectSkinId(newValue[0]!));
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      context
                                          .read<StfBloc>()
                                          .add(FetchProduct());
                                    });
                                  }
                                },
                              );
                            }).toList(),
                          ),
                  ],
                )
              : Column(
                  children: [],
                ),

          const SizedBox(
            height: 10,
          ),

          //product
          state.loadingProduct!
              ? const SizedBox(
                  height: 150,
                  child: Center(child: CircularProgressIndicator()))
              : state.productData != null &&
                      state.productData!.items.length != 0
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: widget.onViewAll,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: SizeConfig.horizontalPadding,
                              ),
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 130,
                          child: ListView.separated(
                            itemCount: state.productData!.items.length,
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                            itemBuilder: (context, index) {
                              final isFirst = index == 0;
                              final isEnd =
                                  index == state.productData!.items.length - 1;

                              final product = state.productData!.items[index];

                              return Padding(
                                padding: EdgeInsets.only(
                                  left: isFirst
                                      ? SizeConfig.horizontalPadding
                                      : 0,
                                  right:
                                      isEnd ? SizeConfig.horizontalPadding : 0,
                                ),
                                child: STFProductItemWidget(
                                  productName: product.name,
                                  brandName: "Brand Name",
                                  price: product.price.toString(),
                                  originalPrice:
                                      product.price.toString().toString(),
                                  imagePath:
                                      product.mediaGalleryEntries[0].file,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  : const EmptyProductWidget()
        ],
      );
    });
  }
}

class _ToneTabItemWidget extends StatelessWidget {
  final ToneTab tab;
  final bool isSelected;
  final Function(ToneTab value) onTap;

  const _ToneTabItemWidget({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(tab);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
        ),
        child: Center(
          child: Text(
            tab.title,
            style: TextStyle(
              fontSize: 18,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkinToneItemWidget extends StatelessWidget {
  final String title;
  final Color color;
  final bool isSelected;
  final Function(String value) onTap;

  const _SkinToneItemWidget({
    required this.title,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 1,
                    ),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchedToneItemWidget extends StatelessWidget {
  final String title;
  final Color color;
  final bool isSelected;
  final Function(String value) onTap;
  final double width;

  const _MatchedToneItemWidget({
    required this.title,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Container(
        height: isSelected ? 40 : 26,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
