import 'package:flutter/material.dart';
import 'package:shop_2023/src/core/providers/counter_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter Page Teste'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      provider?.state.dec();
                    });
                  },
                  icon: const Icon(Icons.remove, color: Colors.red, size: 30),
                ),
                Text(provider?.state.value.toString() ?? '0'),
                IconButton(
                  onPressed: () {
                    setState(() {
                      provider?.state.inc();
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.green, size: 30),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
