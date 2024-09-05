//service --> backend ile frontend arasında bağlantı kuracak olan katman
//bu kısımda api ye istekler yaparız.
//gelen istekleri ön yüze döndürmeye çalışacaz

import 'dart:convert';

import 'package:todo_mobil_app/model/todo.dart';
import 'package:http/http.dart' as http;

class TodoService {
  final String url = "https://dummyjson.com/todos/";
  final String AddUrl = "https://dummyjson.com/todos/add";

  //todo türünde liste döndüren --todo modelclass ında olan todo
  //! future geç gelen veri olabileceği için kullandık
  Future<List<Todo>> getUncompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    List<dynamic> resp = jsonDecode(response.body)[
        "todos"]; //reponse.body --> api de ki body kısmını çekecek
    List<Todo> todos = List.empty(
        growable: true); //growable -->listeye ekleme yapmamızı sağlar.

    resp.forEach((element) {
      Todo task =
          Todo.fromJson(element); //json olan elemanı todo objesine dönüştürdük
      if (task.completed! == false) {
        todos.add(task);
        //ve todos a ekledik
      }
    });
    return todos;
  }

  Future<List<Todo>> getCompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    List<dynamic> resp = jsonDecode(response.body)[
        "todos"]; //reponse.body --> api de ki body kısmını çekecek
    List<Todo> todos = List.empty(
        growable: true); //growable -->listeye ekleme yapmamızı sağlar.

    resp.forEach((element) {
      Todo task =
          Todo.fromJson(element); //json olan elemanı todo objesine dönüştürdük
      if (task.completed! == true) {
        todos.add(task);
        //ve todos a ekledik
      }
    });
    return todos;
  }

  Future<String> addTodo(Todo newTodo) async {
    final response = await http.post(
      Uri.parse(AddUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: json.encode(newTodo.toJson()),
    );
    return response.body;
  }
}
