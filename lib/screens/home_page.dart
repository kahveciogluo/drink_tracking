import 'package:drink_tracking/const/const.dart';
import 'package:drink_tracking/data/dbHelper.dart';
import 'package:drink_tracking/models/user.dart';
import 'package:drink_tracking/screens/calendar.dart';
import 'package:drink_tracking/screens/drink_list.dart';
import 'package:drink_tracking/screens/set_your_body.dart';
import 'package:drink_tracking/screens/today_consume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';

import '../notification_plugin.dart';



class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  var dbHelper = DbHelper();
  List<User> user;

  int waterYouConsumed = 0;
  int waterYouNeed ;

  String selectedDay = (DateFormat('yyyy-MM-dd').format(DateTime.now())).toString();

  String currentMonth = DateFormat.yMMM().format(DateTime.now()).toString();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool value = true;

  DateTime nowTime = DateTime.now();

  showNotification(bool value){
    if(value == true){
      if(nowTime.hour >= 9 && nowTime.hour <= 21){
        notificationPlugin.scheduleNotification();
      }else{
        notificationPlugin.cancelAllNotification();
      }
    }else{
      notificationPlugin.cancelAllNotification();
    }

  }

  @override
  void initState() {
    super.initState();
    print(value);
    showNotification(value);
    firstMethod();
    secondMethod();
  }

  void firstMethod() async{
    await getWaterYouConsumedThisDayFromDatabase(selectedDay);
  }

  void secondMethod() async{
    await getWaterYouNeed();
  }

  @override
  Widget build(BuildContext context) {
    getUser();


    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          bottomOpacity: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Const.blue),
          centerTitle: true,
          actions: <Widget>[
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Calendar()));
              },
              elevation: 0,
              color: Colors.transparent,
              highlightColor: Colors.transparent,
              highlightElevation: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 2.0, bottom: 2.0, top:2.0, right: 5.0),
                    child: Text('$currentMonth', style: Const.titleFontBlue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.calendar_today,
                      size: 20.0, color: Const.blue,
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 40),
              ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SetYourBody(this.user[0])));
                  },
                  leading: Icon(Icons.settings_rounded, color: Color(0xFF23374d),),
                  title: Container(child: Text('Settings', style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFF23374d),))))
              ),
              Divider(
                indent: 15,
                endIndent: 15,
              ),
              SwitchListTile(
                title: Container(child: Text('Notification', style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFF23374d),)))),
                subtitle: Text('Every 1 hours'),
                secondary: Icon(Icons.notification_important, color:  Color(0xFF23374d)),
                activeColor: Colors.teal,
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.black,
                inactiveTrackColor: Colors.blueGrey,
                value: value,
                onChanged: (bool newValue){
                  setState(() {
                    value = newValue;
                    showNotification(value);
                  });
                } ,
              ),
              Divider(
                indent: 15,
                endIndent: 15,
              ),

            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bluewave.png"),
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: HorizontalCalendar(
                        date: DateTime.now().add(Duration(days: 0)),
                        textColor: Const.black,
                        backgroundColor: Colors.transparent,
                        selectedColor: Const.blue,
                        onDateSelected: (date) => print(
                          date.toString(),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Expanded(flex: 2, child: Container(child: Image.asset("assets/background.png",))),
                    SizedBox(height: 80),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                              '${waterYouConsumed.toString()} ml / ${waterYouNeed.toString()} ml',
                              style: Const.fontBlue
                          ),
                          SizedBox(height: 5),
                          Text('Drinking water is essential for a healthier body', style: Const.fontBlack),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    FlatButton(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TodayConsume()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today, color: Const.grey, size: 15,),
                          SizedBox(width: 10),
                          Text("Today Consume", style: Const.fontGrey),
                        ],
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DrinkList()),
            );
          },
          backgroundColor: Const.blue,
          child: Icon(Icons.add, color: Const.grey),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );

  }

  void getUser() async {
    var usersFuture = dbHelper.getUser();
    usersFuture.then((data) { setState(() {
      this.user = data;
    });
    });
  }

  void getWaterYouNeed() async{
    var x = dbHelper.getWaterYouNeed();
    return x.then((value){setState(() {
      if(value == null){
        this.waterYouNeed = 1500;
      }else{
        this.waterYouNeed= value;
      }
    });});
  }

  void getWaterYouConsumedThisDayFromDatabase(String selectedDay) async{
    var water = dbHelper.getWaterYouConsumedThisDay(selectedDay);
    return water.then((value){setState(() {
      if(value == null){
        this.waterYouConsumed = 0;
      }else{
        this.waterYouConsumed = value;
      }
    });
    });

  }

}





