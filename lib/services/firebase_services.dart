import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List>getPeople() async {
  List people=[];
  CollectionReference collectionReferencePeople=db.collection("people");
  QuerySnapshot queryPeople=await collectionReferencePeople.get();
  for (var doc in queryPeople.docs) {
    final Map<String, dynamic> data=doc.data() as Map<String, dynamic>;
    final person = {
      "name": data["name"],
       "uid": doc.id,
      
    };
    people.add(person);
  }
  return people;
}
//guardar un nombre en base de datos
Future<void> addpeople(String name) async {
  await db.collection("people").add({"name": name});
}
 
 //actualixzar nombre en base de datos
 Future<void> updatepeople(String uid, String newName) async {
  await db.collection("people").doc(uid).set({"name": newName});
}

 //borrar datos firebase
 Future<void> deletepeople(String uid) async {
  await db.collection("people").doc(uid).delete();
}