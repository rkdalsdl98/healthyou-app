class UserProfileModel {
  String? nickname, profileIcon;

  UserProfileModel({
    this.nickname,
    this.profileIcon,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        profileIcon = json['profileIcon'];

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "profileIcon": profileIcon,
      };
}
