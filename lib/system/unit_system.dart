String addCommas(int num) {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  return num.toString().replaceAllMapped(reg, (match) => '${match[1]},');
}
