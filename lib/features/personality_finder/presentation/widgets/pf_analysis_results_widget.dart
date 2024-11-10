import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For Uint8List

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unveels/features/personality_finder/presentation/cubit/pf_bloc.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/pf_tab_bar_parsing.dart';
import '../models/pf_model.dart';
import 'pf_attributes_analysis_widget.dart';
import 'pf_personality_analysis_widget.dart';
import 'pf_recommendations_analysis_widget.dart';

class PFAnalysisResultsWidget extends StatefulWidget {
  final PfState pfState;
  const PFAnalysisResultsWidget({super.key, required this.pfState});

  @override
  State<PFAnalysisResultsWidget> createState() =>
      _PFAnalysisResultsWidgetState();
}

class _PFAnalysisResultsWidgetState extends State<PFAnalysisResultsWidget> {

  String? _getImageData() {
    final model = widget.pfState.resultPersonalityModel!.firstWhere(
          (model) => model.name == "Image Data",
      orElse: () => ResultPersonalityModel(name: "Image Data", outputName: "", labels: [], outputLabel: ""),
    );
    return model.imageData;
  }

  String? _getPersonalityLabel() {
    final model = widget.pfState.resultPersonalityModel!.firstWhere(
          (model) => model.name == "Personality Finder",
      orElse: () => ResultPersonalityModel(name: "Personality Finder", outputName: "", labels: [], outputLabel: ""),
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
                  const PFPersonalityAnalysisWidget(),
                  PFAttributesAnalysisWidget(pfState: widget.pfState),
                  PfRecommendationsAnalysisWidget(pfState: widget.pfState),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
