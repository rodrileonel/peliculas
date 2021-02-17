
class Peliculas{
  List<Pelicula> peliculas = List();

  Peliculas();
  Peliculas.fromJsonListMap(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item) {
      final pelicula = Pelicula.fromJsonMap(item);
      peliculas.add(pelicula);
    });
  }
}

class Pelicula {
  String heroId;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String,dynamic> jsonMap){
    popularity        = jsonMap['popularity']/1;
    voteCount         = jsonMap['vote_count'];
    video             = jsonMap['video'];
    posterPath        = jsonMap['poster_path'];
    id                = jsonMap['id'];
    adult             = jsonMap['adult'];
    backdropPath      = jsonMap['backdrop_path'];
    originalLanguage  = jsonMap['original_language'];
    originalTitle     = jsonMap['original_title'];
    genreIds          = jsonMap['genre_ids'].cast<int>();
    title             = jsonMap['title'];
    voteAverage       = jsonMap['vote_average']/1;
    overview          = jsonMap['overview'];
    releaseDate       = jsonMap['release_date'];
  }

  getPosterPath(){
    if(posterPath==null)
      return 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png';
    else
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  getBannerPath(){
    if(backdropPath==null)
      return 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png';
    else
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }

}