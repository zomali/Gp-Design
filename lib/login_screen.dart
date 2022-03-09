import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gp/Home.dart';
import 'package:gp/signup%20screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<Login_screen> {
  String email="";
  var password="";
  final _auth=FirebaseAuth.instance;
  bool _passwordVisible=false;
  bool _remembercheck=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 30,
        title: Text(

          "Personalized E-learning System"
        ),

      ),
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          width: double.infinity,
          decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   width: double.infinity,
              //   height: 100,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image:AssetImage('proj_images/login_image.jpeg'),
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              //
              // ),//image
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //
              //     padding: const EdgeInsets.all(20),
              //     child: Row(
              //       children: [
              //         Container(
              //           width: 70,
              //           height: 70,
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image:AssetImage('proj_images/Ain_Shams_logo.png'),
              //               fit: BoxFit.fill,
              //             ),
              //           ),
              //
              //         ),//image
              //         SizedBox(
              //           width: 20,
              //         ),
              //         Text(
              //           "Welcome To FCIS \n"
              //               "AinShams University",
              //           style: TextStyle(
              //             fontSize: 17,
              //             fontWeight: FontWeight.bold,
              //           ),
              //
              //         ),
              //
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Container(


                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage('proj_images/Ain_Shams_logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),

              ),//image
              Text(
                "Welcome To FCIS AinShams University",
                style: TextStyle(

                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),

              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   "Welcome To FCIS \n"
              //       "AinShams University",
              //   style: TextStyle(
              //     fontSize: 17,
              //     fontWeight: FontWeight.bold,
              //   ),
              //
              // ),
             //  CircleAvatar(
             //    backgroundImage:AssetImage('proj_images/stud_image.jpg'),
             //  //  backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png_detail/20181208/male-student-icon-png_265268.jpg'),
             // radius: 50,
             //
             //  ),
             //
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
                  onChanged: (value){
                    email=value;
                  },
                  onFieldSubmitted: (String email){

                  },
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
              ),//e-mail text

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

                  onChanged: (value){
                    password=value;
                  },

                  onFieldSubmitted: (String pass){

                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: Colors.blue[400],
                    ),

                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible?Icons.visibility:Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onPressed: (){
                        setState(() {
                          _passwordVisible=!_passwordVisible;
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
              ),//pass text

              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon:Icon(
                        _remembercheck?Icons.check_box:Icons.check_box_outline_blank,
                        color: Colors.blue,

                      ), onPressed: () {
                        setState(() {
                          _remembercheck=!_remembercheck;

                        });

                    },
                    ),//remembercheck
                    Text(
                      "Remember Password",
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 15,

                      ),
                    ),//remember pass word

                    SizedBox(
                      width: 40,
                    ),
                    TextButton(onPressed: (){

                    }, child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                      fontSize: 14,
                    ),
                    ),

                    ),
                   ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),

                  child: Container(
                    width: double.infinity,

                    child: MaterialButton(onPressed: () async{
                      try{

                     //   await _auth.createUserWithEmailAndPassword(email: email, password: password);

                        await _auth.signInWithEmailAndPassword(email: email, password: password);
                        await Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>Home(0)
                            )
                        );
                      }
                      on FirebaseAuthException catch (e) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                            title: Text("Ops! Login Failed"),
                            content: Text('${e.message}'),
                               )
                        );


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
                        color: Colors.blue[500],
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),

                  ),
                ),//login btn

              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>signup_screen()
                        )
                    );
                  }, child: Text(
                    "Register Now",
                  ),
                  ),
                ],
              )//register now


            ],
          ),
        ),
      ),
    );
  }
}
