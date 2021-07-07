import 'package:drink_tracking/const/const.dart';
import 'package:drink_tracking/data/dbHelper.dart';
import 'package:drink_tracking/models/consume.dart';
import 'package:drink_tracking/models/drink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'home_page.dart';

// ignore: must_be_immutable
class ConsumeDetail extends StatefulWidget{
  Drink drink;
  ConsumeDetail(this.drink);

  @override
  State<StatefulWidget> createState() {
    return _ConsumeDetailState(drink);
  }
}

class _ConsumeDetailState extends State{
  var dbHelper = DbHelper();
  Drink drink;
  _ConsumeDetailState(this.drink);
  double _currentSliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    double consumeStep = drink.consumeStep.toDouble();
    double min = drink.minConsume.toDouble();
    double max = drink.maxConsume.toDouble();

    var steps = List.generate(max~/consumeStep+1, (index) => index*consumeStep.toInt());

    return Scaffold(
      backgroundColor: Const.blue,
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('${this.drink.name}',style: Const.titleFontGrey),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20.0,
            color: Const.grey,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top:30, bottom: 80),
                  child: Image.asset("assets/${this.drink.id}-2.png"),
                ),
                Container(
                  padding: EdgeInsets.only(top:30, bottom: 80, right: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 1, child: Text('How much', style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC9DDED), fontSize: 16, fontWeight: FontWeight.bold)))),
                      Expanded(
                        flex: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Slider(
                                  value: _currentSliderValue,
                                  min: min,
                                  max: max,
                                  divisions: max~/consumeStep,
                                  activeColor: Color(0xFF1b8aef),
                                  inactiveColor: Color(0xFFC9DDED),
                                  label: _currentSliderValue.round().toString(),
                                  onChanged: (double newValue) {
                                    setState(() {
                                      _currentSliderValue=newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top:10, bottom:50),
                              width: 50,
                              child: ListView.separated(
                                reverse: true,
                                itemCount: steps.length,
                                itemBuilder: (BuildContext context, int index){
                                  return Text('${steps[index]} ml', style: Const.fontGrey,);
                                },
                                separatorBuilder:(BuildContext context, int index) => Divider(height: (consumeStep*1.1)/(steps.length/2)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 1,child: SizedBox()),
                      Expanded(
                        flex:1,
                        child: RaisedButton(
                          color: Color(0xFF1b8aef),
                          elevation: 0,
                          highlightElevation: 0,
                          child: Text('Add', style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC9DDED), fontSize: 14, fontWeight: FontWeight.bold))),
                          onPressed: (){
                              addConsume();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }


  void addConsume() async {
    var result = dbHelper.insertConsume(Consume(drinkId: this.drink.id, amount: _currentSliderValue.toInt(), consumedTime: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()));
    result.then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())));
  }

}