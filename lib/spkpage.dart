import 'package:flutter/material.dart';
import 'package:paudspk/main.dart';

class SpkpageWidget extends StatefulWidget {
  const SpkpageWidget({super.key});

  @override
  State<SpkpageWidget> createState() => _SpkpageWidgetState();
}

class _SpkpageWidgetState extends State<SpkpageWidget> {
  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int halaman = 1;

  List<Map<String, dynamic>> Criteria = [
    {
      'Name': 'Luas',
      'Bobot': 5,
      'Sort': 'High',
    },
    {
      'Name': 'Jumlah Staff',
      'Bobot': 4,
      'Sort': 'High',
    },
    {
      'Name': 'Keamanan',
      'Bobot': 8,
      'Sort': 'High',
    },
  ];

  List<Map<String, dynamic>> SAW = [
    // {
    //   'Name': 'Tunas Bangsa ',
    //   'Luas': 21,
    //   'Jumlah Staff': 16,
    //   'Keamanan': 7,
    // },
    // {
    //   'Name': 'Bunda Hati ',
    //   'Luas': 19,
    //   'Jumlah Staff': 10,
    //   'Keamanan': 6,
    // },
    // {
    //   'Name': 'Cahaya Kecil',
    //   'Luas': 12,
    //   'Jumlah Staff': 24,
    //   'Keamanan': 3,
    // },
  ];

  List<Map<String, dynamic>> Hasil = [];

  void tambah_kriteria(String Name, int Bobot, String Sort) async {
    final nomor = Criteria.indexWhere((entry) => entry['Name'] == Name);

    if (nomor != -1) {
      setState(() {
        Criteria[nomor]['Bobot'] = Bobot;
        Criteria[nomor]['Sort'] = Sort;
      });
    } else {
      setState(() {
        Map<String, dynamic> kriteria_baru = {
          'Name': Name,
          'Bobot': Bobot,
          'Sort': Sort,
        };
        Criteria.add(kriteria_baru);
        for (var entry in SAW) {
          entry[Name] = 10;
        }
      });
    }
  }

  void hapus_kriteria(String Name) async {
    setState(() {
      for (var entry in SAW) {
        entry.remove(Name);
      }
      Criteria.removeWhere((entry) => entry['Name'] == Name);
    });
  }

  void tambah_alternatif(List<String> data) async {
    final existingIndex = SAW.indexWhere((entry) => entry['Name'] == data[0]);

    if (existingIndex != -1) {
      setState(() {
        for (var i = 0; i < Criteria.length; i++) {
          final Nama = Criteria[i]['Name'];
          SAW[existingIndex][Nama] = int.parse(data[i + 1]);
        }
      });
    } else {
      Map<String, dynamic> alternatif_baru = {'Name': data[0]};

      for (var i = 0; i < Criteria.length; i++) {
        final Nama = Criteria[i]['Name'];
        alternatif_baru[Nama] = 1;
      }
      setState(() {
        SAW.add(alternatif_baru);
      });
    }
  }

  void hapus_alternatif(String Nama) async {
    setState(() {
      SAW.removeWhere((entry) => entry['Name'] == Nama);
    });
  }

  void Cari_Terbaik() {
    List<Map<String, dynamic>> Nilai = SAW;

    //
    for (var criterion in Criteria) {
      String criterionName = criterion['Name'];

      int Nilai_Terendah = SAW[0][criterionName];
      int Nilai_Tertinggi = SAW[0][criterionName];

      // Cari nilai terendah dan tertinggi
      print(SAW);
      for (var alternative in SAW) {
        int Nilai_Sekarang = alternative[criterionName];
        Nilai_Terendah =
            Nilai_Sekarang < Nilai_Terendah ? Nilai_Sekarang : Nilai_Terendah;
        Nilai_Tertinggi =
            Nilai_Sekarang > Nilai_Tertinggi ? Nilai_Sekarang : Nilai_Tertinggi;
      }

      for (var alternative in SAW) {
        final Indexs =
            Nilai.indexWhere((entry) => entry['Name'] == alternative['Name']);
        if (criterion['Sort'] == "Low") {
          Nilai[Indexs][criterionName] =
              (Nilai_Terendah / alternative[criterionName]) *
                  criterion['Bobot'];
          // print(
          //     "Nilai[${alternative['Name']}][${criterionName}] = (${Nilai_Terendah} / ${alternative[criterionName]}) * ${criterion['Bobot']};");
        } else {
          Nilai[Indexs][criterionName] =
              (alternative[criterionName] / Nilai_Tertinggi) *
                  criterion['Bobot'];
          // print(
          //     "Nilai[${alternative['Name']}][${criterionName}] = (${alternative[criterionName]} / ${Nilai_Tertinggi}) * ${criterion['Bobot']};");
        }
      }
    }

    for (var entry in Nilai) {
      final name = entry['Name'];
      final sum = entry.values.whereType<double>().reduce((a, b) => a + b);
      entry['Score'] = sum;
      print('$name Score: $sum');
    }

    Nilai.sort((a, b) => b['Score'].compareTo(a['Score']));
    setState(() {
      Hasil = Nilai;
    });

    print(Nilai);
  }

