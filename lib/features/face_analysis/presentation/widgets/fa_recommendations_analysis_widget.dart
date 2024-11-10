import 'package:flutter/material.dart';

import '../../../../shared/configs/size_config.dart';
import '../cubit/fa_bloc.dart';
import 'fa_product_item_widget.dart';

class FaRecommendationsAnalysisWidget extends StatelessWidget {
  final FaState faState;

  const FaRecommendationsAnalysisWidget({super.key, required this.faState});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductItemWidget(
            title: "Perfumes Recommendations",
            faState: faState,
          ),
          const SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Look Recommendations",
            description:
            "A bold red lipstick and defined brows, mirror your strong, vibrant personality",
            faState: faState,
          ),
          const SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Lip Color Recommendations",
            description: "The best lip color for you are orange shades",
            faState: faState,
          ),
          const SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Accessories Recommendations",
            faState: faState,
          ),
        ],
      ),
    );
  }
}

class _ProductItemWidget extends StatelessWidget {
  final String title;
  final String? description;
  final FaState faState;

  const _ProductItemWidget({
    required this.title,
    required this.faState,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (description != null) ...[
                const SizedBox(
                  height: 6,
                ),
                Text(
                  description!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 242,
          child: ListView.separated(
            itemCount: faState.productData!.items.length,
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
              final isEnd = index == faState.productData!.items.length - 1;

              // Extracting item properties
              final item = faState.productData!.items[index];
              final productName = item.name;
              final brandName = "Brand Name";
              final price = item.price?.toString();
              final originalPrice = item.price?.toString().toString();
              final imagePath = item.mediaGalleryEntries[0].file;

              return Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? SizeConfig.horizontalPadding : 0,
                  right: isEnd ? SizeConfig.horizontalPadding : 0,
                ),
                child: FAProductItemWidget(
                  productName: productName,
                  brandName: brandName,
                  price: price!,
                  originalPrice: originalPrice!,
                  imagePath: imagePath,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}