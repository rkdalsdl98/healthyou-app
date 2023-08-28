class TraningPreset {
  int? index;
  List<dynamic>? presetItems;
  String? name, daily;

  TraningPreset({
    this.index,
    this.presetItems,
    this.name,
    this.daily,
  }) {
    presetItems ??= [];
  }

  TraningPreset.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    name = json['name'];
    daily = json['daily'];
    presetItems = [];
    if (json['presetItems'] != null && json['presetItems'].isNotEmpty) {
      var items = json['presetItems'];
      for (var item in items) {
        presetItems!.add(item);
      }
    }
  }

  Map<String, dynamic> toJson() => {
        "index": index,
        "presetItems": presetItems,
        "name": name,
        "daily": daily,
      };

  currentDaily(String? newDaily) => daily = newDaily;
  changeItems(List<dynamic>? items) => presetItems = items;
}
