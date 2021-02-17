
import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider{
  String _apiKey     ='73c5c6d8763f9d2eae6fe6ff32185495';
  String _language   ='es-ES';
  String _url        ='api.themoviedb.org';
  int _pagina        = 0;

  //esta variable me va a permitir hacer una sola carga de peliculas 
  //y esperar hasta que llegue nueva informacion
  bool _loading = false;

  ///////construyendo el stream
  //listado en el que va a estar el total de peliculas
  List<Pelicula> _populares = List();
  //creo streamcontroller
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
  //creo el sink que ingresara datos al stream
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  //creo el stream que es el que va a escuchar
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;
  //siempre debo cerrar todos los streams cuando ya no sean usados
  void disposeStream() => _popularesStreamController?.close();
  /////

  Future<List<Pelicula>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key': _apiKey,
      'language':_language,
    });
    return await _getData(url);
  }

  Future<List<Pelicula>> search( String query) async {
    final url = Uri.https(_url, '3/search/movie',{
      'api_key': _apiKey,
      'language':_language,
      'query':query,
    });
    return await _getData(url);
  }

  Future<List<Pelicula>> getPopulars() async {
    
    if(_loading) return [];

    _loading = true;
    print('Cargando nuevas pelis...');
    
    _pagina++;
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key': _apiKey,
      'language':_language,
      'page':_pagina.toString(),
    });

    final respuesta = await _getData(url);
    
    //añado la respuesta de la pagina al listado total
    _populares.addAll(respuesta);
    //suscribo ese listado al stream
    popularesSink(_populares);
    //indico que estoy cargando
    _loading = false;
    //finalmente solo retorno la pagina

    return respuesta;
  }

  Future<List<Pelicula>> _getData(Uri url) async{
    final response = await http.get(url);
    final data = json.decode(response.body);

    final peliculas = Peliculas.fromJsonListMap(data['results']);

    return peliculas.peliculas;
  }

}