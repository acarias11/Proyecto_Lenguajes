import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home Page'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: const Text('Add a Note'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: [
                  TextFormField(
                    controller: _textController,
                    onFieldSubmitted: (value) async {
                      await Supabase.instance.client
                          .from('notes')
                          .insert({'body': value});
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Supabase.instance.client
                          .from('notes')
                          .insert({'body': _textController.text});
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
          child: const Icon(Icons.add),
      ),
      );
      }
    }