import 'package:firstapp/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({this.transactions});

  ListView _buildListView() {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: (index - 1) % 2 == 0 ? Colors.orange : Colors.teal,
            elevation: 10,
            child: ListTile(
              leading: const Icon(Icons.access_alarm),
              title: Text(
                transactions[index].content,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              subtitle: Text('Price: ${transactions[index].amount}',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              onTap: () {
                print('${transactions[index].content}');
              },
            ),
          );
        });
    int index = 0;
  }

  @override
  Widget build(BuildContext context) {
    //ListView(children: <Widget>[])
    //ListView(itemBuilder: ...) load only visible items
    return Container(height: 500, child: _buildListView());
  }
}
