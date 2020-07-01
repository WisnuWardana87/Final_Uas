import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas/ui/inputpenjualan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class Berandaadmin extends StatefulWidget {
  @override
  _BerandaadminState createState() => _BerandaadminState();
}

class _BerandaadminState extends State<Berandaadmin> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  List penjualanList;
  int count = 0;

  Future<List> getData() async {
    final response =
        await http.get('http://192.168.43.190/flutter/Minuman/index');
    return json.decode(response.body);
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      //set level 0
      preferences.setInt("level", 0);
    });
    //redirect login
    Navigator.pushNamed(context, '/login');
  }

  @override
  void initState() {
    Future<List> penjualanListFuture = getData();
    penjualanListFuture.then((penjualanList) {
      setState(() {
        this.penjualanList = penjualanList;
        this.count = penjualanList.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: new AppBar(
        title: Text("Penjualan Minuman"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(""),
              accountEmail: new Text(""),
              currentAccountPicture: new GestureDetector(
                onTap: () {},
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      'http://192.168.100.75/apiflutter/media/photo'),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/appimages/bg_profile.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            new ListTile(
              title: new Text('logout'),
              trailing: new Icon(Icons.settings),
              onTap: () {
                signOut();
              },
            ),
          ],
        ),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Input Penjualan',
          onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new InputPenjualan(
                    list: null,
                    index: null,
                  )))),
    );
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              penjualanList[index]['nama'],
              style: textStyle,
            ),
            subtitle: Row(
              children: <Widget>[
                Text(penjualanList[index]['tanggal'].toString()),
                Text(
                  " | Rp. " + penjualanList[index]['harga'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                confirm(
                    penjualanList[index]['id'], penjualanList[index]['nama']);
              },
            ),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new InputPenjualan(
                      list: penjualanList[index],
                      index: index,
                    ))),
          ),
        );
      },
    );
  }

  Future<http.Response> deletePenjualan(id) async {
    final http.Response response =
        await http.delete("http://192.168.43.190/flutter/Minuman/delete/$id");
    Future<List> penjualanListFuture = getData();
    penjualanListFuture.then((penjualanList) {
      setState(() {
        this.penjualanList = penjualanList;
        this.count = penjualanList.length;
      });
    });
    return response;
  }

  void confirm(id, nama) {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Anda yakin Hapus '$nama'"),
      actions: <Widget>[
        new RaisedButton(
          child: Text("Ok Hapus"),
          color: Colors.red,
          onPressed: () {
            deletePenjualan(id);
            Navigator.of(context).pop();
            _globalKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Data '$nama' Berhasil Dihapus"),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
        new RaisedButton(
          child: Text("Batal"),
          color: Colors.green,
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    showDialog(context: context, child: alertDialog);
  }
}
