import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends ConsumerWidget {
  const ModToolsScreen({Key? key, required this.name}) : super(key: key);

  final String name;

  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  void navigateToAddModTools(BuildContext context) {
    Routemaster.of(context).push('/add-mods/$name');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mod Tools"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.add_moderator),
            title: Text("Add Moderators"),
            onTap: () => navigateToAddModTools(context),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Edit Community"),
            onTap: () {
              navigateToModTools(context);
            },
          )
        ],
      ),
    );
  }
}
// what is a flutter
