import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/all_user_model.dart';
import 'package:ifgpadmin/service/user_api.dart';
import 'package:http/http.dart' as http;

class UserNDWidget extends StatefulWidget {
  @override
  _UserNDWidgetState createState() => _UserNDWidgetState();
}

class _UserNDWidgetState extends State<UserNDWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: APIUser.getUser(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AllUsers>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];

                  return ExpansionTile(
                    leading: Icon(
                      CupertinoIcons.capsule_fill,
                      color: user.status == "active"
                          ? Color(0xFF5AA469)
                          : Color(0xFFC05555),
                      size: 24,
                    ),
                    title: Text(
                      user.username!,
                    ),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: 14.0, bottom: 30.0, left: 18.0, right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            user.image == null || user.image == " "
                                ? CircleAvatar(
                                    radius: 38,
                                    backgroundImage:
                                        AssetImage('assets/second.png'),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(1000.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'http://35.213.159.134/avatar/${user.image}',
                                      height: 76,
                                      width: 76,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return CircleAvatar(
                                          radius: 38,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.email!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // Text(
                                  //   "Create : " + user.createdate,
                                  //   style: TextStyle(
                                  //     color: Colors.black,
                                  //     fontSize: 13.5,
                                  //   ),
                                  // ),
                                  SizedBox(height: 3),
                                  // Text(
                                  //   "Follower : " + user.follower.toString(),
                                  //   style: TextStyle(
                                  //     color: Colors.black,
                                  //     fontSize: 13.5,
                                  //   ),
                                  // ),
                                  // SizedBox(height: 3),
                                  // Text(
                                  //   "Following : " + user.following.toString(),
                                  //   style: TextStyle(
                                  //     color: Colors.black,
                                  //     fontSize: 13.5,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            user.status == "active"
                                ? ElevatedButton(
                                    onPressed: () {
                                      openalertbox(user);
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
                                : Text("Blocked")
                          ],
                        ),
                      ),
                    ],
                  );
                });
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  openalertbox(AllUsers user) {
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
