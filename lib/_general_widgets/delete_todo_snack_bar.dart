import 'package:demo_flut/todos/model/todo_model.dart';
import 'package:flutter/material.dart';

class DeleteTodoSnackBar extends SnackBar {
  

  DeleteTodoSnackBar({
    Key key,
    @required Todo todo,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            "${todo.task} deleted",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: "Undo",
            onPressed: onUndo,
          ),
        );
}
