import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifgpadmin/models/content_model.dart';
import 'package:ifgpadmin/service/content_api.dart';
import 'package:ifgpadmin/widgets/content/content_top_widget.dart';
import 'package:ifgpadmin/widgets/content/content_widget.dart';

class ContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TopContentWidget(),
          ContentWidget(),
        ],
      )),
    );
  }
}
