import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifgpadmin/widgets/user/user_nd_widget.dart';
import 'package:ifgpadmin/widgets/user/user_test_widget.dart';
import 'package:ifgpadmin/widgets/user/user_top_widget.dart';
import 'package:ifgpadmin/widgets/user/user_widget.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
          child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          TopUserWidget(),
          // UserTestWidget(),
          // UserWidget(),
          UserNDWidget(),
        ],
      )),
    );
  }
}
