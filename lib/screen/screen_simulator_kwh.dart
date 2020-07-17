import 'package:flutter/material.dart';

class SimKwhScreen extends StatefulWidget {
  @override
  _SimKwhScreenState createState() => _SimKwhScreenState();
}

class _SimKwhScreenState extends State<SimKwhScreen> {
  var listElektronik = [];
  var totalDaya = 0.0;

  TextEditingController alatController = TextEditingController();
  TextEditingController dayaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  void _tambahData(String nama, int daya, int jumlah) {
    double va;

    va = _hitungVA(daya, jumlah);

    setState(() {
      listElektronik.add(
          {"namaAlat": nama, "daya": daya, "jumlah": jumlah, "jumlahVa": va});
      totalDaya = totalDaya + va;
    });
  }

  void _hapusData(int index) {
    double va;
    va = listElektronik[index]['jumlahVa'];
    setState(() {
      listElektronik.removeAt(index);
      totalDaya = totalDaya - va;
    });
  }

  double _hitungVA(int daya, int jumlah) {
    double hasil;
    hasil = (daya * jumlah) / 0.85;
    return hasil;
  }

  double _dayaPLN(double daya) {
    double d = 0.0;

    if (daya <= 450.0) {
      d = 450;
    } else if (daya > 450.0 && daya <= 900.0) {
      d = 900;
    } else if (daya > 900.0 && daya <= 1300.0) {
      d = 1300;
    } else if (daya > 1300.0 && daya <= 2200.0) {
      d = 2200;
    } else if (daya > 2200.0 && daya <= 3500.0) {
      d = 3500;
    } else if (daya > 3500.0 && daya <= 4400.0) {
      d = 4400;
    } else if (daya > 4400.0 && daya <= 5500.0) {
      d = 5500;
    }

    return d;
  }

  void _clearScreen() {
    setState(() {
      listElektronik.clear();
      alatController.clear();
      dayaController.clear();
      jumlahController.clear();
      totalDaya = 0.0;
    });
  }

  void _rekomendasiDaya(double daya) {
    var vaPLN;
    vaPLN = _dayaPLN(daya);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Rekomendasi daya PLN"),
            content: Text(
                "Total daya yang Anda butuhkan adalah ${daya.toStringAsFixed(0)} VA. \nAnda dapat berlangganan daya ${vaPLN.toStringAsFixed(0)} VA."),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _clearScreen();
                  },
                  child: Text("TUTUP"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(children: <Widget>[
        SingleChildScrollView(
          padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
          child: Column(children: <Widget>[
            TextFormField(
              controller: alatController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: "Alat elektronik",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: dayaController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: "Daya (Watt)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: jumlahController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: "Jumlah (Unit)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 3),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total kebutuhan daya : "),
                  Text(
                    "${totalDaya.toStringAsFixed(0)} VA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  MaterialButton(
                    color: Colors.orange[900],
                    child: Text(
                      "TAMBAH",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _tambahData(
                        alatController.text,
                        int.parse(dayaController.text),
                        int.parse(jumlahController.text)),
                  ),
                  MaterialButton(
                      minWidth: 10,
                      color: Colors.green[900],
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _rekomendasiDaya(totalDaya);
                      })
                ]),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listElektronik.length,
            itemBuilder: (context, pos) {
              return Card(
                  elevation: 3,
                  color: Colors.green[50],
                  child: ListTile(
                    title: Text(listElektronik[pos]['namaAlat']),
                    subtitle:
                        Text("Jumlah : ${listElektronik[pos]['jumlah']} unit"),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 39,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              color: Colors.blue[300]),
                          child: Center(
                            child: Text(
                              listElektronik[pos]['jumlahVa']
                                  .toStringAsFixed(0),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[400]),
                            onPressed: () => _hapusData(pos))
                      ],
                    ),
                  ));
            },
          ),
        )
      ]),
    );
  }
}
