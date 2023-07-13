import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/helpers/app_assets.dart';
import 'components/body.dart';

class BinderSelection extends StatelessWidget {
  const BinderSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.iconTinder,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(223, 54, 64, 100), BlendMode.srcIn),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Finder",
                style: TextStyle(
                  fontFamily: 'Grandista',
                  fontSize: 24,
                  color: Color.fromRGBO(223, 54, 64, 100),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BodySelection(),
    );
  }

}

