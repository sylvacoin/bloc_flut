// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:demo_flut/_general_widgets/extra_action.dart';
import 'package:demo_flut/todos/bloc/todos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key key});

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder(
      bloc: todosBloc,
      builder: (BuildContext context, TodosState state) {
        if (state is TodosLoaded) {
          final allComplete = (todosBloc.state as TodosLoadSuccess).todos
              .every((todo) => todo.complete);
          return PopupMenuButton<ExtraAction>(
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  todosBloc.add(TodosClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  todosBloc.add(TodosToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
            
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete
                      ? "Mark all Incomplete"
                      : "Mark all completed",
                ),
              ),
              PopupMenuItem<ExtraAction>(
                value: ExtraAction.clearCompleted,
                child: Text(
                  "Clear completed",
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
