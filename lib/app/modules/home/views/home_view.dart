import 'package:cek_ongkir/app/modules/home/views/widgets/berat.dart';
import 'package:cek_ongkir/app/modules/home/views/widgets/city.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'widgets/provinsi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Ongkos Kirim'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          provinsi(
            homeC: homeC,
            tipe: "asal",
          ),
          Obx(
            () => city(
              provId: homeC.provIdAsal.value,
              tipe: "asal",
            ),
          ),
          provinsi(
            homeC: homeC,
            tipe: "tujuan",
          ),
          Obx(
            () => city(
              provId: homeC.provIdTujuan.value,
              tipe: "tujuan",
            ),
          ),
          satuanBerat(),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<String>(
            mode: Mode.BOTTOM_SHEET,
            items: ["jne", "tiki", "pos"],
            label: "Kurir",
            onChanged: (value) {
              homeC.hiddenButtonOngkir.value = false;
              homeC.kurir = value!;
            },
            selectedItem: "",
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => homeC.hiddenButtonOngkir.isTrue
                ? SizedBox()
                : ElevatedButton(
                    onPressed: () {
                      homeC.ongkosKirim();
                    },
                    child: Text("Cek Ongkos Kirim"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
