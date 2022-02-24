import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../courier_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  late TextEditingController beratC;

  var provId = 0.obs;
  var provIdTujuan = 0.obs;
  var provIdAsal = 0.obs;
  var kotaIdAsal = 0.obs;
  var kotaIdTujuan = 0.obs;
  var berat = 0.0;
  var satuan = "Gram";
  var kurir = "";
  var hiddenButtonOngkir = true.obs;

  void ongkosKirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    final response = await http.post(
      url,
      body: {
        "origin": "$kotaIdAsal",
        "destination": "$kotaIdTujuan",
        "weight": "$berat",
        "courier": "$kurir"
      },
      headers: {
        "key": "cfa895dc811c8ab1f3e1cd51acf16c95",
        "content-type": "application/x-www-form-urlencoded",
      },
    );

    var data = json.decode(response.body);
    var results = data["rajaongkir"]["results"] as List<dynamic>;

    var listAllCourier = Courier.fromJsonList(results);
    var courier = listAllCourier[0];

    Get.defaultDialog(
      title: courier.name!,
      content: Column(
        children: courier.costs!
            .map(
              (e) => ListTile(
                title: Text("${e.service}"),
                subtitle: Text("Rp ${e.cost![0].value}"),
                trailing: Text(
                  courier.code == "pos"
                      ? "${e.cost![0].etd}"
                      : "${e.cost![0].etd} HARI",
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    var cekSatuan = satuan;

    switch (cekSatuan) {
      case "Kg":
        berat = berat * 1000;
        break;
      case "Gram":
        berat = berat;
        break;
      default:
        berat = berat;
    }
    print("$berat gram");
  }

  void ubahSatuan(String value) {
    berat = double.parse(beratC.text);

    switch (value) {
      case "Kg":
        berat = berat * 1000;
        break;
      case "Gram":
        berat = berat;
        break;
      default:
        berat = berat;
    }
    satuan = value;
    print("$berat gram");
  }

  @override
  void onInit() {
    beratC = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }
}
