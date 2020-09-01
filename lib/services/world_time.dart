import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime  {
  String location; // location to UI
  String time; // time of the loc.
  String flag; // url for flags
  String url; //location url api endpoint
  bool isDaytime; // day or night.

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try{
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map daytime = jsonDecode(response.body);
      String datetime = daytime['datetime'];
      String offsetHours =  daytime['utc_offset'].substring(2,3);
      String offsetMinutes =  daytime['utc_offset'].substring(4,6);
      //print(datetime);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHours)));
      now = now.add(Duration(minutes: int.parse(offsetMinutes)));
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      time = 'could not get time data';

    }

  }


}
