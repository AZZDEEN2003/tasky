import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgte/Cstem_task_list.dart';
import '../../savices/preferenes_manger.dart';
import '../../theme/theme_controller.dart';

class TodoScrren extends StatefulWidget {
  const TodoScrren({super.key});

  @override
  State<TodoScrren> createState() => _TodoScrrenState();
}

class _TodoScrrenState extends State<TodoScrren> {
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksRaw = prefs.getString('tasks');
    List<dynamic> loadedTasks = [];
    if (tasksRaw != null) {
      loadedTasks = jsonDecode(tasksRaw);
    }
    setState(() {
      tasks = loadedTasks;
    });
  }

  Future<void> _updateTaskInStorage(int originalIndex, bool? value) async {
    setState(() {
      tasks[originalIndex]['isDone'] = value ?? false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String updatedTasksRaw = jsonEncode(tasks);
    await prefs.setString('tasks', updatedTasksRaw);
  }

  @override
  Widget build(BuildContext context) {
    final todoTasks = tasks.where((task) => task['isDone'] == false).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "To Do Tasks",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: todoTasks.isEmpty
                    ? Center(
                        child: Text(
                          "All caught up!",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: todoTasks.length,
                        itemBuilder: (context, index) {
                          final task = todoTasks[index];
                          int originalIndex = tasks.indexOf(task);

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      ThemeController.themeNotifier.value ==
                                          ThemeMode.light
                                      ? Color(0xF9D1DAD6)
                                      : Colors.transparent,
                                ),
                              ),
                              child: CustomTaskList(
                                isDone: task['isDone'] ?? false,
                                title: task['title'] ?? '',
                                description: task['description'] ?? '',
                                isHigh: task['isHigh'] ?? false,
                                onToggle: (bool? p1) {
                                  _updateTaskInStorage(originalIndex, p1);
                                },
                                onDelete: () {
                                  setState(() {
                                    tasks.removeAt(originalIndex);
                                  });
                                  PreferenesManger().setString('tasks', jsonEncode(tasks));

                                },
                                onupdata: (String title , String description  , bool isHigh) {

                                    setState(() {
                                      // 1. تحديث العنصر المحدد بالقيم الجديدة
                                      tasks[originalIndex]['title'] = title;
                                      tasks[originalIndex]['description'] = description;


                                    });

                                    // 2. تحويل القائمة لنص وحفظها نهائياً في الذاكرة
                                    String updatedTasksRaw = jsonEncode(tasks);
                                    PreferenesManger().setString('tasks', updatedTasksRaw);
                                  },


                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
