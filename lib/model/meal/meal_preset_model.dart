class MealPresetModel {
  String? food;
  int? index, count, carbohydrate, protein, fat, calorie, order;

  MealPresetModel({
    this.food,
    this.count,
    this.carbohydrate,
    this.protein,
    this.fat,
    this.calorie,
    this.index,
    this.order,
  });

  MealPresetModel.fromJson(Map<String, dynamic> json)
      : food = json['food'],
        count = json['count'],
        carbohydrate = json['carbohydrate'],
        protein = json['protein'],
        fat = json['fat'],
        calorie = json['calorie'],
        index = json['index'],
        order = json['order'];

  Map<String, dynamic> toJson() => {
        'food': food,
        'count': count,
        'carbohydrate': carbohydrate,
        'protein': protein,
        'fat': fat,
        'calorie': calorie,
        'index': index,
        'order': order,
      };

  void addOrder(int newOrder) => order = newOrder;
  void editInfo({
    int? newCalorie,
    int? newCarbohydrate,
    int? newFat,
    int? newProtein,
  }) {
    calorie = newCalorie ?? calorie;
    carbohydrate = newCarbohydrate = carbohydrate;
    fat = newFat ?? fat;
    protein = newProtein ?? protein;
  }

  Map<String, int> getDiffs(MealPresetModel other) {
    return {
      'calorie': ((calorie ?? 0) * (count ?? 1)) -
          ((other.calorie ?? 0) * (other.count ?? 1)),
      'carbohydrate': ((carbohydrate ?? 0) * (count ?? 1)) -
          ((other.carbohydrate ?? 0) * (other.count ?? 1)),
      'fat':
          ((fat ?? 0) * (count ?? 1)) - ((other.fat ?? 0) * (other.count ?? 1)),
      'protein': ((protein ?? 0) * (count ?? 1)) -
          ((other.protein ?? 0) * (other.count ?? 1)),
    };
  }
}
