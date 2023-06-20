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
}

class Items {
  String? id;
  String? image;
  String? variationType;
  List<Sizes>? sizes;
  List<String>? sides;
  int? sideSelectionLimit;
  int? price;
  String? name;
  String? description;
  bool? availability;

  Items(
    this.id, {
    this.image,
    this.variationType,
    this.sizes,
    this.sides,
    this.sideSelectionLimit,
    this.price,
    this.name,
    this.description,
    this.availability,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    variationType = json['variation_type'];
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
    sides = json['sides'] != null ? json['sides'].cast<String>() : [];
    sideSelectionLimit = json['side_selection_limit'];
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
      data['sides'] = sides;
    }
    data['price'] = price;
    data['name'] = name;
    data['description'] = description;
    data['availability'] = availability;
    return data;
  }
}

class Sizes {
  String? id;
  int? price;
  String? name;

  Sizes({this.id, this.price, this.name});

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['name'] = name;
    return data;
  }
}
