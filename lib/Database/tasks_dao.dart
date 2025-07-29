import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/Database/Model/Task.dart';
import 'package:to_do/Database/UserDao.dart';



class TasksDao {
  static CollectionReference<Task> getTaskCollection(String uid) {
    return UserDao.getUserCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> createTask(Task task, String uid) {
    var docRef = getTaskCollection(uid).doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<List<Task>> getAllTask(
      String uid, DateTime selectedDate) async {
    var dateOnly = selectedDate.copyWith(
        hour: 0, millisecond: 0, second: 0, microsecond: 0, minute: 0);
    var tasksSnapshot = await getTaskCollection(uid)
        .where('dateTime',
            isEqualTo: Timestamp.fromMillisecondsSinceEpoch(
                dateOnly.millisecondsSinceEpoch))
        .get();
    // snapshot is object mn el list
    var tasksList =
        tasksSnapshot.docs.map((snapshot) => snapshot.data()).toList();
    return tasksList;
  }

  // static Stream<List<Task>> ListenForTasks(String uid) async* {
  //   // 3shan ne return stream lazem nst5dm yield*
  //   var stream = getTaskCollection(uid).snapshots();
  //   yield* stream.map((querySnapshots) =>
  //       querySnapshots.docs.map((doc) => doc.data()).toList());
  // }

  static Future<void> removeTask(String taskId, String uid) {
    return getTaskCollection(uid).doc(taskId).delete();
  }

  static Future<void> isDoneTask(Task task, String uid) async {
   await UserDao.getUserCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .doc(task.id)
        .set(task.toFireStore());
  }

  static Future<void> editTask(Task task,String uid) async{
    await UserDao.getUserCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .doc(task.id)
        .set(task.toFireStore());
  }
}
