
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwipper extends StatelessWidget {

  final List<dynamic> peliculas;
  const CardSwipper({ @required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screen = MediaQuery.of(context).size;
    
    return Container(
      padding: EdgeInsets.only(top:40),
      //comentamos las medidas y se las ponemos al Swiper
      //width: double.infinity,
      //height: 300,
      child: Swiper(
        itemHeight: _screen.height * 0.5,
        itemWidth: _screen.width * 0.7,
        itemBuilder: (BuildContext context,int index) => Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
          child: Image.network('http://via.placeholder.com/350x150',fit: BoxFit.cover,),
        ),
        /*itemBuilder: (BuildContext context,int index) => ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10),
          child: Image.network('http://via.placeholder.com/350x150',fit: BoxFit.cover,),
        ),*/
        itemCount: peliculas.length,
        //pagination: SwiperPagination(), //puntitos de abajo
        //control: SwiperControl(), //flechas de navegacion
        layout: SwiperLayout.STACK,
      ),
    );
  }
  
  
}