import 'dart:convert';

import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/data/remote/extension/response_extension.dart';
import 'package:fast_app_base/data/remote/result/api_error.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../memory/vo_todo.dart';
import '../simple_result.dart';
import '../todo_repository.dart';

///Remote DB
class TodoApi implements TodoRepository<ApiError> {
  static Uri todoUri = 'http://localhost:8080/todo'.uri;

  TodoApi._();

  static TodoApi instance = TodoApi._();

  @override
  Future<SimpleResult<List<Todo>, ApiError>> getTodoList() async {
    try {
      final response = await http.get(todoUri);
      return returnResult(response);
    } catch (e) {
      debugPrint('get response fail');
    }
    return SimpleResult.failure(ApiError(message: 'unknown error'));
  }

  static SimpleResult<List<Todo>, ApiError> returnResult(http.Response response) {
    if (response.isSuccessCode) {
      final jsonString = response.body;
      final jsonObjs = json.decode(jsonString);
      if (jsonObjs is List) {
        return SimpleResult.success(jsonObjs.map<Todo>((e) => Todo.fromJson(e)).toList());
      }

      return SimpleResult.success();
    } else {
      return SimpleResult.failure(ApiError(message: response.body));
    }
  }

  @override
  Future<SimpleResult<void, ApiError>> addTodo(Todo model) async {
    final response = await http.post(todoUri, body: json.encode(model.toJson()));
    if (response.isSuccessCode) {
      return SimpleResult.success();
    } else {
      return SimpleResult.failure(ApiError(message: response.body));
    }
  }

  @override
  Future<SimpleResult<void, ApiError>> updateTodo(Todo model) async {
    final response = await http.put(todoUri, body: json.encode(model.toJson()));
    if (response.isSuccessCode) {
      return SimpleResult.success();
    } else {
      return SimpleResult.failure(ApiError(message: response.body));
    }
  }

  @override
  Future<SimpleResult<void, ApiError>> removeTodo(int id) async {
    final response = await http.delete(todoUri, body: id.toString());
    if (response.isSuccessCode) {
      return SimpleResult.success();
    } else {
      return SimpleResult.failure(ApiError(message: response.body));
    }
  }
}
