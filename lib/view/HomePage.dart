import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whakaaro/constants/const.dart';
import 'package:whakaaro/model/homePage_model.dart';
import 'package:whakaaro/services/api_manager.dart';
import 'package:whakaaro/view/widgets/offers.dart';
import 'package:intl/intl.dart';

var token;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print('home token : $token');
    return token;
  }

  Future<HomeModel> _homeModel;

  @override
  void initState() {
    super.initState();
    getToken();
    getAddress();
    _homeModel = ApiManager().fetchData();
  }

  String add1;
  String add2;
  String add3;

  getAddress() async {
    final coordinates = new Coordinates(9.9312, 76.2673);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      add1 = address.first.subLocality;
      add2 = address.first.adminArea;
      add3 = address.first.locality;
    });

    print('$add1, $add2,$add3');
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
            Text('$add1, $add3, $add2',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: FloatingActionButton(
                backgroundColor: Colors.blueAccent,
                onPressed: () => null,
                child: Image.asset(
                  'assets/icons/call.png',
                  height: 23,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              //Listview

              FutureBuilder<HomeModel>(
                future: _homeModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: snapshot.data.data.quick.length,
                      itemBuilder: (context, index) {
                        var restro = snapshot.data.data.quick[index];
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              restro.storeStatus == true
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black54,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://whakaaro-development.s3.ap-south-1.amazonaws.com/${restro.storeBg}'),
                                            fit: BoxFit.cover),
                                      ),
                                      height: 130,
                                      width: 115,
                                    )
                                  : ColorFiltered(
                                      colorFilter: greyscale,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black54,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://whakaaro-development.s3.ap-south-1.amazonaws.com/${restro.storeBg}'),
                                              fit: BoxFit.cover),
                                        ),
                                        height: 130,
                                        width: 115,
                                      ),
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(restro.name,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.orange[800],
                                    ),
                                    height: 25,
                                    width: 65,
                                    child: Center(
                                      child: Text(restro.cuisine,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  restro.storeStatus == false
                                      ? Text('Currently not Accepting Orders',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11))
                                      : Text(
                                          '${restro.distance} km | ${restro.location.address}',
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      '${restro.avgCookingTime}. ₹${int.parse(restro.avgPersonAmt) * 2}'
                                      ' for two . ${restro.openTime}:AM - ${restro.closeTime}PM',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 12)),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              //Offers Title
              Container(
                alignment: Alignment.topLeft,
                child: Text('Offers',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
              ),
              FoodItems(),
              FutureBuilder<HomeModel>(
                future: _homeModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: snapshot.data.data.restaurant.length,
                      itemBuilder: (context, index) {
                        var restro = snapshot.data.data.restaurant[index];
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              restro.storeStatus == true
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black54,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://whakaaro-development.s3.ap-south-1.amazonaws.com/${restro.storeBg}'),
                                            fit: BoxFit.cover),
                                      ),
                                      height: 130,
                                      width: 115,
                                    )
                                  : ColorFiltered(
                                      colorFilter: greyscale,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black54,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://whakaaro-development.s3.ap-south-1.amazonaws.com/${restro.storeBg}'),
                                              fit: BoxFit.cover),
                                        ),
                                        height: 130,
                                        width: 115,
                                      ),
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(restro.name,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.orange[800],
                                    ),
                                    height: 25,
                                    width: 65,
                                    child: Center(
                                      child: Text(restro.cuisine,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  restro.storeStatus == false
                                      ? Text('Currently not Accepting Orders',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11))
                                      : Text(
                                          '${restro.distance} km | ${restro.location.address.trim()}',
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      '${restro.avgCookingTime} mins. ₹${int.parse(restro.avgPersonAmt) * 2}'
                                      ' for two . ${restro.openTime}:AM - ${restro.closeTime}PM',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 11)),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   iconSize: 30,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.roofing_outlined,
      //         color: Colors.green,
      //       ),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.search_outlined,
      //       ),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.person_outlined,
      //       ),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}
