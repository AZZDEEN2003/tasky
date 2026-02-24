import 'package:flutter/material.dart';
import 'package:newprojectflutter/savices/preferenes_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AadTask extends StatefulWidget {
  const AadTask({super.key});

  @override
  State<AadTask> createState() => _AadTaskState();
}

class _AadTaskState extends State<AadTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController tasknameController = TextEditingController();
  final TextEditingController taskDecbtionController = TextEditingController();
  bool highPriority = true;

  Future<void> _saveTask() async {
    PreferenesManger().init() ;
    String? tasksRaw = PreferenesManger().getString('tasks');

    Map<String, dynamic> newTask = {
      'title': tasknameController.text,
      'description': taskDecbtionController.text,
      'isHigh': highPriority,
      'isDone': false,
    };

    List<dynamic> tasksList = [];
    if (tasksRaw != null) {
      tasksList = jsonDecode(tasksRaw);
    }

    tasksList.add(newTask);
    String updatedTasksRaw = jsonEncode(tasksList);
    await  PreferenesManger().setString('tasks', updatedTasksRaw);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme:  IconThemeData(),
        title:  Text(
          "New Task",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("Task Name", style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: tasknameController,
                          style:  Theme.of(context).textTheme.labelMedium,
                          validator: (value) => (value == null || value.isEmpty) ? 'Task name is required' : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.primaryContainer,
                            hintText: "Enter task title",
                            hintStyle: TextStyle(color: Color(0xFF6D6D6D)) ,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                         Text("Task Description", style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: taskDecbtionController,
                          maxLines: 5,
                          style:  Theme.of(context).textTheme.labelMedium,
                          validator: (value) => (value == null || value.isEmpty) ? 'Description is required' : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.primaryContainer,
                            hintText: "Enter details here...",
                            hintStyle:  TextStyle(color: Color(0xFF6D6D6D)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("High Priority", style: Theme.of(context).textTheme.labelMedium),
                            Switch(
                              activeTrackColor: const Color(0xFF2AD67B),
                              value: highPriority,
                              onChanged: (bool value) => setState(() => highPriority = value),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _saveTask();
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Add Task', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2AD67B),
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
