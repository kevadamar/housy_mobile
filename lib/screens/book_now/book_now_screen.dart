import 'package:dev_mobile/components/custom_appbar/custom_appbar_booknow_component.dart';
import 'package:dev_mobile/components/floating_button/floating_button_component.dart';
import 'package:dev_mobile/models/book_now_model.dart';
import 'package:dev_mobile/screens/book_now/widget/book_now_content.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookNowScreen extends StatefulWidget {
  final BookNowModel bookHouse;
  const BookNowScreen({Key key, @required this.bookHouse}) : super(key: key);

  @override
  _BookNowScreenState createState() => _BookNowScreenState(
        houseId: bookHouse.houseId,
        houseImg: bookHouse.houseImg,
        price: bookHouse.price,
      );
}

class _BookNowScreenState extends State<BookNowScreen> {
  final int houseId;
  final String houseImg;
  final int price;

  _BookNowScreenState({
    @required this.houseId,
    @required this.houseImg,
    @required this.price,
  });

  void handleCallback(String event) {
    print(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: identityColor,
      appBar: CustomAppBarBookNow(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 0.35.sh,
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  Api().baseUrlImg + houseImg,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            BookNowContent(),
          ],
        ),
      ),
      bottomSheet: FloatingButton(),
    );
  }
}
