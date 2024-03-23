import 'package:flutter/material.dart';
import 'package:rick_and_morty/kisiler.dart';

class DetaySayfa extends StatefulWidget {
  Kisiler kisi;
  DetaySayfa({required this.kisi});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body:_buildBody(),
      backgroundColor: const Color(0xFFFFF6E9),
    );
  }

  AppBar _buildAppbar(){
    return AppBar(
      title: Text(widget.kisi.isim),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Color(0xFFFFF6E9),
        fontSize: 36,
      ),
      backgroundColor: const Color(0xFF40A2E3),
    );
  }

  Widget _buildBody(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: const Color(0xFFBBE2EC),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              _buildResim(context),
              const SizedBox(height: 5,),
              _buildKarakterIsim(context),
              _buildBilgilerRow("Status", widget.kisi.durum),
              _buildBilgilerRow("Species", widget.kisi.karakterTur),
              _buildBilgilerRow("Gender", widget.kisi.cinsiyet),
              _buildBilgilerRow("Origin", widget.kisi.originName),
              _buildBilgilerRow("Location", widget.kisi.locationName),
              _buildBilgilerRow("Url", widget.kisi.url),
              _buildBilgilerRow("Created", widget.kisi.created),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildResim(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.network(
          widget.kisi.resim,
        ),
      ),
    );
  }
  Widget _buildKarakterIsim(BuildContext context){
    return Text(
      widget.kisi.isim,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0D9276),
      ),
    );
  }
  
  Widget _buildBilgilerRow(String baslik, String detay){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          baslik,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        Text(
          detay,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black87
          ),
        ),
      ],
    );
  }
}
