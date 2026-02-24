enum TaskItemActvionEnum {

  edit(name: "edit"),
  delete(name: "delete"); // استخدمنا ; هنا لأننا سنضيف متغيرات ودالة بناء

  final String name;

  const TaskItemActvionEnum({required this.name});


}
