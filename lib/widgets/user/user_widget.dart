import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/all_user_model.dart';
import 'package:ifgpadmin/service/user_api.dart';
import 'package:http/http.dart' as http;

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  List<AllUsers> users = [];
  String? selected;
  bool? state;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: APIUser.getUser(),
        builder: (context, AsyncSnapshot<List<AllUsers>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  AllUsers user = snapshot.data![index];

                  return ExpansionPanelList(
                    elevation: 1,
                    dividerColor: Colors.black,
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                // name + status
                                user.status == "active"
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.green.shade600,
                                        ),
                                        child: Text(
                                          user.status!.toLowerCase(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.red.shade700,
                                        ),
                                        child: Text(
                                          user.status!.toLowerCase(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.only(left: 18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.username!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        body: Container(
                          padding:
                              EdgeInsets.only(left: 18, bottom: 40, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // avatar
                              user.image == null || user.image == " "
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('assets/second.png'),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10000.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'http://35.213.159.134/avatar/${user.image}',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return CircleAvatar(
                                            backgroundColor: Colors.black12,
                                            child: Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              SizedBox(width: 16),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      user.email!,
                                    ),
                                    SizedBox(height: 5),
                                    // Text('Created : ' + user.createdate),
                                    SizedBox(height: 5),
                                    // Text('Followers : ' +
                                    //     user.follower.toString()),
                                    // SizedBox(height: 5),
                                    // Text('Following : ' +
                                    //     user.following.toString())
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              user.status == "active"
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        final url = Uri.parse(
                                            'http://35.213.159.134/statususer.php');
                                        final response =
                                            await http.post(url, body: {
                                          "ID_User": user.iduser.toString(),
                                          'Block': '',
                                        });
                                        if (response.statusCode == 200) {
                                          print('already BLOCK!');
                                          print('block user : ' +
                                              user.iduser.toString());
                                        } else {
                                          throw 'Failed';
                                        }
                                      },
                                      child: Text('Block'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red.shade900,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        elevation: 0.0,
                                      ),
                                    )
                                  : Text('Blocked')
                              // switch status
                              // Transform.scale(
                              //   scale: 0.4,
                              //   child: LiteRollingSwitch(
                              //     //initial value
                              //     value: user.status == "Active" ? true : false,
                              //     textOn: ' ',
                              //     textOff: ' ',
                              //     colorOn: Colors.greenAccent[700],
                              //     colorOff: Colors.redAccent[700],
                              //     iconOn: Icons.done,
                              //     iconOff: Icons.remove_circle_outline,
                              //     textSize: 18.0,
                              //     onChanged: (state) {
                              //       //Use it to manage the different states

                              //       print('Current State of SWITCH IS: $state');
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        isExpanded: selected == user.username ? true : false,
                      ),
                    ],
                    expansionCallback: (int index, bool isExpanded) {
                      if (isExpanded == false) {
                        setState(() {
                          selected = user.username;
                        });
                      } else {
                        setState(() {
                          selected = '';
                        });
                      }
                    },
                  );
                });
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });

    // return FutureBuilder(
    //   future: APIUser.getUser(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return ListView.builder(
    //           shrinkWrap: true,
    //           scrollDirection: Axis.vertical,
    //           physics: BouncingScrollPhysics(),
    //           itemCount: snapshot.data.length,
    //           itemBuilder: (context, index) {
    //             User user = snapshot.data[index];

    //             return Container(
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     padding: EdgeInsets.only(
    //                         left: 19, top: 12, bottom: 14, right: 10),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         // image
    //                         user.image == null
    //                             ? CircleAvatar(
    //                                 radius: 30.0,
    //                                 backgroundColor: Colors.grey.shade100,
    //                                 child: Icon(
    //                                   Icons.face,
    //                                   color: Colors.black,
    //                                 ),
    //                               )
    //                             : ClipRRect(
    //                                 borderRadius:
    //                                     BorderRadius.circular(10000.0),
    //                                 child: CachedNetworkImage(
    //                                   imageUrl:
    //                                       'http://35.213.159.134/avatar/${user.image}',
    //                                   width: 60,
    //                                   height: 60,
    //                                   fit: BoxFit.cover,
    //                                   placeholder: (context, url) {
    //                                     return Center(
    //                                       child: CircularProgressIndicator(),
    //                                     );
    //                                   },
    //                                   errorWidget: (context, url, error) {
    //                                     return CircleAvatar(
    //                                       backgroundColor: Colors.black12,
    //                                       child: Icon(
    //                                         Icons.error,
    //                                         color: Colors.red,
    //                                       ),
    //                                     );
    //                                   },
    //                                 ),
    //                               ),
    //                         SizedBox(width: 15),
    //                         // username + email + created date
    //                         Container(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Text(
    //                                 user.username,
    //                                 style: TextStyle(
    //                                     fontSize: 16,
    //                                     fontWeight: FontWeight.w600),
    //                               ),
    //                               SizedBox(height: 12),
    //                               Text(user.email),
    //                               SizedBox(height: 3),
    //                               Text('Created : ' + user.createdate),
    //                               SizedBox(height: 3),
    //                               Text('Followers : ' +
    //                                   user.follower.toString()),
    //                               SizedBox(height: 3),
    //                               Text('Following : ' +
    //                                   user.following.toString())
    //                             ],
    //                           ),
    //                         ),

    //                         // status user
    //                         Container(
    //                           child: Column(
    //                             children: [
    //                               Container(
    //                                 padding: EdgeInsets.only(
    //                                     left: 10, right: 10, top: 6, bottom: 6),
    //                                 decoration: BoxDecoration(
    //                                   color: user.status == 'Active'
    //                                       ? Colors.green
    //                                       : Colors.red,
    //                                   borderRadius: BorderRadius.circular(14.0),
    //                                 ),
    //                                 child: Text(
    //                                   user.status,
    //                                   style: TextStyle(color: Colors.white),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 12),
    //                               Transform.scale(
    //                                 scale: 0.4,
    //                                 child: LiteRollingSwitch(
    //                                   //initial value
    //                                   value: true,
    //                                   textOn: ' ',
    //                                   textOff: ' ',
    //                                   colorOn: Colors.greenAccent[700],
    //                                   colorOff: Colors.redAccent[700],
    //                                   iconOn: Icons.done,
    //                                   iconOff: Icons.remove_circle_outline,
    //                                   textSize: 18.0,
    //                                   onChanged: (bool state) {
    //                                     //Use it to manage the different states
    //                                     print('Current State of SWITCH IS: $state');
    //                                   },
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Divider(),
    //                 ],
    //               ),
    //             );
    //           });
    //     }
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }
}
