import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> stocks = [
    {"id": 0, "name": "Apple", "price": 100, "gain": -1.25, "ticker": "APPL"},
    {"id": 1, "name": "Google", "price": 100, "gain": -1.25, "ticker": "GOOGL"},
    {
      "id": 2,
      "name": "Microsoft",
      "price": 100,
      "gain": -1.25,
      "ticker": "MSFT"
    },
    {"id": 3, "name": "Tesla", "price": 100, "gain": -1.25, "ticker": "TSLA"},
    {"id": 4, "name": "Amazon", "price": 100, "gain": -1.25, "ticker": "AMZN"},
    {"id": 5, "name": "Wendys", "price": 100, "gain": -1.25, "ticker": "WEN"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 75, 20, 0),
              child: Text("Welcome! ",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: stocks.length,
                    itemBuilder: (context, index) =>
                        buildStockCard(context, index))),
          ],
        ));
  }

  Widget buildStockCard(BuildContext context, int idx) {
    return Container(
        child: Card(
            child: Column(
      children: <Widget>[
        Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 60, top: 20),
                  child: Text(stocks[idx]["name"],
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                )),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 40, top: 20),
                        child: Text(
                            "(NASDAQ: ${stocks[idx]["ticker"].toString()})")))
              ],
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: Text("\$ ${stocks[idx]["price"]}",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )),
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: Text("% ${stocks[idx]["gain"]}",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )),
            )
          ],
        ),
      ],
    )));
  }
}
