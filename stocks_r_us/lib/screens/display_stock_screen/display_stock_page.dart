import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../stockData.dart';
import 'getStockData.dart';

class DisplayStockScreen extends StatefulWidget {
  final int stockId;
  final String stockName;
  final String stockTicker;

  const DisplayStockScreen(
      {Key? key,
      required this.stockId,
      required this.stockName,
      required this.stockTicker})
      : super(key: key);

  @override
  _DisplayStockScreenState createState() => _DisplayStockScreenState();
}

class _DisplayStockScreenState extends State<DisplayStockScreen> {
  StockData? data;

  @override
  void initState() {
    getStockData(widget.stockTicker).then((result) {
      setState(() {
        data = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Stock Info"),
        ),
        body: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Info"),
      ),
      body: Column(children: [
        Row(
          children: [
            Image.network(data!.logoLink.toString()),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(widget.stockName,
                  style: GoogleFonts.poppins(
                      fontSize: 30, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Company Info:",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text("Sector",
                                  style: TextStyle(fontSize: 18))),
                          Expanded(
                              child: Text(
                            data!.sector,
                            style: TextStyle(fontSize: 18),
                          ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Stock Price Info:",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("Current Price:",
                                    style: TextStyle(fontSize: 18))),
                            Expanded(
                                child: Text(
                              data!.currentPrice.toString(),
                              style: TextStyle(fontSize: 18),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("Open Price:",
                                    style: TextStyle(fontSize: 18))),
                            Expanded(
                                child: Text(
                              data!.openPrice.toString(),
                              style: TextStyle(fontSize: 18),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("Day High:",
                                    style: TextStyle(fontSize: 18))),
                            Expanded(
                                child: Text(
                              data!.dayHigh.toString(),
                              style: TextStyle(fontSize: 18),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("Day Low:",
                                    style: TextStyle(fontSize: 18))),
                            Expanded(
                                child: Text(
                              data!.dayLow.toString(),
                              style: TextStyle(fontSize: 18),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))
      ]),
    );
  }
}
