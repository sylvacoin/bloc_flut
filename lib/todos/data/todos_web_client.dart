import 'dart:async';

import 'package:demo_flut/todos/data/todos_irepository.dart';
import 'package:demo_flut/todos/model/todo_model.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class TodosWebClient implements ITodosRepository {
  final Duration delay;

  const TodosWebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  @override
  Future<List<Todo>> loadTodos() async {
    return Future.delayed(
        delay,
        () => [
              Todo(
                'Buy food for da kitty',
                id: '1',
                note: 'With the chickeny bits!',
                complete: false,
              ),
              Todo(
                'Find a Red Sea dive trip',
                id: '2',
                note: 'Echo vs MY Dream',
                complete: false,
              ),
              Todo(
                'Book flights to Egypt',
                id: '3',
                note: '',
                complete: true,
              ),
              Todo(
                'Decide on accommodation',
                id: '4',
                note: '',
                complete: false,
              ),
              Todo(
                'Sip Margaritas',
                id: '5',
                note: 'on the beach',
                complete: true,
              ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> saveTodos(List<Todo> todos) async {
    return Future.value(true);
  }
}
