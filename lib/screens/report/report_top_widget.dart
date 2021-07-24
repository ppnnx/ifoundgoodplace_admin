import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/report_model.dart';
import 'package:http/http.dart' as http;

class ReportTopPart extends StatefulWidget {
  @override
  _ReportTopPartState createState() => _ReportTopPartState();
}

class _ReportTopPartState extends State<ReportTopPart> {
  List<ReportModel> reportList = [];

  // fetch data from api
  // Future<List<ReportModel>> fetchReport() async {
  //   final url = Uri.parse(
  //       'http://35.213.159.134/reportshow1.php?idctreport=${widget.idcontent}');

  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       final List reportlist = json.decode(response.body);

  //       return reportlist.map((a) => ReportModel.fromJson(a)).toList();
  //     }
  //   } catch (e) {}
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
