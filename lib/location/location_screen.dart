import 'package:chat_app/config/changedNotify/location_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocationSCreenState();
  }
}

class LocationSCreenState extends State<LocationScreen> {
  var textController = TextEditingController();
  String? country;
  String? province;
  String? district;
  String? ward;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    context.read<LocationProvider>().fetchCountry();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Địa chỉ',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: Colors.grey)),
                  child: Container(
                    child: context.watch<LocationProvider>().listCountry != null
                        ? DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            value: null,
                            onChanged: (value) {
                              if (value != null) {
                                List<String> splitValues = value!.split('-');
                                country = splitValues[1];
                                context
                                    .read<LocationProvider>()
                                    .fetchProvince(splitValues[0]);
                                context
                                    .read<LocationProvider>()
                                    .setCountry(splitValues[0]);
                                context
                                    .read<LocationProvider>()
                                    .setListProvinceNull();
                                context
                                    .read<LocationProvider>()
                                    .setListDistrictNull();
                                context
                                    .read<LocationProvider>()
                                    .setListWardNull();
                              }
                            },
                            hint: const Text('Chọn một quốc gia'),
                            items: context
                                .watch<LocationProvider>()
                                .listCountry!
                                .map<DropdownMenuItem<String>>((dynamic item) {
                              return DropdownMenuItem<String>(
                                value:
                                    '${item['countryCode'].toString()}-${item['countryName'].toString()}',
                                child: Text(item['countryName'].toString()),
                              );
                            }).toList(),
                          )
                        : Container(),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: Colors.grey)),
                  child: Container(
                    child: context.watch<LocationProvider>().listProvince !=
                            null
                        ? DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            value: null,
                            onChanged: (value) {
                              if (value != null) {
                                List<String> splitValues = value!.split('-');
                                province = splitValues[1];
                                context
                                    .read<LocationProvider>()
                                    .setProvince(splitValues[0]);
                                context
                                    .read<LocationProvider>()
                                    .fetchDistrict(splitValues[0]);
                                context
                                    .read<LocationProvider>()
                                    .setListDistrictNull();
                                context
                                    .read<LocationProvider>()
                                    .setListWardNull();
                              }
                            },
                            hint: const Text('Chọn một tỉnh, thành phố...'),
                            items: context
                                .watch<LocationProvider>()
                                .listProvince!
                                .map<DropdownMenuItem<String>>((dynamic item) {
                              return DropdownMenuItem<String>(
                                value:
                                    '${item['adminCode1'].toString()}-${item['name'].toString()}',
                                child: Text(item['name'].toString()),
                              );
                            }).toList(),
                          )
                        : Container(),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: Colors.grey)),
                  child: Container(
                    child: context.watch<LocationProvider>().listDistrict !=
                            null
                        ? DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            value: null,
                            onChanged: (value) {
                              if (value != null) {
                                List<String> splitValues = value!.split('-');
                                district = splitValues[1];
                                context
                                    .read<LocationProvider>()
                                    .setDistrict(splitValues[0]);
                                context
                                    .read<LocationProvider>()
                                    .fetchWard(splitValues[0]);
                                context
                                    .read<LocationProvider>()
                                    .setListWardNull();
                              }
                            },
                            hint: const Text('Chọn một thành phố, huyện...'),
                            items: context
                                .watch<LocationProvider>()
                                .listDistrict!
                                .map<DropdownMenuItem<String>>((dynamic item) {
                              return DropdownMenuItem<String>(
                                value:
                                    '${item['adminCode2'].toString()}-${item['name'].toString()}',
                                child: Text(item['name'].toString()),
                              );
                            }).toList(),
                          )
                        : Container(),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: Colors.grey)),
                  child: Container(
                    child: context.watch<LocationProvider>().listWard != null
                        ? DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            value: null,
                            onChanged: (value) {
                              List<String> splitValues = value!.split('-');
                              ward = splitValues[1];
                            },
                            hint: const Text('Chọn một xã, phường...'),
                            items: context
                                .watch<LocationProvider>()
                                .listWard!
                                .map<DropdownMenuItem<String>>((dynamic item) {
                              return DropdownMenuItem<String>(
                                value:
                                    '${item['code'].toString()}-${item['name'].toString()}',
                                child: Text(item['name'].toString()),
                              );
                            }).toList(),
                          )
                        : Container(),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: Colors.grey)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Số nhà, ngõ ...',
                              hintStyle: TextStyle(color: Colors.grey),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 20)),
                      onPressed: () async {
                        String address = '';
                        if (textController.text.isNotEmpty) {
                          address += '${textController.text}, ';
                        }
                        if (ward.toString().isNotEmpty) {
                          address += '${ward.toString()}, ';
                        }
                        if (district.toString().isNotEmpty) {
                          address += '${district.toString()}, ';
                        }
                        if (province.toString().isNotEmpty) {
                          address += '${province.toString()}, ';
                        }
                        if (country.toString().isNotEmpty) {
                          address += country.toString();
                        }
                        if (address.isNotEmpty) {
                          context.go('/home');
                          context
                              .read<LocationProvider>()
                              .updateAddressUser(address);
                        }
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 17),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
