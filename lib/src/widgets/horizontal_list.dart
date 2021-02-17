import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class HorizontalList extends StatelessWidget {
 
  final List<Pelicula> peliculas;
  final Function nextPage;

  HorizontalList({@required this.peliculas, this.nextPage});
  
  final _pageController = PageController(initialPage: 1,viewportFraction: 0.3,);

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() { 
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent -200){//se lanza 200 pixeles antes de llegar al final
        //llamamos a un callback de homepage para no modificar su funcionalidad
        nextPage();
        print('object');
      }
     });

    return Container(
      padding: EdgeInsets.only(top:5),
      height: _screenSize.height * 0.3,
      // el PageView enderiza todo el contenido de una sola vez, pero el PageView.builder lo hace a demanda, asi que es mejor usar el builder
      child: PageView.builder(
        //el pagecontroller me permita visualizar multiples tarjetas en la misma pantalla
        controller: _pageController,
        //evitar el retraso de las imagenes para que siga el flujo del swape
        pageSnapping: false,
        //PageView.builder usa itembuilder conde renderizaremos las peliculas a demanda
        itemBuilder: (context , i) {
          peliculas[i].heroId = '${peliculas[i].id}-horizontalList';
          return Hero(
            tag: peliculas[i].heroId, child:_card(context, peliculas[i]),
          );
        },
        itemCount: peliculas.length, // importante sino solo renderiza la primera carga
        //children: _tarjetas(context),
      ),
    );
  }

  Widget _card(BuildContext context, Pelicula peli){

    final card =  Container(
        child: Column(children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(peli.getPosterPath()),
              placeholder: AssetImage('assets/no-image.jpg'),
              fit: BoxFit.cover,
              height: 160,
            ),
          ),
          Text(
            peli.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],),
      );

      return GestureDetector(
        child: card,
        onTap: () {
          Navigator.pushNamed(context, 'pelicula' , arguments: peli);
        },
      );
  }

  List<Widget> _cards(BuildContext context) {
    return peliculas.map((peli) => Container(
        child: Column(children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(peli.getPosterPath()),
              placeholder: AssetImage('assets/no-image.jpg'),
              fit: BoxFit.cover,
              height: 160,
            ),
          ),
          Text(
            peli.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],),
      ),
    ).toList();
  }
}