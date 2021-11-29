import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:cek_ongkir/app/modules/home/provinsi_model.dart';
import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class provinsi extends StatelessWidget {
  const provinsi({
    Key? key,
    required this.homeC,
    required this.tipe,
  }) : super(key: key);

  final HomeController homeC;
  final tipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownSearch<Provinsi>(
        dropdownSearchDecoration: InputDecoration(
          label:
              tipe == "asal" ? Text("Provinsi Asal") : Text("Provinsi Tujuan"),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(15),
        ),
        showClearButton: true,
        onFind: (String? filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
          final response = await http.get(
            url,
            headers: {"key": "cfa895dc811c8ab1f3e1cd51acf16c95"},
          );

          var data = json.decode(response.body) as Map<String, dynamic>;

          var listProvinsi = data["rajaongkir"]["results"] as List<dynamic>;

          var models = Provinsi.fromJsonList(listProvinsi);
          return models;
        },
        onChanged: (value) {
          if (value != null) {
            print(value.nama_province);
            tipe == "asal"
                ? homeC.provIdAsal.value = int.parse(value.provinceId!)
                : homeC.provIdTujuan.value = int.parse(value.provinceId!);
          } else
            print("Tidak ada data yang dipilih");
        },
        showSearchBox: true,
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "${item.nama_province}",
              style: TextStyle(fontSize: 20),
            ),
          );
        },
        itemAsString: (item) => item!.nama_province!,
      ),
    );
  }
}
