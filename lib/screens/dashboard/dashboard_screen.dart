import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/screens/categories/categories_screen.dart';
import 'package:ifgpadmin/screens/contents/contents_screen.dart';
import 'package:ifgpadmin/screens/login/login_screen.dart';
import 'package:ifgpadmin/screens/rank/rank_screen.dart';
import 'package:ifgpadmin/screens/users/users_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ifgpadmin/service/report_api.dart';
import 'package:ifgpadmin/widgets/report/report_widget.dart';

class DashboardScreen extends StatefulWidget {
  final email;
  final username;

  const DashboardScreen({Key key, this.email, this.username}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var totalContent;
  var totalUser;

  Future getTotalContent() async {
    var url = Uri.parse('http://35.213.159.134/totalct.php?totalcontent');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        totalContent = response.body;
      });
    }
  }

  Future getTotalUser() async {
    var url = Uri.parse('http://35.213.159.134/totaluser.php?totaluser');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        totalUser = response.body;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTotalContent();
    getTotalUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            accountName: Text(
              widget.username,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              widget.email,
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.square_arrow_right,
              color: Colors.black,
              size: 19,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      )),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ],
              ),
            ),
            // menu grid
            Container(
              width: MediaQuery.of(context).size.width - 30.0,
              // height: MediaQuery.of(context).size.height - 50.0,
              // color: Colors.amber,
              padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 30),
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                // childAspectRatio: 1.0,
                children: <Widget>[
                  InkWell(
                    child: buildCardContent(),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContentScreen())),
                  ),
                  InkWell(
                    child: buildCardUser(),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserScreen())),
                  ),
                  InkWell(
                    child: buildCardCatergory(),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CatergoryScreen())),
                  ),
                  InkWell(
                    child: buildCardRanking(),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => RankScreen()));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 35),

            // report part
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                    ),
                    child: Text(
                      'Report',
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: ReportWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // content
  Widget buildCardContent() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 28.0,
            ),
            child: Text(
              'content',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Center(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              '$totalContent',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ))
        ],
      ),
    );
  }

  // user
  Widget buildCardUser() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 28.0,
            ),
            child: Text(
              'user',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Center(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              '$totalUser',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ))
        ],
      ),
    );
  }

  // category
  Widget buildCardCatergory() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 28.0,
            ),
            child: Text(
              'catergory',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Center(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              '12',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ))
        ],
      ),
    );
  }

  Widget buildCardRanking() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 28.0,
            ),
            child: Text(
              'rank',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Center(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              '3',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ))
        ],
      ),
    );
  }
}
