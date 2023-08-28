class TotalNutritionModel {
  int totalCarbohydrate = 0, totalProtein = 0, totalFat = 0, totalCalorie = 0;

  addNutrients(Map<String, int> nutrients) {
    totalCalorie += nutrients['calorie']!;
    totalCarbohydrate += nutrients['carbohydrate']!;
    totalFat += nutrients['fat']!;
    totalProtein += nutrients['protein']!;
  }

  subtractNutrients(Map<String, int> nutrients) {
    totalCalorie -= nutrients['calorie']!;
    totalCarbohydrate -= nutrients['carbohydrate']!;
    totalFat -= nutrients['fat']!;
    totalProtein -= nutrients['protein']!;
  }
}
