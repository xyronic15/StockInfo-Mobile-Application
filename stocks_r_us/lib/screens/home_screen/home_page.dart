import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stocks_r_us/screens/add_stock/add_stock_page.dart';
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
      print("RESULTS =====> $result");
      favStocks = result;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Welcome $widget.username"),
        ),
        body: Column(
          children: [
            Container(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 30, right: 30, bottom: 20),
                    child: GestureDetector(
                      child: Card(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.green, width: 3)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 60, top: 10, bottom: 10),
                                    child: Text(" + Add Stock",
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  )),
                                ],
                              ),
                            ],
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddStockScreen(username: widget.username)));
                      },
                    ))),
            Expanded(child: buildList())
          ],
        ));
  }

  Widget buildList() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        return ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
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
          elevation: 10,
          shadowColor: Colors.black,
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
          )),
    );
  }
}
