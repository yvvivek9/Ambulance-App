import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:user/utils/utils.dart';

class Hospital {
  Hospital({required this.name, required this.latitude, required this.longitude, required this.address, required this.open});

  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final String open;

  static Future<List<Hospital>> getHospitalsList(double lat, double lng) async {
    final typeOfPlace = "hospital";
    final APIKey = "AIzaSyAHcQKv655QyzOGTvrVAGTxWbPP-g5YbPE";
    final url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat%2C$lng&radius=1500&type=$typeOfPlace&key=$APIKey";

    final response = await http.get(Uri.parse(url));
    final decodedResponse = jsonDecode(response.body);
    final hspList = decodedResponse["results"];

    final List<Hospital> temp = [];
    for (final hsp in hspList) {
      try {
        if (hsp["business_status"] == "OPERATIONAL") {
          final loc = hsp["geometry"]["location"];
          temp.add(
            Hospital(
              name: hsp["name"].toString(),
              latitude: loc["lat"],
              longitude: loc["lng"],
              address: hsp["vicinity"].toString(),
              open: hsp["opening_hours"]["open_now"].toString(),
            ),
          );
        }
      } catch (e) {
        safePrint("Error adding a hospital: $e");
      }
    }
    return temp;
  }

  @override
  String toString() {
    return '{name: $name, latitude: $latitude, longitude: $longitude, address: $address, open: $open}';
  }
}
