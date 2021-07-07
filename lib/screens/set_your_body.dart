import 'package:drink_tracking/const/const.dart';
import 'package:drink_tracking/data/dbHelper.dart';
import 'package:drink_tracking/models/user.dart';
import 'package:drink_tracking/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetYourBody extends StatefulWidget {
  User user;
  SetYourBody(this.user);

  @override
  _SetYourBodyState createState() => _SetYourBodyState(user);
}

class _SetYourBodyState extends State<SetYourBody> {
  var dbHelper = DbHelper();
  User user;
  _SetYourBodyState(this.user);

  String _gender ;
  double _ageSlider = 0.0;
  double _weightSlider = 0.0;
  int calculatedWater = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Set Your Body', style: Const.titleFontBlue),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close_rounded,
            size: 20.0,
            color: Const.blue,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background-2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top:150, right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: _gender==null ? Text("Your gender is: ", style: Const.titleFontBlue) : Text("Your gender is: $_gender ", style: Const.titleFontBlue,),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: DropdownButton<String>(
                            value: _gender,
                            //elevation: 5,
                            style: Const.fontBlue,
                            items: <String>[
                              'Woman',
                              'Man',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text(
                              "Please choose your gender",
                              style: Const.titleFontBlue,
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Text("Your age is: ${(_ageSlider.toInt()).toString()}", style: Const.titleFontBlue,),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(left:10, right: 10),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Const.blue,
                        inactiveTrackColor: Const.grey,
                        trackShape: RoundedRectSliderTrackShape(),
                        trackHeight: 4.0,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        thumbColor: Const.blue2,
                        overlayColor: Colors.transparent,
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                        tickMarkShape: RoundSliderTickMarkShape(),
                        activeTickMarkColor: Const.blue2,
                        inactiveTickMarkColor: Const.grey,
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Const.blue2,
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Slider(
                        value: _ageSlider,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: '${_ageSlider.toInt()}',
                        onChanged: (value) {
                          setState(
                                () {
                              _ageSlider = value;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Text("Your weight is: ${(_weightSlider.toInt()).toString()}", style: Const.titleFontBlue,),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(left:10, right: 10),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Const.blue,
                        inactiveTrackColor: Const.grey,
                        trackShape: RoundedRectSliderTrackShape(),
                        trackHeight: 4.0,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        thumbColor: Const.blue2,
                        overlayColor: Colors.transparent,
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                        tickMarkShape: RoundSliderTickMarkShape(),
                        activeTickMarkColor: Const.blue2,
                        inactiveTickMarkColor: Const.grey,
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Const.blue2,
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Slider(
                        value: _weightSlider,
                        min: 0,
                        max: 200,
                        divisions: 200,
                        label: '${_weightSlider.toInt()}',
                        onChanged: (value) {
                          setState(
                                () {
                                  _weightSlider = value;
                            },
                          );
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          RaisedButton(
            color: Color(0xFF1b8aef),
            elevation: 0,
            highlightElevation: 0,
            child: Text('Calculate', style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC9DDED), fontSize: 14, fontWeight: FontWeight.bold))),
            onPressed: (){
              setState(() {
                calculateWater();
              });
            },
          ),
          Container(
            padding: EdgeInsets.only(bottom: 40, top:30),
            child: Text("Amount of water you need daily: $calculatedWater ml", style: Const.titleFontBlue,),
          ),
        ],
      ),
    );
  }

  void calculateWater() {
    if (_gender != null && _ageSlider !=0 && _weightSlider !=0 ){
      calculatedWater = (_weightSlider*0.03*1000).toInt();
      updateUser();
      }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Calculation failed "),
            content: new Text("Be sure to select all of the gender, age and weight fields as required."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

  }

  void updateUser() async{
    await dbHelper.updateUser(User.withId(user.id, _gender, _ageSlider.toInt(), _weightSlider.toInt(), calculatedWater));
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

}
