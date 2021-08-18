import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/content_model.dart';
import 'package:ifgpadmin/screens/detail/detail_screen.dart';

class ContentinCategory extends StatefulWidget {
  final idcategory;
  final namecategory;

  const ContentinCategory({Key key, this.idcategory, this.namecategory})
      : super(key: key);

  @override
  _ContentinCategoryState createState() => _ContentinCategoryState();
}

class _ContentinCategoryState extends State<ContentinCategory> {
  // fetch data from api
  Future<List<ContentModel>> fetchContents() async {
    var url = Uri.parse(
        'http://35.213.159.134/searchbycatead.php?searchbycategory=${widget.idcategory}');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List contents = json.decode(response.body);

        return contents.map((e) => ContentModel.fromJson(e)).toList();
      }
    } catch (e) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            widget.namecategory,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          children: [
            FutureBuilder(
                future: fetchContents(),
                builder: (context, AsyncSnapshot<List<ContentModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          ContentModel contents = snapshot.data[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            contentModel: snapshot.data[index],
                                          )));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 18,
                                        right: 18,
                                        top: 10,
                                        bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // title
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _showStatus(contents),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    contents.title,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(height: 7),
                                                  // date
                                                  Text(
                                                    'created : ' +
                                                        contents.dateContent,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.7)),
                                                  ),
                                                  SizedBox(height: 7),
                                                  // author
                                                  Text(
                                                    contents.username,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                          );
                        });
                  }

                  return Center(
                    child: Container(
                        padding: EdgeInsets.all(21.0),
                        child: Text('no contents')),
                  );
                }),
          ],
        ));
  }

  _showStatus(ContentModel content) {
    if (content.statuscontent == 'posted') {
      return Icon(
        CupertinoIcons.capsule_fill,
        color: Colors.green,
        size: 20,
      );
    } else if (content.statuscontent == 'deleted') {
      return Icon(
        CupertinoIcons.capsule_fill,
        color: Colors.red,
        size: 20,
      );
    } else if (content.statuscontent == 'hidden') {
      return Icon(
        CupertinoIcons.capsule_fill,
        color: Colors.amberAccent,
        size: 20,
      );
    }
  }
}
