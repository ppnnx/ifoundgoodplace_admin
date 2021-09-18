import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/comment_model.dart';

class CommentWidget extends StatefulWidget {
  final idcontent;

  const CommentWidget({Key? key, this.idcontent}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  Future<List<CommentModel>?> getComment() async {
    var url = Uri.parse('http://35.213.159.134/comshow.php');

    try {
      var response = await http
          .post(url, body: {'ID_Content': widget.idcontent.toString()});

      if (response.statusCode == 200) {
        final List comment = json.decode(response.body);

        return comment.map((json) => CommentModel.fromJson(json)).toList();
      } else {
        throw Exception('error');
      }
    } catch (e) {}
    return null;
  }

  @override
  void initState() {
    super.initState();
    getComment();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getComment(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CommentModel>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext _, int index) {
                  final comment = snapshot.data![index];

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 0),
                    padding: EdgeInsets.only(
                        top: 10, left: 20, right: 16, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image
                        comment.image == null || comment.image == ''
                            ? CircleAvatar(
                                radius: 22,
                                backgroundImage:
                                    AssetImage('assets/second.png'),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10000.0),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'http://35.213.159.134/avatar/${comment.image}',
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.black12,
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ),
                        SizedBox(width: 10),
                        // comment box
                        Container(
                          color: Colors.white,
                          constraints: BoxConstraints(
                            maxWidth: 280,
                            maxHeight: 120,
                            minHeight: 110,
                          ),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          comment.username!,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          comment.dateComment!,
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              // comment part
                              Text(
                                comment.comment!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }

          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(12.0),
            child: Text('no comments.'),
          );
        });
  }
}
