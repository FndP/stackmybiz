import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'palette.dart';

class TitleText extends StatelessWidget {
  String text;
  bool isBig;
  TextAlign? textAlign;

  TitleText({required this.text, this.isBig = false, this.textAlign, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isBig ? 90.w : 70.w,
      child: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 15.sp,
            height: 1.4,
            fontWeight: FontWeight.bold,
            color: blackColor),
        textAlign: textAlign ?? TextAlign.start,
      ),
    );
  }
}
