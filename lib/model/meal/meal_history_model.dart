class MealHistoryModel {
  String? time;
  int? index;
  bool? result;

  MealHistoryModel({
    this.time,
    this.index,
    this.result,
  });

  MealHistoryModel.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        index = json['index'],
        result = json['result'];

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "index": index,
      "result": result,
    };
  }
}
