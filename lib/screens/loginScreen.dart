import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_transfer/screens/noteScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  ///firabase main eklemeyi unutma!!
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _editText1 = TextEditingController();
  final TextEditingController _editText2 = TextEditingController();
  ///final Future<String> _anon = FirebaseAuth.instance.
  //final sign_anon = FirebaseAuth.instance.signInWithCredential();


  @override
  Widget build(BuildContext context) {

     


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text("Welcome Back", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[800],
      fontWeight: FontWeight.w800,fontSize: 21,
      fontFamily: 'Open Sans',
        ),
        ),
        centerTitle: true,
        backgroundColor:  Color.fromARGB(255, 251, 172, 71),
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
            ///key: _formKey,
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
                          controller: _editText1,
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
                          controller: _editText2,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                        ),

                        SizedBox(height: 40,),

                        SignInButtonBuilder(
                          elevation: 15,
                          height: 45,
                          width: 280,
                          icon: Icons.login_rounded,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          backgroundColor: Colors.deepPurple[800],
                          text: "Login ",
                          fontSize: 15,
                          onPressed: () async {
                            _LoginMail();
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 70),
              /// google Sign in here !!

            ],
          ),


        ],
      ),
    );
  }

  void _LoginMail() async{
   final  userCredential = await _auth.signInWithEmailAndPassword(
        email: _editText1.text ,
        password: _editText2.text,
    );

   final user = userCredential.user;
   if(user !=null){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NoteScreen()));
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
    path.lineTo(0 * _xScaling,0 * _yScaling);
    path.cubicTo(0 * _xScaling,0 * _yScaling,0 * _xScaling,401.272 * _yScaling,0 * _xScaling,401.272 * _yScaling,);
    path.cubicTo(0 * _xScaling,401.272 * _yScaling,82.318 * _xScaling,69.441 * _yScaling,413.987 * _xScaling,60.881 * _yScaling,);
    path.cubicTo(745.6560000000001 * _xScaling,52.321 * _yScaling,413.987 * _xScaling,-2.8770000000000024 * _yScaling,413.987 * _xScaling,-2.8770000000000024 * _yScaling,);
    path.cubicTo(413.987 * _xScaling,-2.8770000000000024 * _yScaling,0 * _xScaling,0 * _yScaling,0 * _xScaling,0 * _yScaling,);
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
    path.lineTo(414 * _xScaling,896 * _yScaling);
    path.cubicTo(414 * _xScaling,896 * _yScaling,414 * _xScaling,239.764 * _yScaling,414 * _xScaling,239.764 * _yScaling,);
    path.cubicTo(414 * _xScaling,239.764 * _yScaling,459.543 * _xScaling,755.93 * _yScaling,4.7 * _xScaling,896 * _yScaling,);
    path.cubicTo(-450.14300000000003 * _xScaling,1036.0700000000002 * _yScaling,414 * _xScaling,896 * _yScaling,414 * _xScaling,896 * _yScaling,);
    path.cubicTo(414 * _xScaling,896 * _yScaling,414 * _xScaling,896 * _yScaling,414 * _xScaling,896 * _yScaling,);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}





