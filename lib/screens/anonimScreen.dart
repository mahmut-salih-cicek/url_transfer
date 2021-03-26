import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_transfer/screens/noteScreen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  double height, width;
  String qrString = "";
  bool check = false;
  Random randomMail = Random();
  Random randomPass = Random();
  final FirebaseAuth _auth = FirebaseAuth.instance;





  @override
  Widget build(BuildContext context) {
            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  
    int randomNumberEmail = randomMail.nextInt(999999999);
    int randomNumberPass = randomMail.nextInt(999999999);
    String emailVePass = "$randomNumberEmail@gmail.com$randomNumberPass";
    var   mail =  "$randomNumberEmail@gmail.com";
    var pass = "$randomNumberPass";


    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;

    @override
    void initState() {
      super.initState();
      if (UniversalPlatform.isWeb) {

      }
    }

    return Scaffold(
      appBar: AppBar(
        
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("QR Login ", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[300],
      fontWeight: FontWeight.w800,fontSize: 21,
      fontFamily: 'Open Sans',
        ),
        ),
        centerTitle: true,
        backgroundColor:  Color.fromARGB(255, 73, 79, 88),
      ),
      backgroundColor: Color.fromARGB(255, 251, 172, 71),
      body: Stack(

        children: [

          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: BackgroundPaint(),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: CustomPaint(
                  painter: BackgroundPaint2(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ))),



          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 0,),

              /// IS ANDROID
              SizedBox(height: 30,),
              CardLinkText(),
              SizedBox(height: 40),
              ScanQrButton(check),
              //LoginForAndroidButton(qrString),



              /// IS WEB ///
              QrGenarator(emailVePass),
              SizedBox(height: 40,),
              LoginForWebButton(emailVePass),





             
              SizedBox(width: width),

            ],

          ),




        ],

      ),
    );
  }




///// CARD ANDROİD !!!!
  Widget CardLinkText() {
    if (UniversalPlatform.isAndroid) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 80,),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 20.0),

          /// kartı içeri dogru ıttırdık !!!
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.black,
          elevation: 10,
          //color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13,),
            child: SingleChildScrollView(
              child: Container(

                child: Column(

                  
                  children: [

                    // Padding(padding: EdgeInsets.symmetric(horizontal:180)),
                    /// birinci textFromField
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,),
                        children: <TextSpan>[
                          TextSpan(text: 'Now Go To Web And Scan Qr',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),


                    FlatButton(
                      onPressed: () {
                        FlutterClipboard.copy('https://link-from.web.app/');

                        ///launch("https://link-to.web.app/"); /// linki buraya koy
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 22),
                              text: "https://link-from.web.app"
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),

      );
    } else {
      return SizedBox(height: 0,);
    }
  }


  /// QR IMAGE GENERATOR ///
  Widget QrGenarator(String emailVePass) {
    if (UniversalPlatform.isWeb) {
      return QrImage(
        data: "$emailVePass",
        version: QrVersions.auto,
        size: 210.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      );
    } else {
      return SizedBox(height: 0,);
    }
  }

  


  /// QR SCAN METHOD For android
  Future<void> scanQR() async {
    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "Cancel", true, ScanMode.QR)
          .then((value) {
        setState(() async {
          qrString = value;
          check = true;
         await  _auth.createUserWithEmailAndPassword(
            email: qrString,
            password: qrString,
          ).then((_) =>  _auth.signInWithEmailAndPassword(email: qrString, password: qrString)).then((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NoteScreen()))
          );

        });
      });
    } catch (e) {
      setState(() {
        qrString = "unable to read the qr";
      });
    }
  }

///android Scan Qr !!
  Widget ScanQrButton(bool check) {
    if (UniversalPlatform.isAndroid) {
      return SizedBox(
        height: 42,
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green[700],
          ),
          onPressed: () {
            scanQR();
            check = true;
          },
          child: Text("Scan QR Code",
          style: TextStyle(
              fontSize: 15,
          ),
          ),
        ),
      );
    }else {
      return SizedBox(height: 0,);
    }

  }














  /// WEB LOGİN ///
  Widget LoginForWebButton(String emailVePass){
    if(UniversalPlatform.isWeb){
      return SizedBox(
  width: 200,
  height: 40, // <-- Your width
  child:  ElevatedButton(
        child: Text("Login"),
        onPressed: ()async{
      final userCredential =    await _auth.signInWithEmailAndPassword(
             email: emailVePass,
             password:  emailVePass,
         )
      .then((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NoteScreen()))

      );
      ///print("KAYIT BURDA EDİLİYOR $mail ,, $pass");
      }
      ),
);


    }else{
      return SizedBox(height: 0,);
    }

  }




  /*
  *
  *
  *   /// ANDROİD LOGİN ///
  Widget LoginForAndroidButton(String qrString){
    if(UniversalPlatform.isAndroid && check == true ){
      return ElevatedButton(
          child: Text("Login"),
          onPressed: ()async{
            final userCredential =    await  _auth.signInWithEmailAndPassword(
              email: qrString,
              password: qrString,
            ).then((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NoteScreen()))

            );
            print("KAYIT BURDA EDİLİYOR ");
          }
      );

    }else{
      return Text("An error occurred");
    }

  }
  * */






}




///Themelar
class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    Path path = Path();
    paint.color =  Color.fromARGB(255, 73, 79, 88);

    /// parabol özellikleri !!!
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(0 * _xScaling,0 * _yScaling);
    path.cubicTo(0 * _xScaling,0 * _yScaling,81.046 * _xScaling,589.626 * _yScaling,415.2 * _xScaling,707.015 * _yScaling,);
    path.cubicTo(749.3539999999999 * _xScaling,824.404 * _yScaling,415.2 * _xScaling,-2.3050000000000637 * _yScaling,415.2 * _xScaling,-2.3050000000000637 * _yScaling,);
    path.cubicTo(415.2 * _xScaling,-2.3050000000000637 * _yScaling,0 * _xScaling,0 * _yScaling,0 * _xScaling,0 * _yScaling,);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class BackgroundPaint2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    Path path = Path();
    paint.color = Color.fromARGB(255, 84, 190, 229);

    /// parabol özellikleri !!!
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(0 * _xScaling,11.233 * _yScaling);
    path.cubicTo(0 * _xScaling,11.233 * _yScaling,62.846 * _xScaling,332.467 * _yScaling,170.147 * _xScaling,486.679 * _yScaling,);
    path.cubicTo(207.81 * _xScaling,540.807 * _yScaling,140.755 * _xScaling,812.633 * _yScaling,0 * _xScaling,887.191 * _yScaling,);
    path.cubicTo(-52.093 * _xScaling,1194.891 * _yScaling,1.685 * _xScaling,1468.752 * _yScaling,0 * _xScaling,894.875 * _yScaling,);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}