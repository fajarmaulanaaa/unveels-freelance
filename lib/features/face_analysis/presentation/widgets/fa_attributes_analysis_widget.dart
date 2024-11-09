import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../cubit/fa_bloc.dart';
import '../models/fa_model.dart';

class FAAttributesAnalysisWidget extends StatelessWidget {
  final FaState faState;

  const FAAttributesAnalysisWidget({
    Key? key,
    required this.faState,
  }) : super(key: key);

  String _getOutputLabelForTitle(String title) {
    final model = faState.resultFaceAnalyzeModel!.firstWhere(
          (model) => model.name == title,
      orElse: () => ResultFaceAnalyzeModel(name: title, outputName: "", labels: [], outputLabel: ""),
    );
    return (model.outputLabel == null || model.outputLabel!.isEmpty) ? "N/A" : model.outputLabel!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: SizeConfig.horizontalPadding,
      ),
      child: Column(
        children: [
          _BodyItemWidget(
            title: "Face",
            iconPath: IconPath.face,
            leftChildren: [
              _DetailBodyItem(
                title: "Face Shape",
                value: _getOutputLabelForTitle("Face Shape"),
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Skin Tone",
                value: _getOutputLabelForTitle("Skin Tone"),
              ),
            ],
          ),
          const Divider(height: 50),
          _BodyItemWidget(
            title: "Eyes",
            iconPath: IconPath.eye,
            leftChildren: [
              _DetailBodyItem(
                title: "Eye Shape",
                value: _getOutputLabelForTitle("Eye Shape"),
              ),
              _DetailBodyItem(
                title: "Eye Angle",
                value: _getOutputLabelForTitle("Eye Angle"),
              ),
              _DetailBodyItem(
                title: "Eyelid",
                value: _getOutputLabelForTitle("Eye Lid"),
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Eye Size",
                value: _getOutputLabelForTitle("Eye Size"),
              ),
              _DetailBodyItem(
                title: "Eye Distance",
                value: _getOutputLabelForTitle("Eye Distance"),
              ),
              _DetailBodyItem(
                title: "Eye Color",
                value: _getOutputLabelForTitle("Eye Color"),
              ),
            ],
          ),
          const Divider(height: 50),
          _BodyItemWidget(
            title: "Brows",
            iconPath: IconPath.brow,
            leftChildren: [
              _DetailBodyItem(
                title: "Eyebrow Shape",
                value: _getOutputLabelForTitle("Eyebrow Shape"),
              ),
              _DetailBodyItem(
                title: "Eyebrow Distance",
                value: _getOutputLabelForTitle("Eyebrow Distance"),
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Thickness",
                value: _getOutputLabelForTitle("Thickness"),
              ),
              _DetailBodyItem(
                title: "Eyebrow Color",
                valueWidget: Container(
                  height: 28,
                  color: Color(int.tryParse(_getOutputLabelForTitle("Eyebrow Color")) ?? 0xFF473209),
                ),
              ),
            ],
          ),
          const Divider(height: 50),
          _BodyItemWidget(
            title: "Lips",
            iconPath: IconPath.lip,
            leftChildren: [
              _DetailBodyItem(
                title: "Lip Shape",
                value: _getOutputLabelForTitle("Lip Shape"),
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Lip Color",
                valueWidget: Container(
                  height: 28,
                  color: Color(int.tryParse(_getOutputLabelForTitle("Lip Color")) ?? 0xFF473209),
                ),
              ),
            ],
          ),
          const Divider(height: 50),
          _BodyItemWidget(
            title: "Cheekbones",
            iconPath: IconPath.cheekbones,
            leftChildren: [
              _DetailBodyItem(
                title: "Cheekbones",
                value: _getOutputLabelForTitle("Cheeks Bones"),
              ),
            ],
          ),
          const Divider(height: 50),
          _BodyItemWidget(
            title: "Nose",
            iconPath: IconPath.nose,
            leftChildren: [
              _DetailBodyItem(
                title: "Nose Shape",
                value: _getOutputLabelForTitle("Nose Shape"),
              ),
            ],
          ),
          const Divider(height: 50),
          _BodyItemWidget(
            title: "Hair",
            iconPath: IconPath.hair,
            leftChildren: [
              _DetailBodyItem(
                title: "Face Shape",
                valueWidget: Container(
                  height: 28,
                  color: Color(int.tryParse(_getOutputLabelForTitle("Face Shape")) ?? 0xFF473209),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyItemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final List<Widget> leftChildren;
  final List<Widget> rightChildren;

  const _BodyItemWidget({
    required this.iconPath,
    required this.title,
    this.leftChildren = const [],
    this.rightChildren = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: leftChildren.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return leftChildren[index];
                },
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: rightChildren.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return rightChildren[index];
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DetailBodyItem extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;

  const _DetailBodyItem({
    required this.title,
    this.value,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        if (valueWidget != null) ...[
          const SizedBox(
            height: 4,
          ),
          valueWidget!,
        ],
        if (value != null) ...[
          const SizedBox(
            height: 4,
          ),
          Text(
            "• $value",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
}
