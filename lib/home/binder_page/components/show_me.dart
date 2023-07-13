import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowMe extends StatefulWidget {
  const ShowMe({Key? key}) : super(key: key);

  @override
  _ShowMeState createState() => _ShowMeState();
}

class _ShowMeState extends State<ShowMe> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    final styleRichText = TextStyle(
        color: Colors.grey[600],
        fontSize: 13.5,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w400
    );
    final appLocal = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_rounded,
                size: 32,
                color: Colors.grey[800],
              ),

            ],
          ),
        ),
        centerTitle: true,
        title: Text(appLocal.showMeTitleAppbar,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 10),
              child: Text(
                appLocal.showMeTitleAppbar,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            buildListTile("Nữ"),
            buildListTile("Nam"),
            buildListTile("Mọi người"),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                appLocal.showMeHello,
                style: styleRichText,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: appLocal.showMeContent1,
                  style: styleRichText,
                  children: <TextSpan>[

                    TextSpan(
                      text: appLocal.showMeContent2,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                    TextSpan(
                      text: appLocal.showMeContent3,
                    ),
                    TextSpan(
                      text: appLocal.showMeContent4,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 13.5,
                      ),
                    ),
                    TextSpan(
                      text: appLocal.showMeContent5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildListTile(String option) {
    final selectedOptionProvider = context.watch<BinderWatch>();
    return ListTile(
      title: Text(option),
      tileColor: Colors.white,
      onTap: () {
        setState(() {
         selectedOptionProvider.setSelectedOption(option);
        });
      },
      trailing: selectedOptionProvider.selectedOption == option
          ? Icon(Icons.check, color: Colors.red)
          : null,
    );
}

}
