import 'package:drink_tracking/const/const.dart';
import 'package:drink_tracking/data/dbHelper.dart';
import 'package:drink_tracking/models/drink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_consume.dart';

class DrinkList extends StatefulWidget {
  @override
  _DrinkListState createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  var dbHelper = DbHelper();
  List<Drink> drinks;
  int drinkCount = 0;
  


  @override
  void initState() {
    getDrinksFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Const.blue,
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Choose Drink', style: Const.titleFontGrey),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close_rounded,
            size: 20.0,
            color: Const.grey,
          ),
        ),
      ),
      body:  ListView.builder(
          itemCount: drinkCount,
          itemBuilder: (BuildContext context, int position)
          {
            return Container(
              height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - (MediaQuery.of(context).padding.top + kToolbarHeight))/drinkCount,
              padding: EdgeInsets.only(left: 4,right: 4),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Color(0xFF4f5f71),
                child: InkWell(
                  onTap: (){goToDetail(this.drinks[position]);},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 30, left:30),
                            child: Text(this.drinks[position].name, style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white, fontSize: 30)))),
                      ),
                      Expanded(
                        flex: 3,
                        child: Image(
                          alignment: Alignment.bottomCenter,
                          image: AssetImage("assets/${this.drinks[position].id}-nobottom.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }


  void getDrinksFromDatabase() async {
    var drinksFuture = dbHelper.getDrinks();
    drinksFuture.then((data) {
      setState(() {
        this.drinks = data;
        drinkCount = data.length;
      });
    });
  }

  void goToDetail(Drink drink) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ConsumeDetail(drink)));
    if (result != null) {
      if (result == true) {
        getDrinksFromDatabase();
      }
    }
  }
}
