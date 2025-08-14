import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Demo',
      home: const CarouselDemo(),
    );
  }
}

class CarouselDemo extends StatelessWidget {
  const CarouselDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'https://picsum.photos/400/200?random=1',
      'https://picsum.photos/400/200?random=2',
      'https://picsum.photos/400/200?random=3',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Carousel Slider')),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.33,
            aspectRatio: 16/9,
            autoPlayInterval: const Duration(seconds: 3),
          ),
          items: images.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
