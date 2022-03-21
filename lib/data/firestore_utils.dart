import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/data/doto.dart';

CollectionReference<ToDo> getToDOcollectionReference() {
  return FirebaseFirestore.instance
      .collection(ToDo.collectionName)
      .withConverter<ToDo>(
          fromFirestore: (snapshot, _) => ToDo.fromJson(snapshot.data()!),
          toFirestore: (item, _) => item.toJson());
}

Future<void> addToDoFireStore(
    String title, String description, DateTime dateTime) {
  CollectionReference<ToDo> collectionReference = getToDOcollectionReference();
  DocumentReference<ToDo> docRef = collectionReference.doc();
  ToDo item = ToDo(
      id: docRef.id,
      title: title,
      description: description,
      dateTime: dateTime);
  return docRef.set(item);
}

Future<void> deletToDO(ToDo item) {
  CollectionReference<ToDo> collectionReference = getToDOcollectionReference();
  DocumentReference<ToDo> itemDoc = collectionReference.doc(item.id);
  return itemDoc.delete();
}
