import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/content_model.dart';

class APIContent {
  static Future<List<ContentModel>> getContent() async {
    var url = Uri.parse('http://35.213.159.134/ctalladmin.php?content');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final List content = json.decode(response.body);
      // print(content.length);

      return content.map((json) => ContentModel.fromJson(json)).toList();
    } else {
      throw Exception("Request API Error");
    }
  }
}
