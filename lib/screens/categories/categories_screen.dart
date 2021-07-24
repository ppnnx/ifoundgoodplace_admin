import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifgpadmin/widgets/category/category_top_widget.dart';
import 'package:ifgpadmin/widgets/category/category_widget.dart';

class CatergoryScreen extends StatelessWidget {
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
            TopCategoryWidget(),
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
