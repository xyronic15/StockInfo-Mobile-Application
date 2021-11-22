import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stocks_r_us/screens/home_screen/init.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> favStocks = [];

  @override
  void initState() {
    print(widget.username);
    getFavourites(widget.username).then((result) {
      favStocks = result;
    });
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
            Expanded(child: buildList())
          ],
        ));
  }

  Widget buildList() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        return ListView.builder(
            padding: EdgeInsets.only(left: 30, right: 30),
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: favStocks.length,
            itemBuilder: (context, index) => buildStockCard(context, index));
      },
      future: getFavourites(widget.username),
    );
  }

  Widget buildStockCard(BuildContext context, int idx) {
    return Container(
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.green, width: 3)),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 60, top: 20),
                          child: Text(favStocks[idx].name,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 60, top: 10, bottom: 20),
                                child: Text(
                                    "(NASDAQ: ${favStocks[idx].ticker.toString()})")))
                      ],
                    )
                  ],
                ),
              ],
            )));
  }
}
