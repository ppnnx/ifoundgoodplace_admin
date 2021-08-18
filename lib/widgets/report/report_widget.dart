import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/report_model.dart';
import 'package:ifgpadmin/screens/report/report_screen.dart';
import 'package:ifgpadmin/service/report_api.dart';

class ReportWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: APIReport.getReport(),
        builder: (context, AsyncSnapshot<List<ReportModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  ReportModel report = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportScreen(
                                    idcontent: report.idcontent,
                                    namecontent: report.title,
                                    statement: report.statement,
                                    reportModel: snapshot.data[index],
                                  )));
                    },
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                        padding: EdgeInsets.only(
                            left: 22, right: 16, top: 14, bottom: 14),
                        height: 180,
                        width: 375,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // title of reported content
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  report.title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            report.statusReport == 'reported'
                                ? Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          CupertinoIcons.bolt_circle_fill,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Waiting for review',
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    child: Row(
                                      children: [
                                        // already checked
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                CupertinoIcons
                                                    .checkmark_alt_circle_fill,
                                                color: Colors.blue.shade900,
                                                size: 19,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'Already checked',
                                                style: TextStyle(
                                                  color: Colors.blue.shade900,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        // status content
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                CupertinoIcons.capsule_fill,
                                                color: report.statusContent ==
                                                        "posted"
                                                    ? Colors.green.shade600
                                                    : Colors.red.shade800,
                                                size: 19,
                                              ),
                                              SizedBox(width: 5),
                                              //  
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text('report by'),
                                SizedBox(width: 5),
                                Text(
                                  report.username,
                                  style: TextStyle(
                                    color: Color(0xFF161616),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 7),
                            Row(
                              children: [
                                Text('statement : '),
                                SizedBox(width: 5),
                                Text(
                                  report.statement.toUpperCase(),
                                  style: TextStyle(
                                      color: Color(0xFF161616),
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic),
                                )
                              ],
                            ),
                            SizedBox(height: 7),
                            Row(
                              children: [
                                Text('report date : '),
                                SizedBox(width: 5),
                                Text(
                                  report.dateReport,
                                  style: TextStyle(
                                    color: Color(0xFF161616),
                                    // fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  );
                });
          }

          return Center(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
              child: Text('No content reported.'),
            ),
          );
        });
  }
}
