import 'package:flutter/cupertino.dart';
import 'package:flutter_api_with_bloc/widget/palette.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BigHeadText extends StatelessWidget {
  String text;

  BigHeadText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 26.sp,
          height: 1.4,
          fontWeight: FontWeight.bold,
          color: blackColor
      ),
    );
  }
}
