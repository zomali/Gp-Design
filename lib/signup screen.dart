import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class signup_screen extends StatefulWidget {
  const signup_screen({Key? key}) : super(key: key);

  @override
  _signup_screenState createState() => _signup_screenState();
}
class Student{

}
class _signup_screenState extends State<signup_screen> {
  DateTime _date=DateTime.now();

  Future<Null>_selectDate(BuildContext context)async{
    DateTime _datepicker=(await showDatePicker(context: context, initialDate: DateTime(2000), firstDate: DateTime(1995), lastDate:DateTime(2005)))!;
    if(_datepicker!=null&&_datepicker!=_date){
      _date=_datepicker;
    }
  }
  var usernameController=TextEditingController();
  var studentidController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmpasswordController=TextEditingController();
  var level;
  bool _passwordVisible=false;
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign up"
        ),
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 10,
              //     bottom: 10,
              //
              //   ),
              //   child: Text(
              //
              //     "Sign up",
              //     style: TextStyle(
              //       fontSize: 32,
              //       color : Colors.blue[600],
              //       fontWeight: FontWeight.bold,
              //       fontStyle: FontStyle.italic,
              //
              //
              //     ),
              //
              //   ),
              // ),//signup word
              SizedBox(
                height: 20,
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    backgroundImage:AssetImage('proj_images/stud_image.jpg'),
                    //  backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png_detail/20181208/male-student-icon-png_265268.jpg'),
                    radius: 60,

                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,

                  ),
                IconButton(

                  icon: const Icon(Icons.camera_alt,color: Colors.blue,size:40,),

                   onPressed: (){},),
                ],
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
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (String email){

                  },
                  decoration: InputDecoration(
                    labelText: 'User Name',

                    prefixIcon: Icon(
                      Icons.drive_file_rename_outline,
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
              ),//user_name text

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  controller: studentidController,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (String email){

                  },
                  decoration: InputDecoration(
                    labelText: 'Student ID',

                    prefixIcon: Icon(
                      Icons.perm_identity,
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
              ),//id text

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
                  obscureText: !_passwordVisible,

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

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  controller: confirmpasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_passwordVisible,

                  onFieldSubmitted: (String pass){

                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: Colors.blue[400],
                    ),
                    // suffixIcon:Icon(
                    //   Icons.remove_red_eye,
                    //   color: Colors.blue[400],
                    // ),
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
              ),//confirm pass text

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  readOnly: true,

                  onTap: (){
                    setState(() {
                      _selectDate(context);
                    });
                  },
                  onFieldSubmitted: (String pass){

                  },
                  decoration: InputDecoration(


                   // hintText: _date.toString(),
                    hintText: _date.day.toString(),
                    labelText: "Date-Of-Birth",
                    prefixIcon:Icon(
                      Icons.calendar_today,
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
              ),//Birth Date

              SizedBox(
                height: 20,
              ),
               Padding(
                 padding: const EdgeInsets.only(
                   left: 20,
                   right: 20,
                 ),
                 child: Container(
                   decoration: BoxDecoration(
                       border: Border.all( color: Colors.blue,
                         width: 2.0,),
                     borderRadius: BorderRadius.circular(25.0),

                   ),
                   child: Row(

                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                            "Level",
                          style: TextStyle(
                            fontSize: 25,
                            color : Colors.blue[350],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,


                          ),

                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(


                          height: 60,
                          width: 100,
                          child: DropdownButton<String>(
                            value: dropdownValue,

                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            elevation: 16,
                            iconSize: 32,

                            style: const TextStyle(
                                color: Colors.black87,
                            ),
                            onChanged: (String? newvalue){
                              setState(() {
                                dropdownValue=newvalue!;
                              });
                            },
                            items: <String>['One', 'Two', 'Three', 'Four'].
                            map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),);



                            }).toList(),
                          ),
                        ),

                      ],
                    ),
                 ),
               ),//level

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

                  child: MaterialButton(onPressed: (){},
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: Colors.white,
                      ),

                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),

                ),
              ),
              SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ) ,
    );
  }
}
