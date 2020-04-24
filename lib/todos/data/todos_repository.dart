// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:demo_flut/todos/data/todos_irepository.dart';
import 'package:demo_flut/todos/data/todos_web_client.dart';
import 'package:demo_flut/todos/model/todo_model.dart';
import 'package:meta/meta.dart';
 
/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class TodosRepository implements ITodosRepository {
  final ITodosRepository localStorage;
  final ITodosRepository webClient;

  const TodosRepository({
    @required this.localStorage,
    this.webClient = const TodosWebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<Todo>> loadTodos() async {
    try {
      return await localStorage.loadTodos();
    } catch (e) {
      final todos = await webClient.loadTodos();

      await localStorage.saveTodos(todos);

      return todos;
    }
  }

  // Persists todos to local disk and the web
  @override
  Future saveTodos(List<Todo> todos) {
    return Future.wait<dynamic>([
      localStorage.saveTodos(todos),
      webClient.saveTodos(todos),
    ]);
  }
}
