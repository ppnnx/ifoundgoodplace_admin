import 'dart:async';
import 'dart:convert';

import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/report_model.dart';
import 'package:http/http.dart' as http;

class ReportScreen extends StatefulWidget {
  final int idcontent;
  final String namecontent;
  final String statement;
  final ReportModel reportModel;

  const ReportScreen(
      {Key key,
      this.idcontent,
      this.namecontent,
      this.statement,
      this.reportModel})
      : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _current = 0; // for dot (image slide)

  // api unpublished content
  _unpublishcontent() async {
    try {
      final url = Uri.parse('http://35.213.159.134/statusct.php');
      final response = await http.post(url, body: {
        "ID_Content": widget.reportModel.idcontent.toString(),
        "Status_Content": 'hidden',
      });

      if (response.statusCode == 200) {
        print('this content is unpublish!');
      } else {
        print('failed!');
      }
    } catch (e) {}
  }

  // api change status report
  _alreadychecked() async {
    try {
      final url = Uri.parse('http://35.213.159.134/statusreport.php');
      final response = await http.post(url, body: {
        "ID_Report": widget.reportModel.idreport.toString(),
        "Status_Report": 'checked',
      });

      if (response.statusCode == 200) {
        print('already change status ${widget.reportModel.title}!');
      } else {
        print('failed!');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        // title: Text(
        //   'reported content : ' + widget.idcontent.toString(),
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 14,
        //   ),
        // ),
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ProgressHud(
        maximumDismissDuration: Duration(seconds: 2),
        child: Center(
          child: Builder(builder: (context) {
            return Container(
              child: ListView(
                children: [
                  // bill part
                  widget.reportModel.statusReport == 'reported'
                      ? Container(
                          height: 200,
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 8,
                            bottom: 8,
                          ),
                          color: Colors.amber.shade400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 18, right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // title
                                    Row(
                                      children: [
                                        Text(
                                          'Title : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          widget.namecontent,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    // author
                                    Row(
                                      children: [
                                        Text(
                                          'author : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          widget.reportModel.author,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    // statement
                                    Row(
                                      children: [
                                        Text(
                                          'statement : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          widget.reportModel.statement
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    // date
                                    Row(
                                      children: [
                                        Text(
                                          'date : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          widget.reportModel.dateReport,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 18),
                              // button
                              Container(
                                padding: EdgeInsets.only(right: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        _showProgress(context);
                                        _alreadychecked();
                                      },
                                      child: Text('No wrong'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.black,
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          )),
                                    ),
                                    SizedBox(width: 12),
                                    ElevatedButton(
                                      onPressed: () async {
                                        _showAlertUnpublish(context);
                                        await Future.delayed(
                                            Duration(milliseconds: 2000));
                                        _showProgress(context);
                                      },
                                      child: Text('Unpublish'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF185ADB),
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 200,
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 8,
                            bottom: 8,
                          ),
                          color: Colors.green.shade200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 18, right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons
                                              .checkmark_alt_circle_fill,
                                          color: Colors.black,
                                          size: 19,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Already checked',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    // title
                                    Row(
                                      children: [
                                        Text(
                                          'Title : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          widget.namecontent,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    // author
                                    Row(
                                      children: [
                                        Text(
                                          'author : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          widget.reportModel.author,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    // statement
                                    Row(
                                      children: [
                                        Text(
                                          'statement : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          widget.reportModel.statement
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    // date
                                    Row(
                                      children: [
                                        Text(
                                          'date : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          widget.reportModel.dateReport,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    // status content
                                    Row(
                                      children: [
                                        Text(
                                          'status : ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          'Published',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(height: 50),

                  // content part
                  Container(
                    padding: EdgeInsets.all(21.0),
                    child: Text(
                      widget.reportModel.title,
                      style: TextStyle(fontFamily: 'Kanit', fontSize: 24),
                    ),
                  ),
                  imageSlide(widget.reportModel),
                  SizedBox(height: 30),

                  // story
                  Container(
                    padding: EdgeInsets.all(21.0),
                    child: Text(
                      widget.reportModel.content,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // image slide
  Widget imageSlide(ReportModel reportModel) {
    // list images
    List imgList = [
      'http://35.213.159.134/uploadimages/${reportModel.images01}',
      'http://35.213.159.134/uploadimages/${reportModel.images02}',
      'http://35.213.159.134/uploadimages/${reportModel.images03}',
      'http://35.213.159.134/uploadimages/${reportModel.images04}',
    ];

    return Container(
      child: Column(
        children: [
          CarouselSlider(
              items: imgList.map((imgUrl) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        height: 300.0,
                        color: Colors.black12,
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 300.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              )),
          SizedBox(height: 16),

          // dot (indicatior)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);

              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _current == index ? Colors.black : Colors.grey.shade400,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  // alert for button
  _showAlertUnpublish(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('This article will be suspended from publishing.'),
          actions: [
            Container(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                  ),
                  SizedBox(width: 14),
                  ElevatedButton(
                    onPressed: () {
                      _unpublishcontent();
                      _alreadychecked();
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF185ADB),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _showProgress(BuildContext context) {
    var hud = ProgressHud.of(context);
    hud.show(ProgressHudType.progress, "loading");

    int current = 0;
    Timer.periodic(Duration(milliseconds: 1000 ~/ 60), (timer) {
      current += 1;
      var progress = current / 100;
      hud.updateProgress(progress, 'Loading.. $current%');
      if (progress == 1) {
        // finished
        hud.showAndDismiss(ProgressHudType.success, 'Success');
        timer.cancel();
      }
    });
  }
}
