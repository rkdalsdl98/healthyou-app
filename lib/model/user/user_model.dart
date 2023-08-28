import 'package:healthyou_app/model/user/user_info_model.dart';
import 'package:healthyou_app/model/user/user_profile_model.dart';

class UserModel {
  UserInfoModel? info;
  UserProfileModel? profile;
  String? email;

  UserModel({this.info, this.profile, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    if (json['info'] != null) {
      info = UserInfoModel.fromJson(json['userInfo']);
    }
    if (json['profile'] != null) {
      profile = UserProfileModel.fromJson(json['profile']);
    }
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "info": info?.toJson(),
        "profile": profile?.toJson(),
      };

  setCurrentInfo(Map<String, dynamic> data) =>
      info = UserInfoModel.fromJson(data);
  setCurrentProfile(Map<String, dynamic> data) =>
      profile = UserProfileModel.fromJson(data);
}
