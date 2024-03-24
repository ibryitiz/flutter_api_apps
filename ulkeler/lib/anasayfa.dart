

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ulkeler/detaysayfa.dart';
import 'package:ulkeler/ulke.dart';
import 'package:http/http.dart' as http;

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final String _apiUrl =
      "https://restcountries.com/v3.1/all?fields=name,flags,cca2,capital,region,languages,population";

  final List<Ulke> _butunUlkeler = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ulkeleriInteternettenCek();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar(){
    return AppBar(
      title: const Text("Tüm Ülkeler"),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      titleTextStyle: const TextStyle(color: Colors.white,fontSize: 24),
    );
  }

  Widget _buildBody() {
    return _butunUlkeler.isEmpty
        ? const Center(
          child: CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,

            ),
        )
        : ListView.builder(
            itemCount: _butunUlkeler.length,
            itemBuilder: _buildListItem,
          );
  }

  Widget? _buildListItem(BuildContext context, int index) {
    Ulke ulke = _butunUlkeler[index];
    return Card(
      child: ListTile(
        title: Text(ulke.isim),
        subtitle: Text("Capital : ${ulke.baskent}"),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(ulke.bayrak),
        ),
        trailing: IconButton(
          onPressed: (){},
          icon:const Icon(Icons.favorite_border),
          color: Colors.red,
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=> DetaySayfa(ulke: ulke)));

        },
      ),
    );
  }

  void _ulkeleriInteternettenCek() async{
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    List<dynamic> parsedResponse = jsonDecode(response.body);

    for(int i = 0; i<parsedResponse.length; i++){
      Map<String, dynamic> ulkeMap = parsedResponse[i];
      Ulke ulke = Ulke.maptenOlustur(ulkeMap);
      _butunUlkeler.add(ulke);
    }

    setState(() {

    });
  }
}
