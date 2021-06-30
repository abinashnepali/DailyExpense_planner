import 'package:flutter/material.dart';

import 'package:expense_planner/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _usertransaction;
  final Function deleteTX;

  TransactionList(this._usertransaction, this.deleteTX);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _usertransaction.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transaction is added yet!!',
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 19,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                              child:
                                  Text('\$${_usertransaction[index].amount}')),
                        ),
                      ),
                      title: Text(
                        _usertransaction[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(_usertransaction[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width >
                              360 //terniry opertion
                          ? FlatButton.icon(
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              textColor: Theme.of(context).errorColor,
                              onPressed: () =>
                                  deleteTX(_usertransaction[index].id),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              color: Theme.of(context).errorColor,
                              onPressed: () =>
                                  deleteTX(_usertransaction[index].id),
                            ),
                    ),
                  );
                },
                itemCount: _usertransaction.length,
              ));
  }
}
