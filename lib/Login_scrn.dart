import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gp/set_new_password.dart';
import 'package:gp/shared/cubits/cubit/student_cubit.dart';
import 'package:gp/signup%20screen.dart';

import 'DatabaseManager.dart';
import 'Sidebar/sidebar_layout.dart';
import 'analysis_controller.dart';
import 'classes/student.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  String email = "";
  String password = "";
  final _auth = FirebaseAuth.instance;
  bool _passwordVisible = false;
  //bool _remembercheck = false;
  final _formKey = GlobalKey<FormState>();
  DatabaseManager db = DatabaseManager();

  bool studentExist(var emailEntered, var passwordEnteres, List<student> listStudents) {
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('proj_images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Builder(builder: (context){
            StudentCubit.get(context).getStudentData();
            return BlocBuilder<StudentCubit, StudentState>(
              builder: (context, state) {
                if (state is StudentLoading)
                  return Center(child: CircularProgressIndicator());
                else {
                  var studentCubit = StudentCubit.get(context);
                  var list = studentCubit.list;
                  return  Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, top: 90),
                            child: Text(
                              'Personalized\nE-learning System',
                              style: TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: 20, top: 90),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.cyan[400],
                              child: Container(
                                width: 100,
                                height:100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                    AssetImage('proj_images/Ain_Shams_logo.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 35, right: 35),
                                child: Column(
                                  children: [
                                    TextFormField(
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
                                          color: Colors.blue[400],
                                        ),
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
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
                                          color: Colors.blue[400],
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.blue,
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
                                            color: Colors.blue,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sign in',
                                          style: TextStyle(color: Colors.black54,
                                              fontSize: 27, fontWeight: FontWeight.w700),
                                        ),
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.blue,
                                          child: IconButton(

                                              color: Colors.white,
                                              onPressed: () {
                                                try {
                                                  //  await _auth.createUserWithEmailAndPassword(email: email, password: password);

                                                  if (studentExist(email, password, list)) {
                                                    student std = studentLevel(email, list);
                                                    Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => side_layout(std)),
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
                                              icon: Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => signup_screen()));
                                          },
                                          child: Text(
                                            'Sign Up',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Colors.lightBlue,
                                                fontSize: 18),
                                          ),
                                          style: ButtonStyle(),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              showDialogFunc(context);
                                            },
                                            child: Text(
                                              'Forgot Password',
                                              style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Colors.lightBlue,
                                                fontSize: 18,
                                              ),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

              },
            );






          },),
        ),
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
                          color: Colors.blue),
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
                                  color: Colors.blue),
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
                                  colors: [Colors.blue, Colors.blue]),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.blue,
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