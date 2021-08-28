import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/content_model.dart';

class TrendingAPI {
  static Future<List<ContentModel>> getTrendingContent() async {
    var url = Uri.parse('http://35.213.159.134/rankingall.php?rankbyallct');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final List trendingcontent = json.decode(response.body);

      return trendingcontent
          .map((json) => ContentModel.fromJson(json))
          .toList();
    } else {
      throw Exception('request api error');
    }
  }
}
