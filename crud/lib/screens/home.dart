// ignore_for_file: sized_box_for_whitespace, unnecessary_null_comparison

import 'dart:math';

import 'package:crud/controllers/provider_controller.dart';
import 'package:crud/models/todo.dart';
import 'package:crud/screens/edit_screen.dart';
import 'package:crud/screens/input_screen.dart';
import 'package:crud/services/auth.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final todos = context.watch<TodoController>().todo;
    return Scaffold(
        appBar: AppBar(
          title:  Text(Auth().auth.currentUser!.email!),
          centerTitle: true,
          elevation: 0,
          actions: [
            CircleAvatar(
              child: Auth().auth.currentUser!.photoURL !=null ? Image.network(Auth().auth.currentUser!.photoURL!) : Container()
              ),
            
            IconButton(
              onPressed: (){
                Auth().logOut();
              }, 
              icon: const Icon(Icons.logout_outlined))
          ],
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 5,right: 5),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: context.read<TodoController>().fetchTodos(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.error != null) {
                            return const Center(
                              child: Text('An error occurred'),
                            );
                          } else {
                                return ListView.builder(
                                    itemCount: todos.length,
                                    itemBuilder: (context, index) {
                                      return CardWidget(todo: todos[index]);
                                    });
                              
                          }
                        }
                      }),
                ),
               
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  InputScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Theme.of(context).primaryColor,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Add Activities',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            )));
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final _random = RandomColor();
    List<Color> colors = [
      Colors.deepOrangeAccent,
      Colors.cyan,
      Colors.indigo,
      Colors.grey.shade800
    ];
    Color myColor = _random.randomColor();
    return Card(
      color: Colors.cyan.shade600,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        children:[
          Positioned(
            right: 15,
            top: 25,
            child: GestureDetector(
              onTap: (){
                context.read<TodoController>().toggleMarkAsDone(todo);
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: todo.isDone  ? Colors.blue.shade900 : Colors.grey.shade400,
                  shape: BoxShape.circle
                ),
                child:const Icon(Icons.done,color: Colors.white,size: 40,),
              ),
            ),
          ),
          Container(
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10,right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.date != null ? formatDate(todo.date, [MM,' ',d,', ',yyyy]): '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8,),
              Text(todo.title, style: const TextStyle(fontSize: 20),), 
              const SizedBox(height: 10,),
              Text(todo.description, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      context.read<TodoController>().toggleFavorite(todo);
                    }, 
                    icon: Icon(todo.isFavorite? Icons.favorite : Icons.favorite_border, size: 35,
                    color: todo.isFavorite? Colors.red : Colors.white,
                    )),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .50,
                      child: Row(
                        children: [
                          ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(5))
                            ),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScreen(todo: todo,)));
                            }, 
                            icon: const Icon(Icons.edit), 
                            label: const Text('Edit')),
                            const SizedBox(width: 5,),
                            ElevatedButton.icon(
                              style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.amber),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(5))
                            ),
                            onPressed: () async{
                              context.read<TodoController>().deleteMyTodo(context,todo.id);
                            }, 
                            icon: const Icon(Icons.delete_forever,color: Colors.red,), 
                            label: const Text('Delete'))
                        ],
                      ),
                    ),
                  ),
                ],
              )
              ],
          ),
        ),
        ] 
      ),
    );
  }
}
