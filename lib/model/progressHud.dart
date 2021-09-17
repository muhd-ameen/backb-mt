import 'package:flutter/material.dart';

class ProgressHud extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  // final Color color;
  // final Animation<Color> valueColor;

  const ProgressHud(
      {Key key,
       this.child,
       this.inAsyncCall,
       this.opacity,
      // required this.color,
      // required this.valueColor
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.4,
            child: ModalBarrier(dismissible: false, color: Colors.white),
          ),
          new Center(child: new CircularProgressIndicator()),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
