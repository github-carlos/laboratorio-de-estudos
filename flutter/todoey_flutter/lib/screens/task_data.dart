import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:todoey_flutter/models/Task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy bread'),
    Task(name: 'Buy coffe'),
  ];

  int get taskCount {
    return _tasks.length;
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  addTask(Task task){
    _tasks.add(task);
    notifyListeners();
  }
  toggleSelected(index) {
    _tasks[index].toggleDone();
    notifyListeners();
  }
}