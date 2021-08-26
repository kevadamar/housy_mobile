import 'package:dev_mobile/components/house_admin_body/house_admin_body_component.dart';
import 'package:dev_mobile/components/loader_list/loader_list_component.dart';
import 'package:dev_mobile/components/transaction_body/transaction_body_component.dart';
import 'package:dev_mobile/models/history_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/models/user_model.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/providers/history_provider.dart';
import 'package:dev_mobile/providers/houses_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({Key key}) : super(key: key);

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Future<void> _fetchData() async =>
      Provider.of<AuthProvider>(context, listen: false).getUser();

  Future<void> _fetchDataHouses() async {
    final housesProvider = Provider.of<HousesProvider>(context, listen: false);
    String token = Provider.of<AuthProvider>(context, listen: false).token;

    final response = await Services.instance.getHousesByToken(token);

    final msg = response['message'];
    final status = response['status'];
    final data = response['data'];

    final List<HouseModel> dataApi = [];

    data.forEach((api) {
      dataApi.add(HouseModel.fromJson(api));
    });

    housesProvider.setData(dataApi);

    housesProvider.setIsProcessing(false);
  }

  Future<void> _fetchDataTransaction() async {
    final bookingProvider =
        Provider.of<HistoryProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final response = await Services.instance.getHistory(authProvider.token);

    final msg = response['message'];
    final status = response['status'];
    final data = response['data'];

    if (data.length > 0) {
      final List<HistoryModel> dataApi = [];
      data.forEach((api) {
        dataApi.add(HistoryModel.fromJson(api));
      });

      bookingProvider.setData(dataApi);
    } else {
      bookingProvider.setData([]);
    }
    // Timer(Duration(seconds: 3), () => bookingProvider.setIsProcessing(false));
    bookingProvider.setIsProcessing(false);
  }

  Future<void> _refreshDataHouse() async {
    final housesProvider = Provider.of<HousesProvider>(context, listen: false);
    housesProvider.setIsProcessingTrue();
    await _fetchDataHouses();
  }

  Future<void> _refreshDataTransaction() async {
    final bookingProvider =
        Provider.of<HistoryProvider>(context, listen: false);

    bookingProvider.setIsProcessingTrue();
    await _fetchDataTransaction();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchDataTransaction();
    _fetchDataHouses();
    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<AuthProvider>(
            builder: (context, value, child) {
              if (value.isProcessing) {
                return CircularProgressIndicator.adaptive();
              }
              return Text('Welcome ${value.user.fullname}');
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  _prefs.remove('token');
                  _prefs.remove('role');

                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);

                  authProvider..setToken(null);
                  authProvider.resetUser();

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouterGenerator.homeScreen, (route) => false);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Transaksi',
              ),
              Tab(
                text: 'Rumah',
              ),
              Tab(
                text: 'Akun',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(children: [
            RefreshIndicator(
              child: Consumer<HistoryProvider>(
                builder: (context, value, child) {
                  if (value.isProcessing) {
                    return LoaderList();
                  }

                  // return _bodyLoading();
                  return value.data.length == 0
                      ? _bodyNoData("Transaksi masih kosong")
                      : TransactionBody(history: value.data);
                },
              ),
              onRefresh: _refreshDataTransaction,
            ),
            RefreshIndicator(
              child: Consumer<HousesProvider>(
                builder: (context, value, child) {
                  if (value.isProcessing) {
                    return LoaderList();
                  }

                  // return _bodyLoading();
                  return Stack(
                    children: [
                      value.data.length == 0
                          ? _bodyNoData("Rumah masih kosong")
                          : HouseAdminBody(
                              house: value.data,
                              refreshHouses: _refreshDataHouse,
                            ),
                      Positioned(
                        bottom: 45.h,
                        right: 35.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: identityColor,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(RouterGenerator.addEditHouseScreen),
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              onRefresh: _refreshDataHouse,
            ),
            bodyAccountContent(),
          ]),
        ),
      ),
    );
  }

  _bodyNoData(String msg) => ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(msg),
            ),
          )
        ],
      );

  Widget bodyAccountContent() => Builder(
        builder: (context) => Consumer<AuthProvider>(
          builder: (context, value, child) {
            if (value.isProcessing) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            UserModel user = value.user;
            return Column(
              children: [
                Container(
                  width: 1.sw,
                  height: 0.3.sh,
                  child: Align(
                    alignment: Alignment.center,
                    child: user.imagePofile == null
                        ? Image.asset('./assets/images/user-icon.jpeg')
                        : Image.network(Api().baseUrlImg + user.imagePofile),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 0.1,
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10.0)
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Stack(
                      children: [
                        ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.email,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Nama',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.fullname,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Username',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.username,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     SizedBox(
                            //       width: 0.4.sw,
                            //       child: Text(
                            //         'Gender',
                            //         style: TextStyle(
                            //           fontSize: 20.sp,
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         user.gender,
                            //         maxLines: 2,
                            //         overflow: TextOverflow.ellipsis,
                            //         style: TextStyle(
                            //           fontSize: 20.sp,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 15.h,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Nomor',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.phoneNumber,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    'Alamat',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    user.address,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(RouterGenerator.editProfileScreen),
                            child: Container(
                              height: 60.h,
                              width: 1.sw,
                              decoration: BoxDecoration(
                                color: identityColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'EDIT PROFILE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
