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
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
      'DeletedAt': deletedAt,
      'branch_id': branchId,
      'lat': lat,
      'lng': lng,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
      'DeletedAt': deletedAt,
      'branch_id': branchId,
      'value': value,
      'total_sold': totalSold,
    };
  }
}

class Item {
  int? id;
  int? parentItemId;
  String? name;
  double price;
  bool isSold;

  Item({
    this.id,
    this.parentItemId,
    this.name,
    required this.price,
    required this.isSold,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['ID'],
      parentItemId: json['parent_item_id'],
      name: json['name'] ?? "",
      price: double.parse(json['price'].toString()),
      isSold: json['is_sold'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'is_sold': isSold,
    };
  }
}

class ParentItem {
  int? id;
  int? branchId;
  String name;
  double price;
  List<Item> items;

  ParentItem({
    this.id,
    this.branchId,
    required this.name,
    required this.price,
    required this.items,
  });

  factory ParentItem.fromJson(Map<String, dynamic> json) {
    List<Item> itemList = [];
    if (json["items"] != null) {
      var itemJsonList = json['items'] as List;
      itemList = itemJsonList.map((item) => Item.fromJson(item)).toList();
    }

    return ParentItem(
      id: json['ID'],
      branchId: json['branch_id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      items: itemList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      'name': name,
      'price': price,
      'items': items.map((item) => item.toJson()).toList(),
    };
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
  List<dynamic>? transactions;
  HeatMap heatMap;
  int totalSold;
  int soldToday;
  List<Shift> shifts;
  Shift currentShift;
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
    required this.totalSold,
    required this.soldToday,
    required this.shifts,
    required this.currentShift,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    var parentItemJsonList = json['parent_items'] as List;
    List<ParentItem> parentItemList = parentItemJsonList
        .map((parentItem) => ParentItem.fromJson(parentItem))
        .toList();

    var shiftJsonList = json['shifts'] as List;
    List<Shift> shiftList =
        shiftJsonList.map((shift) => Shift.fromJson(shift)).toList();

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
      totalSold: json['total_sold'],
      soldToday: json['sold_today'],
      shifts: shiftList,
      currentShift: Shift.fromJson(json['current_shift']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
      'DeletedAt': deletedAt,
      'name': name,
      'address': address,
      'lat_lng': latLng.toJson(),
      'parent_items': parentItems.map((item) => item.toJson()).toList(),
      'transactions': transactions,
      'heat_map': heatMap.toJson(),
      'total_sold': totalSold,
      'sold_today': soldToday,
      'shifts': shifts.map((shift) => shift.toJson()).toList(),
      'current_shift': currentShift.toJson(),
    };
  }
}

class Shift {
  int id;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int branchId;
  String startedAt;
  String closedAt;
  int employeeId;
  Employee employee;
  bool isClosed;

  Shift({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.branchId,
    required this.startedAt,
    required this.closedAt,
    required this.employeeId,
    required this.employee,
    required this.isClosed,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['ID'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
      deletedAt: json['DeletedAt'],
      branchId: json['branch_id'],
      startedAt: json['started_at'],
      closedAt: json['closed_at'],
      employeeId: json['employee_id'],
      employee: Employee.fromJson(json['employee']),
      isClosed: json['is_closed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
      'DeletedAt': deletedAt,
      'branch_id': branchId,
      'started_at': startedAt,
      'closed_at': closedAt,
      'employee_id': employeeId,
      'employee': employee.toJson(),
      'is_closed': isClosed,
    };
  }
}

class Employee {
  int id;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String name;
  String password;
  String currentOtp;

  Employee({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.password,
    required this.currentOtp,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['ID'],
      createdAt: json['CreatedAt'],
      updatedAt: json['UpdatedAt'],
      deletedAt: json['DeletedAt'],
      name: json['name'],
      password: json['password'],
      currentOtp: json['current_otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
      'DeletedAt': deletedAt,
      'name': name,
      'password': password,
      'current_otp': currentOtp,
    };
  }
}
