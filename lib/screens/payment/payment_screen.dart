import 'dart:io';

import 'package:dev_mobile/providers/booking_provider.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    var placeholder = Container(
      width: double.infinity,
      height: 150.0,
      child: Image.asset('./assets/images/placeholder.png'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        leading: IconButton(
          onPressed: () {
            bookingProvider.resetImageFile();
            print(bookingProvider.imageFile);
            Navigator.of(context).pop();
          },
          icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 0.4.sw,
                          child: Text(
                            'Payment To ',
                          ),
                        ),
                        SizedBox(
                          width: 0.5.sw,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Owner',
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                '1556-1205-1255-32',
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'BCA',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 5,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text('Bukti Pembayaran'),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: 1.sw,
                      height: 0.3.sh,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      )),
                      child: Consumer<BookingProvider>(
                        builder: (context, value, child) => InkWell(
                            onTap: () {
                              dialogFileFoto(context);
                            },
                            child: value.imageFile == null
                                ? placeholder
                                : Image.file(value.imageFile,
                                    fit: BoxFit.fill)),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () => print('pay'),
                    child: Container(
                      alignment: Alignment.center,
                      width: 1.sw,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: identityColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        'BOOKING NOW',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pilihGalerry(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    final XFile image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1920.0,
      maxWidth: 1080,
    );

    if (image?.path != null) {
      bookingProvider.setImageFile(File(image.path));
    }
    Navigator.of(context).pop();
  }

  _pilihCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    final XFile image = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080);

    if (image?.path != null) {
      bookingProvider.setImageFile(File(image.path));
      print(image.path);
    }
    Navigator.of(context).pop();
  }

  dialogFileFoto(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Silahkan pilih file",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _pilihGalerry(context);
                      },
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    InkWell(
                      onTap: () {
                        _pilihCamera(context);
                      },
                      child: Text(
                        "Camera",
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
}
