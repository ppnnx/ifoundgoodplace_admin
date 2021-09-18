import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 30, bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          Text(
            'users',
            style: GoogleFonts.lora(color: Colors.black, fontSize: 32),
          ),
        ],
      ),
    );
  }
}
