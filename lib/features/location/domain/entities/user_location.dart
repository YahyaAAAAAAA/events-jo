import 'package:flutter_map/flutter_map.dart';

//main purpose is state management and abstraction of code
class MapLocation {
  double lat;
  double long;
  double initLat;
  double initLong;
  Marker marker;

  MapLocation({
    required this.lat,
    required this.long,
    required this.initLat,
    required this.initLong,
    required this.marker,
  });

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
