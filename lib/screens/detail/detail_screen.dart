import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/content_model.dart';
import 'package:ifgpadmin/widgets/comment/comment_widget.dart';

class DetailScreen extends StatefulWidget {
  final ContentModel contentModel;

  const DetailScreen({Key key, this.contentModel}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final content = widget.contentModel;

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
              children: [
                // part 1 :
                Container(
                  padding: EdgeInsets.all(21.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        content.dateContent,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        content.username,
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
                          content.category.toLowerCase(),
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

                // part 2 :
                Container(
                  padding: EdgeInsets.all(21.0),
                  child: Text(
                    content.title,
                    style: TextStyle(fontFamily: 'Kanit', fontSize: 24),
                  ),
                ),

                // images
                showimages(content),
                SizedBox(height: 60),

                // story
                Container(
                  padding: EdgeInsets.all(21.0),
                  child: Text(
                    content.content,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                SizedBox(height: 80),

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
                            Text(content.favorite.toString()),
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
                            Text(content.save.toString()),
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
                            Text(content.share.toString()),
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
                            Text(content.counterread.toString()),
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
                          'Comments (' + content.comments.toString() + ')',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      // comment
                      CommentWidget(idcontent: content.idcontent),
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
  Widget showimages(ContentModel contents) {
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
