import 'package:flutter/material.dart';
import 'sqflite_iqbal.dart';
import 'model/kontak.dart';

class FormKontak extends StatefulWidget {
  final KontakApp? kontak;

  FormKontak({this.kontak});

  @override
  _FormKontakState createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  DbIqbal db = DbIqbal();

  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? mobileNo;
  TextEditingController? email;
  TextEditingController? company;
  TextEditingController? alamat;

  @override
  void initState() {
    name = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.name);

    mobileNo = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.mobileNo);

    email = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.email);

    company = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.company);

    alamat = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.alamat);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 179, 6, 29),
        title: Text('Edit Kontak'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: mobileNo,
              decoration: InputDecoration(
                  labelText: 'Nomer Telp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: company,
              decoration: InputDecoration(
                  labelText: 'Instansi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: alamat,
              decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 179, 6, 29),
              ),
              child: (widget.kontak == null)
                  ? Text(
                      'Tambahkan',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Ubah',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertKontak();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
      //update
      await db.updateKontak(KontakApp.fromMap({
        'id': widget.kontak!.id,
        'name': name!.text,
        'mobileNo': mobileNo!.text,
        'email': email!.text,
        'company': company!.text,
        'alamat': alamat!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      print("masuk");
      await db.saveKontak(KontakApp(
          name: name!.text,
          mobileNo: mobileNo!.text,
          email: email!.text,
          company: company!.text,
          alamat: alamat!.text));
      Navigator.pop(context, 'save');
    }
  }
}
