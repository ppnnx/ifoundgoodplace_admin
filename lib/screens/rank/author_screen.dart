import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/author_rank_model.dart';
import 'package:ifgpadmin/service/author_rank_api.dart';

class AuthorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
            size: 19,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Authors.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: AuthorTrendingAPI.getTrendingAuthor(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AuthorTrendingModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext _, int index) {
                        return AuthorChartWidget(
                          rank: index + 1,
                          data: snapshot.data[index],
                        );
                      });
                }

                return Container(
                  margin: EdgeInsets.all(21.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class AuthorChartWidget extends StatelessWidget {
  final int rank;
  final AuthorTrendingModel data;

  const AuthorChartWidget({Key key, this.rank, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 375,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.only(left: 32, right: 20, top: 10, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                '$rank',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data.username,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: <Widget>[
                      Text(
                        data.sumread.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 7),
                      Text(
                        'read',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10000.0),
                    child: CachedNetworkImage(
                      imageUrl: 'http://35.213.159.134/avatar/${data.image}',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.black12,
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
