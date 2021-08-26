import 'package:dev_mobile/components/shimmer_effect/shimmer_effect_component.dart';
import 'package:dev_mobile/models/history_model.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/screens/detail_history/widget/status.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TransactionBody extends StatelessWidget {
  final List<HistoryModel> history;
  const TransactionBody({Key key, @required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 10,
            right: 10,
            bottom: index == (history.length - 1) ? 15 : 0),
        child: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(
            context,
            RouterGenerator.detailHistoryScreen,
            arguments: history[index],
          ),
          child: Container(
            padding: EdgeInsets.all(12),
            // width: 0.5.sw,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Image.network(
                    Api().baseUrlImg + history[index].house.image,
                    width: 0.3.sw,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, value, child) {
                          if (value.isProcessing) {
                            return ShimmerEffect(
                              widget: Container(
                                color: Colors.grey[400],
                                width: 150.w,
                                height: 12.w,
                              ),
                            );
                          }

                          return Text(
                            authProvider.user.role.name == 'tenant'
                                ? history[index].house.name
                                : history[index].user.fullname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, value, child) {
                          if (value.isProcessing) {
                            return ShimmerEffect(
                              widget: Container(
                                color: Colors.grey[400],
                                width: 150.w,
                                height: 12.w,
                              ),
                            );
                          }

                          return Text(
                            authProvider.user.role.name == 'tenant'
                                ? '${formatDate(history[index].checkin)} - ${formatDate(history[index].checkout)}'
                                : history[index].house.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        formatRupiah(history[index].total.toString()),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.red[600],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Status(
                        status: history[index].status,
                        stringStatus: history[index].stringStatus,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
