import 'package:flutter/material.dart';
import 'package:todolist_app/models/tasks.dart';

class EditTask extends StatelessWidget {
  final Function modifyTask, removeTask;
  final Task currentTask;

  EditTask(
      {@required this.currentTask,
      @required this.modifyTask,
      @required this.removeTask});

  @override
  Widget build(BuildContext context) {
    String modifyTaskValue;
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
                TextFormField(
                  initialValue: currentTask.name,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    modifyTaskValue = value;
                  },
                  onFieldSubmitted: (value) {
                    if (modifyTaskValue != null) modifyTask(modifyTaskValue);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  onPressed: () {
                    if (modifyTaskValue != null) modifyTask(modifyTaskValue);

                    Navigator.pop(context);
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlueAccent,
                ),
                FlatButton(
                  onPressed: () {
                    removeTask();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Remove',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.redAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
