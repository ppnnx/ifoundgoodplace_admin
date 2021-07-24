import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/report_model.dart';

class APIReport {
  static Future<List<ReportModel>> getReport() async {
    final url =
        Uri.parse('http://35.213.159.134/reportshowall.php?reportshowall');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List reports = json.decode(response.body);

        return reports.map((f) => ReportModel.fromJson(f)).toList();
      }
    } catch (e) {}
    return null;
  }
}
