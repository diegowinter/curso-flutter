import 'package:flutter/material.dart';
import 'adaptative_datepicker.dart';
import 'adaptative_button.dart';
import 'adaptative_textfield.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }  

  @override
  Widget build(BuildContext context) {
    //final node = FocusScope.of(context);
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AdaptativeTextField(
              controller: _titleController,
              //onEditingComplete: () => node.nextFocus(),
              onSubmitted:  _submitForm(),
              label: 'Título',
            ),
            AdaptativeTextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: _submitForm(),
              label: 'Valor (R\$)'
            ),
            AdaptativeDatePicker(
              selectedDate: _selectedDate,
              onDateChanged: (newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton(
                  label: 'Adicionar transação',
                  onPressed: _submitForm,
                )
                // ElevatedButton(
                //   child: Text('Adicionar transação'),
                //   onPressed: _submitForm,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
