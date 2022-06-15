import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_with_bloc/network/model/post_response.dart';
import 'package:flutter_api_with_bloc/utils/constants.dart';
import 'package:flutter_api_with_bloc/widget/big_head_text.dart';
import 'package:flutter_api_with_bloc/widget/normal_text.dart';
import 'package:flutter_api_with_bloc/widget/palette.dart';
import 'package:flutter_api_with_bloc/widget/profile_thumb.dart';
import 'package:flutter_api_with_bloc/widget/small_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'post_comments_screen.dart';

class PostDetailScreen extends StatefulWidget {
  PostResponse postData;
  int index;

  PostDetailScreen({required this.postData, required this.index, Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(30.h),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage("$randomImageUrl${widget.index}")),

              ),
              child: Container(
                height: 30.h,
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.2),
                      ],
                      begin: const FractionalOffset(0.1, 0.0),
                      end: const FractionalOffset(0.0, 1.5),
                      stops: [0.0, 0.3],
                      tileMode: TileMode.clamp),
                    ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_rounded,size: 8.w,),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            )),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///post title
                BigHeadText(
                  text: "${widget.postData.title}",
                ),

                ///post author
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileThumb(imgUrl: randomLandScapeImageUrl,
                    height: 15.w,
                    width: 15.w,
                    margin: EdgeInsets.only(right: 3.w, top: 3.h, bottom: 3.h),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'By Leanne Graham',
                            style: GoogleFonts.poppins(
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp),
                            recognizer: LongPressGestureRecognizer()
                              ..onLongPress = () {
                                // Long Pressed.
                              },
                          ),
                          TextSpan(
                            text: '\nRomaguera-Crona',
                            style: GoogleFonts.poppins(
                                color: greyColor, fontSize: 13.sp),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Single tapped.
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                ///post body text
                DescriptionText(text:"${widget.postData.body}"),

                ///view comments button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostCommentsScreen(postData:
                          widget.postData,)),
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.all(1.2.h),
                      margin: EdgeInsets.symmetric(vertical: 3.h),
                      decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.h))),
                      child: SmallText(
                        text: "View comments",
                        color: whiteTextColor,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
