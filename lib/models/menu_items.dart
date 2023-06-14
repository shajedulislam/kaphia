class MenuItemsModel {
  String? image;
  String? name;
  bool? availability;
  List<Items>? items;

  MenuItemsModel({this.image, this.name, this.availability, this.items});

  MenuItemsModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    availability = json['availability'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['availability'] = availability;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? image;
  String? variationType;
  List<Sizes>? sizes;
  Sides? sides;
  int? price;
  String? name;
  String? description;
  bool? availability;

  Items(
      {this.image,
      this.variationType,
      this.sizes,
      this.sides,
      this.price,
      this.name,
      this.description,
      this.availability});

  Items.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    variationType = json['variation_type'];
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
    sides = json['sides'] != null ? Sides.fromJson(json['sides']) : null;
    price = json['price'];
    name = json['name'];
    description = json['description'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['variation_type'] = variationType;
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    if (sides != null) {
      data['sides'] = sides!.toJson();
    }
    data['price'] = price;
    data['name'] = name;
    data['description'] = description;
    data['availability'] = availability;
    return data;
  }
}

class Sizes {
  int? price;
  String? name;

  Sizes({this.price, this.name});

  Sizes.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['name'] = name;
    return data;
  }
}

class Sides {
  int? limit;
  List<String>? items;

  Sides({this.limit, this.items});

  Sides.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    items = json['items'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['items'] = items;
    return data;
  }
}
