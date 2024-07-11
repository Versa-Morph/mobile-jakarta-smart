class UserContact {
  final int id;
  final int userId;
  final String fullName;
  final String profilePictPath;
  final String phoneNumber;
  final bool isDanger;

  UserContact({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.profilePictPath,
    required this.phoneNumber,
    this.isDanger = false,
  });

  factory UserContact.fromJson(Map<String, dynamic> json) {
    return UserContact(
      id: json['id'],
      userId: json['user_id'],
      fullName: json['full_name'],
      profilePictPath: json['profile_pict_path'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "is_danger": isDanger,
      };
}
