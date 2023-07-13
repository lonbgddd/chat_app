import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PackageModel {
  final String title;
  final int id;
  final String name;
  final String price;
  final double discount;

  PackageModel( {
    required this.name,
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
  });
}



List<PackageModel> packageBinderPlatinumList(BuildContext context) {
  final appLocal = AppLocalizations.of(context);
 return [
    PackageModel(
      id: 1,
      title: '',
      name: '1 ${appLocal.pageFunctionVipMonthText}',
      price: '279.000 ₫/${appLocal.pageFunctionVipMonthText}',
      discount: 0,
    ),
    PackageModel(
      id: 2,
      title: appLocal.pageFunctionVipPopularText,
      name: '6 Tháng',
      price: '139.833 ₫/${appLocal.pageFunctionVipMonthText}',
      discount: 50,
    ),
    PackageModel(
      id: 3,
      title: appLocal.pageFunctionVipBestText,
      name: '12 ${appLocal.pageFunctionVipMonthText}',
      price: '96.583 ₫/${appLocal.pageFunctionVipMonthText}',
      discount: 65,
      ),
  ];
}

List<PackageModel> packageBinderGoldList (BuildContext context) {
  final appLocal = AppLocalizations.of(context);
  return [
    PackageModel(
      id: 1,
      title: '',
      name: '1 ${appLocal.pageFunctionVipMonthText}',
      price: '189.000 ₫/${appLocal.pageFunctionVipMonthText}',
      discount: 0,
    ),
    PackageModel(
      id: 2,
      title: appLocal.pageFunctionVipPopularText,
      name: '6 ${appLocal.pageFunctionVipMonthText}',
      price: '93.167 ₫/${appLocal.pageFunctionVipMonthText}',
      discount: 50,
    ),
    PackageModel(
      id: 3,
      title: appLocal.pageFunctionVipBestText,
      name: '12 ${appLocal.pageFunctionVipMonthText}',
      price: '64.083 ₫/${appLocal.pageFunctionVipMonthText}',
      discount: 65,
    ),
  ];
}

List<PackageModel> packageBinderSuperLike (BuildContext context) {
  final appLocal = AppLocalizations.of(context);
  return [
    PackageModel(
      id: 1,
      title: '',
      name: '5 ${appLocal.pageFunctionVipSuperText}',
      price: '39.800 ₫/${appLocal.pageFunctionVipMonthText}',
      discount: 0,),
    PackageModel(
      id: 2,
      title: appLocal.pageFunctionVipPopularText,
      name: '25 ${appLocal.pageFunctionVipSuperText}',
      price: '31.160 ₫/${appLocal.pageFunctionVipMonthText}',
      discount: 22,),
    PackageModel(
      id: 3,
      title: appLocal.pageFunctionVipBestText,
      name: '60 ${appLocal.pageFunctionVipSuperText}',
      price: '24.983 ₫/${appLocal.pageFunctionVipMonthText}',
      discount: 37,),
  ];

}
