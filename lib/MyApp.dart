import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:transaction_manager_app/TransactionList.dart';


//Define your owner widget here
class MyApp extends StatefulWidget{

  //StatefulWidget has internal "state"
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

//WidgetsBindingObserver contains the methods related to the lifecycle of the widget
//  it is the same as the 'implement interface' in Java
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  //define a global ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //define variants of Controller
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();

  // //define states - use the 'transaction.dart' instead
  // String _content;
  // double _amount;

  //define a private transaction object in order to receive the input data(state) and save to list
  Transaction _transaction = Transaction(content: '', amount: 0.0);
  //define a list of transaction objects
  List<Transaction> _transactions = new List<Transaction>();

  void _insertTransaction(){
    //validate date
    if(_transaction.content.isEmpty ||
       _transaction.amount.isNaN ||
       _transaction.amount == 0.0 )
     {
       return;
     }
    //add current Date to object
    _transaction.buyDate = DateTime.now();
    //add to list
    _transactions.add(_transaction);
    //reset the transaction object
    _transaction = Transaction(content: '', amount: 0.0);
    //reset the controller
    _amountController.text = '';
    _contentController.text = '';
  }

  //UI of the 'Modal Bottom Sheet'
  void _onButtonShowModalSheet(){
    showModalBottomSheet(
      context: this.context, //this screen
      builder: (context) { //Widget which will be showed by showModalBottomSheet
        return Column(
          children: <Widget>[
            //1.TextField of content
            // it should be put in a container in order to set padding and format easily
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(labelText: 'Content'),
                controller: _contentController,
                onChanged: (text){
                  setState(() {
                    _transaction.content = text ;
                  });
                },
              ),
            ),

            //2.TextField of amount
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onChanged: (text) {
                  setState(() {
                    _transaction.amount = double.tryParse(text) ?? 0; //if error, value = 0
                  });
                },
              ),
            ),

            //3.Row with 2 button
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //Use the 'Expanded' Widget so that
                  //  'Save' and 'Cancel' button can be spread out equally.

                  //3.1.'Save' Button
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: RaisedButton(
                          child: Text('Save'),
                          color: Colors.blueGrey,
                          onPressed: (){
                            setState(() {
                              this._insertTransaction();
                            });
                            //Dismiss the 'Modal Bottom Sheet' after inserting
                            //  'Pop' -> mean that close current screen and turn back the previous one
                            Navigator.of(context).pop();
                          }
                      ),

                    )
                  ),
                  //3.2.Padding
                  Padding(padding: EdgeInsets.only(left: 10)),
                  //3.3.'Cancel' Button
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: RaisedButton(
                        child: Text('Cancel'),
                        color: Colors.deepPurple,
                        onPressed: (){
                          setState(() {
                            //Dismiss the 'Modal Bottom Sheet' after inserting
                            //  'Pop' -> mean that close current screen and turn back the previous one
                            Navigator.of(context).pop();
                          });
                        },
                      )
                    ),
                  )

                ],
              ),
            )
         

          ],
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    //Register the widget to observer
    WidgetsBinding.instance.addObserver(this);
    print('Run initState()');
  }
  @override
  void dispose() {
    super.dispose();
    //Register the widget to observer
    WidgetsBinding.instance.addObserver(this);

  }
  //when I know "the app is in background/foreground mode"?
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //Chứa các phương thức chúng ta phải thực thi
    //it contains the implement methods
    super.didChangeAppLifecycleState(state);
    // if(state == AppLifecycleState.paused){
    //   print('App is in background mode');
    // } else if(state == AppLifecycleState.resumed){
    //   print('App is in foreground mode');
    // }
  }

  //UI of Homepage APP
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //1.AppBar
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
               'TRANSACTION MANAGER',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
              ),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.add),
                //call => 'Modal Bottom Sheet'
                onPressed: (){
                  setState(() {
                    this._onButtonShowModalSheet();
                  });
                }
            )
          ],
        ),

        //2.FloatingActionButton
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Add Transaction',
          child: Icon(Icons.add),
          //call => 'Modal Bottom Sheet'
          onPressed: (){
            setState(() {
              this._onButtonShowModalSheet();
            });
          },
        ),

        //Assign the global ScaffoldState to Scaffold key
        key: _scaffoldKey,

        //3.Body
        body: SafeArea(
           //min padding of SafeArea
           minimum: EdgeInsets.only(left: 20, right: 20),
           child: SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 //1.Add a padding between Button and AppBar
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 5),
                 ),

                 //2.Button and decor the button by 'ButtonTheme'
                 ButtonTheme(
                   height: 50,
                   child: FlatButton(
                       child: Text(
                         'Insert Transaction',
                         style: const TextStyle(
                           fontSize: 18,
                           color: Colors.black87,
                           fontFamily: 'Oswald',
                         ),
                       ),
                       color: Theme.of(context).accentColor,
                       // textColor: Colors.deepOrange,
                       onPressed: (){
                         // 2.1.Show inputted value to Snack bar
                         var snackbar = new SnackBar(
                           content: Text(
                               'Content: ${_transaction.content}, '
                                   'money\'s amount: ${_transaction.amount}'),
                           duration: Duration(seconds: 3),
                         );
                         _scaffoldKey.currentState.showSnackBar(snackbar);

                         // 2.2.call => 'Modal Bottom Sheet'
                         setState(() {
                           this._onButtonShowModalSheet();
                         });
                       }
                   ),
                 ),

                 //3.Display the transaction list by ListTile
                 //   call the 'TransactionList' Widget
                 TransactionList(transactions: _transactions),

               ],
             ),
           ),
        ),
    );
  }

}

