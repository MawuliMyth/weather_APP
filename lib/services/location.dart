import 'package:geolocator/geolocator.dart';

class Location {

   late double latitude;
   late double longitude;

 Future<void> getCurrentLocation() async{
   try {
     // Define location settings
     final LocationSettings locationSettings = LocationSettings(
       accuracy: LocationAccuracy.low, // low accuracy for location
       distanceFilter: 0, // Notify for any movement
     );
     // Use locationSettings in getCurrentPosition
     Position position = await Geolocator.getCurrentPosition(
       locationSettings: locationSettings,

     );
     latitude = position.latitude;
     longitude = position.longitude;
   }
   catch(e){
     print(e);
   }
 }

}