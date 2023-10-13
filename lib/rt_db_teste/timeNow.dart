import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeNow extends StatefulWidget {
  const TimeNow({Key? key}) : super(key: key);

  @override
  State<TimeNow> createState() => _TimeNowState();
}

class _TimeNowState extends State<TimeNow> {
  DateTime now = DateTime.now();
  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
  // String formatdata = DateFormat.HOUR24;
// DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
// var formatedTime = currentTime.toString().split(':')
// Text(formatedTime[0])
  var today;

  @override
  void initState() {
    super.initState();
    // Datetime today = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('time now'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Text('$now'),
          Text('${DateFormat('Hm').format(now)}'),
          // Text('${DateFormat('dd-MM-yyyy').format(now)}'),
          Text('${DateFormat.yMEd().add_jms().format(now)}'),
        ]),
      ),
    );
  }
}
