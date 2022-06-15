import 'package:flutter/cupertino.dart';
import 'package:flutter_api_with_bloc/widget/palette.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DescriptionText extends StatelessWidget {
  String text;

  DescriptionText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 16.sp, color: descriptionTextColor,
      fontWeight: FontWeight.normal),
    );
  }
}
