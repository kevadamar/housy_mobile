import 'dart:io';

import 'package:dev_mobile/components/input_reuse/input_reuse_component.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  placeholder() {
    return Container(
      width: double.infinity,
      height: 150.0,
      child: Image.asset('./assets/images/placeholder.png'),
    );
  }

  _pilihGalerry(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final XFile image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1920.0,
      maxWidth: 1080,
    );

    if (image?.path != null) {
      authProvider.setImageFile(File(image.path));
    }
    Navigator.of(context).pop();
  }

  _pilihCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final XFile image = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080);

    if (image?.path != null) {
      authProvider.setImageFile(File(image.path));
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

  final snackBar = (String msg, int status) => SnackBar(
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
        backgroundColor: status == 200 ? Colors.green[400] : Colors.red[700],
        width: 300, // Width of the SnackBar.
        padding: EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );

  initSetup() {
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    email = TextEditingController(text: user.email);
    fullname = TextEditingController(text: user.fullname);
    username = TextEditingController(text: user.username);

    gender = TextEditingController(text: user.gender);
    phone = TextEditingController(text: user.phoneNumber);
    address = TextEditingController(text: user.address);
  }

  @override
  void initState() {
    super.initState();
    initSetup();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {
            authProvider.resetImageFile();

            Navigator.of(context).pop();
          },
          icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45.0, vertical: 25),
                child: Column(
                  children: [
                    Text(
                      'Foto Profile',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      child: InkWell(
                        onTap: () {
                          dialogFileFoto(context);
                        },
                        child: value.user.imagePofile == null
                            ? value.imageFile == null
                                ? placeholder()
                                : Image.file(value.imageFile,
                                    fit: BoxFit.contain)
                            : value.imageFile == null
                                ? Image.network(
                                    Api().baseUrlImg + value.user.imagePofile,
                                    fit: BoxFit.contain)
                                : Image.file(value.imageFile,
                                    fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputReuse(
                      controller: email,
                      color: Colors.black,
                      label: "Email",
                      readOnly: true,
                      filled: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputReuse(
                      controller: fullname,
                      color: Colors.black,
                      label: "Nama",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputReuse(
                      controller: username,
                      color: Colors.black,
                      label: "Username",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputReuse(
                      controller: phone,
                      color: Colors.black,
                      label: "Nomor",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputReuse(
                        controller: address,
                        color: Colors.black,
                        label: "Alamat",
                        type: "multiline"),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final response = await Services.instance.updateProfile(
                            context,
                            fullname.text,
                            username.text,
                            phone.text,
                            address.text);

                        int status = response['status'];
                        print(response['status']);
                        String msg = status <= 203
                            ? 'Success Update Profile!'
                            : 'Invalid Update Profile!';

                        Navigator.of(context).pushReplacementNamed(
                            RouterGenerator.historyScreen);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar(msg, status));
                        authProvider.resetImageFile();
                        if (value.user.role.name == 'tenant') {
                          Navigator.of(context).pushReplacementNamed(
                              RouterGenerator.accountScreen);
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              RouterGenerator.homeAdminScreen,
                              (route) => false);
                        }
                      },
                      child: Container(
                        height: 60.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: identityColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SAVE PROFILE',
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
