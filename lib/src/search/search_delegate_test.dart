import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

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

    final listaSugerida = (query.isEmpty) ? nuevas 
                : pelis.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context,i) => ListTile(
        leading:Icon(Icons.movie),
        title: Text(listaSugerida[i]),
        onTap: () {
          seleccion = listaSugerida[i];
          showResults(context);
        },
      )
    );
  }

}