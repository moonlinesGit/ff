import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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
List<dynamic> posts=[];
bool loading=false;

Future<void> fetchPosts() async{
  setState(()=>loading=true);
  try{
    final dio=Dio();
    final response= await dio.get('https://test.com/posts');
    setState((){posts=response.data;});
  }catch(e){
    print('error fetching: $e');
  }finally{
    setState(()=>loading=false);
  }
}

@override
Widget build(BuildContext context){
  return Scaffold(
    body:Column(
      children:[
        ElevatedButton(
          child:Text('import data'),
          onPressed:fetchPosts
        ),
    
    if (loading) CircularProgressIndicator(),
    Expanded(
      child:ListView.builder(
        itemCount:posts.length,
        itemBuilder:(context,index){
          final post=posts[index];
          return ListTile(
            title:Text(post['title']),
            subtitle: Text(post['body']),
          );
        }
      )
    )  
    ]
    ),
  );
}

}
