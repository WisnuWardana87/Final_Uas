import 'package:flutter/material.dart';
//import terlebih dahulu halaman yang diperlukan
import './detailproduk.dart';

class ProdukList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appbar
        appBar: AppBar(title: Text("ALCOHOL PRICE")),
        //body untuk content
        //menampilkan list
        body: ListView(
          shrinkWrap: true,
          //padding
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          //anggota dari list berupa widget children
          children: <Widget>[
            //GestureDetector untuk menangani gesture pengguna
            new GestureDetector(
              //listener  berupa klik 1x
              onTap: () {
                //navigator.push  untuk berpindah halaman
                Navigator.of(context).push(new MaterialPageRoute(
                  //pemanggilan class DetailProduk beserta pengiriman detail produk
                  builder: (BuildContext context) => DetailProduk(
                    name: "Chivas Regal",
                    description:
                        "Chivas Regal adalah wiski Scotch campuran yang diproduksi oleh Chivas Brothers, yang merupakan bagian dari Pernod Ricard. Chivas Regal menelusuri akarnya kembali ke 1801.",
                    price: 325000,
                    image: "chivasregal.jpg",
                    star: 4,
                  ),
                ));
              },
              //memanggil class Productbox
              child: ProductBox(
                  //berisi parameter yang diperlukan di class ProductBox
                  name: "Chivas Regal 750ml",
                  description: "WHISKY",
                  price: 325000,
                  image: "chivasregal.jpg",
                  star: 4),
            ),
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => DetailProduk(
                      name: "Jim Beam",
                      description:
                          "JIM BEAM Bourbon Whisky merupakan whisky dibuat dengan formula yang sama sejak 1795, raksasa dari kategori ini berumur empat tahun dalam tong kayu oak untuk menciptakan rasa yang lembut dan lembut dengan sedikit bumbu.",
                      price: 450000,
                      image: "jimbeam.jpg",
                      star: 5,
                    ),
                  ));
                },
                child: ProductBox(
                    name: "Jim Beam 750ml",
                    description: "WHISKY",
                    price: 450000,
                    image: "jimbeam.jpg",
                    star: 5)),
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => DetailProduk(
                      name: "Captain Morgan",
                      description:
                          "Jika Anda menyukai kehidupan, dan rum, sedikit pedas, maka Kapten Morgan Original Spiced Rum cocok untuk Anda. Dinamai setelah bajak laut Welsh abad ke-17, Kapten (Henry) Morgan rum adalah campuran rum Karibia yang berumur sekitar satu tahun, dengan bumbu-bumbu ditambahkan. Karena ini bukan rum yang rumit atau luar biasa, banyak peminum rum baru menggigit Kapten Morgan. Anda dapat menikmati ini sebagai rum menyesap di atas es atau menambahkan Kapten Morgan Original Spiced Rum ke hampir semua koktail rum. Andalkan untuk menambah rasa vanila dan bumbu ringan.",
                      price: 225000,
                      image: "captainmorgan.jpg",
                      star: 4,
                    ),
                  ));
                },
                child: ProductBox(
                    name: "Captain Morgan 750ml",
                    description: "RUM",
                    price: 225000,
                    image: "captainmorgan.jpg",
                    star: 4)),
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => DetailProduk(
                      name: "Vodka Smirnoff",
                      description:
                          "Smirnoff Vodka adalah minuman vodka dengan tiga distilasi dan sangat halus. Sepuluh kali difilter dalam proses yang unik untuk kejelasan tertinggi.",
                      price: 250000,
                      image: "vodkasmirnoff.jpg",
                      star: 3,
                    ),
                  ));
                },
                child: ProductBox(
                    name: "Vodka Smirnoff 750ml",
                    description: "VODKA",
                    price: 125000,
                    image: "vodkasmirnoff.jpg",
                    star: 3)),
            new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => DetailProduk(
                      name: "Jose Cuervo Gold",
                      description:
                          "Jose Cuervo Gold Minuman Alkohol adalah tequila yang memiliki kadar alkohol 40% dengan rasa lembut yang luar biasa. Memiliki rasa khas dan aroma yang unik dapat membuat Anda yang meminumnya menjadi bersemangat. Cocok untuk dicampur. ",
                      price: 250000,
                      image: "tequila.jpg",
                      star: 5,
                    ),
                  ));
                },
                child: ProductBox(
                    name: "Jose Cuervo Gold 750ml",
                    description: "TEQUILA",
                    price: 250000,
                    image: "tequila.jpg",
                    star: 5)),
          ],
        ));
  }
}

//menggunakan widget StatelessWidget
class ProductBox extends StatelessWidget {
  //deklarasi variabel yang diterima dari MyHomePage
  ProductBox(
      {Key key, this.name, this.description, this.price, this.image, this.star})
      : super(key: key);
  //menampung variabel yang diterima untuk dapat digunakan pada class ini
  final String name;
  final String description;
  final int price;
  final String image;
  final int star;
  final children = <Widget>[];

  Widget build(BuildContext context) {
    for (var i = 0; i < star; i++) {
      children.add(new Icon(
        Icons.star,
        size: 10,
        color: Colors.deepOrange,
      ));
    }
    //menggunakan widget container
    return Container(
        //padding
        padding: EdgeInsets.all(10),
        // height: 120,
        //menggunakan widget card
        child: Card(
            //membuat tampilan secara horisontal antar image dan deskripsi
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //children digunakan untuk menampung banyak widget
                children: <Widget>[
              Image.asset(
                "assets/" + image,
                width: 150,
              ),
              Expanded(
                  //child digunakan untuk menampung satu widget
                  child: Container(
                      padding: EdgeInsets.all(5),
                      //membuat tampilan secara vertikal
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //ini isi tampilan vertikal tersebut
                        children: <Widget>[
                          //menampilkan variabel menggunakan widget text
                          Text(this.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(this.description),
                          Text(
                            "Price: " + this.price.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                          //menampilkan widget icon  dibungkus dengan row
                          Row(
                            children: <Widget>[
                              Row(
                                children: children,
                              )
                            ],
                          )
                        ],
                      )))
            ])));
  }
}
