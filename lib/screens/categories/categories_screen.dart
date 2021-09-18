import 'package:flutter/material.dart';
import 'package:ifgpadmin/widgets/category/category_top_widget.dart';
import 'package:ifgpadmin/widgets/category/category_widget.dart';

class CatergoryScreen extends StatefulWidget {
  @override
  _CatergoryScreenState createState() => _CatergoryScreenState();
}

class _CatergoryScreenState extends State<CatergoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        maintainBottomViewPadding: true,
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
