class MyUser {
  final String id;
  final String email;
  final String displayName;
  final String? profilePictureUrl;

  MyUser({
    required this.id,
    required this.email,
    required this.displayName,
    this.profilePictureUrl,
  });

  factory MyUser.fromGoogle(Map<String, dynamic> googleData) {
    return MyUser(
      id: googleData['id'],
      email: googleData['email'],
      displayName: googleData['displayName'],
      profilePictureUrl: googleData['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
