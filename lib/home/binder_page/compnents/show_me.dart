import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                Icons.chevron_left,
                size: 32,
                color: Colors.grey[800],
              ),
              Text(
                "Back",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          "Show Me",
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
                "SHOW ME",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            buildListTile("Men"),
            buildListTile("Women"),
            buildListTile("Everyone"),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Tinder welcomes everyone.",
                style: styleRichText,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: 'Discovery settings now show users who include more information about their ',
                  style: styleRichText,
                  children: <TextSpan>[

                    TextSpan(
                      text: 'gender identity ',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                    TextSpan(
                      text: 'and ',
                    ),
                    TextSpan(
                      text: 'sexual orentation. ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 13.5,
                      ),
                    ),
                    TextSpan(
                      text: 'Once users add more information about themselves, they can select to be shown in searches\nthat best reflect their identity.',
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
