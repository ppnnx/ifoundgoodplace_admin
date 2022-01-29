import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/category_model.dart';
import 'package:ifgpadmin/screens/rank/all_content_screen.dart';
import 'package:ifgpadmin/screens/rank/author_screen.dart';
import 'package:ifgpadmin/screens/rank/by_categories.dart';
import 'package:ifgpadmin/screens/rank/rank_top_widget.dart';
import 'package:ifgpadmin/service/category_api.dart';

class RankScreen extends StatefulWidget {
  @override
  _RankScreenState createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
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
            TopRankWidget(),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: [
                  Divider(color: Colors.black),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllContentScreen()));
                    },
                    leading: Text(
                      '01',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    title: Text(
                      'All Contents.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Divider(color: Colors.black),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthorScreen(),
                        ),
                      );
                    },
                    leading: Text(
                      '02',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    title: Text(
                      'Authors.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Divider(color: Colors.black),
                  // ListTile(
                  //   leading: Text(
                  //     '03',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 21,
                  //       decoration: TextDecoration.underline,
                  //     ),
                  //   ),
                  //   title: Text(
                  //     'By Categories.',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 17,
                  //     ),
                  //   ),
                  // ),
                  ExpansionTile(
                    leading: Text(
                      '03',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    title: Text(
                      'By Categories.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    children: <Widget>[
                      FutureBuilder(
                        future: APICategory.getCategory(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<CategoryModel>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final category = snapshot.data![index];

                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ByCategoryScreen(
                                          idcategory: category.id,
                                          namecategory: category.name,
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(
                                    category.name!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                  Divider(color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
