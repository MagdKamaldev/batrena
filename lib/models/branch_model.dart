class LatLng {
  int id;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int branchId;
  double lat;
  double lng;

  LatLng({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.branchId,
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      id: json['ID'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
      deletedAt: json['DeletedAt'],
      branchId: json['branch_id'],
      lat: json['lat'].toDouble(), // Parse 'lat' as double
      lng: json['lng'].toDouble(), // Parse 'lng' as double
    );
  }
}

class HeatMap {
  int id;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int branchId;
  int value;
  int totalSold;

  HeatMap({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.branchId,
    required this.value,
    required this.totalSold,
  });

  factory HeatMap.fromJson(Map<String, dynamic> json) {
    return HeatMap(
      id: json['ID'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
      deletedAt: json['DeletedAt'],
      branchId: json['branch_id'],
      value: json['value'],
      totalSold: json['total_sold'],
    );
  }
}

class Item {
  int id;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int parentItemId;
  String name;
  int price;
  bool isSold;

  Item({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.parentItemId,
    required this.name,
    required this.price,
    required this.isSold,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['ID'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
      deletedAt: json['DeletedAt'],
      parentItemId: json['parent_item_id'],
      name: json['name'] ?? "",
      price: json['price'],
      isSold: json['is_sold'],
    );
  }
}

class ParentItem {
  int id;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int branchId;
  String name;
  int price;
  List<Item> items;

  ParentItem({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.branchId,
    required this.name,
    required this.price,
    required this.items,
  });

  factory ParentItem.fromJson(Map<String, dynamic> json) {
    var itemJsonList = json['items'] as List;
    List<Item> itemList =
        itemJsonList.map((item) => Item.fromJson(item)).toList();

    return ParentItem(
      id: json['ID'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
      deletedAt: json['DeletedAt'],
      branchId: json['branch_id'],
      name: json['name'],
      price: json['price'], // Parse 'price' as int
      items: itemList,
    );
  }
}

class Branch {
  int id;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String name;
  String address;
  LatLng latLng;
  List<ParentItem> parentItems;
  List<dynamic> transactions;
  HeatMap heatMap;

  Branch({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.address,
    required this.latLng,
    required this.parentItems,
    required this.transactions,
    required this.heatMap,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    var parentItemJsonList = json['parent_items'] as List;
    List<ParentItem> parentItemList = parentItemJsonList
        .map((parentItem) => ParentItem.fromJson(parentItem))
        .toList();

    return Branch(
      id: json['ID'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
      deletedAt: json['DeletedAt'],
      name: json['name'],
      address: json['address'],
      latLng: LatLng.fromJson(json['lat_lng']),
      parentItems: parentItemList,
      transactions: json['transactions'],
      heatMap: HeatMap.fromJson(json['heat_map']),
    );
  }
}
