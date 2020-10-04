import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userprofile_demo/DatabaseManager/DatabaseManager.dart';
import 'package:userprofile_demo/Services/AutheticationServices.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthenticationServices _auth = AuthenticationServices();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();

  List userProfilesList = [];
  String userID = "";

  @override
  void initState() {
    super.initState();
    fectuserInfo();
    fectDatabaseList();
  }

  fectuserInfo() async {
    FirebaseUser getuser = await FirebaseAuth.instance.currentUser();
    userID = getuser.uid;
  }

  fectDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUserslist();
    if (resultant == null) {
      print("Unable to retrive");
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  updateData(String name, String gender, int score, String userID)async{
    await DatabaseManager().updateUserList(name, gender, score, userID);
    fectDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          RaisedButton(
              color: Colors.deepPurpleAccent,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                openDialogBox(context);
              }),
          RaisedButton(
              color: Colors.deepPurpleAccent,
              child: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () async {
                await _auth.signOut().then((result) {
                  Navigator.of(context).pop(true);
                });
              }),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: userProfilesList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(userProfilesList[index]['name']),
                subtitle: Text(userProfilesList[index]['gender']),
                leading: CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/userprofile.jpg'),
                  ),
                ),
                trailing: Text('${userProfilesList[index]['score']}'),
              ),
            );
          },
        ),
      ),
    );
  }

  openDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit User"),
            content: Container(
                height: 150,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                    TextFormField(
                      controller: _genderController,
                      decoration: InputDecoration(
                        hintText: "Gender",
                      ),
                    ),
                    TextFormField(
                      controller: _scoreController,
                      decoration: InputDecoration(
                        hintText: "Score",
                      ),
                    ),
                  ],
                )),
            actions: [
              FlatButton(onPressed: () {
                submitAction(context);
                Navigator.pop(context);
              }, child: Text("Submit")),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ],
          );
        });
  }

  submitAction(BuildContext context) {
    updateData(_nameController.text, _genderController.text, int.parse(_scoreController.text), userID);
    _nameController.clear();
    _genderController.clear();
    _scoreController.clear();
  }
}
