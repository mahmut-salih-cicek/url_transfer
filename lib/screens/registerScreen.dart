import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_transfer/screens/mainScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  bool _success = null;
  String _message = "hatalı deger";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text("Create Account", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[800],
      fontWeight: FontWeight.w800,fontSize: 21,
      fontFamily: 'Open Sans',
        ),
        ),
        centerTitle: true,
        backgroundColor:  Color.fromARGB(255, 84, 190, 229),
      ),

      backgroundColor: Color.fromARGB(255, 73, 79, 88),
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
            key: _formKey,
            ///valide etme işlemi
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 60, horizontal: 200)),
              Card(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),

                /// kartı içeri dogru ıttırdık !!!
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                shadowColor: Colors.black,
                elevation: 10,
                //color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// birinci textFromField
                        TextFormField(
                          controller: _textEditingController1,
                          decoration: const InputDecoration(
                            labelText: "E-Mail",
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),

                        /// ikinci textFromField
                        TextFormField(
                          controller: _textEditingController2,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 70),
              SignInButtonBuilder(
                elevation: 15,
                height: 45,
                width: 280,
                icon: Icons.login_rounded,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                backgroundColor: Colors.deepPurple[500],
                text: "Register",
                fontSize: 15,
                onPressed: () async {
                  _register(_success);

                },
              ),
            ],
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    //! Widget kapatıldığında controllerları temizle
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    super.dispose();
  }

  ///giris method
  _register(bool success) async {

    final  userCredential =
        await _auth.createUserWithEmailAndPassword(
            email: _textEditingController1.text,
            password: _textEditingController2.text);

    final user = userCredential.user;
    if (user != null) {

      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    }


  }
}




///Themelar
class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    Path path = Path();
    paint.color = Color.fromARGB(255, 251, 172, 71);

    /// parabol özellikleri !!!
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(0 * _xScaling,673.95 * _yScaling);
    path.cubicTo(0 * _xScaling,673.95 * _yScaling,96.489 * _xScaling,565.263 * _yScaling,136.433 * _xScaling,583.341 * _yScaling,);
    path.cubicTo(176.37699999999998 * _xScaling,601.419 * _yScaling,171.515 * _xScaling,626.315 * _yScaling,205.356 * _xScaling,685.7860000000001 * _yScaling,);
    path.cubicTo(239.197 * _xScaling,745.2570000000001 * _yScaling,274.677 * _xScaling,718.499 * _yScaling,412.711 * _xScaling,661.62 * _yScaling,);
    path.cubicTo(550.745 * _xScaling,604.741 * _yScaling,412.711 * _xScaling,906.6320000000001 * _yScaling,412.711 * _xScaling,906.6320000000001 * _yScaling,);
    path.cubicTo(412.711 * _xScaling,906.6320000000001 * _yScaling,0 * _xScaling,906.52 * _yScaling,0 * _xScaling,906.52 * _yScaling,);
    path.cubicTo(0 * _xScaling,906.52 * _yScaling,0 * _xScaling,673.95 * _yScaling,0 * _xScaling,673.95 * _yScaling,);
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
    path.lineTo(0 * _xScaling,-0.133 * _yScaling);
    path.cubicTo(0 * _xScaling,-0.133 * _yScaling,0 * _xScaling,201.84699999999998 * _yScaling,0 * _xScaling,201.84699999999998 * _yScaling,);
    path.cubicTo(0 * _xScaling,201.84699999999998 * _yScaling,213.627 * _xScaling,44.41499999999999 * _yScaling,413.238 * _xScaling,201.84699999999998 * _yScaling,);
    path.cubicTo(612.8489999999999 * _xScaling,359.279 * _yScaling,413.238 * _xScaling,-0.4530000000000314 * _yScaling,413.238 * _xScaling,-0.4530000000000314 * _yScaling,);
    path.cubicTo(413.238 * _xScaling,-0.4530000000000314 * _yScaling,0 * _xScaling,-0.133 * _yScaling,0 * _xScaling,-0.133 * _yScaling,);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}


