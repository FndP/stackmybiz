import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_with_bloc/network/bloc/comment/comment_bloc.dart';
import 'package:flutter_api_with_bloc/network/bloc/comment/comment_events.dart';
import 'package:flutter_api_with_bloc/network/bloc/view_state.dart';
import 'package:flutter_api_with_bloc/network/model/comment_response.dart';
import 'package:flutter_api_with_bloc/network/model/post_response.dart';
import 'package:flutter_api_with_bloc/widget/head_text.dart';
import 'package:flutter_api_with_bloc/widget/palette.dart';
import 'package:flutter_api_with_bloc/widget/common/error_message.dart';
import 'package:flutter_api_with_bloc/widget/common/loading_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class PostCommentsScreen extends StatefulWidget {
  PostResponse postData;

  PostCommentsScreen({required this.postData, Key? key}) : super(key: key);

  @override
  State<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen> {
  @override
  void initState() {
    super.initState();
    loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        color: lightPurpleColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(10.h),
                child: Container(
                  color: lightPurpleColor,
                  padding: EdgeInsets.all(2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          size: 8.w,
                        ),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      HeadText(text: "Post comments"),
                      IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.transparent,
                        onPressed: () {},
                      )
                    ],
                  ),
                )),
            body: BlocBuilder<CommentBloc, ViewState>(
                builder: (BuildContext c, ViewState state) {
              if (state is ErrorState) {
                final error = state.error;
                return ErrorMessage(
                    error: '${error.message}\nTap to Retry.',
                    callBack: () {
                      loadPost();
                    });
              } else if (state is LoadedState) {
                return ListView.builder(
                  itemCount: state.commentResponse!.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return commentItemView(
                        commentResponse: state.commentResponse![index]);
                  },
                );
              } else if (state is LoadingState) {
                return LoadingPageIndicator();
              } else if (state is Empty) {
                return ErrorMessage(
                    error: '${state.msg}',
                    callBack: () {
                      loadPost();
                    });
              }
              return LoadingPageIndicator();
            }),
          ),
        ),
      ),
    );
  }

  Widget commentItemView({required CommentResponse commentResponse}) {
    return Container(
      height: 26.h,
      margin: EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 1.5.h),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
      decoration: BoxDecoration(
          color: lightPurpleColor,
          borderRadius: BorderRadius.all(Radius.circular(2.h))),
      child: RichText(
        softWrap: true,
        overflow: TextOverflow.clip,
        maxLines: 7,
        text: TextSpan(
          text: '${commentResponse.name}',
          style: GoogleFonts.poppins(
            color: blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,),
          children: [
            TextSpan(
              text: '\n${commentResponse.body}',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: greyColor,
                  fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }

  void loadPost() {
    context.read<CommentBloc>().add(FetchData("${widget.postData.id}"));
  }
}
