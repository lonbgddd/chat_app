import 'dart:convert';
import 'package:chat_app/config/data_mothes.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../helpers/helpers_database.dart';

class LocationProvider extends ChangeNotifier {
  List<dynamic>? listCountry = [];
  List<dynamic>? listProvince = [];
  List<dynamic>? listDistrict = [];
  List<dynamic>? listWard = [];
  dynamic country;
  dynamic province;
  dynamic district;

  Future<void> updateAddressUser(String address) async {
    try {
      String? uid = await HelpersFunctions().getUserIdUserSharedPreference();
      await DatabaseMethods().updateAddressUser(uid!, address);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> fetchCountry() async {
    try {
      var url = Uri.parse(
          'https://secure.geonames.org/countryInfoJSON?username=ksuhiyp&style=short');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // Xử lý dữ liệu địa chỉ ở đây nếu cần thiết
        dynamic data = json.decode(response.body);
        List<dynamic> jsonList = data['geonames'];
        List<Map<String, dynamic>> countries = jsonList
            .map((dynamic item) => {
                  'countryCode': item['countryCode'],
                  'countryName': item['countryName']
                })
            .toList();
        listCountry = countries;
        notifyListeners();
      } else {
        print('Lỗi khi gọi API: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  Future<void> fetchProvince(var code) async {
    try {
      var url = Uri.parse(
          'https://secure.geonames.org/searchJSON?username=ksuhiyp&lang=vi&country=$code&featureCode=ADM1');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // Xử lý dữ liệu địa chỉ ở đây nếu cần thiết
        dynamic data = json.decode(response.body);
        List<dynamic> jsonList = data['geonames'];
        List<Map<String, dynamic>> provinces = jsonList
            .map((dynamic item) =>
                {'adminCode1': item['adminCode1'], 'name': item['name']})
            .toList();
        listProvince = provinces;
        notifyListeners();
      } else {
        print('Lỗi khi gọi API: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  Future<void> fetchDistrict(var code) async {
    try {
      var url = Uri.parse(
          'https://secure.geonames.org/searchJSON?username=ksuhiyp&lang=vi&style=full&country=$country&adminCode1=$code&featureCode=ADM2');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // Xử lý dữ liệu địa chỉ ở đây nếu cần thiết
        dynamic data = json.decode(response.body);
        List<dynamic> jsonList = data['geonames'];
        List<Map<String, dynamic>> districts = jsonList
            .map((dynamic item) =>
                {'adminCode2': item['adminCode2'], 'name': item['name']})
            .toList();
        listDistrict = districts;
        notifyListeners();
      } else {
        print('Lỗi khi gọi API: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  Future<void> fetchWard(var code) async {
    try {
      var url = Uri.parse(
          'https://secure.geonames.org/searchJSON?username=ksuhiyp&lang=vi&style=short&country=$country&adminCode1=$province&adminCode2=$code&featureCode=ADM3');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // Xử lý dữ liệu địa chỉ ở đây nếu cần thiết
        dynamic data = json.decode(response.body);
        List<dynamic> jsonList = data['geonames'];
        List<Map<String, dynamic>> wards = jsonList
            .map((dynamic item) =>
                {'adminCode3': item['adminCode3'], 'name': item['name']})
            .toList();
        listWard = wards;
        notifyListeners();
      } else {
        print('Lỗi khi gọi API: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  void setCountry(var value) {
    country = value;
  }

  void setProvince(var value) {
    province = value;
  }

  void setDistrict(var value) {
    district = value;
  }

  void setListProvinceNull() {
    listProvince = null;
    notifyListeners();
  }

  void setListDistrictNull() {
    listDistrict = null;
    notifyListeners();
  }

  void setListWardNull() {
    listWard = null;
    notifyListeners();
  }
}
