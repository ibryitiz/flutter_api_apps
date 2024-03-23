import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/detaysayfa.dart';
import 'package:rick_and_morty/kisiler.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  final String _apiUrl =
      "https://rickandmortyapi.com/api/character";

  List<Kisiler> _butunKisiler = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bilgileriInternettenCek();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6E9),
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar(){
    return AppBar(
      title: const Text("Rick & Morty"),
      backgroundColor: const Color(0xFF40A2E3),
      titleTextStyle: const TextStyle(color: Color(0xFFFFF6E9),fontSize: 24,fontWeight: FontWeight.bold),
      centerTitle: true,
    );
  }

  Widget _buildBody(){
    return _butunKisiler.isEmpty
      ? const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    ) :
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1 / 0.4),
          itemCount: _butunKisiler.length,
          itemBuilder: _buildkisiItems,
        );
  }

   Widget? _buildkisiItems(BuildContext context, int index){
    var kisi = _butunKisiler[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kisi: kisi),));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 3,right: 3,top: 1,bottom: 1),
        child: Card(
          color:const Color(0xFFBBE2EC),
          child: Row(
            children: [
          GestureDetector(
            onTap: () {
               showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text(kisi.isim,style:const TextStyle(color:Color(0xFF0D9276),fontSize: 36 ),)),
                  content:Image.network(kisi.resim,fit: BoxFit.cover,),
                  backgroundColor: const Color(0xFFBBE2EC),
                );
              },);
            },
            child: ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft:Radius.circular(11),topLeft:Radius.circular(11) ),
            child: Image.network(kisi.resim,fit: BoxFit.cover,)),
          ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(kisi.isim,style: const TextStyle(color: Color(0xFF0D9276),fontSize: 18,fontWeight: FontWeight.bold),),
                    Row(children: [
                      Text(kisi.durum),
                      const SizedBox(width: 5,),
                      const Text("-",style: TextStyle(fontSize: 20),),
                      const SizedBox(width: 5,),
                      Text(kisi.karakterTur),
                    ],),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }


  void _bilgileriInternettenCek() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    Map<String, dynamic> jsonVerisi = jsonDecode(response.body);

    if (jsonVerisi["results"] != null) {
      List<Kisiler> kisilerListesi = [];

      for (var kisiMap in jsonVerisi["results"]) {
        kisilerListesi.add(Kisiler.fromMap(kisiMap));
      }

      setState(() {
        _butunKisiler = kisilerListesi;
      });
    }
  }

}
