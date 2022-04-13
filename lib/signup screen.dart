import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:form_validator/form_validator.dart';

import 'DatabaseManager.dart';
import 'classes/student.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({Key? key}) : super(key: key);

  @override
  _signup_screenState createState() => _signup_screenState();
}

class Student {}

class _signup_screenState extends State<signup_screen> {
  DateTime _date = DateTime.now();
  String d = '';
  final Storage storage = Storage();

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datepicker = (await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1995),
        lastDate: DateTime(2005)))!;
    if (_datepicker == null) return;
    setState(() {
      _date = _datepicker;
      d = _date.day.toString() +
          "/" +
          _date.month.toString() +
          "/" +
          _date.year.toString();
    });
  }

  bool loaded = false;
  Future<Null> _upLoadImage(BuildContext context) async {
    final results = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);
    if (results == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('no file')));
      return null;
    }
    final path = results.files.single.path;
    final name = results.files.single.name;

    await storage.UpLoadImage(path!, name).then((value) => print('done'));
    setState(() {
      image = storage.downloadURL;
      loaded = true;
    });
  }

  String getDate() {
    if (d == '') {
      return "Date of Birth";
    } else {
      return d;
    }
  }

  var usernameController = TextEditingController();
  var studentidController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var level;
  DatabaseManager db = DatabaseManager();
  student std = student();
  var image = 'proj_images/stud_image.jpg';

  var _username_text = '';
  var _id_text = "";
  bool _submitted = false;
  final requiredValidator =
      RequiredValidator(errorText: 'this field is required');
  String? get _error_username_Text {
    final text = usernameController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  ImageProvider returnImage() {
    if (loaded == false) {
      return AssetImage(image);
    } else {
      return NetworkImage(image);
    }
  }

  String? get _error_id_Text {
    final text = studentidController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 10 || text.length > 10) {
      return 'The ID Length Must Be 10';
    }
    // return null if the text is valid
    return null;
  }

  // bool get isValidEmail {
  //   final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  //   return emailRegExp.hasMatch(this);
  // }
  //
  // bool get isValidName{
  //   final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  //   return nameRegExp.hasMatch(this);
  // }

  bool _passwordVisible = false;
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    backgroundImage: returnImage(),
                    //  backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png_detail/20181208/male-student-icon-png_265268.jpg'),
                    radius: 60,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.blue,
                      size: 40,
                    ),
                    onPressed: () {
                      _upLoadImage(context);
                    },
                  ),
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
                  onChanged: (text) => setState(() => _username_text),
                  onFieldSubmitted: (String email) {},
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    errorText: _error_username_Text,
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
              ), //user_name text

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
                  onFieldSubmitted: (String email) {},
                  onChanged: (text) => setState(() => _id_text),
                  decoration: InputDecoration(
                    labelText: 'Student ID',
                    errorText: _error_id_Text,
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
              ), //id text

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
                  onFieldSubmitted: (String email) {},
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
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_passwordVisible,
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
              ), //pass text

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
                  onFieldSubmitted: (String pass) {},
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
              ), //confirm pass text

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
                  onTap: () {
                    _selectDate(context);
                  },
                  onFieldSubmitted: (String pass) {},
                  decoration: InputDecoration(
                    // hintText: _date.toString(),
                    hintText: getDate(),
                    labelText: "Date-Of-Birth",
                    prefixIcon: Icon(
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
              ), //Birth Date

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
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
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
                          color: Colors.blue[350],
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
                  child: MaterialButton(
                    onPressed: () {
                      if (studentidController.text.isNotEmpty &&
                          usernameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        std.id = studentidController.text;
                        std.name = usernameController.text;
                        std.email = emailController.text;
                        std.password = passwordController.text;
                        std.profile_picture = 'proj_images/login_image.jpeg';
                        std.birthdate = d;
                        db.insertNewStudent(std);
                        print("inserted");
                      } else {
                        print("not inserted");
                      }
                    },
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
      ),
    );
  }
}
