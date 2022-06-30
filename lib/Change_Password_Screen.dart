import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Change_password extends StatefulWidget {
  @override
  State<Change_password> createState() => _Change_passwordState();
}

class _Change_passwordState extends State<Change_password> {
  bool _passwordVisible=false;

  var password="";

//  const Change_password({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title:const Text("Change Password"),
        leading:const Icon(Icons.vpn_key),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              //controller: password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_passwordVisible,

              onChanged: (value){
                password=value;
              },
              validator: (value){
                if(value==""||value==null){
                  return "Please Enter Valid Password ";
                }
                else if(value.length<6){
                  return"The Password Length must Be 6 At Least";

                }
                return null;
              },

              onFieldSubmitted: (String pass){

              },
              decoration: InputDecoration(
                labelText: 'Current Password',
                prefixIcon: Icon(
                  Icons.lock_outlined,
                  color: Colors.blue[800],
                ),

                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible?Icons.visibility:Icons.visibility_off,
                    color: Colors.blue[800],
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
                    color: Colors.blue[800]!,
                    width: 2.0,
                  ),
                ),



              ),

            ),
          ),//pass text
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              //controller: password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_passwordVisible,

              onChanged: (value){
                password=value;
              },
              validator: (value){
                if(value==""||value==null){
                  return "Please Enter Valid Password ";
                }
                else if(value.length<6){
                  return"The Password Length must Be 6 At Least";

                }
                return null;
              },

              onFieldSubmitted: (String pass){

              },
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: Icon(
                  Icons.lock_outlined,
                  color: Colors.blue[800],
                ),


                border: OutlineInputBorder(),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue[800]!,
                    width: 2.0,
                  ),
                ),



              ),

            ),
          ),//pass text
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              //controller: password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_passwordVisible,

              onChanged: (value){
                password=value;
              },
              validator: (value){
                if(value==""||value==null){
                  return "Please Enter Valid Password ";
                }
                else if(value.length<6){
                  return"The Password Length must Be 6 At Least";

                }
                return null;
              },

              onFieldSubmitted: (String pass){

              },
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                prefixIcon: Icon(
                  Icons.lock_outlined,
                  color: Colors.blue[800],
                ),


                border: OutlineInputBorder(),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color:Color(0xFF1565C0),
                    width: 2.0,
                  ),
                ),



              ),

            ),
          ),//pass text
          Padding(
            padding: const EdgeInsets.all(20),

            child: Container(
              width: double.infinity,

              child: MaterialButton(onPressed: (){},
                child: Text(
                  "Change Password",
                  style: TextStyle(
                    color: Colors.white,
                  ),

                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),

            ),
          ),
        ],
      ),
    );
  }
}
