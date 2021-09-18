import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/mycontent_model.dart';
import 'package:ifgpadmin/screens/map/map_screen.dart';
import 'package:ifgpadmin/widgets/comment/comment_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatefulWidget {
  final MyContentModel? myContentModel;

  const ArticleScreen({Key? key, this.myContentModel}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  int _current = 0;

  // for link
  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final mycontent = widget.myContentModel!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
            size: 19,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // part 1
                Container(
                  padding: EdgeInsets.all(21.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mycontent.datecontent!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        mycontent.username!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Text(
                          mycontent.category!.toLowerCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),

                // part 2
                Container(
                  padding: EdgeInsets.all(21.0),
                  child: Text(
                    mycontent.title!,
                    style: TextStyle(fontFamily: 'Kanit', fontSize: 24),
                  ),
                ),

                // images
                showimages(mycontent),
                SizedBox(height: 60),

                // story
                Container(
                  padding: EdgeInsets.all(21.0),
                  child: Text(
                    mycontent.content!,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                SizedBox(height: 80),

                // map + link
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // map
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                        lat: mycontent.latitude,
                                        lng: mycontent.longitude,
                                        title: mycontent.title,
                                      )));
                        },
                        child: Icon(
                          CupertinoIcons.placemark,
                          color: Colors.white,
                          size: 21,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF7EB5A6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 0.0),
                      ),
                      SizedBox(width: 14),

                      // link
                      mycontent.link == null || mycontent.link == " "
                          ? Text('')
                          : ElevatedButton(
                              onPressed: () {
                                _launchURL(mycontent.link!);
                              },
                              child: Icon(
                                CupertinoIcons.play_fill,
                                color: Colors.white,
                                size: 21,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFF2442),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 0.0),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 70),

                // show all total
                Container(
                  padding: EdgeInsets.all(21.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // favorite
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 7),
                            Text(mycontent.favorite.toString()),
                          ],
                        ),
                      ),
                      // bookmark
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.bookmark_fill,
                              color: Colors.black,
                              size: 18,
                            ),
                            SizedBox(width: 7),
                            Text(mycontent.save.toString()),
                          ],
                        ),
                      ),
                      // share
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.share,
                              color: Colors.black,
                              size: 18,
                            ),
                            SizedBox(width: 7),
                            Text(mycontent.share.toString()),
                          ],
                        ),
                      ),
                      // count read
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.eye,
                              color: Colors.black,
                              size: 18,
                            ),
                            SizedBox(width: 7),
                            Text(mycontent.read.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),

                // comment
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // head
                      Container(
                        padding: EdgeInsets.only(top: 40, left: 21, bottom: 20),
                        child: Text(
                          'Comments (' + mycontent.comment.toString() + ')',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      // comment
                      CommentWidget(idcontent: mycontent.idcontent),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // images
  Widget showimages(MyContentModel contents) {
    List images = [
      'http://35.213.159.134/uploadimages/${contents.images01}',
      'http://35.213.159.134/uploadimages/${contents.images02}',
      'http://35.213.159.134/uploadimages/${contents.images03}',
      'http://35.213.159.134/uploadimages/${contents.images04}',
    ];

    return Container(
      child: Column(
        children: [
          CarouselSlider(
              items: images.map((imgUrl) {
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
            children: images.map((url) {
              int index = images.indexOf(url);

              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                  color: _current == index ? Colors.black : Colors.white,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
