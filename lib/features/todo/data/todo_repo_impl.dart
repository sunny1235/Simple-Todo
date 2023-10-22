


import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo/features/todo/data/todo_model.dart';
import 'package:my_todo/features/todo/domain/todo_repo.dart';

import 'api_service.dart';

final todoRepoProvider = Provider<ToDoRepo>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return ToDoRepoImpl(apiService: apiService);
});


class ToDoRepoImpl implements ToDoRepo{
  final ApiService apiService;
  ToDoRepoImpl({
   required this.apiService
});

  @override
  Future<List<ToDo>> fetchTodos() async{
    final res = await apiService.fetchTodos();
    return res;
  }



}