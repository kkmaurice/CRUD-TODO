// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/todo.dart';
import 'package:flutter/services.dart';

class FirebaseService{
  CollectionReference ref = FirebaseFirestore.instance.collection('activities');
  
  // create
  Future addTodo(Todo todo) async{
    try{
       await ref.doc(todo.id)
            .set(todo.toMap(), SetOptions(merge: true));
            return true;
    }catch(e){
      return e.toString();
    }
  }

  // read
  // Future<List<Todo>> getTodo() {
  //   return ref.snapshots()
  //             .map((snapshot) => 
  //             snapshot.docs
  //             .map((doc) => Todo.fromMap(doc.data() as Map<String, dynamic>)
  //             ).toList()
  //             );
  // }
  // Future getTodo() async{
  //   try{
  //     return await ref.get()
  //           .then((QuerySnapshot snapshot) => 
  //           snapshot.docs
  //           .forEach((doc) { 
  //             Todo.fromMap(doc.data() as Map<String, dynamic>);
  //           })
  //           );
  //   }catch(e){
  //     return e.toString();
  //   }
  // }

    Future getTodo() async {
    try {
      var myDocuments = await ref.get();
      if (myDocuments.docs.isNotEmpty) {
        return myDocuments.docs
            .map((snapshot) => Todo.fromMap(snapshot.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  // update
  Future updateTodo(Todo todo) async{
    try{
      await ref
            .doc(todo.id)
            .update(todo.toMap());
        return true;
    }catch(e){
      if(e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
  
  // delete
  Future<void> deleteTo(String todoId) async{
    return await ref.doc(todoId).delete();
  }
}