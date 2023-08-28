class WeightTraningPresetModel {
  String? machine, identifier, count, totalSet, machineWeight;
  int? restTime, index;
  bool isDone;

  WeightTraningPresetModel({
    this.index,
    this.machine,
    this.restTime,
    this.isDone = false,
  });

  WeightTraningPresetModel.fromJson(Map<String, dynamic> json)
      : index = json['index'],
        identifier = json['identifier'],
        machine = json['machine'],
        restTime = int.parse(json['restTime']),
        isDone = json['isDone'] ?? false,
        count = json['count'],
        totalSet = json['totalSet'],
        machineWeight = json['weight'];

  Map<String, dynamic> toJson() => {
        "index": index,
        "identifier": identifier,
        "machine": machine,
        "restTime": restTime,
        "isDone": isDone,
        "count": count,
        "totalSet": totalSet,
        "weight": machineWeight,
      };
}
