class Agency {
  final int id;
  final String name;
  final String iconPath;
  final List<AgencyDetails> details;

  const Agency({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.details,
  });

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['id'],
      name: json['name'],
      iconPath: json['icon'],
      details: List<AgencyDetails>.from(
        json['details'].map(
          (x) => AgencyDetails.fromJson(x),
        ),
      ),
    );
  }
}

class AgencyDetails {
  final int id;
  final int instanceId;
  final String name;
  final String logoPath;
  final String address;
  final String latitude;
  final String longitude;
  final String pluscode;

  const AgencyDetails({
    required this.id,
    required this.instanceId,
    required this.name,
    required this.logoPath,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.pluscode,
  });

  factory AgencyDetails.fromJson(Map<String, dynamic> json) {
    return AgencyDetails(
      id: json['id'],
      instanceId: json['instance_id'],
      name: json['name'],
      logoPath: json['logo'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      pluscode: json['pluscode'],
    );
  }
}
