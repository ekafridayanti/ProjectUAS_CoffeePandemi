import 'package:coffee_pandemi_app/Flutter_Api/server/api.dart';

import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPelanggan extends StatelessWidget {
  var _controllerNama = TextEditingController();
  var _controllerEmail = TextEditingController();
  var _controllerTotal = TextEditingController();
  var _gender = '';

  void addNewPelanggan() async {
    // var url = '${Api.server}/add_pelanggan.php';
    try {
      var response = await http.post(Api.urlAddPelanggan, body: {
        'nama': _controllerNama.text,
        'email': _controllerEmail.text,
        'total': _controllerTotal.text,
        'gender': _gender,
      });
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody['succes']) {
          print('Berhasil');
        } else {
          print('Gagal');
        }
      } else {
        print('Request Eror');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data Pelanggan'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerNama,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Costumer Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerEmail,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerTotal,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Price Coffee Shopping'),
            ),
          ),
          SizedBox(height: 8),
          Text("Gender"),
          SizedBox(height: 8),
          RadioButtonGroup(
            labels: <String>[
              "Perempuan",
              "Laki-laki",
            ],
            onSelected: (String selected) {
              _gender = selected;
              print(_gender);
            },
          ),
          SizedBox(height: 8),
          RaisedButton(
            onPressed: () {
              addNewPelanggan();
            },
            child: Text(
              'Add',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
