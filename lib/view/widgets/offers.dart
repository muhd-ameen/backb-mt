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
    'assets/images/food-1.png',
    'assets/images/food-2.png',
    'assets/images/food-1.png',
    'assets/images/food-2.png',
    'assets/images/food-1.png',
    'assets/images/food-2.png',
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
      child: Column(
        children: [
          CarouselSlider.builder(
              itemCount: urlImages.length,
              options: CarouselOptions(
                viewportFraction: 0.4,
                // enlargeCenterPage: true,
                initialPage: 0,
                aspectRatio: 12 / 7,
                // enableInfiniteScroll: false,
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
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget foodScroll(String urlImage, int index, String hotel) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Image.asset(
                  urlImage,
                  fit: BoxFit.cover,
                  height: 110,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Chicken Biryani',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xff1F2937),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: kThemeColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    child: Text('$hotel',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
