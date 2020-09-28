import 'package:firstapp/main.dart';
import 'package:flutter/material.dart';
import 'transaction.dart';
import 'transactionList.dart';

class MyApp extends StatefulWidget {
  String name;
  int age;
  MyApp({this.name, this.age});
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Transaction _transaction = Transaction(content: '', amount: 0.0);

  List<Transaction> _transactions = List<Transaction>();

  @override
  void initState() {
    super.initState();
  }

  void _insertTransaction() {
    if (_transaction.content.isEmpty ||
        _transaction.amount == 0.0 ||
        _transaction.amount.isNaN) {
      return;
    }
    _transactions.add(_transaction);
    _transaction = Transaction(content: '', amount: 0.0);
    _contentController.text = '';
    _amountController.text = '';
  }

  void _onButtonShowModalSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Content'),
                  controller: _contentController,
                  onChanged: (text) {
                    setState(() {
                      _transaction.content = text;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  onChanged: (text) {
                    setState(() {
                      _transaction.amount = double.tryParse(text) ?? 0;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              this._insertTransaction();
                            });

                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(
                        child: SizedBox(
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () {
                          print('Cancel');
                        },
                      ),
                    )),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transaction manager'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  this._onButtonShowModalSheet();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add transaction',
          child: Icon(Icons.add),
          onPressed: () {
            this._onButtonShowModalSheet();
          },
        ),
        key: _scaffoldkey,
        body: SafeArea(
            minimum: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      onPressed: () {
                        this._onButtonShowModalSheet();

                        //display list
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'Transaction list: ' + _transactions.toString()),
                          duration: Duration(seconds: 3),
                        ));
                      },
                      child: Text(
                        'Insert',
                        style: TextStyle(fontSize: 18),
                      ),
                      color: Colors.pinkAccent,
                      textColor: Colors.white,
                    ),
                  ),
                  TransactionList(transactions: _transactions)
                ],
              ),
            )));
  }
}
