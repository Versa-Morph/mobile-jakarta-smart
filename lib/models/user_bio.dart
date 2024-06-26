class UserBio {
  final String id;
  final String userId;
  final String nik;
  final String? profilePictPath;
  final String fullName;
  final String nickname;
  final String city;
  final String address;
  final int age;
  final String bloodType;
  final int height;
  final int weight;

  UserBio({
    required this.id,
    required this.userId,
    required this.nik,
    this.profilePictPath,
    required this.fullName,
    required this.nickname,
    required this.city,
    required this.address,
    required this.age,
    required this.bloodType,
    required this.height,
    required this.weight,
  });
}
