class Actors{
  List<Actor> actors = List();

  Actors();
  Actors.fromJsonListMap(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actors.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String,dynamic> jsonMap){
    castId        = jsonMap['cast_id'];
    character         = jsonMap['character'];
    creditId             = jsonMap['credit_id'];
    gender        = jsonMap['gender'];
    id                = jsonMap['id'];
    name             = jsonMap['name'];
    order      = jsonMap['order'];
    profilePath  = jsonMap['profile_path'];
  }

  getProfilePath(){
    if(profilePath==null)
      return 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png';
    else
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }

}



