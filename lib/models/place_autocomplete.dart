import 'dart:convert';

PlacesAutocomplete placesAutocompleteFromJson(String responseBody) =>
    PlacesAutocomplete.fromJson(json.decode(responseBody));

class PlacesAutocomplete {
  List<Suggestion> suggestions;

  PlacesAutocomplete({
    required this.suggestions,
  });

  factory PlacesAutocomplete.fromJson(Map<String, dynamic> json) =>
      PlacesAutocomplete(
        suggestions: List<Suggestion>.from(
          json["suggestions"].map(
            (value) => Suggestion.fromJson(value),
          ),
        ),
      );
}

class Suggestion {
  PlacePrediction placePrediction;

  Suggestion({
    required this.placePrediction,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        placePrediction: PlacePrediction.fromJson(json["placePrediction"]),
      );
}

class PlacePrediction {
  String place;
  String placeId;
  PlacesText placesText;
  StructuredFormat structuredFormat;
  List<String> types;

  PlacePrediction({
    required this.place,
    required this.placeId,
    required this.placesText,
    required this.structuredFormat,
    required this.types,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) =>
      PlacePrediction(
        place: json["place"],
        placeId: json["placeId"],
        placesText: PlacesText.fromJson(json["text"]),
        structuredFormat: StructuredFormat.fromJson(json["structuredFormat"]),
        types: List<String>.from(json["types"].map((value) => value)),
      );
}

class StructuredFormat {
  PlacesText mainText;
  PlacesText? secondaryText;

  StructuredFormat({
    required this.mainText,
    required this.secondaryText,
  });

  factory StructuredFormat.fromJson(Map<String, dynamic> json) =>
      StructuredFormat(
        mainText: PlacesText.fromJson(json["mainText"]),
        secondaryText: json['secondaryText'] != null
            ? PlacesText.fromJson(json["secondaryText"])
            : null,
      );
}

class PlacesText {
  String text;

  PlacesText({
    required this.text,
  });

  factory PlacesText.fromJson(Map<String, dynamic> json) => PlacesText(
        text: json["text"],
      );
}
