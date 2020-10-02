
import 'package:flutter/material.dart';
import 'package:userprofile_demo/Loginscreen.dart';
import 'package:userprofile_demo/Services/AutheticationServices.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final AuthenticationServices _auth = AuthenticationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent,
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Name can't be empty";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email can't be empty";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value.length < 3) {
                            return "Password should more than 3 charachers";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                                child: Text("Sign Up"),
                                onPressed: () {
                                  if (_key.currentState.validate()) {
                                    createUser();
                                  }
                                }),
                            RaisedButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createUser() async{
    dynamic result = await _auth.createNewUser(_emailController.text, _passwordController.text);
    if(result == null){
      print("Email is not Valid");
    }else{
      print(result.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
