class User {
  int id;
  String gender;
  int age;
  int weight;
  int dailyNeedWater;

  User(this.gender, this.age, this.weight, this.dailyNeedWater);
  User.withId(this.id, this.gender, this.age, this.weight, this.dailyNeedWater);

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["gender"] = gender;
    map["age"] = age;
    map["weight"] = weight;
    map["dailyNeedWater"] = dailyNeedWater;
    if(id!=null){
      map["id"] = id;
    }
    return map;
  }

  User.fromMap(dynamic o){
    this.id = int.tryParse(o["id"].toString());
    this.gender = o["gender"].toString();
    this.age = int.tryParse(o["age"].toString());
    this.weight = int.tryParse(o["weight"].toString());
    this.dailyNeedWater = int.tryParse(o["dailyNeedWater"].toString());
  }

}








