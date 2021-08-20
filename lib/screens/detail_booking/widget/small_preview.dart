import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallPreview extends StatelessWidget {
  final Function setState;
  final String selectedImg;
  final String imageDefault;

  SmallPreview({Key key, this.setState, this.selectedImg, this.imageDefault})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(),
      child: Container(
        padding: EdgeInsets.all(4),
        width: 80.w,
        height: 53.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: selectedImg == imageDefault
                  ? identityColor
                  : Colors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(Api().baseUrlImg + imageDefault),
        ),
      ),
    );
  }
}
