import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  await Hive.openBox('cartBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      home: const Main(),
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<String>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<String>> {
  CartNotifier() : super([]) {
    loadFromHive();
  }

  void loadFromHive() {
    final box = Hive.box('cartBox');
    final savedItems = box.get('items', defaultValue: <String>[]);
    state = List<String>.from(savedItems); // cast to List<String>
  }

  void addItem(String item) {
    state = [...state, item]; // semicolon added
    final box = Hive.box('cartBox');
    box.put('items', state);
  }

  void deleteItem(String item) {
    state = state.where((el) => el != item).toList();
    final box = Hive.box('cartBox');
    box.put('items', state);
  }
}

class Main extends ConsumerStatefulWidget {
  const Main({super.key});

  @override
  ConsumerState<Main> createState() => _MainState();
}

class _MainState extends ConsumerState<Main> {
  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(cartProvider);
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                final item = cartList[index];
                return ListTile(title: Text('$item'));
              }),
        ),
        ElevatedButton(
          child: const Text('Go to Modifier'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ModifyCart(),
                ));
          },
        )
      ]),
    );
  }
}

class ModifyCart extends ConsumerStatefulWidget {
  const ModifyCart({super.key});

  @override
  ConsumerState<ModifyCart> createState() => _ModifyCartState();
}

class _ModifyCartState extends ConsumerState<ModifyCart> {
  void addItem(String item) {
    ref.read(cartProvider.notifier).addItem(item);
  }

  void deleteItem(String item) {
    ref.read(cartProvider.notifier).deleteItem(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Modify')),
        body: Column(children: [
          ElevatedButton(
            child: const Text('Add item'),
            onPressed: () => addItem('item'),
          ),
          ElevatedButton(
            child: const Text('Remove item'),
            onPressed: () => deleteItem('item'),
          )
        ]));
  }
}
