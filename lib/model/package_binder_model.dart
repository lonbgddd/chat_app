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

List<PackageModel> packageBinderPlatinumList = [

  PackageModel(
    id: 1,
    title: '',
    name: '1 Tháng',
    price: '279.000 ₫/th',
    discount: 0,
  ),
  PackageModel(
    id: 2,
    title: 'Phổ biến',
    name: '6 Tháng',
    price: '139.833 ₫/th',
    discount: 50,
  ),
  PackageModel(
    id: 3,
    title: 'Giá Tốt Nhất',
    name: '12 Tháng',
    price: '96.583 ₫/th',
    discount: 65,
  ),
];

List<PackageModel> packageBinderGoldList = [
  PackageModel(
    id: 1,
    title: '',
    name: '1 Tháng',
    price: '189.000 ₫/th',
    discount: 0,
  ),
  PackageModel(
    id: 2,
    title: 'Phổ biến',
    name: '6 tháng',
    price: '93.167 ₫/th',
    discount: 50,
  ),
  PackageModel(
    id: 3,
    title: 'Giá Tốt Nhất',
    name: '12 tháng',
    price: '64.083 ₫/th',
    discount: 65,
  ),
];

List<PackageModel> packageBinderSuperLike = [
  PackageModel(
    id: 1,
    title: '',
    name: '5 lượt Siêu Thích',
    price: '39.800 ₫/th',
    discount: 0,),
  PackageModel(
    id: 2,
    title: 'Phổ biến',
    name: '25 lượt Siêu Thích',
    price: '31.160 ₫/th',
    discount: 22,),
  PackageModel(
    id: 3,
    title: 'Giá Tốt Nhất',
    name: '60 lượt Siêu Thích',
    price: '24.983 ₫/th',
    discount: 37, ),
];
