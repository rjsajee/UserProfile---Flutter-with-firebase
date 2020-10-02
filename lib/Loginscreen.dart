import 'package:flutter/material.dart';
import 'package:userprofile_demo/Registerscreen.dart';
import 'package:userprofile_demo/Services/AutheticationServices.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();

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
                  "Login",
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
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                            "Not Registerd? Signup",
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(height: 20),
                      RaisedButton(
                          child: Text("Login"),
                          onPressed: () {
                            if (_key.currentState.validate()) {
                              signInUser();
                            }
                          }),
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

  void signInUser() async{
    dynamic authResult = await _auth.signInUser(_emailController.text, _passwordController.text);
    if(authResult==null){
      print("Signin Error");
    }else{
      _emailController.clear();
      _passwordController.clear();
      print("Sign In Sucess");
    }
  }
}
