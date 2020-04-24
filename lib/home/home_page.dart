import 'package:demo_flut/_general_widgets/extra_actions.dart';
import 'package:demo_flut/_general_widgets/filter_button.dart';
import 'package:demo_flut/filtered_todos/filtered_todos.dart';
import 'package:demo_flut/stats/stats.dart';
import 'package:demo_flut/tab/bloc/tab_bloc.dart';
import 'package:demo_flut/tab/models/app_tab.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
            appBar: AppBar(title: Text('Home'), actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ]),
            body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addTodo');
              },
              child: Icon(Icons.add),
              tooltip: "Add Todo",
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppTab.values.indexOf(activeTab),
              onTap: (index) => BlocProvider.of<TabBloc>(context).add(TabUpdated(AppTab.values[index])),
              items: AppTab.values.map((tab) {
                return BottomNavigationBarItem(
                  icon: Icon(
                    tab == AppTab.todos ? Icons.list : Icons.show_chart,
                  ),
                  title: Text(tab == AppTab.stats
                      ? "Stats"
                      : "Todos"),
                );
              }).toList(),
            ));
      },
    );
  }
}
