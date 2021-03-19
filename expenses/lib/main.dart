import 'dart:math';
import 'dart:io';

import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Para definir uma orientação fixa para a aplicação
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]);

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')]
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return TransactionForm(_addTransaction);
      }
    );
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);      
    });
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS 
      ? GestureDetector(onTap: fn, child: Icon(icon))
      : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = [
      if(isLandscape)
        _getIconButton(
          _showChart ? Icons.list : Icons.bar_chart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          }
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context)
      )
    ];

    final PreferredSizeWidget appBar = Platform.isIOS 
    ? CupertinoNavigationBar(
        middle: Text('Despesas pessoais'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions
        ),
      )
    : AppBar(
        title: Text(
          'Despesas pessoais',
          // A propriedade abaixo leva em consideração a escala definida no SO
          // para quando o usuário deseja ter fontes maiores, por questões de
          // acessibilidade.
          // style: TextStyle(
          //   fontSize: 20 * mediaQuery.textScaleFactor
          // ),
        ),
        actions: actions,
      );

    final availableHeight = mediaQuery.size.height 
      - appBar.preferredSize.height
      - mediaQuery.padding.top;

    final bodyPage = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Switch para alternar entre gráfico ou lista no modo paisagem.
          // Substituído pelo botão na AppBar.
          // if(isLandscape)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text('Exibir gráfico'),
          //       Switch.adaptive(
          //         activeColor: Theme.of(context).accentColor,
          //         value: _showChart,
          //         onChanged: (value) {
          //           setState(() {
          //             _showChart = value;
          //           });
          //         }
          //       ),
          //     ],
          //   ),
          if (_showChart || !isLandscape)
            Container(
                height: availableHeight * (isLandscape ? 1 : 0.3),
                child: Chart(_recentTransactions)
              ),
          if(!_showChart|| !isLandscape)
            Container(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction)
              ),
        ],
      ),
    );

    return Platform.isIOS 
      ? CupertinoPageScaffold(
          navigationBar: appBar,
          child: bodyPage
        )
      : Scaffold(
        appBar: appBar,
        body: bodyPage,
        floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      );
  }
}