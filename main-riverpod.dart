import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()) );
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
final listProvider= StateProvider<List<Map<String, String>>>((ref)=>[]);

class Main extends ConsumerStatefulWidget{
  const Main({super.key});

  @override
  ConsumerState<Main> createState()=> _MainState();
}

class _MainState extends ConsumerState<Main>{
  @override
  Widget build(BuildContext context){
    final list=ref.watch(listProvider);
    return Scaffold(
      body:Column(
        children:[
          Expanded(
            child: ListView.builder(
              itemCount:list.length,
              itemBuilder: (context,index)
                {
                  final item = list[index];
                  final key = item.keys.first;
                  final value = item.values.first;
                  return ListTile(title:Text('$key'),trailing:Text('$value'));
                })
          ),
          ElevatedButton(child:Text('Add More'), onPressed:(){Navigator.push(context,MaterialPageRoute(builder:(context)=>Todo()));})
        ]
      )
    );
  }
}

class Todo extends ConsumerStatefulWidget{
  const Todo({super.key});

  @override
  ConsumerState<Todo> createState()=> _TodoState();
}

class _TodoState extends ConsumerState<Todo>{
  final TextEditingController _title= TextEditingController();
  final TextEditingController _value=TextEditingController();
  void addToList(){
    final old_list=ref.read(listProvider);
    ref.read(listProvider.notifier).state=[...old_list,{_title.text:_value.text}];
    _title.clear();
    _value.clear();
  }
  @override
  Widget build(BuildContext context){
    final list= ref.watch(listProvider);
    return Scaffold(
      appBar:AppBar(title:Text('TODO ADD')),
      body:Column(
        children:[
          TextField(controller:_title),
          Text('its value:'),
          TextField(controller:_value),
          ElevatedButton(child:Text('add'),onPressed:addToList)
        ]
      )
    );
  }
}