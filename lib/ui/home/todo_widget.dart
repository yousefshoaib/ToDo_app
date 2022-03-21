import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/data/doto.dart';
import 'package:to_do_app/data/firestore_utils.dart';

class TodoWidget extends StatelessWidget {
  ToDo item;

  TodoWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        dismissible: Container(
          color: Colors.red,
          child: Column(
            children: [],
          ),
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext) {
              deletToDO(item).then((value) {
                Fluttertoast.showToast(
                    msg: "Task Deleted successfull",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.SNACKBAR,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black26,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }).onError((error, stackTrace) {
                Fluttertoast.showToast(
                    msg: "Error Deleting Task",
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
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        height: 100,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 62,
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.symmetric(vertical: 12),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
            )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Image.asset('assets/images/Ic-check.png'),
            )
          ],
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
