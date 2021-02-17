
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwipper extends StatelessWidget {

  final List<Pelicula> peliculas;
  const CardSwipper({ @required this.peliculas});
  

  @override
  Widget build(BuildContext context) {

    final _screen = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top:20),
      child: Swiper(
        itemHeight: _screen.height * 0.5,
        itemWidth: _screen.width * 0.6,
        itemBuilder: (BuildContext context,int index) {
          peliculas[index].heroId = '${peliculas[index].id}-swiper';
          return Hero(
            tag: peliculas[index].heroId,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'pelicula' , arguments: peliculas[index]),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image:NetworkImage(peliculas[index].getPosterPath()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }
  
  
}