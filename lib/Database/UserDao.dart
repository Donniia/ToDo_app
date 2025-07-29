import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/Database/Model/User.dart';

class UserDao {
  static CollectionReference<User> getUserCollection() {
    var db = FirebaseFirestore.instance;
    var userCollection = db.collection(User.collectionName).withConverter(
        fromFirestore: (snapshot, options) =>
            User.fromFireStore(snapshot.data()),
        toFirestore: (object, options) => object.toFireStore());
    return userCollection;
  }

  static Future<void> createUser(User user) {
    var userCollection = getUserCollection();
    var doc = userCollection.doc(user.id);
    return doc.set(user);
  }

 static Future<User?> getUser(String uid) async{
   var doc = getUserCollection().doc(uid);
   var docSnapshot = await doc.get();
   return docSnapshot.data();
  }
}
