class Agency {
  final int id;
  final String name;
  final String iconPath;

  const Agency({
    required this.id,
    required this.name,
    required this.iconPath,
  });

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['id'],
      name: json['name'],
      iconPath: json['icon'],
    );
  }
}
