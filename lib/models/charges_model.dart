class ChargesModel {
  int? serviceCharge;
  int? vat;

  ChargesModel({this.serviceCharge, this.vat});

  ChargesModel.fromJson(Map<String, dynamic> json) {
    serviceCharge = json['service_charge'];
    vat = json['vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_charge'] = serviceCharge;
    data['vat'] = vat;
    return data;
  }

  ChargesModel copyWith({
    int? serviceCharge,
    int? vat,
  }) {
    return ChargesModel(
      serviceCharge: serviceCharge ?? this.serviceCharge,
      vat: vat ?? this.vat,
    );
  }
}
