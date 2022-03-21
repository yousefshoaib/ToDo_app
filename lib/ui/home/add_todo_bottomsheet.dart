import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/data/firestore_utils.dart';

class AddToDOBottomSheet extends StatefulWidget {
  @override
  State<AddToDOBottomSheet> createState() => _AddToDOBottomSheetState();
}

class _AddToDOBottomSheetState extends State<AddToDOBottomSheet> {
  var formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: Theme.of(context).textTheme.subtitle1,
                      ),
                      validator: (textValue) {
                        if (textValue == null || textValue.isEmpty) {
                          return 'please enter todo title';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        title = text;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: Theme.of(context).textTheme.subtitle1,
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter todo title';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        description = text;
                      },
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Date'),
            ),
            InkWell(
              onTap: () {
                showDateDialge();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addToDo();
                },
                child: Text('Add'))
          ],
        ));
  }

  void addToDo() {
    if (!formkey.currentState!.validate()) {
      return;
    }
    addToDoFireStore(title, description, selectedDate).then((value) {
      Fluttertoast.showToast(
          msg: "Task Adding successfull",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black26,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Error Adding Task",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black26,
          textColor: Colors.white,
          fontSize: 16.0);
    }).timeout(Duration(seconds: 10), onTimeout: () {
      Fluttertoast.showToast(
          msg: "Timeout",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black26,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void showDateDialge() async {
    var newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      setState(() {});
    }
  }
}
