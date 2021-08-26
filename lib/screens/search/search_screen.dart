import 'dart:io';

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
  var _budgetController = TextEditingController();
  String city;
  @override
  Widget build(BuildContext context) {
    final houseProvider = Provider.of<HousesProvider>(context, listen: false);

    houseProvider.setShowFilter(false);
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) => Consumer<HousesProvider>(
            builder: (context, houseProvider, child) => SearchItem(
              controller: searchController,
              autoFocus: true,
              onSubmit: (value) {
                setState(() {
                  _budgetController = TextEditingController();
                  houseProvider.searchHouseByFilterCity(value, context);
                  city = value;
                });
              },
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            houseProvider.setShowFilter(false);
          },
          icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
        ),
        actions: [
          Consumer<HousesProvider>(
            builder: (context, value, child) {
              if (value.showFilter) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    size: 24.sp,
                    color: Colors.white,
                  ),
                );
              }
              return Text('');
            },
          )
        ],
      ),
      body: _bodyContent(context),
      endDrawer: Consumer<HousesProvider>(
        builder: (context, value, child) {
          if (value.showFilter) {
            return Drawer(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Text('Budget'),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _budgetController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        houseProvider.searchHouseByFilterCombination(
                          city,
                          context,
                          _budgetController.text,
                        );

                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        width: 100.w,
                        height: 50.h,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: identityColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'FILTER',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Text('');
        },
      ),
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Mau cari Rumah di lokasi lain?"),
                ),
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Rumah tidak ditemukan"),
                ),
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
          },
        );
      },
    );
  }
}
