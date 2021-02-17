import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/actors_provider.dart';

class PeliculaPage extends StatelessWidget {

  /*
  //podria recibir los parametros como argumentos de la clase
  final Pelicula pelicula;
  const PeliculaPage({this.pelicula});
  */

  final actorsProvider = ActorsProvider();

  @override
  Widget build(BuildContext context) {

    //tambien puedo recibirlos por el pushednamed
    final Pelicula peli = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(slivers: [
        _appBar(peli),
        SliverList(delegate: SliverChildListDelegate(
          [
            _poster(context,peli),
            _descripcion(context,peli),
            _actores(context,peli.id.toString()),
          ]
        ))
      ],),
    );
  }

  Widget _appBar(Pelicula peli) => SliverAppBar(
    elevation: 3,
    backgroundColor: Colors.indigo,
    expandedHeight: 200,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle:true,
      title: Text(peli.title,style:TextStyle(color: Colors.white,fontSize: 16)),
      background: FadeInImage(
        placeholder: AssetImage('assets/loading.gif'), 
        image: NetworkImage(peli.getBannerPath()),
        fit: BoxFit.cover,
      ),
    ),
  );

  Widget _poster(BuildContext context, Pelicula peli) {
    return Container(
      margin: EdgeInsets.only(left: 20,top: 20, right: 20),
      child: Row(
        children:[
          Hero(
            tag: peli.heroId,
            child: ClipRRect(
              child: Image(image: NetworkImage(peli.getPosterPath()),height: 150,),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(width: 20,),
          Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(peli.title, style:Theme.of(context).textTheme.headline5,overflow: TextOverflow.ellipsis,),
            Text(peli.originalTitle, style:Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.ellipsis,),
            Row(children: [Icon(Icons.star),Text(peli.voteAverage.toString(),style: Theme.of(context).textTheme.subtitle1,)],)
          ],))
        ]
      ),
    );
  }

  Widget _descripcion(BuildContext context,Pelicula peli) {
    return Container(
      margin: EdgeInsets.only(left: 20,top: 20, right: 20),
      child: Text(
        peli.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _actores(BuildContext context, String id) {
    final _screen = MediaQuery.of(context).size;

    return FutureBuilder(
      future: actorsProvider.getActors(id),
      builder: ( context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData)
          return _listaActores(actores: snapshot.data);
        else
          return Container(padding: EdgeInsets.only(top:20),height:_screen.height*0.5, child: Center(child: CircularProgressIndicator()));
      
      }
    ); 
  }

  Widget _listaActores({List actores}) {

    final _pageController = PageController(initialPage: 1,viewportFraction: 0.3,);
    
    return Container(
      padding: EdgeInsets.only(top:5),
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemBuilder: (context , i) => _card(context,actores[i]),
        itemCount: actores.length,
      ),
    );
  }

  Widget _card(BuildContext context, Actor actor){

    final card =  Container(
        child: Column(children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            //borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(actor.getProfilePath()),
              placeholder: AssetImage('assets/no-image.jpg'),
              fit: BoxFit.cover,
              height: 160,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],),
      );

      return GestureDetector(
        child: card,
        onTap: () {
          Navigator.pushNamed(context, 'actor' , arguments: actor);
        },
      );
  }

}