import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Home.dart';

import 'classes/student.dart';

class Edit_Proile_Screen extends StatefulWidget {
  final student std;
  Edit_Proile_Screen(this.std);

  @override
  _Edit_Proile_ScreenState createState() => _Edit_Proile_ScreenState(std);
}

class _Edit_Proile_ScreenState extends State<Edit_Proile_Screen> {
  final student std;
  _Edit_Proile_ScreenState(this.std);
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datepicker = (await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1995),
        lastDate: DateTime(2005)))!;
    if (_datepicker != null && _datepicker != _date) {
      _date = _datepicker;
    }
  }

  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var studentidController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('proj_images/me.jpg'),
                  //  backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png_detail/20181208/male-student-icon-png_265268.jpg'),
                  radius: 60,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 19.5,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left:650),
            //   child: Container(
            //     alignment:Alignment.centerLeft ,
            //     child: Text(
            //       "User Name",
            //       textAlign: TextAlign.left,
            //
            //       style: TextStyle(
            //         fontSize: 12,
            //         color: Colors.blue[300],
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                // initialValue: "Hazem Ali ",
                controller: usernameController,

                keyboardType: TextInputType.text,

                onFieldSubmitted: (String email) {},
                decoration: InputDecoration(
                  labelText: 'User Name',
                  hintText: std.name,
                  hintStyle: TextStyle(
                    inherit: true,
                    //fontWeight: FontWeight.bold,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,

                  alignLabelWithHint: true,
                  prefixIcon: Icon(
                    Icons.drive_file_rename_outline,
                    color: Colors.blue[400],
                  ),
                  // border: OutlineInputBorder(),
                  //  enabledBorder: OutlineInputBorder(
                  //    borderRadius: BorderRadius.circular(25.0),
                  //    borderSide: BorderSide(
                  //      color: Colors.blue,
                  //      width: 2.0,
                  //    ),
                  //
                  //  ),
                ),
              ),
            ), //user_name text
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: studentidController,

                keyboardType: TextInputType.number,
                //  initialValue:'2018170135' ,

                onFieldSubmitted: (String email) {},
                decoration: InputDecoration(
                  labelText: 'ID',
                  hintText: std.id.toString(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  alignLabelWithHint: true,
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.blue[400],
                  ),
                ),
              ),
            ), //ID text
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (String email) {},
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: std.email,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  alignLabelWithHint: true,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.blue[400],
                  ),
                ),
              ),
            ), //e-mail text

            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                readOnly: true,
                onTap: () {
                  setState(() {
                    _selectDate(context);
                  });
                },
                onFieldSubmitted: (String pass) {},
                decoration: InputDecoration(
                  //    labelText: 'Confirm Password',

                  hintText: _date.toString(),
                  labelText: "Date Of Birth",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.blue[400],
                  ),
                ),
              ),
            ), //calender text
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "Level",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue[350],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      height: 40,
                      width: 120,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        elevation: 16,
                        iconSize: 32,
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                        onChanged: (String? newvalue) {
                          setState(() {
                            dropdownValue = newvalue!;
                          });
                        },
                        items: <String>['One', 'Two', 'Three', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ), //level
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Container(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue[500],
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
              ),
            ), //save btn
          ],
        ),
      ),
    );
  }
}
