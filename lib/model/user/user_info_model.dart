class UserInfoModel {
  int? age,
      height,
      weight,
      skeletalMuscle,
      bodyFat,
      bmi,
      basalMetabolicRate,
      bodyFatPercent;

  UserInfoModel({
    this.age,
    this.height,
    this.weight,
    this.skeletalMuscle,
    this.bodyFat,
    this.bmi,
    this.basalMetabolicRate,
    this.bodyFatPercent,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : age = json['age'],
        height = json['height'],
        weight = json['weight'],
        skeletalMuscle = json['skeletalMuscle'],
        bodyFat = json['bodyFat'],
        bmi = json['bmi'],
        basalMetabolicRate = json['basalMetabolicRate'],
        bodyFatPercent = json['bodyFatPercent'];

  Map<String, dynamic> toJson() => {
        "age": age,
        "height": height,
        "weight": weight,
        "skeletalMuscle": skeletalMuscle,
        "bodyFat": bodyFat,
        "bmi": bmi,
        "basalMetabolicRate": basalMetabolicRate,
        "bodyFatPercent": bodyFatPercent,
      };
}
