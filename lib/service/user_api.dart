import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/all_user_model.dart';

class APIUser {
  static Future<List<AllUsers>> getUser() async {
    var url = Uri.parse('http://35.213.159.134/totalctuser2.php?plus');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List user = json.decode(response.body);

        return user.map((json) => AllUsers.fromJson(json)).toList();
      } else {
        throw Exception('Failed!');
      }
    } catch (e) {}
    return [];
  }
}
