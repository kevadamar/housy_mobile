import 'dart:io';

import 'package:dev_mobile/components/loader_list/loader_list_component.dart';
import 'package:dev_mobile/components/shimmer_effect/shimmer_effect_component.dart';
import 'package:dev_mobile/components/transaction_body/transaction_body_component.dart';
import 'package:dev_mobile/models/history_model.dart';
import 'package:dev_mobile/providers/auth_provider.dart';

import 'package:dev_mobile/providers/history_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final bookingProvider =
        Provider.of<HistoryProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final response = await Services.instance.getHistory(authProvider.token);

    final msg = response['message'];
    final status = response['status'];
    final data = response['data'];

    // print(data);
    if (data.length > 0) {
      final List<HistoryModel> dataApi = [];
      data.forEach((api) {
        dataApi.add(HistoryModel.fromJson(api));
      });

      bookingProvider.setData(dataApi);
    }
    // Timer(Duration(seconds: 3), () => bookingProvider.setIsProcessing(false));
    bookingProvider.setIsProcessing(false);
  }

  Future<void> _refreshData() async {
    final bookingProvider =
        Provider.of<HistoryProvider>(context, listen: false);
    bookingProvider.setIsProcessingTrue();

    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              RouterGenerator.homeScreen, (route) => false),
          icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
        ),
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: identityColor,
        title: Text('Riwayat'),
      ),
      body: RefreshIndicator(
        child: Consumer<HistoryProvider>(
          builder: (context, value, child) {
            if (value.isProcessing) {
              return LoaderList();
            }

            // return _bodyLoading();
            return value.data.length == 0
                ? _bodyNoData()
                : TransactionBody(history: value.data);
          },
        ),
        onRefresh: _refreshData,
      ),
    );
  }

  _bodyNoData() => ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Oppss... Coba untuk booking dahulu"),
            ),
          )
        ],
      );
}
