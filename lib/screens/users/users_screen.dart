import 'package:flutter/material.dart';
import 'package:ifgpadmin/service/user_api.dart';
import 'package:ifgpadmin/widgets/refresh_indicator/refresh_widget.dart';
import 'package:ifgpadmin/widgets/user/user_default_widget.dart';
import 'package:ifgpadmin/widgets/user/user_top_widget.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future loadList() async {
    await Future.delayed(Duration(milliseconds: 3000));
    APIUser.getUser().then((value) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0.0,
      ),
      body: RefreshWidget(
        onRefresh: loadList,
        child: SafeArea(
            child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            TopUserWidget(),
            UserDefaultWidget(),
          ],
        )),
      ),
    );
  }
}
