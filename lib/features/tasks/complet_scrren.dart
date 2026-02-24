import 'dart:convert';
import 'package:flutter/material.dart';
import '../../savices/preferenes_manger.dart';
import '../../theme/theme_controller.dart';
import '../../Widgte/Cstem_task_list.dart'; // استيراد الويدجت المشترك

class CompletScrren extends StatefulWidget {
  const CompletScrren({super.key});

  @override
  State<CompletScrren> createState() => _CompletScrrenState();
}

class _CompletScrrenState extends State<CompletScrren> {
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await PreferenesManger().init(); // إضافة await لضمان استقرار البيانات
    String tasksRaw = PreferenesManger().getString('tasks');

    List<dynamic> loadedTasks = [];
    if (tasksRaw.isNotEmpty) {
      try {
        loadedTasks = jsonDecode(tasksRaw);
      } catch (e) {
        loadedTasks = [];
      }
    }
    setState(() {
      tasks = loadedTasks;
    });
  }

  Future<void> _updateTaskInStorage(int originalIndex, bool? value) async {
    setState(() {
      tasks[originalIndex]['isDone'] = value ?? false;
    });
    String updatedTasksRaw = jsonEncode(tasks);
    await PreferenesManger().setString('tasks', updatedTasksRaw);
  }

  @override
  Widget build(BuildContext context) {
    // تصفية المهام المكتملة فقط
    final completedTasksList = tasks.where((task) => task['isDone'] == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: completedTasksList.isEmpty
                  ? Center(
                      child: Text(
                        "No completed tasks yet.",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : ListView.builder(
                      itemCount: completedTasksList.length,
                      itemBuilder: (context, index) {
                        final task = completedTasksList[index];
                        int originalIndex = tasks.indexOf(task);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: ThemeController.themeNotifier.value == ThemeMode.light
                                    ? const Color(0xF9D1DAD6)
                                    : Colors.transparent,
                              ),
                            ),
                            // استخدام الويدجت المشترك هنا
                            child: CustomTaskList(
                              title: task['title'] ?? "No Title",
                              description: task['description'] ?? "No Description",
                              isDone: task['isDone'] ?? true,
                              isHigh: task['isHigh'] ?? false,
                              onToggle: (bool? value) {
                                _updateTaskInStorage(originalIndex, value);
                              },
                              onDelete: () {
                                setState(() {
                                  // الحذف من القائمة الأصلية باستخدام الـ Index الصحيح
                                  tasks.removeAt(originalIndex);
                                });
                                // حفظ التغييرات في الذاكرة
                                PreferenesManger().setString('tasks', jsonEncode(tasks));
                              },
                              onupdata: (String title , String description , bool isHigh) {

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
    );
  }
}
