import 'dart:io';

import 'package:dev_mobile/components/custom_appbar/custom_appbar_component.dart';
import 'package:dev_mobile/models/book_now_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/providers/book_now_provider.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final HouseModel house;
  const DetailScreen({Key key, @required this.house}) : super(key: key);

  @override
  _DetailScreenState createState() =>
      _DetailScreenState(selectedImg: house.image);
}

class _DetailScreenState extends State<DetailScreen> {
  String selectedImg;

  _DetailScreenState({this.selectedImg});

  @override
  Widget build(BuildContext context) {
    final bookNowProvider =
        Provider.of<BookNowProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              ...imagePreview(
                widget.house,
                selectedImg,
                (imgselected) => setState(() => selectedImg = imgselected),
              ),
              Expanded(flex: 1, child: detailProductInformation(widget.house)),
            ],
          ),
          floatingBookNow(bookNowProvider),
        ],
      ),
    );
  }

  Widget floatingBookNow(BookNowProvider provider) {
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
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouterGenerator.bookNowScreen,
                      arguments: BookNowModel.obj(
                        widget.house.id,
                        widget.house.image,
                        widget.house.price,
                      ),
                    );
                    provider.setBookNowProvider(
                        widget.house.price, widget.house.id);
                  },
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
                        'BOOK NOW',
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

  Widget detailProductInformation(HouseModel house) => Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(
          top: 25.h,
          left: 12,
          right: 12,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
                spreadRadius: 0.1,
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0)
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              house.name,
              style: TextStyle(
                fontSize: setFontSize(24),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: identityColor,
                  size: 14.sp,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  house.address + ', ' + house.city,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${formatRupiah(house.price.toString())},-/${house.typeRent}',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.red[600],
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '${house.bedroom} Beds, ${house.bathroom} Baths, ${house.area} Sqft',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Text(widget.house.description.length.toString()),
            // Container(
            //   width: deviceWidth(),
            //   child:
            // ),
            Text(
              house.description,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                height: 1.4,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            if (house.description.length >= 358)
              GestureDetector(
                onTap: () => print('see more'),
                child: Row(
                  children: [
                    Text(
                      "See More Detail",
                      style: TextStyle(
                        color: identityColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: identityColor,
                    )
                  ],
                ),
              ),
          ],
        ),
      );

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
