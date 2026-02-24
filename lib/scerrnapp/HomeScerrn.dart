import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:newprojectflutter/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:newprojectflutter/scerrnapp/aad_task.dart';
import 'dart:convert';
import '../Widgte/Cstem_task_list.dart'; // استيراد الويدجت المشترك
import '../savices/preferenes_manger.dart';

class Homescerrn extends StatefulWidget {
  const Homescerrn({super.key});

  @override
  State<Homescerrn> createState() => _HomescerrnState();
}

class _HomescerrnState extends State<Homescerrn> {
  String userName = "";
  String motivationQuote = "";
  List<dynamic> tasks = [];
  int completedTasks = 0;
  int totalTasks = 0;
  double percentage = 0.0;
  String? userImage;


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await PreferenesManger().init();
    String name = PreferenesManger().getString('userName');
    String mm = PreferenesManger().getString('Motivation Quote');
    String tasksRaw = PreferenesManger().getString('tasks');
    
    // تصحيح: تحويل النص الفارغ إلى null لضمان ظهور الصورة الافتراضية
    String savedImage = PreferenesManger().getString('user_image');

    List<dynamic> loadedTasks = [];
    if (tasksRaw.isNotEmpty) {
      try {
        loadedTasks = jsonDecode(tasksRaw);
      } catch (e) {
        loadedTasks = [];
      }
    }

    setState(() {
      userName = name.isEmpty ? "User" : name;
      motivationQuote = mm.isEmpty ? "One task at a time. One step closer." : mm;
      userImage = savedImage.isEmpty ? null : savedImage;
      tasks = loadedTasks;
      _calculateProgress(loadedTasks);
    });
  }

  void _calculateProgress(List<dynamic> currentTasks) {
    totalTasks = currentTasks.length;
    completedTasks = currentTasks.where((task) => task['isDone'] == true).length;
    percentage = totalTasks == 0 ? 0.0 : (completedTasks / totalTasks);
  }

  Future<void> _updateTaskInStorage(int index, bool? value) async {
    setState(() {
      tasks[index]['isDone'] = value ?? false;
      _calculateProgress(tasks);
    });
    String updatedTasksRaw = jsonEncode(tasks);
    await PreferenesManger().setString('tasks', updatedTasksRaw);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    key: ValueKey(userImage),
                    radius: 25, // تكبير الحجم قليلاً ليكون واضحاً
                    backgroundImage: (userImage == null || userImage!.isEmpty)
                          ? const AssetImage("assets/ezz.jpg") as ImageProvider
                          : FileImage(File(userImage!)),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Good Evening, $userName\n",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextSpan(
                            text: motivationQuote,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Yuhuu, Your work Is \nalmost done!",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Achieved Tasks", style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text("$completedTasks Tasks Completed", style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: -math.pi / 2,
                          child: SizedBox(
                            width: 54,
                            height: 54,
                            child: CircularProgressIndicator(
                              value: percentage,
                              strokeWidth: 6,
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2AD67B)),
                            ),
                          ),
                        ),
                        Text("${(percentage * 100).toInt()}%", style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("My Tasks", style: Theme.of(context).textTheme.labelLarge),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: tasks.isEmpty
                  ? Center(child: Text("No tasks yet", style: Theme.of(context).textTheme.titleMedium))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: ThemeController.themeNotifier.value == ThemeMode.light 
                                      ? const Color(0xF8D1DAD6) 
                                      : Colors.transparent),
                            ),
                            child: CustomTaskList(
                              title: task['title'] ?? "",
                              description: task['description'] ?? "",
                              isDone: task['isDone'] ?? false,
                              isHigh: task['isHigh'] ?? false,
                              onToggle: (bool? value) => _updateTaskInStorage(index, value),
                              onDelete: () {
                                setState(() {
                                  tasks.removeAt(index);
                                  _calculateProgress(tasks);
                                });
                                PreferenesManger().setString('tasks', jsonEncode(tasks));
                              },
                              onupdata: (String newTitle, String newDescription , bool isHigh) {
                                setState(() {
                                  tasks[index]['title'] = newTitle;
                                  tasks[index]['description'] = newDescription;
                                  tasks[index]['isHigh'] = isHigh;
                                });
                                PreferenesManger().setString('tasks', jsonEncode(tasks));
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AadTask())).then((_) => _loadData());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2AD67B),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            fixedSize: const Size(180, 48),
          ),
          icon: const Icon(Icons.add),
          label: const Text("Add New Task", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
