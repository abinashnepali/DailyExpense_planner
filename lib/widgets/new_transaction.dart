import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import 'adaptivebutton.dart';

class NewTransaction extends StatefulWidget {
  // TextEditingController() is constructor that directtly assigned value to
  final Function addTX;

  NewTransaction(this.addTX);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControl = TextEditingController();
  final _amountControl = TextEditingController();
  var _selectedDate;

  void _submitData() {
    final enteredTitle = _titleControl.text;
    if (_amountControl.text.isEmpty) return;
    final enteredAmount = double.parse(_amountControl.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTX(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    var currentyear = DateTime.now().year;
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(currentyear),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (value) {
                //   titleInput = value;
                // },
                controller: _titleControl,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,

                // onChanged: (val) => amountInput = val,
                controller: _amountControl,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Choosen'
                            : 'Pick Date: ${DateFormat().add_yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                //textColor: Theme.of(context).textTheme.button.Colors.,
                textColor: Theme.of(context).buttonColor,

                onPressed: _submitData,
                // onPressed: () {?
                //   // print(titleInput);
                //   // print(amountInput);
                //   // print(titleControl.text);
                //   // print(amountControl.text);

                //   widget.addTX(
                //     titleControl.text,
                //     double.parse(amountControl.text),
                //   );
                // }
              )
            ],
          ),
        ),
      ),
    );
  }
}
