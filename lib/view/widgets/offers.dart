import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:whakaaro/constants/const.dart';

class FoodItems extends StatefulWidget {
  const FoodItems({key}) : super(key: key);

  @override
  _FoodItemsState createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  final urlImages = [
    'https://whakaaro-development.s3.ap-south-1.amazonaws.com/offers/1630488143336offer1.png',
    'https://whakaaro-development.s3.ap-south-1.amazonaws.com/offers/1630488143336offer1.png',
    'https://whakaaro-development.s3.ap-south-1.amazonaws.com/offers/1630488143336offer1.png',
    'https://whakaaro-development.s3.ap-south-1.amazonaws.com/offers/1630488143336offer1.png',
    'https://whakaaro-development.s3.ap-south-1.amazonaws.com/offers/1630488143336offer1.png',
    'https://whakaaro-development.s3.ap-south-1.amazonaws.com/offers/1630488143336offer1.png',

  ];

  final hotels = [
    'Ambrosia Hotel & Restaurant',
    'Handi Restaurant, Chittagong',
    'Ambrosia Hotel & Restaurant',
    'Handi Restaurant, Chittagong',
    'Ambrosia Hotel & Restaurant',
    'Handi Restaurant, Chittagong',
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CarouselSlider.builder(
              itemCount: urlImages.length,
              options: CarouselOptions(
                viewportFraction: 0.4,
                // enlargeCenterPage: true,
                // initialPage: 0,
                aspectRatio: 16.3 / 9,
                enableInfiniteScroll: true,

                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];
                final hotel = hotels[index];
                return foodScroll(urlImage, index, hotel);
              }),
        ],
      ),
    );
  }

  Widget foodScroll(String urlImage, int index, String hotel) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Color(0xFF84FFA2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              child: Image.network(
                urlImage,
                height: 100,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'STEAL THE DEAL',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xff05B640),
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      child: Text(
                        'exclusive offer@129'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF505050),
                          fontWeight: FontWeight.w900,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
