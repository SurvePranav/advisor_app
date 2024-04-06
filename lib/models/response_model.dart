import 'dart:convert';

ResponseModel postsDataUiModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String postsDataUiModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  Content? content;
  String? finishReason;
  int? index;
  List<SafetyRating>? safetyRatings;

  ResponseModel({
    this.content,
    this.finishReason,
    this.index,
    this.safetyRatings,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
        finishReason: json["finishReason"],
        index: json["index"],
        safetyRatings: json["safetyRatings"] == null
            ? []
            : List<SafetyRating>.from(
                json["safetyRatings"]!.map((x) => SafetyRating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content?.toJson(),
        "finishReason": finishReason,
        "index": index,
        "safetyRatings": safetyRatings == null
            ? []
            : List<dynamic>.from(safetyRatings!.map((x) => x.toJson())),
      };
}

class Content {
  List<Part>? parts;
  String? role;

  Content({
    this.parts,
    this.role,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        parts: json["parts"] == null
            ? []
            : List<Part>.from(json["parts"]!.map((x) => Part.fromJson(x))),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "parts": parts == null
            ? []
            : List<dynamic>.from(parts!.map((x) => x.toJson())),
        "role": role,
      };
}

class Part {
  String? text;

  Part({
    this.text,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}

class SafetyRating {
  String? category;
  String? probability;

  SafetyRating({
    this.category,
    this.probability,
  });

  factory SafetyRating.fromJson(Map<String, dynamic> json) => SafetyRating(
        category: json["category"],
        probability: json["probability"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "probability": probability,
      };
}
