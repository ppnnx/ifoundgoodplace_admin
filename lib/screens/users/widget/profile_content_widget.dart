import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/detail_report_model.dart';
import 'package:ifgpadmin/models/mycontent_model.dart';
import 'package:ifgpadmin/models/total_about_content.dart';
import 'package:ifgpadmin/screens/detail/article_screen.dart';

class ProfileContentWidget extends StatefulWidget {
  final id;

  const ProfileContentWidget({Key key, this.id}) : super(key: key);

  @override
  _ProfileContentWidgetState createState() => _ProfileContentWidgetState();
}

class _ProfileContentWidgetState extends State<ProfileContentWidget> {
  // fetch contents from api by iduser
  Future<List<MyContentModel>> fetchcontents() async {
    try {
      final url = Uri.parse(
          "http://35.213.159.134/mycontentbyadmin.php?iduser=${widget.id}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List contents = json.decode(response.body);
        return contents.map((e) => MyContentModel.fromJson(e)).toList();
      } else {
        print("API MYCONTENT FAILED");
      }
    } catch (e) {}
    return [];
  }

  // fetch detail report from api by iduser
  Future<List<DetailReportModel>> fetchreport() async {
    try {
      final url = Uri.parse(
          "http://35.213.159.134/detailreport.php?iduser=${widget.id}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List reports = json.decode(response.body);
        return reports.map((e) => DetailReportModel.fromJson(e)).toList();
      } else {
        print("API DETAIL REPORT FAILED");
      }
    } catch (e) {}
    return [];
  }

  // fetch total about content from api by iduser
  Future<List<TotalAboutContent>> fetchtotal() async {
    try {
      final url = Uri.parse(
          "http://35.213.159.134/totalctuser.php?iduser=${widget.id}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List totals = json.decode(response.body);
        return totals.map((e) => TotalAboutContent.fromJson(e)).toList();
      } else {
        print("API TOTAL FAILED");
      }
    } catch (e) {}
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          // Divider(color: Colors.black),
          // content part
          FutureBuilder(
            future: fetchtotal(),
            builder:
                (context, AsyncSnapshot<List<TotalAboutContent>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final total = snapshot.data[index];

                      return ExpansionTile(
                        title: Text(
                          "Contents (" + total.content.toString() + ")",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        childrenPadding: EdgeInsets.only(bottom: 14.0),
                        children: <Widget>[
                          // all contents
                          total.content == 0
                              ? ListTile(
                                  subtitle: Center(child: Text("No content")),
                                )
                              : FutureBuilder(
                                  future: fetchcontents(),
                                  builder: (context,
                                      AsyncSnapshot<List<MyContentModel>>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            final mycontent =
                                                snapshot.data[index];

                                            return ListTile(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ArticleScreen(
                                                              myContentModel:
                                                                  snapshot.data[
                                                                      index],
                                                            )));
                                              },
                                              leading: Icon(
                                                CupertinoIcons.capsule_fill,
                                                color: mycontent
                                                            .statuscontent ==
                                                        "posted"
                                                    ? Color(0xFF5AA469)
                                                    : mycontent.statuscontent ==
                                                            "hidden"
                                                        ? Color(0xFF6B7AA1)
                                                        : Color(0xFFC05555),
                                                size: 21.5,
                                              ),
                                              title: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      mycontent.title,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 12),
                                                    Text(
                                                      "created : " +
                                                          mycontent.datecontent,
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // comment
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                CupertinoIcons
                                                                    .chat_bubble,
                                                                color: Colors
                                                                    .black45,
                                                                size: 15.5,
                                                              ),
                                                              SizedBox(
                                                                  width: 6),
                                                              Text(
                                                                mycontent
                                                                    .comment
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black45,
                                                                  fontSize: 13,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(width: 12),
                                                          // favorite
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                CupertinoIcons
                                                                    .heart_fill,
                                                                color: Colors
                                                                    .black45,
                                                                size: 15.5,
                                                              ),
                                                              SizedBox(
                                                                  width: 6),
                                                              Text(
                                                                mycontent
                                                                    .favorite
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black45,
                                                                  fontSize: 13,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(width: 12),
                                                          // save
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                CupertinoIcons
                                                                    .bookmark_fill,
                                                                color: Colors
                                                                    .black45,
                                                                size: 14.7,
                                                              ),
                                                              SizedBox(
                                                                  width: 6),
                                                              Text(
                                                                mycontent.save
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black45,
                                                                  fontSize: 13,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(width: 12),
                                                          // read
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                CupertinoIcons
                                                                    .eye,
                                                                color: Colors
                                                                    .black45,
                                                                size: 15.5,
                                                              ),
                                                              SizedBox(
                                                                  width: 6),
                                                              Text(
                                                                mycontent.read
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black45,
                                                                  fontSize: 13,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 14),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    }

                                    return Container(width: 0.0, height: 0.0);
                                  }),
                        ],
                      );
                    });
              }

              return Container(width: 0.0, height: 0.0);
            },
          ),
          // Divider(
          //   color: Colors.black,
          // ),

          // report part
          FutureBuilder(
              future: fetchtotal(),
              builder:
                  (context, AsyncSnapshot<List<TotalAboutContent>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final total = snapshot.data[index];

                        return ExpansionTile(
                          // leading: total.report == 3
                          //     ? Icon(
                          //         Icons.error,
                          //         color: Color(0xFFF6D167),
                          //         size: 24,
                          //       )
                          //     : null,
                          title: Container(
                            child: Row(
                              children: [
                                Text(
                                  "Reported (" + total.report.toString() + ")",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 12),
                                total.report == 3
                                    ? Icon(
                                        Icons.error,
                                        color: Color(0xFFF6D167),
                                        size: 24,
                                      )
                                    : null,
                              ],
                            ),
                          ),
                          childrenPadding: EdgeInsets.only(bottom: 16.0),
                          children: <Widget>[
                            total.report == 0
                                ? ListTile(
                                    subtitle: Center(child: Text("No report")),
                                  )
                                : FutureBuilder(
                                    future: fetchreport(),
                                    builder: (context,
                                        AsyncSnapshot<List<DetailReportModel>>
                                            snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (context, int index) {
                                              final report =
                                                  snapshot.data[index];
                                              int number = index + 1;
                                              return ListTile(
                                                  leading: Text(
                                                    "0$number",
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 18.7,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  title: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          report.title,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.7,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "เนื่องจาก  :  ",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            report.cause ==
                                                                    "rude"
                                                                ? Text(
                                                                    "ใช้ภาษาที่ไม่เหมาะสม",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                      letterSpacing:
                                                                          0.5,
                                                                    ),
                                                                  )
                                                                : report.cause ==
                                                                        "copyright"
                                                                    ? Text(
                                                                        "ลอกเลียนแบบบทความผู้อื่น",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      )
                                                                    : Text(
                                                                        "ใช้ภาพประกอบที่ไม่เหมาะสม",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 14),
                                                      ],
                                                    ),
                                                  ));
                                            });
                                      }

                                      return Container(width: 0.0, height: 0.0);
                                    }),
                          ],
                        );
                      });
                }

                return Container(width: 0.0, height: 0.0);
              }),
        ],
      ),
    );
  }
}
