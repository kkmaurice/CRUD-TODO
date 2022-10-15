// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, use_build_context_synchronously

import 'package:crud/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoController with ChangeNotifier{
  final service = FirebaseService();
  final user = FirebaseAuth.instance.currentUser;
  
    List<Todo> _todo = [];
   List<Todo> get todo => _todo;

  // toggle favorite status and send to firebase
   Future<void> toggleFavorite(Todo todo) async{
       todo.isFavorite = !todo.isFavorite;
       await service.addTodo(todo);
      notifyListeners();
     }

  // toggling markAsDone and adding it to firebase
   Future<void> toggleMarkAsDone(Todo todo) async{
     if (todo != null) {
      todo.isDone = !todo.isDone;
     }
     await service.addTodo(todo);
    notifyListeners();
   }

   // Add todo
   Future addTodo(String id, DateTime date, String title, String description,) async{
     await service.addTodo(Todo(userId: user!.uid, id: id, date: date, title: title, description: description,));
    notifyListeners();
   } 

   // Retrieve todo
   Future<List<Todo>> fetchTodos() async{
    var _mytodo = await service.getTodo();
    //print('${_mytodo[0].title}');
    if(_mytodo is List<Todo>){
      _todo = _mytodo;
    }  
    notifyListeners();
     return _todo;
   }

   // Update todo
    Future<void> updateTodo(String id, DateTime date, String title, String description) async{
      await service.updateTodo(Todo(userId: user!.uid, id: id, date: date, title: title, description: description));
      notifyListeners();
    }
  

   // Delete todo
   Future<void> deleteMyTodo(BuildContext context, String todoId) async{
     showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          content:const Text('Do you want delete this todo content?'),
          actions: [
            ElevatedButton(
              onPressed: () async{
                await service.deleteTo(todoId);
                 Navigator.pop(context);
              }, 
              child:const Text('Delete'))
          ],
        );
      });
    notifyListeners();
   }
}