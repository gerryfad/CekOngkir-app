class Provinsi {
  String? provinceId;
  String? nama_province;

  Provinsi({this.provinceId, this.nama_province});

  Provinsi.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    nama_province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['province_id'] = provinceId;
    data['province'] = nama_province;
    return data;
  }

  static List<Provinsi> fromJsonList(List list) {
    if (list.length == 0) return List<Provinsi>.empty();
    return list.map((item) => Provinsi.fromJson(item)).toList();
  }
}
