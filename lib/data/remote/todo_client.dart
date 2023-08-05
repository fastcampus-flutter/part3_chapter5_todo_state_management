import 'package:dio/dio.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:retrofit/retrofit.dart';

part 'todo_client.g.dart';

@RestApi(baseUrl: 'http://localhost:8080/todo')
abstract class TodoClient {
  factory TodoClient(Dio dio, {String baseUrl}) = _TodoClient;

  @GET('/todo')
  Future<List<Todo>> getTodoList();

  @POST('/todo')
  Future<void> addTodo(@Body() Todo todo);

  @PUT('/todo')
  Future<void> updateTodo(@Body() Todo todo);

  @DELETE('/todo')
  Future<void> removeTodo(@Body() int todoId);
}
