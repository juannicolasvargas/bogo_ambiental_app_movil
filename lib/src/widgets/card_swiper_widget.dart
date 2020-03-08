import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// class CardSwiperWidget extends StatelessWidget {

  
// }

class CardSwiperWidget extends StatefulWidget {
  final List<dynamic> wetlands;
  const CardSwiperWidget({Key key, this.wetlands}): super(key: key);

  @override
  _CardSwiperWidgetState createState() => _CardSwiperWidgetState();
}

class _CardSwiperWidgetState extends State<CardSwiperWidget> {

  List<dynamic> wetlands;
  int currentIndex = 0;

  @override
  void initState(){
    super.initState();
    wetlands = this.widget.wetlands;
  }

  // CardSwiperWidget({ @required this.wetlands });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 70.0),
          child: Swiper(
            onIndexChanged: (int index) {
              setState(() {
                currentIndex = index;
              });    
            },
            itemWidth: _screenSize.width * 0.7,
            itemHeight: _screenSize.height * 0.6,
            layout: SwiperLayout.STACK,
            itemBuilder: (BuildContext context,int index){
              return ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(wetlands[index].image),
                  placeholder: AssetImage('assets/placeholder-image.jpg'),
                  fit: BoxFit.cover,
                ),
              );
            },
            itemCount: wetlands.length,
            onTap: (int index) => Navigator.pushNamed(context, 'wetlands_detail', arguments: wetlands[index]),
            // pagination: new SwiperPagination(),
            // control: new SwiperControl(),
          ),
        ),
        SizedBox(height: 10.0),
        Text(wetlands[currentIndex].name,
        style: TextStyle(color: Colors.black, fontSize: 22.0),
        )
      ],
    );
  }
}