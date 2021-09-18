import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/content_model.dart';
import 'package:ifgpadmin/screens/detail/detail_screen.dart';
import 'package:ifgpadmin/service/content_api.dart';

class ContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIContent.getContent(),
      builder: (context, AsyncSnapshot<List<ContentModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ContentModel content = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  contentModel: snapshot.data![index],
                                )));
                  },
                  child: Container(
                    child: Column(
                      children: [
                        // text
                        Container(
                          padding: EdgeInsets.only(
                              left: 18, right: 18, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // catergory
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 6, bottom: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: Text(
                                      content.category!,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  // status content
                                  _buildCardStatus(content),
                                ],
                              ),

                              SizedBox(height: 10),
                              Text(
                                content.title!,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              SizedBox(height: 12),

                              // date
                              Text(
                                'created : ' + content.dateContent!,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7)),
                              ),

                              SizedBox(height: 12),

                              // counter read + author(username)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    content.username!,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Container(
                                      child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.eye_fill,
                                        color: Colors.black.withOpacity(0.8),
                                        size: 19,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        content.counterread.toString(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: 14),
                                      )
                                    ],
                                  )),
                                ],
                              ),

                              SizedBox(height: 12),
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
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  _buildCardStatus(ContentModel contentModel) {
    if (contentModel.statuscontent == 'posted') {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Text(
          contentModel.statuscontent!,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else if (contentModel.statuscontent == 'deleted') {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: Colors.red.shade900,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Text(
          contentModel.statuscontent!,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else if (contentModel.statuscontent == 'hidden') {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Text(
          contentModel.statuscontent!,
          style: TextStyle(color: Colors.black),
        ),
      );
    }
  }
}
