import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  final provider = PeliculasProvider();

  String seleccion = '';

  final pelis = [
    'seat',
    'honda',
    'hyundai',
    'renault',
    'ford',
    'toyota',
    'kia',
  ];

  final nuevas = [
    'lamborgini',
    'ferrari',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // las acciones de nuestro appbar (icono)
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
          query ='';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);//pongo null porque no quiero que regresa nada aun
      },);
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultdos que vamos a mostrar
    return Container(
      height: 100,
      width: 100,
      color: Colors.amberAccent,
      child: Text(seleccion),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias que aparecen cuando la persona escribe

    if(query.isEmpty)
      return Container();
    
    return FutureBuilder(
      future: provider.search(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData)
          return ListView(children:snapshot.data.map((movie) {
            movie.heroId = '${movie.id}-search';
            return GestureDetector(
              child: ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.getPosterPath()),
                  width: 40,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Row(children: [Icon(Icons.star),Text(movie.voteAverage.toString())]),
              ),
              onTap: () {
                close(context, null);
                Navigator.pushNamed(context, 'pelicula' , arguments: movie);
              }
            );
          }).toList());
        else
          return Center(child: CircularProgressIndicator());

      },
    );
  }

}