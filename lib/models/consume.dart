class Consume {
  int id;
  int drinkId;
  int amount;
  String consumedTime;
  String name;



  Consume({this.drinkId, this.amount, this.consumedTime});
  Consume.withID(this.id, this.drinkId, this.amount, this.consumedTime);

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["drinkId"] = drinkId;
    map["amount"] = amount;
    map["consumedTime"] = consumedTime;
    if(id!=null){
      map["id"] = id;
    }
    return map;
  }

  Consume.fromObject(dynamic o){
    this.id = int.tryParse(o["id"].toString());
    this.drinkId = int.tryParse(o["did"].toString());
    this.amount = int.tryParse(o["amount"].toString());
    this.consumedTime = o["consumedTime"].toString();
    this.name = o["name"].toString();
  }

}