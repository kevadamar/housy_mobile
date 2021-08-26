import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Status extends StatelessWidget {
  final int status;
  final String stringStatus;

  const Status({Key key, this.status, this.stringStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _waitingStatus = Container(
      padding: EdgeInsets.all(5),
      color: Colors.yellow[800],
      child: Text(
        stringStatus,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.yellow,
        ),
      ),
    );

    switch (status) {
      case 1:
        return _waitingStatus;
        break;
      case 2:
        return _waitingStatus;
        break;
      case 3:
        return Container(
          padding: EdgeInsets.all(5),
          color: Colors.green[200],
          child: Text(
            stringStatus,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.green[700],
            ),
          ),
        );
        break;
      default:
        return Container(
          padding: EdgeInsets.all(5),
          color: Colors.red[50],
          child: Text(
            stringStatus,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.red,
            ),
          ),
        );
    }
  }
}
