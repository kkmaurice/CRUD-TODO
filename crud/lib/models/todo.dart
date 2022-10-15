import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Todo {
  final String userId;
  final String id;
  final DateTime date;
  final String title;
  final String description;
  bool isFavorite;
  bool isDone;
  Todo({
    required this.userId,
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    this.isFavorite = false,
    this.isDone = false
  });

  factory Todo.fromMap(Map<String, dynamic> data){
    return Todo(
      userId: data['userId'] ?? '',
      id: data['id'] ?? '', 
      date: data['date'] is DateTime ? data['date '] : data['date'] is String ? DateTime.parse(data['date']) : data['date'] is Timestamp? data['date'].toDate() : null,  
      title: data['title'] ?? '', 
      description: data['description'] ?? '',
      isFavorite: data['isFavorite'] ?? '',
      isDone: data['isDone']
      );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'id': id,
      'date': DateTime.now().toIso8601String(),
      'title': title,
      'description': description,
      'isFavorite' : isFavorite,
      'isDone' : isDone
    };
  }
}
