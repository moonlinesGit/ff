import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Track(), 
    );
  }
}

class Track extends StatefulWidget{
  @override
  State<Track> createState()=>_TrackState();
}

class _TrackState extends State<Track>{
final TextEditingController _nameController = TextEditingController();
final TextEditingController _amountController = TextEditingController();
String error='';
List<Map<String, double>> list = [];
double total=0;
void addTuple(String nameC,double amountC){
    setState((){
      list.add({nameC:amountC});
      error="";
      total+=amountC;
    });
}
void setError(){
  setState((){
    error="please fill all fields";
  });
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0), // add padding around all edges
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // left-align text
        children: [
          if (error.isNotEmpty)
            Text(error, style: TextStyle(color: Colors.red)),
          Row(
            children: [
              Text('Expenses name:'),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _nameController,
                ),
              ),
            ],
          ),
          SizedBox(height: 12), // spacing between rows
          Row(
            children: [
              Text('Amount:'),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  final name = _nameController.text;
                  final amountText = _amountController.text;
                  final amount = double.tryParse(amountText);
                  if (name.isNotEmpty && amount != null) {
                    addTuple(name, amount);
                  } else {
                    setError();
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Expenses: '),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                final name = item.keys.first;
                final amount = item.values.first;
                return ListTile(
                  title: Text(name),
                  trailing: Text(amount.toStringAsFixed(2)),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Text('Total: $total'),
        ],
      ),
    ),
  );
}
}
