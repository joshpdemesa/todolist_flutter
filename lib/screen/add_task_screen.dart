import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final Function addTask;

  AddTaskScreen(this.addTask);

  @override
  Widget build(BuildContext context) {
    String newTask;

    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Color(0xFF757575),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.black45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Add a task',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    newTask = value;
                  },
                  onSubmitted: (value) {
                    if (newTask != null) addTask(newTask);
                  },
                ),
                FlatButton(
                  onPressed: () {
                    if (newTask != null) addTask(newTask);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlueAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
