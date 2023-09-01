class Branch {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String address;
  LatLng latLng;
  List<ParentItem> parentItems;
  List<Transaction> transactions;
  HeatMap heatMap;

  Branch({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.address,
    required this.latLng,
    required this.parentItems,
    required this.transactions,
    required this.heatMap,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['ID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      name: json['name'],
      address: json['address'],
      latLng: LatLng.fromJson(json['lat_lng']),
      parentItems: (json['parent_items'] as List<dynamic>)
          .map((item) => ParentItem.fromJson(item))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((item) => Transaction.fromJson(item))
          .toList(),
      heatMap: HeatMap.fromJson(json['heat_map']),
    );
  }
}

class LatLng {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int branchId;
  double lat;
  double lng;

  LatLng({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      id: json['ID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      branchId: json['branch_id'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class ParentItem {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int branchId;
  List<Item> items;

  ParentItem({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    required this.items,
  });

  factory ParentItem.fromJson(Map<String, dynamic> json) {
    return ParentItem(
      id: json['ID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      branchId: json['branch_id'],
      items: (json['items'] as List<dynamic>)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }
}

class Item {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int parentItemId;
  String name;
  double price;
  bool isSold;

  Item({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.parentItemId,
    required this.name,
    required this.price,
    required this.isSold,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['ID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      parentItemId: json['parent_item_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      isSold: json['is_sold'],
    );
  }
}

class Transaction {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int branchId;
  // Other properties specific to the Transaction class

  Transaction({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    // Initialize other properties here
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['ID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      branchId: json['branch_id'],
      // Parse and assign other properties here
    );
  }
}

class HeatMap {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int branchId;
  int value;
  int totalSold;

  HeatMap({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.branchId,
    required this.value,
    required this.totalSold,
  });

  factory HeatMap.fromJson(Map<String, dynamic> json) {
    return HeatMap(
      id: json['ID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      branchId: json['branch_id'],
      value: json['value'],
      totalSold: json['total_sold'],
    );
  }
}
