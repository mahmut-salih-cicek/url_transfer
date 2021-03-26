

import 'dart:developer';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_transfer/screens/mainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_transfer/screens/noteScreenAdd.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final  firebaseUser =FirebaseAuth.instance.currentUser;
  final user =  FirebaseAuth.instance.currentUser;

 

  @override
  Widget build(BuildContext context) {


  
   
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text("Note Screen", style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,


        actions: [
          
          Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.exit_to_app_rounded),
                onPressed: () async{
                  await _auth.signOut();
                  ///gogle cıkıs buraya ekle
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                },

              )
          ),
        ],


      ),

      body: Stack(

        children: [

          

        Column(),


        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .orderBy("time", descending: true)
              .where("uid", isEqualTo: user.uid)
              .snapshots(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );

            else if(snapshot.hasError){
              return Center(
                child: Icon(Icons.error,color: Colors.red,size: 60,

                ),
              );
            }
            final user =  FirebaseAuth.instance.currentUser;
            final QuerySnapshot querySnapshot = snapshot.data;
            ///print("HATA BURDA OLABİLİRRRRRRRRRRRRRRRRRRRRRRRRRR:    "+user.uid);

            return  ListView.builder(
              padding: EdgeInsets.all(18),
              itemCount: snapshot.data.docs.length, /// bunu mutlaka unutma listenin boyutunu vericeksin!!
              itemBuilder: (context , index){

               /// print(" HATAAAAA BURDAAAAAAA ${querySnapshot.size}");
                final map = querySnapshot.docs[index].data();///querySnapshot.docs[index].data();
                DocumentSnapshot reservation = snapshot.data.docs[index];


                return Dismissible(
                  key: Key(querySnapshot.docs[index].id),
                  onDismissed: (direction)async{
                    await querySnapshot.docs[index].reference.delete();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 6,
                    
                    child: ListTile(
                         
                        title: Text(map["not"],
                        maxLines: 5,
                        ),
                        onTap: (){
                         var x3 =  map["not"];
                         FlutterClipboard.copy('$x3');
                         launchURL(x3);


                        }
                    ),

                  ),
                );
              },
            );


          }
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteScreenAdd()));
        },
      ),
      ),
      
     


        ],

      ),
      );

  }

   static Stream<QuerySnapshot> getData()async*{
    final user = await FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('notes').doc(user.uid).snapshots();

   /// final xmod = await FirebaseFirestore.instance.collection("notes").doc(user.uid).get().then((value) => print("DATALAR BURDA OLMASI LAZIMM ${value.data}") );




    }


  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }







}
