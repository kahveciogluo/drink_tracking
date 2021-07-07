import 'package:drink_tracking/const/const.dart';
import 'package:drink_tracking/data/dbHelper.dart';
import 'package:drink_tracking/models/consume.dart';
import 'package:drink_tracking/screens/calendar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'home_page.dart';

class SelectedDayConsume extends StatefulWidget {
  DateTime date;
  SelectedDayConsume(this.date);

  @override
  _SelectedDayConsumeState createState() => _SelectedDayConsumeState(date);
}

class _SelectedDayConsumeState extends State<SelectedDayConsume> {
  DateTime date;
  _SelectedDayConsumeState(this.date);

  var dbHelper = DbHelper();
  List<Consume> consumes;
  int consumeCount = 0;

  String get selectedDay => (DateFormat('yyyy-MM-dd').format(this.date)).toString();

  @override
  void initState() {
    getSelectedDayConsumes(selectedDay);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("${DateFormat('yMMMMd').format(this.date)}", style: Const.titleFontBlue),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20.0,
            color: Const.blue,
          ),
        ),
      ),
      body: buildConsumeList(),
    );
  }

  buildConsumeList() {
    if(consumeCount==0 || consumeCount==null){
      return Center(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 100, right: 100, left: 100, bottom: 40),
                child: Image.asset("assets/sad.png")),
            Text("You haven't consumed any drink yet today", style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFF23374d), fontSize: 14, fontWeight: FontWeight.bold))),
          ],
        ),
      );
    }
    return ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: consumeCount,
        itemBuilder: (BuildContext context, int index){
          return Container(
            height: 120,
            padding: EdgeInsets.only(left: 4.0, right: 4.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Color(0xFF23374d),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                child: ListTile(
                  leading: Container(padding: EdgeInsets.all(3.0), child: Image.asset("assets/${this.consumes[index].drinkId}.png")),
                  title: Text("Drink: ${this.consumes[index].name.toString()}",style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC9DDED), fontSize: 15))),
                  subtitle: Text("Amount: ${this.consumes[index].amount.toString()} ml", style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFF849fbd), fontSize: 13))),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Color(0xFF849fbd),),
                    onPressed: (){
                      deleteConsume(this.consumes[index]);
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }

  void deleteConsume(Consume consume) async {
    int result = await dbHelper.deleteConsume(consume.id);
    if(result==1){
      setState(() {
        getSelectedDayConsumes(selectedDay);
      });
    }

  }

  void getSelectedDayConsumes(String selectedDay) async {
    var consumesFuture = dbHelper.getSelectedDayConsumes(selectedDay);
    consumesFuture.then((data){ setState(() {
      this.consumes = data;
      consumeCount = data.length;
    });
    });

  }

}
