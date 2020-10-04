import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseManager{
  final CollectionReference profileList = Firestore.instance.collection('profileInfo');

  Future<void> createUserData(String name, String gender, int score, String uid) async{
    return await profileList.document(uid).setData({
      'name': name,
      'gender': gender,
      'score': score
    });
  }

  Future updateUserList(String name, String gender, int score, String uid)async{
    return await profileList.document(uid).updateData({
      'name': name,
      'gender':gender,
      'score': score
    });
  }

  Future getUserslist() async{
    List itemList = [];
    try{
      await profileList.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemList.add(element.data);
         });
      });
      return itemList;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}