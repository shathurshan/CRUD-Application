import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollections = _firestore.collection("notes");

class DataBase {
  static String? userId;

  static Future<void> addItem({
    required String title,
    required String description,
  }) async {
    DocumentReference documentReference =
        _mainCollections.doc(userId).collection('item').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'title': title,
      'description': description,
    };
    await documentReference
        .set(data)
        .whenComplete(
          () {
            print("Note item is inserted to the database");
          },
        )
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollections.doc(userId).collection('item').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'title': title,
      'description': description,
    };

    await documentReference
        .set(data)
        .whenComplete(
          () => print("Note item is Updated in the database"),
        )
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollections =
        _mainCollections.doc(userId).collection('item');

    return notesItemCollections.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollections.doc(userId).collection('item').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Note Item delete from the database"))
        .catchError(
          (e) => print(e),
        );
  }
}
