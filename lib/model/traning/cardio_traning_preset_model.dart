class CardioTraningPresetModel {
  String? machine, identifier, distance;
  int? restTime, index;
  bool isDone;

  CardioTraningPresetModel({
    this.index,
    this.machine,
    this.distance,
    this.restTime,
    this.isDone = false,
  });

  CardioTraningPresetModel.fromJson(Map<String, dynamic> json)
      : index = json['index'],
        identifier = json['identifier'],
        machine = json['machine'],
        distance = json['distance'],
        restTime = int.parse(json['restTime']),
        isDone = json['isDone'] ?? false;

  Map<String, dynamic> toJson() => {
        "index": index,
        "identifier": identifier,
        "machine": machine,
        "distance": distance,
        "restTime": restTime,
        "isDone": isDone,
      };
}
