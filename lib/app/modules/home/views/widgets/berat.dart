import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:convert';
import 'package:get/get.dart';

class satuanBerat extends StatelessWidget {
  satuanBerat({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextField(
              controller: homeController.beratC,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Berat"),
              ),
              onChanged: (value) {
                homeController.ubahBerat(value);
              },
            ),
          ),
        ),
        SizedBox(width: 20),
        Container(
          width: 130,
          child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              items: ["Gram", "Kg"],
              label: "Satuan berat",
              onChanged: (value) {
                homeController.ubahSatuan(value!);
              },
              selectedItem: "Gram"),
        ),
      ],
    );
  }
}
