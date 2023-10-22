
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:my_todo/features/todo/data/todo_model.dart';


final apiServiceProvider = Provider<ApiService>((ref){
  return ApiService();
});

class ApiService {

  var url =
  Uri.parse('https://jsonplaceholder.typicode.com/todos');

  Future<List<ToDo>> fetchTodos() async {
    print('api station');

    try{
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonResponse =
        json.decode(response.body) as List ;
        return jsonResponse.map((e) => ToDo.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        print('Failure: ${response.statusCode}.');
        return [];
      }
    }catch (e){
      print('EXception :: $e');
      return [];
    }
  }

}


// class Failure {
//   final String msg;
//   Failure({ required this.msg});
// }