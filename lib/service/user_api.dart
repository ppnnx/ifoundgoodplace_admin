import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/user_model.dart';

class APIUser {
  static Future<List<User>> getUser() async {
    var url = Uri.parse('http://35.213.159.134/alluser.php?alluser');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List user = json.decode(response.body);

        return user.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed!');
      }
    } catch (e) {}
    return null;
  }
}
