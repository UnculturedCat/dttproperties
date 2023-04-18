class Property {
  final int id;
  final String imageAddress;
  final int price;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int size = 54;
  final String description;
  final String zip;
  final String city;
  final String latitude;
  final String longitude;
  final String dateCreated;
  Property({
    required this.id,
    required this.imageAddress,
    required this.price,
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.description,
    required this.zip,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.dateCreated,
  });
}
