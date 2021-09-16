
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whakaaro/view/widgets/offers.dart';
import 'package:whakaaro/view/widgets/offersl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            Text('Vm Rd, koonthnadeu, kochi',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.add_call,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54,
                      ),
                      height: 130,
                      width: 115,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lulu Hypermarket',
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
                          width: 55,
                          child: Center(
                            child: Text('Arabic',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text('1.2km | Lulu Mall,Edappaly',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        SizedBox(
                          height: 8,
                        ),
                        Text('45 mins. ₹120 for two .10:Am : 10:00Pm',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54,
                      ),
                      height: 130,
                      width: 115,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lulu Hypermarket',
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
                          width: 55,
                          child: Center(
                            child: Text('Chinese',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text('1.2km | Lulu Mall,Edappaly',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        SizedBox(
                          height: 8,
                        ),
                        Text('45 mins. ₹120 for two .10:Am : 10:00Pm',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text('Offers',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
              ),
              // CarouselSl(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note_rounded,
              color: Colors.green,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_note_rounded,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_outlined,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
