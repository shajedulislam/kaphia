class CheckoutModel {
  String? orderStatus;
  String? orderNumber;
  String? orderDate;
  String? orderTime;
  String? tableNumber;
  String? specialInstruction;
  List<CheckoutOrderItems>? orderItems;

  CheckoutModel({
    this.orderStatus,
    this.orderNumber,
    this.orderDate,
    this.orderTime,
    this.tableNumber,
    this.specialInstruction,
    this.orderItems,
  });

  CheckoutModel copyWith({
    String? orderStatus,
    String? orderNumber,
    String? orderDate,
    String? orderTime,
    String? tableNumber,
    String? specialInstruction,
    List<CheckoutOrderItems>? orderItems,
  }) {
    return CheckoutModel(
      orderStatus: orderStatus ?? this.orderStatus,
      orderNumber: orderNumber ?? this.orderNumber,
      orderDate: orderDate ?? this.orderDate,
      orderTime: orderTime ?? this.orderTime,
      tableNumber: tableNumber ?? this.tableNumber,
      specialInstruction: specialInstruction ?? this.specialInstruction,
      orderItems: orderItems ?? this.orderItems,
    );
  }

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    orderStatus = json['orderStatus'];
    orderNumber = json['orderNumber'];
    orderDate = json['orderDate'];
    orderTime = json['orderTime'];
    tableNumber = json['tableNumber'];
    specialInstruction = json['specialInstruction'];
    if (json['orderItems'] != null) {
      orderItems = <CheckoutOrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(CheckoutOrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderStatus'] = orderStatus;
    data['orderNumber'] = orderNumber;
    data['orderDate'] = orderDate;
    data['orderTime'] = orderTime;
    data['tableNumber'] = tableNumber;
    data['specialInstruction'] = specialInstruction;
    if (orderItems != null) {
      data['orderItems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckoutOrderItems {
  String? id;
  String? name;
  int? quantity;
  int? price;
  String? variationType;
  String? size;
  List<String>? sides;

  CheckoutOrderItems(
      {this.id,
      this.name,
      this.quantity,
      this.price,
      this.variationType,
      this.size,
      this.sides});

  CheckoutOrderItems copyWith({
    String? id,
    String? name,
    int? quantity,
    int? price,
    String? variationType,
    String? size,
    List<String>? sides,
  }) {
    return CheckoutOrderItems(
        id: id ?? this.id,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        sides: sides ?? this.sides,
        size: size ?? this.size,
        variationType: variationType ?? this.variationType);
  }

  CheckoutOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    variationType = json['variationType'];
    size = json['size'];
    sides = json['sides'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['variationType'] = variationType;
    data['size'] = size;
    data['sides'] = sides;
    return data;
  }
}

class CheckoutOrderItemSize {
  String? id;
  String? name;

  CheckoutOrderItemSize({this.id, this.name});

  CheckoutOrderItemSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
