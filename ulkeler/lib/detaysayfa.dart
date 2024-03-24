import 'package:flutter/material.dart';
import 'package:ulkeler/ulke.dart';

class DetaySayfa extends StatefulWidget {
  final Ulke ulke;
  const DetaySayfa({super.key, required this.ulke});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar(){
    return AppBar(
      title: Text(widget.ulke.isim),
      backgroundColor: Colors.blueAccent,
      titleTextStyle: const TextStyle(color: Colors.white,fontSize: 24),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const SizedBox(width: double.infinity,height: 36,),
        Image.network(widget.ulke.bayrak,width: MediaQuery.sizeOf(context).width / 2,),
        const SizedBox(height: 24,),
        Text(widget.ulke.isim,style: const TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
        const SizedBox(height: 44,),
        _buildTumDetaylar(),
      ],
    );
  }

  Widget _buildTumDetaylar(){
    return Padding(
      padding: const EdgeInsets.only(left: 120),
      child: Column(
        children: [
          _buildDetayRow("Ülke Adı: ", widget.ulke.isim),
          _buildDetayRow("Başkent: ", widget.ulke.baskent),
          _buildDetayRow("Bölge : ", widget.ulke.bolge),
          _buildDetayRow("Nufus : ", widget.ulke.nufus.toString()),
          _buildDetayRow("Dil : ", widget.ulke.dil),
        ],
      ),
    );
  }

  Widget _buildDetayRow(String baslik,String detay){
    return Row(
      children: [
         Expanded(
          flex: 3,
          child: Text(baslik,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ),
        Expanded(
          flex: 7,
          child: Text(detay,style: const TextStyle(fontSize: 20),),
        ),
      ],
    );
  }
}
