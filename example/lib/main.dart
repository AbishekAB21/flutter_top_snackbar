import 'package:flutter/material.dart';
import 'package:flutter_top_snackbar/flutter_top_snackbar.dart';

void main() {
  runApp(const SnackbarExampleApp());
}

class SnackbarExampleApp extends StatelessWidget {
  const SnackbarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Top Snackbar Example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Top Snackbar Example')),
        body: const SnackbarDemo(),
      ),
    );
  }
}

class SnackbarDemo extends StatelessWidget {
  const SnackbarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success
          ElevatedButton(
            onPressed: () {
              FlutterTopSnackbar.success(context, 'Operation Successful!');
            },
            child: const Text('Show Success Snackbar'),
          ),
          const SizedBox(height: 16),

          // Error
          ElevatedButton(
            onPressed: () {
              FlutterTopSnackbar.error(context, 'Operation Failed!');
            },
            child: const Text('Show Error Snackbar'),
          ),
          const SizedBox(height: 16),

          // Info
          ElevatedButton(
            onPressed: () {
              FlutterTopSnackbar.info(
                context,
                'This is a snackbar from the top!',
              );
            },
            child: const Text('Show info Snackbar'),
          ),
          const SizedBox(height: 16),

          // Warning
          ElevatedButton(
            onPressed: () {
              FlutterTopSnackbar.warning(context, 'Warning!');
            },
            child: const Text('Show warning Snackbar'),
          ),
          const SizedBox(height: 16),

          // Custom
          ElevatedButton(
            onPressed: () {
              FlutterTopSnackbar.show(
                context,
                'Custom Snackbar Example',
                customBackgroundColor: Colors.black,
                customIcon: Icons.star,
                animationType: AnimationTypes.fade,
              );
            },
            child: const Text('Show Custom Snackbar'),
          ),
        ],
      ),
    );
  }
}
