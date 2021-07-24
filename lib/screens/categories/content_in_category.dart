import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/content_model.dart';

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
  Future<List<ContentModel>> getContents() async {
    var url = Uri.parse(
        'http://35.213.159.134/searchbycategory.php?searchbycategory=${widget.idcategory}');

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
      body: Container(
        child: FutureBuilder(
            future: getContents(),
            builder: (context, AsyncSnapshot<List<ContentModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      ContentModel content = snapshot.data[index];
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(left: 18, right: 18, top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // image
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'http://35.213.159.134/uploadimages/${content.images01}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.0),

                                  // title + date + author
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // title
                                        Text(
                                          content.title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        SizedBox(height: 8.0),
                                        // date
                                        Text(
                                          'published : ' + content.dateContent,
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        // author
                                        Text(
                                          content.username,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),

                                  // status content
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10, top: 6, bottom: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade800,
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                      child: Text(
                                        content.statuspost,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Divider(
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
