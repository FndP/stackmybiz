import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'palette.dart';

class SmallText extends StatelessWidget {
  String text;
  Color? color;

  SmallText({required this.text, this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 12.sp,
          height: 1.4,
          fontWeight: FontWeight.w500,
          color: color ?? commentTextColor),
    );
  }
}
