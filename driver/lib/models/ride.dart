import 'package:driver/utils/requests.dart';

class Ride {
  Ride({required this.rideID, required this.pickupLat, required this.pickupLng, required this.dropLat, required this.dropLng, required this.hospital});

  final int rideID;
  final double pickupLat;
  final double pickupLng;
  final double dropLat;
  final double dropLng;
  final String hospital;

  static Future<List<Ride>> getRidesFromServer() async {
    try {
      final List<Ride> ridesList = [];

      final response = await httpPostRequest(route: "/ride/list", body: {});
      final tempList = List.from(response);
      for (final entry in tempList) {
        ridesList.add(
          Ride(
            rideID: entry["ride_id"],
            pickupLat: entry["pickup_lat"],
            pickupLng: entry["pickup_lng"],
            dropLat: entry["drop_lat"],
            dropLng: entry["drop_lng"],
            hospital: entry["hospital"],
          ),
        );
      }

      return ridesList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> acceptRide(Ride ride) async {
    try {
      final response = await httpPostRequest(
        route: "/ride/accept",
        body: {
          "ride_id": ride.rideID,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static List<Ride> subtractList(List<Ride> first, List<Ride> second) {
    return first.where((element) => !second.contains(element)).toList();
  }

  @override
  String toString() {
    return 'Ride{rideID: $rideID, pickupLat: $pickupLat, pickupLng: $pickupLng, dropLat: $dropLat, dropLng: $dropLng, hospital: $hospital}';
  }

  @override
  bool operator ==(Object other) => (other is Ride && rideID == other.rideID);

  @override
  int get hashCode => rideID;
}
