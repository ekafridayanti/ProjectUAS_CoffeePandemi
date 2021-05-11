import 'package:coffee_pandemi_app/Flutter_Api/model/pelanggan.dart';
import 'package:coffee_pandemi_app/Flutter_Api/server/api.dart';

import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdatePelanggan extends StatefulWidget {
  final Pelanggan pelanggan;
  UpdatePelanggan({this.pelanggan});
  @override
  _UpdatePelangganState createState() => _UpdatePelangganState();
}

class _UpdatePelangganState extends State<UpdatePelanggan> {
  var _controllerNama = TextEditingController();

  var _controllerEmail = TextEditingController();

  var _controllerTotal = TextEditingController();
  var _gender = '';

  void updateNewPelanggan() async {
    // var url = 'http://192.168.1.2/db_coffee_api/update_pelanggan.php';
    try {
      var response = await http.post(Api.urlUpdatePelanggan, body: {
        'id': widget.pelanggan.id,
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
  void initState() {
    _controllerNama.text = widget.pelanggan.nama;
    _controllerEmail.text = widget.pelanggan.email;
    _controllerTotal.text = widget.pelanggan.total;
    _gender = widget.pelanggan.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Customer'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _controllerNama,
              keyboardType: TextInputType.text,
              // textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                  // contentPadding: EdgeInsets.only(left: 10, bottom: 16),
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Customer Name'),
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
                  labelText: 'Price Coffe Shopping'),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text("Gender :"),
              Text(_gender),
            ],
          ),
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
          RaisedButton(
            onPressed: () {
              updateNewPelanggan();
            },
            child: Text(
              'Update',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
