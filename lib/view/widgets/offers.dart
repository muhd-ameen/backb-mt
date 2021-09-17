import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:whakaaro/model/homePage_model.dart';
import 'package:whakaaro/services/api_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodItems extends StatefulWidget {
  const FoodItems({key}) : super(key: key);

  @override
  _FoodItemsState createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  Future<HomeModel> _homeModel;
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    _homeModel = ApiManager().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          FutureBuilder<HomeModel>(
            future: _homeModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CarouselSlider.builder(
                  itemCount: snapshot.data.data.branch.offers.length,
                  itemBuilder: (context, index, realIndex) {
                    var offer = snapshot.data.data.branch.offers[index];
                    var primary = offer.primary.split("#");
                    var secondary = offer.secondary.split("#");

                    return Column(
                      children: [
                        Container(

                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 20,left: 20),
                                decoration: BoxDecoration(
                                  color: Color(
                                      int.parse("0xFF" + "${secondary[1]}")),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Image.network(
                                  offer.image.location,
                                  height: 100,
                                ),
                                width: 150,
                              ),
                              Positioned(
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          offer.title.toUpperCase(),
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(int.parse(
                                                "0xFF" + "${primary[1]}")),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        child: Text(
                                          offer.subtitle.toUpperCase(),
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF323232),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ],
                                  ),
                                ),
                                bottom: 0,
                              ),
                              Positioned(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Color(
                                          int.parse("0xFF" + "${primary[1]}"))),
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                    child: SvgPicture.network(
                                      offer.icon.location,
                                      height: 50,
                                    ),
                                  ),
                                ),
                                bottom:50 ,
                                right: 10,

                              ),
                            ],
                          ),
                          height: 170,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 0.4,
                    enableInfiniteScroll: true,
                    height: 200.1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
