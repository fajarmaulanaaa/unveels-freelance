// To parse this JSON data, do
//
//     final resultFaceAnalyzeModel = resultFaceAnalyzeModelFromJson(jsonString);

import 'dart:convert';

List<ResultFaceAnalyzeModel> resultFaceAnalyzeModelFromJson(String str) => List<ResultFaceAnalyzeModel>.from(json.decode(str).map((x) => ResultFaceAnalyzeModel.fromJson(x)));

String resultFaceAnalyzeModelToJson(List<ResultFaceAnalyzeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResultFaceAnalyzeModel {
  String? name;
  String? outputName;
  List<String>? labels;
  String? outputLabel;
  double? outputScore;
  Map<String, double>? outputData;
  int? outputIndex;
  String? outputColor;
  String? imageData;

  ResultFaceAnalyzeModel({
    this.name,
    this.outputName,
    this.labels,
    this.outputLabel,
    this.outputScore,
    this.outputData,
    this.outputIndex,
    this.outputColor,
    this.imageData,
  });

  factory ResultFaceAnalyzeModel.fromJson(Map<String, dynamic> json) => ResultFaceAnalyzeModel(
    name: json["name"] ?? "",  // Default to empty string if 'name' is null
    outputName: json["outputName"] ?? "",  // Default to empty string if 'outputName' is null
    labels: json["labels"] != null
        ? List<String>.from(json["labels"].map((x) => x ?? "")) // Safely handle null elements in the labels list
        : [],  // Default to empty list if 'labels' is null
    outputLabel: json["outputLabel"] ?? "",  // Default to empty string if 'outputLabel' is null
    outputScore: json["outputScore"] != null ? json["outputScore"].toDouble() : null, // Safely handle null for 'outputScore'
    outputData: json["outputData"] != null
        ? Map.from(json["outputData"]).map((k, v) => MapEntry(k, v != null ? v.toDouble() : null)) // Safely handle null values in the map
        : null,  // Default to null if 'outputData' is null
    outputIndex: json["outputIndex"],  // Can be null, so no need for a default value
    outputColor: json["outputColor"],  // Can be null, so no need for a default value
    imageData: json["imageData"],  // Can be null, so no need for a default value
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "outputName": outputName,
    "labels": List<dynamic>.from(labels!.map((x) => x)),
    "outputLabel": outputLabel,
    "outputScore": outputScore,
    "outputData": Map.from(outputData!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "outputIndex": outputIndex,
    "outputColor": outputColor,
    "imageData": imageData,
  };
}
