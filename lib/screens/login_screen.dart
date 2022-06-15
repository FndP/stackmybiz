
import 'package:flutter/material.dart';
import 'package:flutter_api_with_bloc/screens/dashboard_screen.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';
import '../utils/google_sign_out.dart';
import '../utils/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Padding(
          padding:  EdgeInsets.only(left: 4.w,right: 4.w),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 6.h),
                  height: 40.w,
                  width: 40.w,
                  child: Icon(Icons.flutter_dash, size: 40.w),
                )
              ),
              SizedBox(
                height: 4.w,
              ),
              Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, fontFamily: 'MatterRegular'),
              ),
              SizedBox(
                height: 4.w,
              ),
              GestureDetector(
                onTap: (){
                  signInWithGoogle().then((user) {
                    if (user.user != null && user.user!.uid != null) {
                      storage.write('login', true);

                      ///move to dash board screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen()));
                    }
                  });
                },
                child: SizedBox(
                  height: 12.w,
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 6.w,
                        width: 6.w,
                        child: Image.asset("assets/images/google.png"),
                      ),
                      SizedBox(width: 1.w,),
                      Text("Login with Google",style: TextStyle(fontSize: 16.sp,color: const Color(0xffda3c23),
                          fontFamily: 'MatterMedium'),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
