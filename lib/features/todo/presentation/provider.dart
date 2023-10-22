



import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/features/todo/data/todo_model.dart';
import '../../../enums.dart';
import '../data/todo_repo_impl.dart';
import '../domain/todo_repo.dart';

final todoProvider = ChangeNotifierProvider((ref) {
  final todoRepo = ref.read(todoRepoProvider);
  return TodoProvider(toDoRepo: todoRepo);
});


class TodoProvider extends ChangeNotifier{
  final ToDoRepo toDoRepo;
  TodoProvider({required this.toDoRepo});

  final List<ToDo> _todoList = [];
  List<ToDo> get todoList => _todoList;

   int _completeCount = 0;
   int get completeCount => _completeCount;


   EventState _eventState  = EventState.Initial;
   EventState get eventState => _eventState;

  void setCompleteCount(){
    int count = 0;
    _todoList.forEach((element) {
      if(element.completed == true){
        count++;
      }
    });
    _completeCount = count;
    notifyListeners();
  }


  void fetchTodos() async {
    _eventState = EventState.Loading;
    List<ToDo> res = await toDoRepo.fetchTodos();
    if(res.isNotEmpty){
      _eventState = EventState.Done;
      _todoList.addAll(res);
      setCompleteCount();
    }else{
      _eventState = EventState.Done;
      notifyListeners();
    }
   }

}