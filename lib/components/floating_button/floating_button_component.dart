import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingButton extends StatelessWidget {
  final String titleButton;
  final Function cb;
  const FloatingButton({Key key, @required this.titleButton, this.cb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.03.sh,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: deviceWidth(),
              height: 50.h,
              child: LayoutBuilder(builder: (context, constraints) {
                return GestureDetector(
                  onTap: () => cb('clicked book now'),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: identityColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: constraints.maxWidth * 0.8,
                      alignment: Alignment.center,
                      child: Text(
                        titleButton.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
