class UserBio {
  final int id;
  final int userId;
  final String nik;
  final String profilePictPath;
  final String fullName;
  final String nickname;
  final String city;
  final String address;
  final int age;
  final String bloodType;
  final int height;
  final int weight;
  final String phoneNumber;

  UserBio({
    required this.id,
    required this.userId,
    required this.nik,
    required this.profilePictPath,
    required this.fullName,
    required this.nickname,
    required this.city,
    required this.address,
    required this.age,
    required this.bloodType,
    required this.height,
    required this.weight,
    required this.phoneNumber,
  });

  factory UserBio.fromJson(Map<String, dynamic> json) => UserBio(
        id: json["id"],
        userId: json["user_id"],
        nik: json["nik"],
        profilePictPath: json["profile_pict_path"],
        fullName: json["full_name"],
        nickname: json["nickname"],
        city: json["city"],
        address: json["address"],
        age: json["age"],
        bloodType: json["blood_type"],
        height: json["height"],
        weight: json["weight"],
        phoneNumber: json['phone_number'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nik": nik,
        "profile_pict_path": profilePictPath,
        "full_name": fullName,
        "nickname": nickname,
        "city": city,
        "address": address,
        "age": age,
        "blood_type": bloodType,
        "height": height,
        "weight": weight,
        "phone_number": phoneNumber,
      };
}
