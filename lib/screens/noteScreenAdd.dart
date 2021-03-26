import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_transfer/screens/mainScreen.dart';

import 'noteScreen.dart';

class NoteScreenAdd extends StatefulWidget {
  @override
  _NoteScreenAddState createState() => _NoteScreenAddState();
}

class _NoteScreenAddState extends State<NoteScreenAdd> {
  final TextEditingController _Notetext = TextEditingController();
  final  _firebaseFirestore = FirebaseFirestore .instance;


  ///
  var firebaseUser = FirebaseAuth.instance.currentUser;/// new not save method
  ///


  @override
  Widget build(BuildContext context) {

  
    

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Note Add Screen", style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 14, horizontal: 200)),
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
                      maxLines: 18,
                      controller: _Notetext,
                      decoration: const InputDecoration(
                        labelText: "Click To Add Note",
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


        ],
      ),


        
        Positioned(
        left: MediaQuery.of(context).size.width / 2.3,
        bottom:  105,
        child: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        
        elevation: 12,
        onPressed: (){
          /// Note Screen add => gotur !!!!
         _saveNot();
        },
      ),
      ),
      



        ],
      ),
    );
  }

  void _saveNot() async{
    final user = await FirebaseAuth.instance.currentUser;
    var time = DateTime.now();//hashCode;
    if(_Notetext != null || _Notetext != ""){
      await FirebaseFirestore .instance.collection("notes").doc().set({
        "not":_Notetext.text,
        "uid": user.uid,
        "time": time
      });
      Navigator.pop(context, MaterialPageRoute(builder: (context)=> NoteScreen()));
     

      
    }



    ///

 ///  doc(firebaseUser.uid

  /// await _firebaseFirestore.collection("notes").add({"not":"${_Notetext.text}"});
  ///if(_Notetext.text != "" ){///nota bısey eklenmediyse noteScreen yonlendırme yapılmadı
  /// await Navigator.pop(context, MaterialPageRoute(builder: (context)=> NoteScreen()));



  }
  


  }
