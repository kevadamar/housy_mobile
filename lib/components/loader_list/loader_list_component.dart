import 'package:dev_mobile/components/shimmer_effect/shimmer_effect_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoaderList extends StatelessWidget {
  const LoaderList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
            top: 15, left: 10, right: 10, bottom: index == 19 ? 15 : 0),
        child: Container(
          padding: EdgeInsets.all(12),
          width: 1.sw,
          height: 0.2.sh,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(0, 2),
                ),
              ]),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: ShimmerEffect(
                    widget: Container(
                  width: 0.3.sw,
                  height: 75,
                  color: Colors.grey[400],
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerEffect(
                    widget: Container(
                      width: 0.51.sw,
                      height: 20,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ShimmerEffect(
                    widget: Container(
                      width: 0.43.sw,
                      height: 20,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ShimmerEffect(
                    widget: Container(
                      width: 0.4.sw,
                      height: 20,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 0.45.sw,
                    height: 20,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
