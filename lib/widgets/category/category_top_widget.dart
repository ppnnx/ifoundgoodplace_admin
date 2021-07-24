import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopCategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
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
            'categories',
            style: GoogleFonts.lora(color: Colors.black, fontSize: 32),
          ),
        ],
      ),
    );
  }
}