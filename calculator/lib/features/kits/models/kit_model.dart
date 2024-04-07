class KitModel {
  String id;
  double value;
  bool isChecked;

  KitModel({
    required this.id,
    required this.value,
    this.isChecked = false,
  });

  KitModel.fromStringList(List<String> data)
      : id = data[0],
        value = double.parse(data[1]),
        isChecked = data[2] == 'true';

  void setValue(String val) => value = double.parse(val);

  void setStatus(bool status) => isChecked = status;

  void toggleStatus() => isChecked = !isChecked;

  String get format {
    String spaces = '    ';
    return '$id,$spaces';
  }

  List<String> toStringList() {
    return [
      id,
      value.toString(),
      isChecked.toString(),
    ];
  }
}
