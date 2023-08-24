class LatLng {
  int id;
  int branchId;
  String lat;
  String lng;

  LatLng({
    required this.id,
    required this.branchId,
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      id: json['ID'],
      branchId: json['branch_id'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class Inventory {
  int id;
  int branchId;
  dynamic items;

  Inventory({
    required this.id,
    required this.branchId,
    required this.items,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['ID'],
      branchId: json['branch_id'],
      items: json['items'],
    );
  }
}

class Branch {
  int id;
  String name;
  String address;
  LatLng latLng;
  Inventory inventory;

  Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.latLng,
    required this.inventory,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['ID'],
      name: json['name'],
      address: json['address'],
      latLng: LatLng.fromJson(json['lat_lng']),
      inventory: Inventory.fromJson(json['inventory']),
    );
  }
}
