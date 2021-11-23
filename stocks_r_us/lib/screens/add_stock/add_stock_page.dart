import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:stocks_r_us/screens/add_stock/getStock.dart';
import 'package:stocks_r_us/screens/home_screen/home_page.dart';
import '../../Stock.dart';

class AddStockScreen extends StatefulWidget {
  final String username;
  const AddStockScreen({Key? key, required this.username}) : super(key: key);

  @override
  _AddStockScreenState createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  List<dynamic> stocks = [];
  List<dynamic> filteredStocks = [];

  @override
  void initState() {
    super.initState();
    getAllStocks().then((result) {
      setState(() {
        stocks = result;
        filteredStocks = stocks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Stock"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Enter Stock Name Here",
                ),
                onChanged: (string) {
                  setState(() {
                    filteredStocks = stocks
                        .where((stock) => (stock.name
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            stock.ticker
                                .toString()
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                        .toList();
                  });
                },
              ),
            ),
            Expanded(child: buildList())
          ],
        ));
  }

  Widget buildList() {
    return ListView.builder(
        padding: EdgeInsets.only(left: 30, right: 30),
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: filteredStocks.length,
        itemBuilder: (context, index) => GestureDetector(
            child: buildStockCard(context, index),
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text(
                          "Do you want to add ${filteredStocks[index].name} to your favorites?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              addFavourite(
                                      widget.username, filteredStocks[index].id)
                                  .then((value) {
                                if (value.statusCode == 400) {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text("Error adding stock"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text("Okay"))
                                            ],
                                          ));
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(username: widget.username)));
                                }
                              });
                            },
                            child: Text('Add'))
                      ],
                    ))));
  }

  Widget buildStockCard(BuildContext context, int idx) {
    return Card(
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
                    child: Text(filteredStocks[idx].name,
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
                          padding:
                              EdgeInsets.only(left: 60, top: 10, bottom: 20),
                          child: Text(
                              "(NASDAQ: ${filteredStocks[idx].ticker.toString()})")))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
