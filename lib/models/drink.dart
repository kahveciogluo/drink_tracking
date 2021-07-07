class Drink {
  int id;
  String name;
  int minConsume;
  int maxConsume;
  int consumeStep;

  Drink(this.name, this.minConsume, this.maxConsume, this.consumeStep);
  Drink.withId(this.id, this.name, this.minConsume, this.maxConsume, this.consumeStep);

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["name"] = name;
    map["minConsume"] = minConsume;
    map["maxConsume"] = maxConsume;
    map["consumeStep"] = consumeStep;
    if(id!=null){
      map["id"] = id;
    }
    return map;
  }

  Drink.fromMap(dynamic o){
    this.id = int.tryParse(o["id"].toString());
    this.name = o["name"].toString();
    this.minConsume = int.tryParse(o["minConsume"].toString());
    this.maxConsume = int.tryParse(o["maxConsume"].toString());
    this.consumeStep = int.tryParse(o["consumeStep"].toString());
  }

}









