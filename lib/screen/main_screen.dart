import 'package:flutter/material.dart';
import 'package:todolist_app/models/tasks.dart';
import 'package:todolist_app/screen/add_task_screen.dart';
import 'package:todolist_app/screen/edit_remove_task.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Task> tasks = [
    Task(name: 'Go to the gym'),
    Task(name: 'Work'),
    Task(name: 'Dinner with friends'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) => AddTaskScreen((newTaskTitle) {
                    setState(() {
                      tasks.add(Task(name: newTaskTitle));
                    });
                    Navigator.pop(context);
                  }));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //This is the header
            Container(
              padding: EdgeInsets.only(
                top: 60.0,
                left: 30.0,
                right: 30.0,
                bottom: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      Icons.list,
                      size: 30,
                      color: Colors.blueGrey,
                    ),
                    backgroundColor: Colors.white,
                    radius: 30.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'To Do List',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '${tasks.length} Tasks',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      color: Colors.blueGrey),
                  child: ReorderableListView(
                      children: [
                        for (final task in tasks)
                          ListTile(
                              key: ValueKey(task),
                              title: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          EditTask(
                                            currentTask: task,
                                            modifyTask: (value) {
                                              setState(() {
                                                task.name = value;
                                              });
                                            },
                                            removeTask: () {
                                              setState(() {
                                                tasks.removeWhere((element) =>
                                                    element.name == task.name);
                                              });
                                            },
                                          ));
                                },
                                child: Text(
                                  task.name,
                                  style: TextStyle(
                                      decoration: task.isDone
                                          ? TextDecoration.lineThrough
                                          : null),
                                ),
                              ),
                              trailing: Checkbox(
                                activeColor: Colors.lightBlueAccent,
                                value: task.isDone,
                                onChanged: (checkBoxState) {
                                  setState(() {
                                    task.isDone = checkBoxState;
                                  });
                                },
                              ))
                      ],
                      onReorder: (int oldIndex, int newIndex) {
                        if (newIndex > oldIndex) newIndex -= 1;

                        setState(() {
                          Task switchTask = tasks[oldIndex];

                          tasks.removeAt(oldIndex);
                          tasks.insert(newIndex, switchTask);
                        });
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
