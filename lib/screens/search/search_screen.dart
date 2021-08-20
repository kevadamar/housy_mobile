import 'package:dev_mobile/components/search_item/search_item_component.dart';
import 'package:dev_mobile/providers/houses_provider.dart';
import 'package:dev_mobile/screens/search/widget/house_item_card.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) => Consumer<HousesProvider>(
            builder: (context, houseProvider, child) => SearchItem(
              controller: searchController,
              autoFocus: true,
              onSubmit: (value) =>
                  houseProvider.searchHouseByFilterCity(value, context),
            ),
          ),
        ),
      ),
      body: _bodyContent(context),
    );
  }

  Widget _bodyContent(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _contentList(),
        ],
      ),
    );
  }

  Widget _contentList() {
    return Builder(
      builder: (context) {
        return Consumer<HousesProvider>(
          builder: (context, value, _) {
            //* If collection data null then fetch
            if (value.searchByFilter == null && value.onSearch == false) {
              return Center(
                child: Text("Mau cari Rumah di lokasi lain?"),
              );
            }

            if (value.onSearch) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            //* If collection is not found
            if (value.searchByFilter.length == 0) {
              return Center(
                child: Text("Rumah tidak ditemukan"),
              );
            }

            return GridView.count(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 0.82.h,
              children: List.generate(
                value.searchByFilter.length,
                (index) => HouseItemCard(
                  house: value.searchByFilter[index],
                  index: index,
                ),
              ),
            );
            // return ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: 16,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) {
            //     var house = value.searchByFilter[1];
            //     return HouseItemCard(house: house);
            //   },
            // );
          },
        );
      },
    );
  }
}
