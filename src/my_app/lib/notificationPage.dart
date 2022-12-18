import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'models/notificationModel.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<NotificationPage> {
  final _notification = <NotificationModel>[];
  final _readNotification = <NotificationModel>{};

  @override
  void initState() {
    //adding item to list, you can add using json from network
    for (var i = 0; i <= 5; i++) {
      if (i % 2 == 0) {
        _notification.add(NotificationModel("Thông báo $i",
            "1$i/10/2022 10:30, khu vực: Lầu 3, vị trí: 3F_2", 2, 3));
        if (i == 4 || i == 8 || i == 12) {
          _readNotification.add(_notification[i]);
        }
      } else {
        _notification.add(NotificationModel(
            "Thông báo $i", "12/10/2022 10:3$i, khu vực: Lầu 3,3F_1", 1, 3));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green[700],
            title: Text("Notification"),
            leading: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () =>
                    Navigator.pop(context, NotificationModel("", "", 0, 0)))),
        body: ListView.builder(
            itemCount: _notification.length,
            itemBuilder: (context, index) {
              final isRead = _readNotification.contains(_notification[index]);
              return ListTile(
                title: Text(_notification[index].content),
                subtitle: Text(_notification[index].sendAt),
                trailing: Icon(isRead ? null : Icons.circle_sharp,
                    color: isRead ? null : Colors.green[700],
                    semanticLabel: isRead ? 'Remove from saved' : 'Save'),
                onTap: () {
                  setState(() {
                    if (isRead) {
                      //_readNotification.remove(_notification[index]);
                    } else {
                      _readNotification.add(_notification[index]);
                    }
                    Navigator.pop(context, _notification[index]);
                  });
                },
              );
            }));
  }
}
