import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/category_model.dart';

class APICategory {
  static Future<List<CategoryModel>> getCategory() async {
    var url = Uri.parse('http://35.213.159.134/category.php?plus');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final List category = json.decode(response.body);

      return category.map((data) => CategoryModel.fromJson(data)).toList();
    } else {
      throw Exception("Request API Error");
    }
  }
}
