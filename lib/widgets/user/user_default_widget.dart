import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/all_user_model.dart';
import 'package:ifgpadmin/screens/users/profile_screen.dart';
import 'package:ifgpadmin/service/user_api.dart';

class UserDefaultWidget extends StatefulWidget {
  @override
  _UserDefaultWidgetState createState() => _UserDefaultWidgetState();
}

class _UserDefaultWidgetState extends State<UserDefaultWidget> {
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

              return Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                id: user.iduser,
                              ),
                            ),
                          );
                        },
                        leading: checkstatus(user),
                        title: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                user.username!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          user.email!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        trailing: user.image == null || user.image == " "
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                  'assets/second.png',
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10000.0),
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
                                      radius: 30,
                                      backgroundColor: Colors.black12,
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                    Divider(color: Colors.black),
                  ],
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  checkstatus(AllUsers user) {
    if (user.status == "active") {
      if (user.report == 3) {
        return Icon(
          Icons.error,
          color: Color(0xFFF6D167),
          size: 24,
        );
      } else {
        return Icon(
          CupertinoIcons.capsule_fill,
          color: Color(0xFF5AA469),
          size: 20,
        );
      }
    } else {
      return Icon(
        CupertinoIcons.capsule_fill,
        color: Color(0xFFC05555),
        size: 20,
      );
    }
  }
}
