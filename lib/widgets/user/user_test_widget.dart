import 'package:flutter/material.dart';


class UserTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.amber,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://pbs.twimg.com/media/EfehCajX0AAsXiK?format=jpg&name=medium'),
            radius: 30,
          ),
          SizedBox(width: 21),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('username'),
                Text('name@example.com'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}