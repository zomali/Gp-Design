import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/Home.dart';
import 'package:gp/Sidebar/BlockNavigation.dart';
import 'package:gp/Sidebar/sidebar_layout.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/set_new_password.dart';
import 'package:gp/shared/cubits/cubit/student_cubit.dart';
import 'package:gp/signup%20screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'analysis_controller.dart';
import 'DatabaseManager.dart';

class Login_screen extends StatefulWidget with NavigationStates {
  const Login_screen({Key? key}) : super(key: key);

  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<Login_screen> {
  String email = "";
  String password = "";
  final _auth = FirebaseAuth.instance;
  bool _passwordVisible = false;
  bool _remembercheck = false;
  final _formKey = GlobalKey<FormState>();
  DatabaseManager db = DatabaseManager();

  bool studentExist(
      var emailEntered, var passwordEnteres, List<student> listStudents) {
    for (var std in listStudents) {
      // print(std.email + "====" + std.password);
      if (std.email == emailEntered.toString() &&
          std.password == passwordEnteres.toString()) return true;
    }
    return false;
  }

  student studentLevel(String email, List<student> list) {
    student std = student();
    for (std in list) {
      if (std.email == email.toString()) return std;
    }
    return std;
  }

  analysis_controller ss = new analysis_controller();

  @override
  Widget build(BuildContext context) {
    ss.cluster_performence('2018170065');
    //db.update2();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 30,
        title: Text("Personalized E-learning System"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          StudentCubit.get(context).getStudentData();
          return BlocBuilder<StudentCubit, StudentState>(
            builder: (context, state) {
              if (state is StudentLoading)
                return Center(child: CircularProgressIndicator());
              else {
                var studentCubit = StudentCubit.get(context);
                var list = studentCubit.list;
                return SingleChildScrollView(
                  child: Container(
                    height: 800,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'proj_images/Ain_Shams_logo.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 50, right: 20),
                        //   child: Row(
                        //     children: [
                        //       // SizedBox(
                        //       //   width: 50,
                        //       // ),
                        //       CircleAvatar(
                        //         radius: 40,
                        //         backgroundColor: Colors.white,
                        //         child: Container(
                        //           width: 90,
                        //           height: 90,
                        //           decoration: BoxDecoration(
                        //             image: DecorationImage(
                        //               image: AssetImage(
                        //                   'proj_images/Ain_Shams_logo.png'),
                        //               fit: BoxFit.fill,
                        //             ),
                        //           ),
                        //         ),
                        //       ), //image
                        //       // Spacer(),
                        //       // CircleAvatar(
                        //       //   radius: 60,
                        //       //   backgroundColor: Colors.white,
                        //       //   child: Container(
                        //       //     width: 90,
                        //       //     height: 90,
                        //       //     decoration: BoxDecoration(
                        //       //       image: DecorationImage(
                        //       //         image: AssetImage('proj_images/fcis.png'),
                        //       //         fit: BoxFit.fill,
                        //       //       ),
                        //       //     ),
                        //       //   ),
                        //       // ), //image
                        //     ],
                        //   ),
                        // ),

                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: TextFormField(
                            //   controller: email,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                            onFieldSubmitted: (String email) {},
                            validator: EmailValidator(
                                errorText: 'enter a valid email address'),
                            decoration: InputDecoration(
                              labelText: 'E-mail Address',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(0xFF1565C0),
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF1565C0),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ), //e-mail text

                        SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: TextFormField(
                            //controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !_passwordVisible,

                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value == "" || value == null) {
                                return "Please Enter Valid Password ";
                              } else if (value.length < 6) {
                                return "The Password Length must Be 6 At Least";
                              }
                              return null;
                            },

                            onFieldSubmitted: (String pass) {},
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                color: Color(0xFF1565C0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xFF1565C0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF1565C0),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ), //pass text

                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _remembercheck
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: Color(0xFF1565C0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _remembercheck = !_remembercheck;
                                    });
                                  },
                                ), //remembercheck
                                Text(
                                  "Remember Password",
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ), //remember pass word

                                SizedBox(
                                  width: 40,
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialogFunc(context);
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Container(
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () async {
                                try {
                                  //  await _auth.createUserWithEmailAndPassword(email: email, password: password);

                                  if (studentExist(email, password, list)) {
                                    student std = studentLevel(email, list);
                                    std.collabretive = false;
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              side_layout(std)),
                                      (Route<dynamic> route) => false,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "not exist",
                                        toastLength: Toast.LENGTH_LONG,
                                        //    gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black87,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                } on FirebaseAuthException catch (e) {
                                  Fluttertoast.showToast(
                                      msg: "Ops! Login Failed, ${e.message} ",
                                      toastLength: Toast.LENGTH_LONG,
                                      //    gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black87,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue[800],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                          ),
                        ), //login btn

                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signup_screen()));
                              },
                              child: Text(
                                "Register Now",
                              ),
                            ),
                          ],
                        ), //register now
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        }),
      ),
    );
  }
}

showDialogFunc(context) {
  var height = 400;
  var width = 250;
  var email;
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(5),
              height: 420,
              width: MediaQuery.of(context).size.width * 2.7,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.15),
                height: height * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: ListView(
                  children: [
                    SizedBox(height: height * 0.08),
                    Text(
                      'reset password'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Center(
                      child: Container(
                        height: 1,
                        width: width * 0.8,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.15,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: EmailValidator(
                              errorText: 'enter a valid email address'),
                          onChanged: (value) {
                            email = value;
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "Your Email * ",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Color(0xFF1565C0)),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Colors.grey),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (email == "" || email == null) {
                          Fluttertoast.showToast(
                            msg: "Please Enter Your Email ", // message
                            toastLength: Toast.LENGTH_SHORT, // length
                            gravity: ToastGravity.BOTTOM, // location
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        }
                        return null;
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 26, vertical: 10),
                          decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [Color(0xFF1565C0), Color(0xFF1565C0)]),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0xFF1565C0),
                                    offset: Offset(2, 2))
                              ]),
                          child: Text(
                            "Reset".toUpperCase(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.7),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      );
    },
  );
}
