import 'dart:io';

import 'package:dev_mobile/components/input_reuse/input_reuse_component.dart';
import 'package:dev_mobile/models/city_model.dart';
import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/providers/houses_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/api.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddEditHouse extends StatefulWidget {
  AddEditHouse({Key key}) : super(key: key);

  @override
  _AddEditHouseState createState() => _AddEditHouseState();
}

class _AddEditHouseState extends State<AddEditHouse> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  setup(HouseModel house) async {
    name = TextEditingController(text: house.name);
    price = TextEditingController(text: house.price.toString());
    area = TextEditingController(text: house.area);
    description = TextEditingController(text: house.description);
    address = TextEditingController(text: house.address);
  }

  Future<List<CityModel>> getData(filter) async {
    var response = await Services.instance.getCities();

    final data = response['data'];

    if (data != null) {
      List<CityModel> _data = [];
      data.forEach((api) {
        _data.add(CityModel.fromJson(api));
      });
      return _data;
    }

    return [];
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

  _pilihGalerry(BuildContext context, int forImg) async {
    final ImagePicker _picker = ImagePicker();
    final houseProvider = Provider.of<HousesProvider>(context, listen: false);

    final XFile image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1920.0,
      maxWidth: 1080,
    );

    if (image?.path != null) {
      switch (forImg) {
        case 1:
          houseProvider.setImageFileOne(File(image.path));
          break;
        case 2:
          houseProvider.setImageFileTwo(File(image.path));
          break;
        case 3:
          houseProvider.setImageFileThree(File(image.path));
          break;
        case 4:
          houseProvider.setImageFileFourth(File(image.path));
          break;
      }
    }
    Navigator.of(context).pop();
  }

  _pilihCamera(BuildContext context, int forImg) async {
    final ImagePicker _picker = ImagePicker();
    final houseProvider = Provider.of<HousesProvider>(context, listen: false);

    final XFile image = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080);

    if (image?.path != null) {
      switch (forImg) {
        case 1:
          houseProvider.setImageFileOne(File(image.path));
          break;
        case 2:
          houseProvider.setImageFileTwo(File(image.path));
          break;
        case 3:
          houseProvider.setImageFileThree(File(image.path));
          break;
        case 4:
          houseProvider.setImageFileFourth(File(image.path));
          break;
      }
    }
    Navigator.of(context).pop();
  }

  dialogFileFoto(BuildContext context, int forImg) {
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
                        _pilihGalerry(context, forImg);
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
                        _pilihCamera(context, forImg);
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

  _initData() {
    final houseProvider = Provider.of<HousesProvider>(context, listen: false);
    HouseModel house = houseProvider.house;
    if (house != null) {
      print('initt house edit');
      houseProvider
          .setCity(CityModel(id: house.city.id, name: house.city.name));
      houseProvider.setInitBedroom(house.bedroom);
      houseProvider.setInitBathroom(house.bathroom);

      setup(house);
    }
  }

  _resetState(HousesProvider houseProvider) {
    houseProvider.setHouse(null);
    houseProvider.setCity(null);
    houseProvider.setInitBedroom('1');
    houseProvider.setInitBathroom('1');
    houseProvider.resetImage();

    name = TextEditingController();
    price = TextEditingController();
    area = TextEditingController();
    description = TextEditingController();
    address = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final houseProvider = Provider.of<HousesProvider>(context, listen: false);
    HouseModel house = houseProvider.house;

    var placeholder = Container(
      width: double.infinity,
      height: 150.0,
      child: Image.asset('./assets/images/placeholder.png'),
    );

    return Scaffold(
      appBar: AppBar(
        title: house == null ? Text('Tambah Rumah') : Text('Edit Rumah'),
        leading: IconButton(
          onPressed: () {
            _resetState(houseProvider);
            Navigator.of(context).pop();
          },
          icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    InputReuse(
                      controller: name,
                      color: identityColor,
                      label: 'Nama Rumah',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputReuse(
                      controller: price,
                      keyboardType: TextInputType.number,
                      color: identityColor,
                      label: 'Harga Sewa Rumah Per Hari',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Dropdown input city
                    Consumer<HousesProvider>(
                      builder: (context, value, _) => DropdownSearch<CityModel>(
                        dropdownSearchDecoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: identityColor,
                          ),
                          hintText: 'Masukkan Kota',
                          hintStyle: TextStyle(
                            color: identityColor,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: identityColor,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: identityColor,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: identityColor, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        dropdownButtonBuilder: (_) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.deepPurple,
                          ),
                        ),
                        showAsSuffixIcons: true,
                        // clearButtonBuilder: (_) => Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: const Icon(
                        //     Icons.clear,
                        //     size: 24,
                        //     color: Colors.deepPurple,
                        //   ),
                        // ),
                        itemAsString: (CityModel u) => u.name,
                        maxHeight: 300,
                        onFind: (String filter) => getData(filter),
                        showSelectedItem: true,
                        compareFn: (item, selectedItem) =>
                            item?.id == selectedItem?.id,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (u) =>
                            u == null ? "Kota is required " : null,
                        // label: "Kota",
                        hint: value.city != null
                            ? value.city.name
                            : "Masukkan Kota Rumah Anda",

                        selectedItem: value.city,
                        onChanged: (CityModel city) => value.setCity(city),
                        showSearchBox: true,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // dropdown input bedroom
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          // color: identityColor,
                          border: Border.all(
                            width: 1,
                            color: identityColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Consumer<HousesProvider>(
                          builder: (context, _houseProvider, child) =>
                              DropdownButton<String>(
                            value: _houseProvider.bedroom,
                            hint: Text(
                              'Bedroom',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: identityColor,
                              ),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.deepPurple,
                            ),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: SizedBox(),
                            isExpanded: true,
                            onChanged: (String newValue) {
                              _houseProvider.setBedroom(newValue);
                            },
                            items: <String>['1', '2', '3', '4', '5']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value + 'Bedroom'),
                              );
                            }).toList(),
                          ),
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    // dropdown input Bathroom
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          // color: identityColor,
                          border: Border.all(
                            width: 1,
                            color: identityColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Consumer<HousesProvider>(
                          builder: (context, _houseProvider, child) =>
                              DropdownButton<String>(
                            value: _houseProvider.bathroom,
                            hint: Text(
                              'Bathroom',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: identityColor,
                              ),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.deepPurple,
                            ),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: SizedBox(),
                            isExpanded: true,
                            onChanged: (String newValue) {
                              _houseProvider.setBathroom(newValue);
                            },
                            items: <String>['1', '2', '3', '4', '5']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value + ' Bathroom'),
                              );
                            }).toList(),
                          ),
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputReuse(
                      controller: area,
                      color: identityColor,
                      label: 'Area',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputReuse(
                      controller: description,
                      color: identityColor,
                      label: 'Deskripsi Rumah',
                      type: "multiline",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputReuse(
                      controller: address,
                      color: identityColor,
                      label: 'Alamat',
                      type: "multiline",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Gambar 1
                    Column(
                      children: [
                        Text(
                          'Gambar 1',
                          style: TextStyle(
                            color: identityColor,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 1.sw,
                          height: 0.3.sh,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          )),
                          child: Consumer<HousesProvider>(
                              builder: (context, value, child) => InkWell(
                                    onTap: () {
                                      dialogFileFoto(context, 1);
                                    },
                                    child: value.imageFileOne == null
                                        ? placeholder
                                        : Image.file(value.imageFileOne,
                                            fit: BoxFit.contain),
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Gambar 2
                    Column(
                      children: [
                        Text(
                          'Gambar 2',
                          style: TextStyle(
                            color: identityColor,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 1.sw,
                          height: 0.3.sh,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          )),
                          child: Consumer<HousesProvider>(
                              builder: (context, value, child) => InkWell(
                                    onTap: () {
                                      dialogFileFoto(context, 2);
                                    },
                                    child: value.imageFileTwo == null
                                        ? placeholder
                                        : Image.file(value.imageFileTwo,
                                            fit: BoxFit.contain),
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Gambar 3
                    Column(
                      children: [
                        Text(
                          'Gambar 3',
                          style: TextStyle(
                            color: identityColor,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 1.sw,
                          height: 0.3.sh,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          )),
                          child: Consumer<HousesProvider>(
                              builder: (context, value, child) => InkWell(
                                    onTap: () {
                                      dialogFileFoto(context, 3);
                                    },
                                    child: value.imageFileThree == null
                                        ? placeholder
                                        : Image.file(value.imageFileThree,
                                            fit: BoxFit.contain),
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Gambar 4
                    Column(
                      children: [
                        Text(
                          'Gambar 4',
                          style: TextStyle(
                            color: identityColor,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 1.sw,
                          height: 0.3.sh,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          )),
                          child: Consumer<HousesProvider>(
                              builder: (context, value, child) => InkWell(
                                    onTap: () {
                                      dialogFileFoto(context, 4);
                                    },
                                    child: value.imageFileFourth == null
                                        ? placeholder
                                        : Image.file(value.imageFileFourth,
                                            fit: BoxFit.contain),
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () async {
                      final isValid = _formKey.currentState.validate();
                      FocusScope.of(context).unfocus();
                      if (isValid) {
                        if (houseProvider.imageFileOne == null &&
                            houseProvider.imageFileTwo == null &&
                            houseProvider.imageFileThree == null &&
                            houseProvider.imageFileFourth == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBar("Minimal 1 Gambar Rumah", 400));
                        } else {
                          // print(name.text);
                          // print(price.text);
                          // print(address.text);
                          // print(area.text);
                          // print(description.text);

                          if (house == null) {
                            // add new house
                            final response = await Services.instance.addHouse(
                                context,
                                name.text,
                                int.parse(price.text),
                                address.text,
                                int.parse(area.text),
                                description.text);
                            int statusCode = response['status'];

                            String msg = statusCode <= 203
                                ? 'Success Add House'
                                : 'Add House Failed';

                            if (statusCode <= 203) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterGenerator.homeAdminScreen,
                                  (route) => false);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar(msg, statusCode));
                              _resetState(houseProvider);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar(msg, statusCode));
                            } // else jika status code diaatas 203
                          } else {
                            // update
                            final response = await Services.instance
                                .updateHouse(
                                    context,
                                    name.text,
                                    int.parse(price.text),
                                    address.text,
                                    int.parse(area.text),
                                    description.text,
                                    house.id);
                            int statusCode = response['status'];

                            String msg = statusCode <= 203
                                ? 'Success Update House'
                                : 'Update House Failed';

                            if (statusCode <= 203) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouterGenerator.homeAdminScreen,
                                  (route) => false);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar(msg, statusCode));
                              _resetState(houseProvider);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar(msg, statusCode));
                            }
                          } // akhir house dari provider
                          print('valid gans');
                        } // valid by field & picture
                        print('valid gans form');
                      } else {
                        print('not valid gans form');
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
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            house != null
                                ? 'Simpan Perubahan'
                                : 'Tambah Rumah Baru',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
