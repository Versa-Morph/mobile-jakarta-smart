class PlaceDisplayName {
  final String? text;

  PlaceDisplayName({
    this.text,
  });

  factory PlaceDisplayName.fromJson(Map<String, dynamic> json) =>
      PlaceDisplayName(
        text: json["text"],
      );
}
