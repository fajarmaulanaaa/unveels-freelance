import 'dart:convert';
import 'dart:typed_data'; // For Uint8List

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unveels/features/face_analysis/presentation/cubit/fa_bloc.dart';
import 'package:unveels/features/face_analysis/presentation/models/fa_model.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/fa_tab_bar_parsing.dart';
import '../../../../shared/extensions/pf_tab_bar_parsing.dart';
import 'fa_attributes_analysis_widget.dart';
import 'fa_personality_analysis_widget.dart';
import 'fa_recommendations_analysis_widget.dart';

class FAAnalysisResultsWidget extends StatefulWidget {
  final FaState faState;
  const FAAnalysisResultsWidget({super.key, required this.faState});

  @override
  State<FAAnalysisResultsWidget> createState() =>
      _FAAnalysisResultsWidgetState();
}

class _FAAnalysisResultsWidgetState extends State<FAAnalysisResultsWidget> {
  String? _getImageData() {
    final model = widget.faState.resultFaceAnalyzeModel!.firstWhere(
          (model) => model.name == "Image Data",
      orElse: () => ResultFaceAnalyzeModel(name: "Image Data", outputName: "", labels: [], outputLabel: ""),
    );
    return model.imageData;
  }

  String? _getPersonalityLabel() {
    final model = widget.faState.resultFaceAnalyzeModel!.firstWhere(
          (model) => model.name == "Personality Finder",
      orElse: () => ResultFaceAnalyzeModel(name: "Personality Finder", outputName: "", labels: [], outputLabel: ""),
    );
    return model.outputLabel;
  }

  @override
  Widget build(BuildContext context) {
    String? imageData = _getImageData();

    // If the imageData is base64-encoded, decode it
    Uint8List? imageBytes;
    if (imageData != null && imageData.startsWith('data:image/jpeg;base64,')) {
      // Extract the base64 string part (after 'data:image/jpeg;base64,')
      String base64String = imageData.split('data:image/jpeg;base64,').last;
      imageBytes = base64Decode(base64String); // Decode base64 string to bytes
    }

    return Container(
      padding: const EdgeInsets.only(
        top: 30, // padding to recording controller buttons
      ),
      color: Colors.black,
      child: DefaultTabController(
        length: PFTabBar.values.length,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.horizontalPadding,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      // Display the image using Image.memory
                      imageBytes != null
                          ? Image.memory(
                        imageBytes,
                        width: 108,
                        height: 108,
                      )
                          : Image.asset(
                        ImagePath.saFaceExample,
                        width: 108,
                        height: 108,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        _getPersonalityLabel() ?? "Extravert",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconPath.hasTagCircle,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AI Personality Analysis :",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Your face attributes indicate you enjoy interacting with people and are full of energy. Extraversions tend to be enthusiastic, action-oriented, and very social. You're the friendly, inviting individual who likes to talk and connect with people.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: const Color(0xFF9E9E9E),
              labelColor: ColorConfig.primary,
              indicatorColor: ColorConfig.primary,
              labelStyle: const TextStyle(
                fontSize: 16,
              ),
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              dividerColor: const Color(0xFF9E9E9E),
              dividerHeight: 1.5,
              tabs: PFTabBar.values.map((e) {
                return Tab(
                  text: e.title,
                );
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const FAPersonalityAnalysisWidget(),
                  FAAttributesAnalysisWidget(faState: widget.faState),
                  const FaRecommendationsAnalysisWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
