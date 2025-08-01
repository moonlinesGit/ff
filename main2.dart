import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      /* home: HomeScreen(),  */
      home:const Main(), 
    );
  }
}

class Main extends StatefulWidget{
  const Main({super.key});

  @override
  State<Main> createState()=>_MainState();
}

class _MainState extends State<Main>{
  int _currentIndex=0;
  static const List<Widget> _pages=<Widget>[
      Center(child:Text('Home Page')),
      Center(child:Text('2nd Page')),
      Contact(),
      Center(child:Text('Profile Page')),
  ];
  void _navClicked(int index){
    setState((){
      _currentIndex=index;
    });
  }
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[_currentIndex],
      bottomNavigationBar:BottomNavigationBar(
        currentIndex:_currentIndex,
        onTap:_navClicked,
        type:BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ]
      )
    );
   }
}
class Contact extends StatefulWidget{
  const Contact({super.key});
 @override
 State<Contact> createState()=>_ContactState();
}
class _ContactState extends State<Contact>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Center(child: ElevatedButton(child:Text('Contact us!'),onPressed:(){Navigator.push(context,MaterialPageRoute(builder:(context)=>Contact2()));})),
    );
  }
}

class Contact2 extends StatefulWidget{
  @override
  State<Contact2> createState()=> _Contact2State();
}  
class _Contact2State extends State<Contact2>{
  final TextEditingController _message= TextEditingController();
  List<String> list=[];
  void _addToList(String a){
    setState((){
      list.add(a);
      _message.text="";
    });
  }
 @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text('contact2')),
      body:Column(children:[
        Expanded(
        child:TextField(
          controller:_message
        )
        ),
        ElevatedButton(
          child:Text('Send Message'),
          onPressed:()=>_addToList(_message.text)
        ),
        Expanded(child:ListView.builder(
          itemCount:list.length,
          itemBuilder:(context,index){
            final item=list[index];
            return ListTile(
              title:Text('me'),
              trailing: Text(item)
            );
          }
        ))
      ])
    );
  } 
}
