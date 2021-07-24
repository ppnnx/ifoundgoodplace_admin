class CategoryModel {
  int id;
  String name;
  int total;

  CategoryModel({this.id, this.name, this.total});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['ID_Category'];
    name = json['Category'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_Category'] = this.id;
    data['Category'] = this.name;
    data['Total'] = this.total;
    return data;
  }
}
