import 'package:cek_ongkir/app/modules/home/Kota_model.dart';
import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class city extends StatelessWidget {
  city({
    Key? key,
    required this.provId,
    required this.tipe,
  }) : super(key: key);

  final provId;
  final tipe;
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: 80,
        child: DropdownSearch<Kota>(
          dropdownSearchDecoration: InputDecoration(
            label: tipe == "asal"
                ? Text("Kota / Kabupaten Asal")
                : Text("Kota / Kabupaten Tujuan"),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(15),
          ),
          showClearButton: true,
          onFind: (String? filter) async {
            Uri url = Uri.parse(
                "https://api.rajaongkir.com/starter/city?province=$provId");
            final response = await http.get(
              url,
              headers: {"key": "cfa895dc811c8ab1f3e1cd51acf16c95"},
            );

            var data = json.decode(response.body) as Map<String, dynamic>;

            var listProvinsi = data["rajaongkir"]["results"] as List<dynamic>;

            var models = Kota.fromJsonList(listProvinsi);
            return models;
          },
          onChanged: (value) {
            if (tipe == "asal") {
              homeController.kotaIdAsal.value = int.parse(value!.cityId!);
            }
            homeController.kotaIdTujuan.value = int.parse(value!.cityId!);
          },
          showSearchBox: true,
          popupItemBuilder: (context, kota, isSelected) {
            return Container(
              padding: EdgeInsets.all(15),
              child: Text(
                "${kota.type} ${kota.cityName}",
                style: TextStyle(fontSize: 20),
              ),
            );
          },
          itemAsString: (item) => "${item!.type!} ${item.cityName!}",
        ),
      ),
    );
  }
}
