class Category{
  static String sportsid='sports';
  static String moviesid='movies';
  static String musicid='music';
  String id;
  late String title;
  late String imagepath;
  Category({required this.id,required this.title,required this.imagepath});
  Category.fromid(this.id){
    if(id==sportsid){
      title=sportsid;
      imagepath='assets/images/sports.png';
    }
    else if(id==moviesid){
      title=moviesid;
      imagepath='assets/images/movies.png';
    }
    else{
      title=musicid;
      imagepath='assets/images/music.png';
    }
  }
  static List<Category> getallcategories(){
    return[
      Category.fromid(sportsid),
      Category.fromid(musicid),
      Category.fromid(moviesid),
    ];
  }

}