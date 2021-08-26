import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/providers/houses_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HouseAdminBody extends StatelessWidget {
  final List<HouseModel> house;
  final Function refreshHouses;
  HouseAdminBody({Key key, this.house, this.refreshHouses}) : super(key: key);

  _snackBar(String msg, int status) => SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3,
        duration: Duration(
          milliseconds: 2500,
        ),
        backgroundColor: status <= 203 ? Colors.green[400] : Colors.red[700],
        width: 300, // Width of the SnackBar.
        padding: EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );

  dialogDelete(BuildContext context, int houseId) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Apakah anda yakin untuk menghapus ?",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Tidak",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    InkWell(
                      onTap: () async {
                        final response = await Services.instance
                            .deleteHouse(context, houseId);
                        int statusCode = response['status'];

                        String msg = statusCode <= 203
                            ? 'Success Delete House'
                            : 'Delete House Failed';

                        if (statusCode <= 203) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(_snackBar(msg, statusCode));
                          await refreshHouses();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(_snackBar(msg, statusCode));
                        } // else jika status code diaatas 203
                        print('ya');
                      },
                      child: Text(
                        "Ya",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final houseProvider = Provider.of<HousesProvider>(context, listen: false);

    return ListView.builder(
      itemCount: house.length,
      // physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          top: 15,
          left: 10,
          right: 10,
          bottom: index == (house.length - 1) ? 15 : 0,
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        house[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton(
                          onSelected: (value) {
                            if (value == 0) {
                              print('edit');
                              houseProvider.setHouse(house[index]);

                              Navigator.of(context).pushNamed(
                                RouterGenerator.addEditHouseScreen,
                              );
                            } else {
                              dialogDelete(context, house[index].id);
                              print('delete');
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 0,
                              child: ListTile(
                                leading: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                leading: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Hapus',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          child: Icon(Icons.more_vert),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    RouterGenerator.detailProductScreen,
                    arguments: house[index],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          Api().baseUrlImg + house[index].image,
                          width: 0.3.sw,
                          height: 100.h,
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
                            Text(
                              house[index].city.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${house[index].bedroom} Beds, ${house[index].bathroom} Baths, ${house[index].area} Sqft',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${formatRupiah(house[index].price.toString())},-/${house[index].typeRent}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                color: Colors.red[600],
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Container(
                            //   padding: EdgeInsets.all(5),
                            //   color: Colors.yellow[800],
                            //   child: Text(
                            //     house[index].stringStatus,
                            //     maxLines: 1,
                            //     overflow: TextOverflow.ellipsis,
                            //     style: TextStyle(
                            //       fontSize: 15.sp,
                            //       color: Colors.yellow,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
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
              ],
            )),
      ),
    );
  }
}
