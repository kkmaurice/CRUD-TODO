// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_element, no_logic_in_create_state, unnecessary_null_comparison, use_build_context_synchronously

import 'package:crud/controllers/provider_controller.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';



class EditScreen extends StatefulWidget {
  const EditScreen({Key? key, required this.todo}) : super(key: key);

 final Todo todo;
  
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  bool _isLoading = false;
  DateTime? _picked;
 

  Future<void> _myDatePicker(BuildContext context) async{
   DateTime? _date = await showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime(2019), 
        lastDate: DateTime(2050));
    if (_date != null){
      setState(() {
        _picked = _date;
      });
    }
  }

  _myDialoge(String title, var name){
    return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(name),
        actions: [
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, 
            child: const Text('Ok'))
        ],
      ));
  }

  @override
  void initState() {
    // setting initial values to do the editing
    if(widget.todo != null){
      _titleController.text = widget.todo.title;
      _descriptionController.text = widget.todo.description;
      _picked = widget.todo.date;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Your Activities'),
        elevation: 0,
      ),
      body:  _isLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
               controller: _titleController,
                decoration: const InputDecoration(
                  label:  Text('Title',style: TextStyle(fontSize: 25),),
                  border: InputBorder.none,
                ),
                onChanged: (value){
                  _titleController.text = value;
                  _titleController.selection = TextSelection.fromPosition(TextPosition(offset: _titleController.text.length));
                },
              ),
              const SizedBox(height: 10,),
               TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  label: Text('Description',style: TextStyle(fontSize: 25),),
                  border: InputBorder.none
                ),
                maxLines: 5,
                onChanged: (value){
                  _descriptionController.text = value;
                  _descriptionController.selection = TextSelection.fromPosition(TextPosition(offset: _descriptionController.text.length));
                },
              ),
              Text(_picked!=null? formatDate(_picked!, [MM,' ',d,', ',yyyy]): 'No date picked', style: const TextStyle(fontSize: 25),),
              const SizedBox(height: 10,),
              ElevatedButton.icon(
                onPressed: () async{
                  await _myDatePicker(context);
                }, 
                icon: const Icon(Icons.calendar_month), 
                label: const Text('Pick Date')),

                const SizedBox(height: 10,),

               GestureDetector(
                 onTap: () async{ 
                  setState(() {
                    _isLoading = true;
                  });
                await context.read<TodoController>().updateTodo(widget.todo.id, _picked as DateTime, _titleController.text, _descriptionController.text);
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).pop();
                },

                child: Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).primaryColor,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: const Text('Update Todo',style: TextStyle(fontSize: 20,color: Colors.white),),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

