import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ifgpadmin/models/user_model.dart';
import 'package:ifgpadmin/screens/users/widget/profile_content_widget.dart';

class ProfileScreen extends StatefulWidget {
  final id;

  const ProfileScreen({Key key, this.id}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<List<User>> fetchdatauser() async {
    try {
      final url =
          Uri.parse("http://35.213.159.134/myprofile.php?profile=${widget.id}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List users = json.decode(response.body);
        return users.map((e) => User.fromJson(e)).toList();
      } else {
        print("API USER FAILED");
      }
    } catch (e) {}
    return [];
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
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: [
          // profile part
          Container(
            child: FutureBuilder(
                future: fetchdatauser(),
                builder: (context, AsyncSnapshot<List<User>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          User profile = snapshot.data[index];

                          return Container(
                            padding: EdgeInsets.only(
                                left: 17.0, right: 14.0, top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // avatar
                                profile.image == null || profile.image == ""
                                    ? CircleAvatar(
                                        radius: 43,
                                        backgroundImage:
                                            AssetImage('assets/second.png'),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10000.0),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'http://35.213.159.134/avatar/${profile.image}',
                                          width: 86,
                                          height: 86,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                          errorWidget: (context, url, error) {
                                            return CircleAvatar(
                                              radius: 43,
                                              backgroundColor: Colors.black12,
                                              child: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            );
                                          },
                                        ),
                                      ),

                                // all details
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        profile.username,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.7,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        profile.email,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(height: 1.0),
                                      Text(
                                        "created : " + profile.createdate,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      buildfollow(
                                        profile.following.toString(),
                                        profile.follower.toString(),
                                      ),
                                    ],
                                  ),
                                ),
                                profile.status == "active"
                                    ? ElevatedButton(
                                        onPressed: () {
                                          openalertbox(profile);
                                        },
                                        child: Text(
                                          "Block",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red.shade900,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            )),
                                      )
                                    : Text("Blocked"),
                              ],
                            ),
                          );
                        });
                  }

                  return Container(
                    margin: EdgeInsets.all(30.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
          ),
          SizedBox(height: 25.0),

          // content part
          ProfileContentWidget(
            id: widget.id,
          ),
        ],
      ),
    );
  }

  Widget buildfollow(String follow, String following) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            following,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13.5,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 5.5),
          Text(
            "following",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.5,
            ),
          ),
          SizedBox(width: 12),
          Text(
            following,
            style: TextStyle(
                color: Colors.black,
                fontSize: 13.5,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 5.5),
          Text(
            "followers",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }

  // alert box for block button
  openalertbox(User user) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0))),
            contentPadding: EdgeInsets.only(top: 15.0),
            content: Container(
              padding: EdgeInsets.only(bottom: 16.0),
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
                        "Block Account",
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
                        "this account will be blocked and suspended, Are you sure?",
                        style: TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                        onTap: () async {
                          Navigator.of(context).pop();
                          final url =
                              Uri.parse('http://35.213.159.134/statususer.php');
                          final response = await http.post(url, body: {
                            "ID_User": user.iduser.toString(),
                            'Block': '',
                          });
                          if (response.statusCode == 200) {
                            // print('already BLOCK!');
                            print('block user : ' + user.iduser.toString());
                          } else {
                            throw 'Failed';
                          }
                        },
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.only(
                              top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Text(
                            "Block",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
