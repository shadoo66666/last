import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection('todoApp');

  //create
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  //update
  void updateTask(String? docID, bool? valueUpdate) {
    todoCollection.doc(docID).update({'isDone': valueUpdate});
  }

  //delete
  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }
}
