import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp/Home.dart';
import 'package:gp/signup%20screen.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<Login_screen> {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Structured Programming"
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
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage('proj_images/login_image.jpeg'),
                    fit: BoxFit.fill,
                  ),
                ),

              ),//image

              SizedBox(
                height: 20,
              ),

             /* Text(

                  "Login",
                  style: TextStyle(
                    fontSize: 32,
                    color : Colors.blue[600],
                    fontWeight: FontWeight.bold,
               fontStyle: FontStyle.italic,

               //     decorationStyle: TextDecorationStyle.solid,
                 //   decoration: TextDecorationStyle.solid
                  ),

                ),//login word*/
              CircleAvatar(
                backgroundImage:AssetImage('proj_images/stud_image.jpg'),
              //  backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png_detail/20181208/male-student-icon-png_265268.jpg'),
             radius: 50,

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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,

                  onFieldSubmitted: (String pass){

                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: Colors.blue[400],
                    ),
                    suffixIcon:Icon(

                      Icons.remove_red_eye,
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
              ),//pass text

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),

                  child: Container(
                    width: double.infinity,

                    child: MaterialButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=>Home(0)
                          )
                      );
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
