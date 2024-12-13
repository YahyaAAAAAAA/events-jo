import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

//main purpose is state management
class EjLocation {
  double lat;
  double long;
  double initLat;
  double initLong;
  Marker? marker;

  EjLocation({
    required this.lat,
    required this.long,
    required this.initLat,
    required this.initLong,
  }) {
    this.marker = Marker(
      point: LatLng(
        lat,
        long,
      ),
      child: Icon(
        Icons.location_pin,
        color: GColors.black,
      ),
    );
  }

//team example on why we use Entities/Models
//.
//. in main()
//. int value = 0;
//. increment(value);
//. print(value) -> 0
//. in another class we have method
//. void increment(int i){
//.  i++;
//. print(value) -> 1
//. }
//.
//. let's make a new Entity class called Test
//. class Test(){
//. int value;
//. Test({
//. required this.value});
//. }
//.
//. now in main()
//. Test test = Test(value=0);
//. increment_2(test)
//. print(test.value) -> 1
//. let's make a different method (that takes our entity)
//. void increment_2(Test t){
//. t.value++;
//. print(t.value) -> 1
//. }
}
