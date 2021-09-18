import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:whakaaro/constants/const.dart';
import 'package:whakaaro/model/homePage_model.dart';
import 'package:whakaaro/services/api_manager.dart';
import 'package:whakaaro/view/widgets/callButton.dart';
import 'package:whakaaro/view/widgets/offers.dart';
import 'package:whakaaro/view/widgets/quick_list.dart';
import 'package:whakaaro/view/widgets/restro_List.dart';

import 'widgets/bottomNavigation.dart';

var token;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<HomeModel> _homeModel;

  String subLocality;
  String adminArea;
  String locality;

  @override
  void initState() {
    super.initState();
    _homeModel = ApiManager().fetchData();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Image.asset('assets/images/locationIcon.png'),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delivering to',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 15)),
            Text('$subLocality, $adminArea, $locality',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: CallButton(homeModel: _homeModel),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              //Quick list
              QuickList(homeModel: _homeModel),
              //Offers Title
              Container(
                alignment: Alignment.topLeft,
                child: Text('Offers', style: kGrey),
              ),
              //CarouselSlider
              OfferSlider(),
              //Restaurant list
              RestroList(homeModel: _homeModel),
            ],
          ),
        ),
      ),
    );
  }

  getAddress() async {
    final coordinates = new Coordinates(10.050227, 76.318962);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      subLocality = address.first.subLocality;
      adminArea = address.first.adminArea;
      locality = address.first.locality;
    });
  }
}

