import 'package:dev_mobile/providers/location_providers.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SearchItem extends StatefulWidget {
  Function onClick;
  Function(String) onSubmit;
  TextEditingController controller;
  bool readOnly;
  bool autoFocus;

  SearchItem({
    this.onClick,
    this.onSubmit,
    @required this.controller,
    this.readOnly = false,
    this.autoFocus = false,
  });

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: identityColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              size: 20,
              color: identityColor,
            ),
            SizedBox(width: 5),
            Consumer<LocationProvider>(builder: (context, locationProv, _) {
              if (locationProv.city == null) {
                return CircularProgressIndicator();
              }

              return Expanded(
                child: TextField(
                  controller: widget.controller,
                  textInputAction: TextInputAction.done,
                  onTap: () => widget.onClick != null ? widget.onClick() : {},
                  keyboardType: TextInputType.text,
                  readOnly: widget.readOnly,
                  autofocus: widget.autoFocus,
                  style: TextStyle(
                      fontSize: 15,
                      // color: Colors.grey,
                      fontWeight: FontWeight.w600),
                  onSubmitted: (value) =>
                      widget.onSubmit != null ? widget.onSubmit(value) : {},
                  decoration: InputDecoration(
                    hintText: locationProv.city,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    // hintStyle: TextStyle(color: identityColor),
                  ), //
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
