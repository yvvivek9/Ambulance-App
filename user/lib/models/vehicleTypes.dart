class VehicleType {
  const VehicleType({required this.title, required this.cost, required this.image});

  final String title;
  final String cost;
  final String image;

  static const List<VehicleType> list = [
    VehicleType(
      title: "Fully equipped",
      cost: "1000 INR",
      image: "assets/ambulance/full.png",
    ),
    VehicleType(
      title: "Mini Equipped",
      cost: "700 INR",
      image: "assets/ambulance/mini.png",
    ),
    VehicleType(
      title: "Transport Only",
      cost: "300 INR",
      image: "assets/ambulance/bare.png",
    ),
  ];

  @override
  String toString() {
    return 'Ride{title: $title, cost: $cost, image: $image}';
  }
}
