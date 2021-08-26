import 'package:dev_mobile/models/booking_model.dart';
import 'package:dev_mobile/models/history_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/providers/booking_provider.dart';
import 'package:dev_mobile/screens/detail_history/widget/detail_information.dart';

import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailContent extends StatelessWidget {
  final HistoryModel history;
  const DetailContent({Key key, this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HouseModel house = history.house;
    Provider.of<BookingProvider>(context, listen: false).resetSelectedImg();
    return SafeArea(
      child: Column(
        children: [
          Consumer<BookingProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  ...imagePreview(
                      house,
                      value.selectedImg == null || value.selectedImg.length == 0
                          ? house.image
                          : value.selectedImg,
                      (img) => value.setSelecetImg(img))
                ],
              );
            },
          ),
          DetailInformation(
            history: history,
          ),
        ],
      ),
    );
  }

  List<Widget> imagePreview(
      HouseModel house, String selectedImg, Function setState) {
    return [
      Container(
        width: deviceWidth(),
        height: deviceHeight() * 0.3,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        child: Image.network(
          Api().baseUrlImg + selectedImg,
          fit: BoxFit.fill,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          smallPreview(
            house.image,
            selectedImg,
            () => setState(house.image),
          ),
          SizedBox(
            width: 10,
          ),
          smallPreview(
            house.imageFirst == null ? house.image : house.imageFirst,
            selectedImg,
            () => setState(
                house.imageFirst == null ? house.image : house.imageFirst),
          ),
          SizedBox(
            width: 10,
          ),
          smallPreview(
            house.imageSecond == null ? house.image : house.imageSecond,
            selectedImg,
            () => setState(
                house.imageSecond == null ? house.image : house.imageSecond),
          ),
          SizedBox(
            width: 10,
          ),
          smallPreview(
            house.imageThird == null ? house.image : house.imageThird,
            selectedImg,
            () => setState(
                house.imageThird == null ? house.image : house.imageThird),
          ),
        ],
      )
    ];
  }

  Widget smallPreview(String image, String selectedImg, Function setState) {
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
              color: selectedImg == image ? identityColor : Colors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(Api().baseUrlImg + image),
        ),
      ),
    );
  }
}
