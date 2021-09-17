import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whakaaro/model/homePage_model.dart';

class CallButton extends StatelessWidget {
  const CallButton({
    Key key,
    @required Future<HomeModel> homeModel,
  }) : _homeModel = homeModel, super(key: key);

  final Future<HomeModel> _homeModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HomeModel>(
        future: _homeModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton(
                backgroundColor: Colors.blueAccent,
                onPressed: () async {
                  var url =
                      "tel:${snapshot.data.data.branch.supportNumber}";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                  print(snapshot.data.data.branch.supportNumber);
                },
                child: Image.asset(
                  'assets/icons/call.png',
                  height: 23,
                ));
          } else {
            return Container();
          }
        });
  }
}
