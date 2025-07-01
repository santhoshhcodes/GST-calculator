import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Gst extends StatefulWidget {
  const Gst({super.key});

  @override
  State<Gst> createState() => _GstState();
}

class _GstState extends State<Gst> {
  TextEditingController ctrl1 = TextEditingController();
  TextEditingController ctrl2 = TextEditingController();
  double _gst = 0.0;
  double _total  =0.0;
  double _price =0.0;

   _calculateGSTEx() {
    final price = double.tryParse(ctrl1.text) ?? 0.0;
    final gst = double.tryParse(ctrl2.text) ?? 0.0;

    setState(() {
      _gst = (price * gst) / 100;
      _total = price + _gst;

    });

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 200,
            width: 350,
            child: Column(
              children: [
                Text("Exculsive tax",style: TextStyle(
                    color: Colors.red[600],
                    fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
                SizedBox(height: 50,),
                Text("Gst%  :  ${_gst.toStringAsFixed(2)}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Total  :  ${_total.toStringAsFixed(20)}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

              ],
            ),
          );

        }
    );
  }
  _calculateGSTIn() {
    final price = double.tryParse(ctrl1.text) ?? 0.0;
    final gst = double.tryParse(ctrl2.text) ?? 0.0;

    setState(() {
      _gst = price * 100 / (100 + gst);
      _price = price - _gst;
      _total = price;

    });

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            padding: EdgeInsets.all(20),
            height: 200,
            width: 350,
            child: Column(
              children: [

                Text("Inclusive tax",style: TextStyle(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),
                SizedBox(height: 20,),
                Text("Gst%  :  ${_price.toStringAsFixed(2)}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Amount  :  ${_gst.toStringAsFixed(2)}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Total  :  $_total",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),



              ],
            ),
          );
        },
    );

  }



  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios),
        title: Text("Gst Calculator",style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.settings_outlined,color: Colors.black,),
          )
        ],

      ),
      body: Form(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(height: 150,),
                Center(
                  child: Container(
                    height: 230,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: ctrl1,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(RegExp('[a-z,A_Z,[@#!%^&*();:/*-+]')),
                            ],
                            decoration: InputDecoration(
                              hintText: "calculate the Gst",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  TextFormField(
                            controller: ctrl2,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny(RegExp('[a-z,A_Z,[@#!%^&*();:/*-+]')),
                            ],
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.percent),
                              hintText: "Enter Gst rate",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            ElevatedButton(onPressed: _calculateGSTEx,
                             child: Text("Exclusive")),
                            ElevatedButton(onPressed: _calculateGSTIn,
                                child: Text("Inclusive")),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),



    );
  }
}

