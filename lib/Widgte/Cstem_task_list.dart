import 'package:flutter/material.dart';
import '../enume/task_item_actvion_enum.dart';
import '../scerrnapp/aad_task.dart';

class CustomTaskList extends StatelessWidget {
  final bool isDone;
  final String title;
  final String description;
  final bool isHigh; // إضافة متغير الأولوية
  final Function(bool?) onToggle;
  final VoidCallback onDelete;
  final Function(String, String, bool) onupdata; // إضافة bool للدالة

  const CustomTaskList({
    super.key,
    required this.isDone,
    required this.title,
    required this.description,
    required this.isHigh,
    required this.onToggle,
    required this.onDelete,
    required this.onupdata,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isDone,
          onChanged: onToggle,
          activeColor: const Color(0xFF2AD67B),
          checkColor: Colors.white,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        PopupMenuButton<TaskItemActvionEnum>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case TaskItemActvionEnum.edit:
                _showModelBottomSheet(context);
                break;
              case TaskItemActvionEnum.delete:
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Task"),
                      content: const Text("Are you sure you want to delete this task?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            onDelete();
                            Navigator.pop(context);
                          },
                          child: const Text("Delete", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    );
                  },
                );
                break;
            }
          },
          itemBuilder: (context) => TaskItemActvionEnum.values
              .map((e) => PopupMenuItem(
                    value: e,
                    child: Text(e.name),
                  ))
              .toList(),
        ),
      ],
    );
  }

  _showModelBottomSheet(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController tasknameController = TextEditingController(text: title);
    final TextEditingController taskDecbtionController = TextEditingController(text: description);
    bool currentHighPriority = isHigh; // متغير مؤقت للتعديل

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor ,
      builder: (BuildContext context) {

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) => Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // القفز فوق الكيبورد
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // تأخذ حجم المحتوى فقط
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Task Name", style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: tasknameController,
                          style: Theme.of(context).textTheme.labelMedium,
                          validator: (value) => (value == null || value.isEmpty) ? 'Task name is required' : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.primaryContainer,
                            hintText: "Enter task title",
                            hintStyle: const TextStyle(color: Color(0xFF6D6D6D)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text("Task Description", style: Theme.of(context).textTheme.labelMedium),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: taskDecbtionController,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.labelMedium,
                          validator: (value) => (value == null || value.isEmpty) ? 'Description is required' : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.primaryContainer,
                            hintText: "Enter details here...",
                            hintStyle: const TextStyle(color: Color(0xFF6D6D6D)),
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
                              value: currentHighPriority,
                              onChanged: (bool value) {
                                setModalState(() {
                                  currentHighPriority = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onupdata(tasknameController.text, taskDecbtionController.text, currentHighPriority);
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text('Edit Task', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
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
      },
    );
  }
}
