import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';

class CustomPackageCard extends StatelessWidget {
  final PackageModel packageModel;
  const CustomPackageCard({
    Key? key,
    required this.packageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child:  GestureDetector(
        onTap: ()=>print("aaaa${packageModel.title}"),
        child: Container(
            width: double.parse('${size.width/1.4}'),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(packageModel.title,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                      ),),

                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: Icon(Icons.check),
                        // )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(
                    packageModel.name,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        packageModel.price,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: packageModel.discount==0?Colors.white:Colors.grey[350],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            packageModel.discount==0?'':'Tiết kiệm ${packageModel.discount.round().toString()}%',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
