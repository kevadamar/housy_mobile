import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/providers/houses_provider.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HouseItemCard extends StatefulWidget {
  final HouseModel house;
  final int index;

  const HouseItemCard({Key key, @required this.house, this.index})
      : super(key: key);

  @override
  _HouseItemCardState createState() => _HouseItemCardState();
}

class _HouseItemCardState extends State<HouseItemCard> {
  void onClick() async {
    print('to detail');
    // Provider.of<HousesProvider>(context, listen: false).clearHouseSearch();
    // Navigator.pushNamed(context, RouterGenerator.routeDetailRestaurant,
    //     arguments: widget.restaurant);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.house;
    final index = widget.index;

    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Provider.of<HousesProvider>(context, listen: false)
              .setFromHome(false);
          Navigator.pushNamed(context, RouterGenerator.detailProductScreen,
              arguments: data);
        },
        child: Container(
          width: 200.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft:
                    index % 2 == 0 ? Radius.circular(15) : Radius.circular(0),
                bottomRight:
                    index % 2 != 0 ? Radius.circular(15) : Radius.circular(0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                )
              ],
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight:
                      index % 2 == 0 ? Radius.circular(15) : Radius.circular(0),
                  topLeft:
                      index % 2 != 0 ? Radius.circular(15) : Radius.circular(0),
                ),
                child: Image.network(
                  Api().baseUrlImg + data.image,
                  fit: BoxFit.cover,
                  width: 1.sw,
                  height: 0.1.sh,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      formatRupiah(data.price.toString()),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.red[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 17.5.sp,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${data.bedroom} Beds, ${data.bathroom} Baths, ${data.area} Sqft',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: identityColor,
                          size: 15.sp,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            data.city,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: () => onClick(),
    //   child: Column(
    //     children: <Widget>[
    //       Row(
    //         children: <Widget>[houseImage(), SizedBox(width: 10), _content()],
    //       ),
    //       Divider(color: Colors.black12),
    //     ],
    //   ),
    // );
  }

  Widget houseImage() {
    return Container(
      width: 100.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
            image: NetworkImage(Api().baseUrlImg + widget.house.image),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _content() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.house.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 5),
          Text(
            widget.house.address,
            style: TextStyle(
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
