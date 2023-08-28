class EventModel {
  String? text;
  DateTime? notifyDate;
  int? order;

  EventModel({
    this.text,
    this.notifyDate,
    this.order,
  });

  EventModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        order = json['order'],
        notifyDate = DateTime.parse(json['notifyDate']);

  Map<String, dynamic> toJson() => {
        "text": text,
        "order": order,
        "notifyDate": notifyDate.toString(),
      };

  void addOrder(int newOrder) => order = newOrder;
}
