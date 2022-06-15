import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_with_bloc/network/bloc/post/post_bloc.dart';
import 'package:flutter_api_with_bloc/network/bloc/post/post_events.dart';
import 'package:flutter_api_with_bloc/network/bloc/view_state.dart';
import 'package:flutter_api_with_bloc/network/model/post_response.dart';
import 'package:flutter_api_with_bloc/utils/constants.dart';
import 'package:flutter_api_with_bloc/widget/head_text.dart';
import 'package:flutter_api_with_bloc/widget/palette.dart';
import 'package:flutter_api_with_bloc/widget/profile_thumb.dart';
import 'package:flutter_api_with_bloc/widget/title_text.dart';
import 'package:flutter_api_with_bloc/widget/common/error_message.dart';
import 'package:flutter_api_with_bloc/widget/common/loading_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import 'post_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(10.h),
            child: SafeArea(
              child: Container(
                color: whiteColor,
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                margin: EdgeInsets.symmetric(vertical: 3.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ProfileThumb(
                      imgUrl: randomLandScapeImageUrl,
                    ),
                    HeadText(
                      text: "Posts list",
                      // textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 6.h,
                      width: 6.h,
                      child: FittedBox(
                        child: Image.asset(
                          'assets/img_menu.png',
                          width: 1.2.h,
                          height: 3.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: BlocBuilder<PostBloc, ViewState>(
              builder: (BuildContext c, ViewState state) {
            if (state is ErrorState) {
              final error = state.error;
              return ErrorMessage(error: '${error}\nTap to Retry.',
              callBack: (){
                loadPost();
              },);
            } else if (state is LoadedState) {
              return ListView.separated(
                itemCount: state.postResponse!.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return index == 0
                      ? postBigItemWidget(state.postResponse![index], index)
                      : postItemWidget(state.postResponse![index], index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return divider();
                },
              );
            } else if (state is LoadingState) {
              return LoadingPageIndicator();
            } else if (state is Empty) {
              return ErrorMessage(error: '${state.msg}',callBack: (){
                loadPost();
              });
            }
            return LoadingPageIndicator();
          }),
        ),
        bottomNavigationBar: Container(
          height: 8.h,
          color: whiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              tabItem(currentPage == 0, 'img_home'),
              tabItem(currentPage == 1, 'img_posts'),
              tabItem(currentPage == 2, 'img_person'),
            ],
          ),
        ),
      ),
    );
  }

  void loadPost() {
    context.read<PostBloc>().add(PostEvents.fetchData);
  }

  Widget tabItem(bool isActive, String imgName) {
    return Image.asset(
      'assets/$imgName.png',
      width: 3.h,
      height: 4.h,
      color: isActive ? Colors.black : Colors.grey,
    );
  }

  Widget postItemWidget(PostResponse postData, int index) {
    return GestureDetector(
      onTap: () {
        ///to show post details
        gotoPostDetailScreen(postData, index);
      },
      child: FittedBox(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2.5.h),
          color: whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///thumb img
              Container(
                height: 20.w,
                width: 20.w,
                margin: EdgeInsets.only(right: 3.w),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("$randomImageUrl$index")),
                    borderRadius: BorderRadius.all(Radius.circular(4.w))),
              ),

              ///post title
              TitleText(text: '${postData.title}')
            ],
          ),
        ),
      ),
    );
  }

  Widget postBigItemWidget(PostResponse postData, int index) {
    return GestureDetector(
      onTap: () {
        ///to show post details
        gotoPostDetailScreen(postData, index);
      },
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///thumb image
            Container(
              height: 24.h,
              width: 90.w,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(randomLandScapeImageUrl)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),

            ///post title
            TitleText(
              text: "${postData.title}",
              isBig: true,
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }

  void gotoPostDetailScreen(PostResponse postData, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostDetailScreen(
                postData: postData,
                index: index
              )),
    );
  }
}
