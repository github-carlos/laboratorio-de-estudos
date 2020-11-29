import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/admin_users_manager.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminUsersManager>(
      builder: (_, adminUsersManager, __) {
        return Scaffold(
          appBar: AppBar(title: Text('Usuários'), centerTitle: true,),
          body: AlphabetListScrollView(
            itemBuilder: (_, index) {
                return ListTile(
                  title: Text(adminUsersManager.users[index].name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                  subtitle: Text(adminUsersManager.users[index].email, style: TextStyle(color: Colors.white),),
                );
            },
            indexedHeight: (index) => 80,
            strList: adminUsersManager.names,
            showPreview: true,
            highlightTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
        );
      }
    );
  }
}
