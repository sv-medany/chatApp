class MyUser{
  static String collection_name='Users';
  String firstname;
  String email;
  String user_id;
  MyUser({required this.firstname,required this.email,required this.user_id});

  MyUser.fromjson(Map<String,dynamic>json):this(
    firstname: json["firstname"] as String,
    email: json["email"] as String,
    user_id: json["id"] as String
  );
  Map<String,dynamic> toJson (){
    return {
      "firstname":firstname,
      "email":email,
      "id":user_id
    };
  }
}