  @override
  void initState() {
    super.initState();

    textController1 ??= TextEditingController();
    textFieldFocusNode1 ??= FocusNode();

    textController2 ??= TextEditingController();
    textFieldFocusNode2 ??= FocusNode();

    textController3 ??= TextEditingController();
    textFieldFocusNode3 ??= FocusNode();

    textController4 ??= TextEditingController();
    textFieldFocusNode4 ??= FocusNode();

    textController5 ??= TextEditingController();
    textFieldFocusNode5 ??= FocusNode();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    textFieldFocusNode5?.dispose();
    textController5?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (halaman == 1)
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, -1),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: Text(
                                  'Daftar Paud',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF14181B),
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 5, 15, 5),
                                    child: TextFormField(
                                      controller: textController1,
                                      focusNode: textFieldFocusNode1,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: false,
                                        labelText: 'Daftarkan paud',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF57636C),
                                          letterSpacing: 0,
                                        ),
                                        hintStyle: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Color(0xFF57636C),
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF39d2c0),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                15, 0, 15, 0),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF14181B),
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1, 1),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 15, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (textController1!.text.isNotEmpty) {
                                          tambah_alternatif(
                                              [textController1!.text]);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF39d2c0),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0,
                                                2,
                                              ),
                                              spreadRadius: 2,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15, 8, 15, 8),
                                          child: Text(
                                            'Tambah',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Colors.white,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            for (int i = 0; i < SAW.length; i++)
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 15, 15),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1, 0),
                                          child: GestureDetector(
                                            onDoubleTap: () {
                                              hapus_alternatif(SAW[i]['Name']);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all(
                                                  color: Color(0x33000000),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 5, 10, 5),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      SAW[i]['Name'],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF14181B),
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 15, 15),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      halaman = 2;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF39d2c0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x33000000),
                                          offset: Offset(
                                            0,
                                            2,
                                          ),
                                          spreadRadius: 2,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 8, 15, 8),
                                      child: Text(
                                        'Selanjutnya',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                          fontSize: 16,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (halaman == 2)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: Color(0xFFffffff),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Text(
                                'Kriteria Paud',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xFF14181B),
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  child: TextFormField(
                                    controller: textController2,
                                    focusNode: textFieldFocusNode2,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: false,
                                      labelText: 'Kriteria',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF57636C),
                                        letterSpacing: 0,
                                      ),
                                      hintStyle: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF57636C),
                                        letterSpacing: 0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF39d2c0),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              15, 0, 15, 0),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF14181B),
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  child: TextFormField(
                                    controller: textController3,
                                    focusNode: textFieldFocusNode3,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: false,
                                      labelText: 'Bobot',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF57636C),
                                        letterSpacing: 0,
                                      ),
                                      hintStyle: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF57636C),
                                        letterSpacing: 0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF39d2c0),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              15, 0, 15, 0),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF14181B),
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(1, 1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                              child: GestureDetector(
                                onTap: () {
                                  if (textController2!.text.isNotEmpty &&
                                      textController3!.text.isNotEmpty) {
                                    tambah_kriteria(
                                        textController2!.text,
                                        int.parse(textController3!.text),
                                        "High");
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF39d2c0),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          0,
                                          2,
                                        ),
                                        spreadRadius: 2,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 8, 15, 8),
                                    child: Text(
                                      'Tambah',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    for (int i = 0; i < Criteria.length; i++)
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: GestureDetector(
                                          onDoubleTap: () {
                                            hapus_kriteria(Criteria[i]['Name']);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              border: Border.all(
                                                color: Color(0x33000000),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 5, 10, 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Kriteria : ${Criteria[i]['Name']}\nBobot : ${Criteria[i]['Bobot']}',
                                                    style: TextStyle(
                                                      fontFamily: 'Readex Pro',
                                                      color: Color(0xFF14181B),
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 15, 15),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    halaman = 3;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF39d2c0),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          0,
                                          2,
                                        ),
                                        spreadRadius: 2,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 8, 15, 8),
                                    child: Text(
                                      'Selanjutnya',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (halaman == 3)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Text(
                                'Isi Nilai Paud',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xFF14181B),
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1, -1),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0; i < SAW.length; i++)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 5, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, -1),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 12, 0, 0),
                                              child: Text(
                                                SAW[i]['Name'],
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF14181B),
                                                  fontSize: 16,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          for (int u = 0;
                                              u < Criteria.length;
                                              u++)
                                            Container(
                                              width: 150,
                                              decoration: BoxDecoration(),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 5, 0, 5),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value.isNotEmpty) {
                                                      SAW[i][Criteria[u]
                                                              ['Name']] =
                                                          int.parse(value);
                                                    }
                                                  },
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    labelText: Criteria[u]
                                                        ['Name'],
                                                    labelStyle: TextStyle(
                                                      fontFamily: 'Open Sans',
                                                      color: Color(0xFF57636C),
                                                      letterSpacing: 0,
                                                    ),
                                                    hintStyle: TextStyle(
                                                      fontFamily: 'Readex Pro',
                                                      color: Color(0xFF57636C),
                                                      letterSpacing: 0,
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFE0E3E7),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFF39d2c0),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFFF5963),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFFF5963),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15, 0, 15, 0),
                                                  ),
                                                  style: TextStyle(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF14181B),
                                                    letterSpacing: 0,
                                                  ),
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 15, 15),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    halaman = 4;
                                  });
                                  Cari_Terbaik();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF39d2c0),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          0,
                                          2,
                                        ),
                                        spreadRadius: 2,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 8, 15, 8),
                                    child: Text(
                                      'Selanjutnya',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (halaman == 4)
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              'Metode SAW',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xFF14181B),
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        for (int i = 0; i < Hasil.length; i++)
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 12, 0, 15),
                              child: Text(
                                "${i + 1}. ${Hasil[i]['Name']} memperoleh nilai ${Hasil[i]['Score']}.",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xFF14181B),
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        Align(
                          alignment: AlignmentDirectional(1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 15, 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyHomePage(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF39d2c0),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x33000000),
                                      offset: Offset(
                                        0,
                                        2,
                                      ),
                                      spreadRadius: 2,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 8, 15, 8),
                                  child: Text(
                                    'Ulangi',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
