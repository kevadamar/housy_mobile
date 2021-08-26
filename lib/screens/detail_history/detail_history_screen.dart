import 'package:dev_mobile/components/custom_appbar/custom_appbar_component.dart';
import 'package:dev_mobile/models/history_model.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/screens/detail_history/widget/detail_content.dart';

import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailHistoryScreen extends StatefulWidget {
  final HistoryModel history;
  const DetailHistoryScreen({Key key, @required this.history})
      : super(key: key);

  @override
  DetailHistoryScreenState createState() => DetailHistoryScreenState();
}

class DetailHistoryScreenState extends State<DetailHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final history = widget.history;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        routeBack: false,
        routeBackCb: authProvider.user.role.name == 'tenant'
            ? RouterGenerator.historyScreen
            : RouterGenerator.homeAdminScreen,
      ),
      body: DetailContent(
        history: history,
      ),
    );
  }
}
