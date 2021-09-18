import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whakaaro/constants/const.dart';
import 'package:whakaaro/model/homePage_model.dart';

class RestroList extends StatelessWidget {
  const RestroList({
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
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.data.restaurant.length,
            itemBuilder: (context, index) {
              var restro = snapshot.data.data.restaurant[index];
              var dis = restro.distance / 1000;
              var dis1 = dis.toStringAsExponential(1);
              var distance = dis1.toString().split("e");
              DateTime now = DateTime.parse("2021-09-19 ${restro.closeTime}");
              String closeTime = DateFormat.jm().format(now);
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
                                    fontSize: 11)),
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
                            '${distance[0]} km | ${restro.location.address.trim()}',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 11)),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 230,
                          child: Text(
                              '${restro.avgCookingTime} mins. ₹${int.parse(restro.avgPersonAmt) * 2}'
                                  ' for two . ${restro.openTime}:AM - $closeTime ',
                              overflow: TextOverflow.fade,

                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 11)),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return Center();
        }
      },
    );
  }
}
