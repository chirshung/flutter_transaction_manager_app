import 'package:flutter/material.dart';


//Define your owner widget here
class MyApp extends StatefulWidget{
  //Define the constructor
  String name;
  int age;
  MyApp({this.name, this.age}); //name and age are not state

  //StatefulWidget has internal "state"
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

//WidgetsBindingObserver contains the methods related to the lifecycle of the widget
//  it is the same as the 'implement interface' in Java
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  //when a widget is created and running, there are 3 functions that we may concern:
  // 1. initState
  // 2. build() is triggered when we call setState(...)
  // 3. dispose() is called when state/widget object is removed


  String _email = ''; //This is state
  final emailEditingController = TextEditingController();

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

    //dispose state when the app is running background
    emailEditingController.dispose();
    print('Run dispose()');
  }
  //when I know "the app is in background/foreground mode"?
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //Chứa các phương thức chúng ta phải thực thi
    //it contains the implement methods
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused){
      print('App is in background mode');
    } else if(state == AppLifecycleState.resumed){
      print('App is in foreground mode');
    }
  }


  @override
  Widget build(BuildContext context) {
    //How to display a DateTime
    DateTime myDate = new DateTime.now();

    print('Run build()');
    return MaterialApp(
      title: "My first StatefulWidget",
      home: Scaffold(
        body: Center(
          child: Column(
            //Alignment of Column by the vertical
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //1. Test transfer the argument for Widget
              Text(
                //'widget' is mentioned as the public class (MyApp)
                'Name is ${widget.name} and age is ${widget.age}',
                style: TextStyle(fontSize: 20, color: Colors.deepOrange),
              ),

              //2. Test the changing statefulWidget
              //Add the 'TextField' into an 'Container' in order to add padding
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    //How to get the value of the TextField? Use 'TextEditingController'
                    controller: emailEditingController,
                    //get the value of TextField and set to
                    onChanged: (text){
                      this.setState(() {
                        _email = text;//when the state changed => build() rerun => reload widget
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(30)
                            )
                        ),
                        labelText: 'Enter your email'
                    ),
                  )
              ),
              Text(
                _email,
                style: TextStyle(fontSize: 20, color: Colors.deepOrange),
              ),

              //3. Test the Datetime
              Text(
                myDate.toString(),
                style: TextStyle(fontSize: 20, color: Colors.amberAccent),
              ),



            ],

          ),
        ),
      ),
    );
  }

}