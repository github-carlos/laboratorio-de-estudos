import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final isChecked;
  final String taskTitle;
  final Function callback;

  TaskTile({this.isChecked, this.taskTitle, this.callback});

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(taskTitle, style: TextStyle(decoration: isChecked ? TextDecoration.lineThrough : null),),
      trailing:
      Checkbox(
        value: isChecked,
        onChanged: callback,
      )
    );
  }
}


