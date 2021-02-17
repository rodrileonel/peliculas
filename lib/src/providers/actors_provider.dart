

import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actor_model.dart';
import 'package:http/http.dart' as http;

class ActorsProvider{
  String _apiKey     ='73c5c6d8763f9d2eae6fe6ff32185495';
  String _url        ='api.themoviedb.org';

  Future<List<Actor>> getActors(String movie) async {
    print('Cargando actores...');

    final url = Uri.https(_url,'3/movie/$movie/credits',{
      'api_key': _apiKey,
    });

    var response = await _getData(url);
    return response;
  }

  Future<List<Actor>> _getData(Uri url) async {
    final response = await http.get(url);
    final data = json.decode(response.body);
    final actores = Actors.fromJsonListMap(data['cast']);
    
    return actores.actors;

  }
}