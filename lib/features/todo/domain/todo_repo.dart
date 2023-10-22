

import 'package:my_todo/features/todo/data/todo_model.dart';


abstract class ToDoRepo {
  Future<List<ToDo>>fetchTodos();
}