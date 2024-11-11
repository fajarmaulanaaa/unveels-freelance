import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/configs/color_config.dart';
import '../cubit/pf_bloc.dart';
import '../models/pf_model.dart';
import 'pf_alaysis_details_widget.dart';

class PFPersonalityAnalysisWidget extends StatefulWidget {
  final PfState pfState;

  const PFPersonalityAnalysisWidget({
    Key? key,
    required this.pfState,
  }) : super(key: key);

  @override
  _PFPersonalityAnalysisWidgetState createState() => _PFPersonalityAnalysisWidgetState();
}

class _PFPersonalityAnalysisWidgetState extends State<PFPersonalityAnalysisWidget> {
  List<String> label = [];
  Map<String, double> outputData = {};
  final List<Color> colors = [
    ColorConfig.yellow,
    ColorConfig.pink,
    ColorConfig.oceanBlue,
    ColorConfig.green,
    ColorConfig.purple,
  ];

  @override
  void initState() {
    super.initState();
    _getOutputDataForTitle();
  }

  void _getOutputDataForTitle() {
    final model = widget.pfState.resultPersonalityModel!.firstWhere(
          (model) => model.name == "Personality Finder",
      orElse: () => ResultPersonalityModel(
        name: "Personality Finder",
        outputName: "",
        labels: [],
        outputLabel: "",
      ),
    );

    label = model.labels!;
    outputData = model.outputData!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Center(
            child: Text(
              "Main 5 Personality Traits",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                for (int i = 0; i < label.length; i++)
                  _CircularChartBarWidget(
                    height: 140 + i * 20.0,
                    width: 140 + i * 20.0,
                    color: colors[i],
                    value: outputData[i.toString()] ?? 0.0,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      for (int i = 0; i < (label.length + 1) ~/ 2; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: _LegendItemWidget(
                            color: colors[i],
                            value: (outputData[i.toString()]! * 100).toInt(),
                            label: label[i],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      for (int i = (label.length + 1) ~/ 2; i < label.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: _LegendItemWidget(
                            color: colors[i],
                            value: (outputData[i.toString()]! * 100).toInt(),
                            label: label[i],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            )
          ),
          for (int i = 0; i < label.length; i++)
            PFAnalysisDetailsWidget(
              title: label[i],
              description: _getDescriptionForTrait(label[i]),
              severityValue: (outputData[i.toString()]! * 100).toInt(),
            )
        ],
      ),
    );
  }

  String _getDescriptionForTrait(String trait) {
    switch (trait) {
      case "Open":
        return "People with an open personality are known for their vibrant imagination, curiosity, and eagerness to explore new ideas and experiences. You have a strong desire for novelty and diversity, and you're open to different perspectives and ways of thinking. With the trait of openness, you tend to be creative, flexible, and adaptable and are often receptive to change and innovation.\nYou're obsessed with discovering new cultures, concepts, and opportunities, and are willing to challenge conventional norms and beliefs. Overall, those with an open personality bring a sense of wonder and enthusiasm to their interactions and endeavours. Thus, here is your recommendation list from Unveels based on having an Open Personality.";
      case "Neurotic":
        return "Neuroticism , as a personality trait, reflects an individual's tendency to experience negative emotions such as anxiety, depression, and moodiness. People high in neuroticism may be more prone to worry, stress, and self-doubt, they often react strongly to perceived threats or challenges. Those low in neuroticism, on the other hand, tend to be more emotionally stable and resilient in the face of adversity. Thus, here's your bespoke recommendation list from Unveels based on your Neuroticism.";
      case "Agreable":
        return "People with an agreeable personality reveal their kind-hearted and compassionate nature; characterized by a strong desire to maintain harmonious relationships.\nPeople high in agreeableness are often cooperative, empathetic, and considerate towards others; making them valuable team players and supportive friends.\nThey prioritize the needs of others and are willing to go out of their way to help and support those around them. Their warm and nurturing behaviour makes them approachable and easy to get along with, fostering a sense of trust and camaraderie in their social interactions.\n\nIn short, your agreeable personality is a key aspect of your character and it influences your interactions and relationships with others.\nUnveels has prepared a customized recommendation list based on your agreeable personality.";
      case "Extravert":
        return "An extravert personality provides insights into an individual's social behaviour and interaction preferences.\nExtraverts are known for their outgoing, energetic, and talkative nature. They thrive in social settings, seek excitement, and enjoy being the center of attention. Extraverts are often described as sociable, assertive, and enthusiastic individuals who are comfortable in group settings and have a wide circle of friends.\nThis also delves into the extraversion traits; highlighting that they're strong in communication, leadership, and relationship-building skills.\nTherefore, here's what Unveels suggests for you based on your Extraversion.";
      case "Conscientious":
        return "Conscientiousness is a key personality trait that reflects an individual's tendency to be organized, responsible, and goal-oriented. People high in conscientiousness are known for their reliability, diligence, and attention to detail; moreover, they're often diligent in their work, follow through on tasks, and are typically well-prepared.\n\nUnveels has unveiled the Conscientious side of your personality; and here's your recommended list based on it.";
      default:
        return "";
    }
  }

}

class _LegendItemWidget extends StatelessWidget {
  final Color color;
  final int value;
  final String label;

  const _LegendItemWidget({
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "$value%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _CircularChartBarWidget extends StatelessWidget {
  final double height, width, value;
  final Color color;

  const _CircularChartBarWidget({
    required this.height,
    required this.width,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Transform.rotate(
        angle: 1.5,
        child: CircularProgressIndicator(
          color: color,
          value: value,
          strokeCap: StrokeCap.round,
          strokeWidth: 6,
        ),
      ),
    );
  }
}
