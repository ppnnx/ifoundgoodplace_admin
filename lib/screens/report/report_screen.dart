import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ifgpadmin/models/report_model.dart';
import 'package:http/http.dart' as http;

class ReportScreen extends StatefulWidget {
  final int? idcontent;
  final String? namecontent;
  final String? statement;
  final ReportModel? reportModel;

  const ReportScreen(
      {Key? key,
      this.idcontent,
      this.namecontent,
      this.statement,
      this.reportModel})
      : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Timer? _timer;
  late double _progress;

  int _current = 0; // for dot (image slide)

  // api unpublished content
  unpublishcontent() async {
    try {
      final url = Uri.parse('http://35.213.159.134/unpublish.php');
      final response = await http.post(url, body: {
        "ID_Content": widget.reportModel!.idcontent.toString(),
        "Cause": widget.reportModel!.statement,
        "Status_Content": 'hidden',
      });

      if (response.statusCode == 200) {
        print('this content is unpublish!');
        _progress = 0;
        _timer?.cancel();
        _timer = Timer.periodic(const Duration(milliseconds: 100),
            (Timer timer) async {
          EasyLoading.showProgress(_progress,
              status: '${(_progress * 100).toStringAsFixed(0)}%');
          _progress += 0.03;

          if (_progress >= 1) {
            EasyLoading.showSuccess('Done');
            _timer?.cancel();
            EasyLoading.dismiss();
            await delayprogress(2000);
            Navigator.pop(context);
          }
        });
      } else {}
    } catch (e) {}
  }

  // api change status report
  alreadychecked() async {
    try {
      final url = Uri.parse('http://35.213.159.134/statusreport.php');
      final response = await http.post(url, body: {
        "ID_Report": widget.reportModel!.idreport.toString(),
        "Status_Report": 'checked',
      });

      if (response.statusCode == 200) {
        print('already change status ${widget.reportModel!.title}!');
      } else {
        print('failed!');
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        child: ListView(
          children: [
            // bill part
            widget.reportModel!.statusReport == 'reported'
                ? Container(
                    // height: 200,
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 8,
                      bottom: 8,
                    ),
                    color: Colors.amber.shade300,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Text(
                                        'Title : ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      child: Text(
                                        widget.namecontent!,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
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
                                    widget.reportModel!.author!,
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
                                    widget.reportModel!.statement!
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      // fontStyle: FontStyle.italic,
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
                                    widget.reportModel!.dateReport!,
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
                                onPressed: () async {
                                  openAlertBox();
                                  await delayprogress(2000);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Approve'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )),
                              ),
                              SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () => showAlertBox(),
                                child: Text('Unpublish'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
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
                  )
                : Container(
                    height: 200,
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 8,
                      bottom: 8,
                    ),
                    color: widget.reportModel!.statusContent == "hidden"
                        ? Colors.red.shade700
                        : Colors.green.shade200,
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
                                    CupertinoIcons.checkmark_alt_circle_fill,
                                    color: widget.reportModel!.statusContent ==
                                            "hidden"
                                        ? Colors.white
                                        : Colors.black,
                                    size: 19,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Already checked',
                                    style: TextStyle(
                                        color:
                                            widget.reportModel!.statusContent ==
                                                    "hidden"
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // title
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Text(
                                        'Title : ',
                                        style: TextStyle(
                                            color: widget.reportModel!
                                                        .statusContent ==
                                                    "hidden"
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      child: Text(
                                        widget.namecontent!,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: widget.reportModel!
                                                        .statusContent ==
                                                    "hidden"
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 15),
                                      ),
                                    ),
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
                                      color:
                                          widget.reportModel!.statusContent ==
                                                  "hidden"
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    widget.reportModel!.author!,
                                    style: TextStyle(
                                      color:
                                          widget.reportModel!.statusContent ==
                                                  "hidden"
                                              ? Colors.white
                                              : Colors.black,
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
                                      color:
                                          widget.reportModel!.statusContent ==
                                                  "hidden"
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    widget.reportModel!.statement!
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color:
                                          widget.reportModel!.statusContent ==
                                                  "hidden"
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      // fontStyle: FontStyle.italic,
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
                                      color:
                                          widget.reportModel!.statusContent ==
                                                  "hidden"
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    widget.reportModel!.dateReport!,
                                    style: TextStyle(
                                      color:
                                          widget.reportModel!.statusContent ==
                                                  "hidden"
                                              ? Colors.white
                                              : Colors.black,
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
                                      color:
                                          widget.reportModel!.statusContent ==
                                                  "hidden"
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  widget.reportModel!.statusContent == 'hidden'
                                      ? Text(
                                          'Unpublished',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : Text(
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
                widget.reportModel!.title!,
                style: TextStyle(fontFamily: 'Kanit', fontSize: 24),
              ),
            ),
            imageSlide(widget.reportModel!),
            SizedBox(height: 30),

            // story
            Container(
              padding: EdgeInsets.all(21.0),
              child: Text(
                widget.reportModel!.content!,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
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

  // alert box for unpublish button
  showAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0))),
            contentPadding: EdgeInsets.only(top: 15.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Content Suspended",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
                    child: Center(
                      child: Text(
                        "This article will be suspended from publishing. Are you sure?",
                        style: TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // cancel button
                        InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          child: Container(
                            width: 100,
                            padding: EdgeInsets.only(
                                top: 12.0,
                                bottom: 12.0,
                                left: 20.0,
                                right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // yes button
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                            unpublishcontent();
                            alreadychecked();
                          },
                          child: Container(
                            width: 100,
                            padding: EdgeInsets.only(
                                top: 12.0,
                                bottom: 12.0,
                                left: 20.0,
                                right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  // alert box for no wrong
  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0))),
            contentPadding: EdgeInsets.only(top: 20.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Are you sure?",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // cancel button
                        InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          child: Container(
                            width: 100,
                            padding: EdgeInsets.only(
                                top: 12.0,
                                bottom: 12.0,
                                left: 20.0,
                                right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // yes button
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                            alreadychecked();
                          },
                          child: Container(
                            width: 100,
                            padding: EdgeInsets.only(
                                top: 12.0,
                                bottom: 12.0,
                                left: 20.0,
                                right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future delayprogress(int millisec) async {
    await Future.delayed(Duration(milliseconds: millisec));
  }
}
