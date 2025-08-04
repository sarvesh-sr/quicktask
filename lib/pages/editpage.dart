import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class EditTaskPage extends StatefulWidget {
  final int taskIndex;
  final Box box;

  const EditTaskPage({super.key, required this.taskIndex, required this.box});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    List taskData = widget.box.get(widget.taskIndex);
    controller.text = taskData[0];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Edit Task", style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Edit task name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                List taskData = widget.box.get(widget.taskIndex);
                taskData[0] = controller.text;
                widget.box.put(widget.taskIndex, taskData);
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
