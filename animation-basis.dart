import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validation Demo',
      home: TweenDemo(),
    );
  }
}
class TweenDemo extends StatefulWidget {
  @override
  _TweenDemoState createState() => _TweenDemoState();
}

class _TweenDemoState extends State<TweenDemo> with SingleTickerProviderStateMixin {
late AnimationController _controller;
late Animation<double> _size;
@override
void initState(){
  super.initState();
  _controller=AnimationController(vsync:this,duration:Duration(seconds:2));
  _size= Tween<double>(begin:1,end:200).animate(_controller);
  _controller.repeat(reverse:true);
}
@override
void dispose(){
  super.dispose();
  _controller.dispose();
}
@override
Widget build(BuildContext context){
  return Scaffold(
    body:Center(
      child:Column(
        children:[
          AnimatedBuilder(
            animation:_controller,
            builder:(context,child){
              return Container(
                width:_size.value,
                height:_size.value,
                color:Colors.blue
              );
            }
          ),
          ElevatedButton(
            child:Text('go to next page'),
            onPressed:(){Navigator.push(context,PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation)=> Page2(),
              transitionsBuilder:(context,animation, secondaryAnimation, child){
                return SlideTransition(
                  position:Tween<Offset>(begin:Offset(1,0),end:Offset.zero).animate(animation),
                  child:child,
                );
              }
            ));
            }
          )
        ]
      )
    )
  );
}
}

class Page2 extends StatefulWidget{
  const Page2({super.key});
  @override
  State<Page2> createState() => _Page2State();
}
class _Page2State extends State<Page2>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text('animated transition')),
      body:Center(
        child:Text('hello Page 2')
      )
    );
  }

}





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//scrub/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ScrollScrubDemo extends StatefulWidget {
  const ScrollScrubDemo({super.key});

  @override
  State<ScrollScrubDemo> createState() => _ScrollScrubDemoState();
}

class _ScrollScrubDemoState extends State<ScrollScrubDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scale = Tween<double>(begin: 0.5, end: 2).animate(_controller);

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final scrollFraction =(_scrollController.offset / maxScroll).clamp(0.0, 1.0);
      _controller.value = scrollFraction;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        children: [
          const SizedBox(height: 600), // Empty space to scroll
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scale.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 800),// Empty space to scroll
        ],
      ),
    );
  }
}
