import 'package:drink_tracking/const/const.dart';
import 'package:drink_tracking/screens/selected_day_consume.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'home_page.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String currentMonth = DateFormat.yMMM().format(DateTime.now()).toString();
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 4, right: 4, top: 40),
              child: TableCalendar(
                headerVisible: true,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  centerHeaderTitle: true,
                  titleTextStyle: Const.titleFontBlue,
                  leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF23374d),),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF23374d),),
                ),
                initialCalendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(
                    selectedColor: Color(0xFF23374d),
                    todayColor: Color(0xFF23374d),
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.white)),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events, e) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedDayConsume(date)));
                  print(date.toUtc());
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFF23374d),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        date.day.toString(),
                        style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC9DDED))),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF23374d),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                        date.day.toString(),
                        style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xFFC9DDED)),
                        )),
                  ),

                ),
                calendarController: _controller,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom:30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF23374d),
              ),
              width: 50,
              height: 50,
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close_rounded, color: Color(0xFFC9DDED),),
              ),
            ),

          ],
        ));
  }
}
