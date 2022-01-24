import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'notification_manager.dart';
import 'package:perfectholyquran/canvaDBFiles/newDBHelper.dart';

class AddNotification extends StatefulWidget {
  final NotificationManager manager;
  const AddNotification(this.manager);

  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {

  final dbHelper = DatabaseHelper.instance;
  //final maangerS = NotificationManager;
  NotificationManager managerNoti = new NotificationManager();

  @override
  Widget build(BuildContext context) {

    void _insertNotification(String notificationName,String hours, String minutes) async {
      Map<String, dynamic> row = {
        DatabaseHelper.nameNotification : notificationName,
        DatabaseHelper.hoursNotification : hours,
        DatabaseHelper.minutesNotification : minutes,
      };
      final id = await dbHelper.insertNotification(row);
      print('inserted row id: $id');
    }

    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              ).then((selectedTime) async {
                int hour = selectedTime.hour;
                int minute = selectedTime.minute;
                print(selectedTime);
                // insert into database
                _insertNotification("notificationName", hour.toString(), minute.toString());
                // sehdule the notification
                managerNoti.showNotificationDaily(1, "Asar", "isNotification", hour, minute);
                // The medicine Id and Notitfaciton Id are the same
                //print('New Med id' + medicineId.toString());

              });
            },
            child: Text("Add Notification"),



          ),
        ),
      ),


    );
  }

// void _submit(NotificationManager manager) async {
//
//     //show the time picker dialog
//     showTimePicker(
//       initialTime: TimeOfDay.now(),
//       context: context,
//     ).then((selectedTime) async {
//       int hour = selectedTime.hour;
//       int minute = selectedTime.minute;
//       print(selectedTime);
//       // insert into database
//      inse
//       // sehdule the notification
//       manager.showNotificationDaily(medicineId, _name, _dose, hour, minute);
//       // The medicine Id and Notitfaciton Id are the same
//       print('New Med id' + medicineId.toString());
//       // go back
//       Navigator.pop(context, medicineId);
//     });
//
// }

}
