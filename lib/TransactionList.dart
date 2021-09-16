import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';



class TransactionList extends StatelessWidget{
  //define a list of transaction objects
  List<Transaction> transactions = new List<Transaction>();
  //define constructor
  TransactionList({this.transactions});

  //1.ListView(children: <Widget>[]) => this loads all children at the same time
  //Method return a list of Card Widget
  // => return a list to display
  List<Widget> _buildWidgetList (){
    //define an index to control the color of CARD
    int index = 0;
    return transactions.map((eachTransaction) {
      //5.1.Display the transaction list to display by ListTile
      //  return ListTile(
      //    //A basic ListTile
      //      leading:  Icon(Icons.access_alarm_sharp),
      //      title:    Text('name: ${eachTransaction.content}'),
      //      subtitle: Text('price: ${eachTransaction.amount.toString()}'),
      //      onTap: (){
      //        print('Tap ${eachTransaction.content}');
      //      },
      //    );

      //5.2. Decor the ListTile under the CARD
      index++;
      return Card(
        //Decor ListTile by properties of Card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        //Base on 'index' to display CARD with different color
        color: (index-1) % 2 == 0 ? Colors.deepOrange : Colors.blueAccent,
        elevation: 5, //shadow
        //ListTile
        child: ListTile(
          //A basic ListTile
          leading:  Icon(Icons.access_alarm_sharp),
          title:    Text(
            'name: ${eachTransaction.content}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'price: ${eachTransaction.amount.toString()}',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onTap: (){
            print('Tap ${eachTransaction.content}');
          },
        ),
      );
    }).toList();
  }

  //2.ListView(itemBuilder: ...)     => this loads only visible items
  //Method return a listView Builder
  ListView _buildListView (){
    return ListView.builder(
      //itemCount is length of List
      itemCount: transactions.length,
      itemBuilder: (context, index){
          //context -> is current screen(tham chiếu đến màn hình hiện tại)
          //indext -> (là chỉ số của từng phần tử trong ListView)
          return Card(

              //Decor ListTile by properties of Card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Base on 'index' to display CARD with different color
              color: (index-1) % 2 == 0 ? Colors.deepOrange : Colors.blueAccent,
              elevation: 5, //shadow

              //Customize the List Items using ROW and COLUMN instead of ListTile
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 10) ),
                      Text(
                        '${transactions[index].content}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Date: ${DateFormat.yMMMd().format(transactions[index].buyDate)}',
                        style: TextStyle(fontSize: 12, color: Colors.limeAccent),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10) ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            '\$${transactions[index].amount.toString()}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 20)),
                      ],
                    )
                  ),

                ],
              ),
          );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    //Make "Scrollable" by using ListView
    // //1.ListView(children: <Widget>[]) => this loads all children at the same time
    // return Container(
    //   height: 500,
    //   //Display the transaction list by ListTile
    //   child: ListView(
    //     children: this._buildWidgetList(),
    //   )
    // );

    //2.ListView(itemBuilder: ...)     => this loads only visible items
    return Container(
        height: 500,
        //Display the transaction list by ListTile
        child: this._buildListView(),
    );
  }

}