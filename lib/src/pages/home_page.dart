import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/horizontal_list.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) { 
    peliculasProvider.getPopulars();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cartelera'),
        actions: [
          IconButton(icon: Icon(Icons.search),onPressed: () {
            showSearch(context: context, delegate: DataSearch(),query: '');//puedo obviar el query
          },),
        ],
      ),
      body: OverflowBox (
        alignment: Alignment.topCenter,
        minHeight: 0.0,
        maxHeight: double.infinity,
        child: Container(child:Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children:[
          _swiper(context),
          _populares(context),
        ]),),
      ),
    );
  }

  /*
  Widget _swiper() => Container(
    padding: EdgeInsets.only(top:40),
    width: double.infinity,
    height: 300,
    child: Swiper(
      itemBuilder: (BuildContext context,int index) => Image.network(
        'http://via.placeholder.com/350x150',
        fit: BoxFit.fill,
      ),
      itemCount: 3,
      itemWidth: 300,
      //pagination: SwiperPagination(), //puntitos de abajo
      //control: SwiperControl(), //flechas de navegacion
      layout: SwiperLayout.STACK,
    ),
  );
  */
  //creamos un widget personalizado llamado CardSwiper
  //Widget _swiper() => CardSwipper(peliculas: [1,2,3]);

  Widget _swiper(BuildContext context) { 

    final _screen = MediaQuery.of(context).size;

    return FutureBuilder(
      future: peliculasProvider.getNowPlaying(),
      builder: ( context, AsyncSnapshot<List<dynamic>> snapshot){
        if(snapshot.hasData)
          return CardSwipper(peliculas: snapshot.data);
        else
          return Container(padding: EdgeInsets.only(top:20),height:_screen.height*0.5, child: Center(child: CircularProgressIndicator()));
      }
    );
    //return CardSwipper(peliculas: [1,2,3]);
  }

  Widget _populares(BuildContext context) {
    return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Container(
          padding: EdgeInsets.only(left:20,top: 20),
          child: Text('Populares',style:Theme.of(context).textTheme.subtitle1)
        ),
        StreamBuilder(
          stream: peliculasProvider.popularesStream,
          builder: ( context, AsyncSnapshot<List<dynamic>> snapshot){
            if(snapshot.hasData)
              return HorizontalList(
                peliculas: snapshot.data,
                //ejecutamos la funcion callback 
                nextPage: peliculasProvider.getPopulars,
              );
            else
              return Container(height:160,child: Center(child: CircularProgressIndicator()));
          }
        )
      ],
    ),
  );
}
}