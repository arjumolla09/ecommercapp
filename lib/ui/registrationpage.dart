
import 'package:ecommercapp/const/appcolor.dart';
import 'package:ecommercapp/const/custombutton.dart';
import 'package:ecommercapp/ui/loginpage.dart';
import 'package:ecommercapp/ui/userform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Registrationwidget extends StatefulWidget {
  const Registrationwidget({Key? key}) : super(key: key);

  @override
  _RegistrationwidgetState createState() => _RegistrationwidgetState();
}

class _RegistrationwidgetState extends State<Registrationwidget> {
  @override
  final _formkeys = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must have at least one special character')
  ]);

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool _obscureText = true;
  signup() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => Userwidget()));
      } else {
        (Fluttertoast.showToast(msg: "Something went wrong"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    String password;
    return Scaffold(
      backgroundColor: appcolor.mycolor,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 150.h,
            width: ScreenUtil().screenWidth,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    "Registration",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  )),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formkeys,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Welcome To Registration",
                          style: TextStyle(
                              fontSize: 22.sp, color: appcolor.mycolor),
                        ),
                        Text(
                          "Glad to see you",
                          style: TextStyle(
                              fontSize: 14.sp, color: Color(0xFFBBBBBB)),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(
                                  color: appcolor.mycolor,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: TextFormField(
                              validator: EmailValidator(
                                  errorText: "Enter a valid email"),
                              controller: _emailcontroller,
                              decoration: InputDecoration(
                                  hintText: "Enter your email address",
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xFF414041),
                                  ),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: appcolor.mycolor,
                                  )),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(
                                  color: appcolor.mycolor,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: TextFormField(
                              validator: passwordValidator,
                              onChanged: (val) => password = val,
                              controller: _passwordcontroller,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: "Password must be 8 character",
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF414041),
                                ),
                                labelText: "Enter Password",
                                labelStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: appcolor.mycolor,
                                ),
                                suffixIcon: _obscureText == true
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = false;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          size: 20.w,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = true;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.visibility_off,
                                          size: 20.w,
                                        ),
                                      ),
                              ),
                            ))
                          ],
                        ),
                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       height: 48.h,
                        //       width: 41.w,
                        //       decoration: BoxDecoration(
                        //           color: appcolor.mycolor,
                        //           borderRadius: BorderRadius.circular(12.r)),
                        //       child: Center(
                        //         child: Icon(
                        //           Icons.email_outlined,
                        //           color: Colors.white,
                        //           size: 20.w,
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10.w,
                        //     ),
                        //     Expanded(
                        //         child: TextField(
                        //       decoration: InputDecoration(
                        //           hintText: "Password must be 8 character",
                        //           hintStyle: TextStyle(
                        //             fontSize: 14.sp,
                        //             color: Color(0xFF414041),
                        //           ),
                        //           labelText: "Confirm Password",
                        //           labelStyle: TextStyle(
                        //             fontSize: 15.sp,
                        //             color: appcolor.mycolor,
                        //           )),
                        //     ))
                        //   ],
                        // ),
                        SizedBox(
                          height: 50.h,
                        ),
                        // SizedBox(
                        //   width: 1.sw,
                        //   height: 56.w,
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       if (_formkeys.currentState!.validate()) {
                        //         return signup();
                        //       }
                        //     },
                        //     child: Text(
                        //       "SIGN UP",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 18.sp,
                        //       ),
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //         primary: appcolor.mycolor, elevation: 3),
                        //   ),
                        // ),
                        CustomButton("Sign Up", () {
                          if (_formkeys.currentState!.validate()) {
                            return signup();
                          }
                        }),
                        SizedBox(
                          height: 20.h,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Have an account?",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFBBBBBB),
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: appcolor.mycolor,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Loginwidget()));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
