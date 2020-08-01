
import 'package:chalechalo/Authentication/loginPage.dart';
import 'package:chalechalo/drawer.dart';
import 'package:chalechalo/history.dart';
import 'package:chalechalo/main.dart';
import 'package:chalechalo/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chalechalo/passengerForm/passenger.dart';
import 'package:chalechalo/passengerForm/empty_state.dart';
import 'package:chalechalo/passengerForm/form.dart';
import '../Constants/constants.dart';

class AddPassengerPage extends StatefulWidget {
  @override
  _AddPassengerPageState createState() => _AddPassengerPageState();
}

class _AddPassengerPageState extends State<AddPassengerPage> {
  List<UserForm> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Center(
            child: Text(
              'Add Passenger',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Container(
                child: users.length <= 0
                    ? Center(
                        child: EmptyState(
                          title: 'Oops !!',
                          message: 'Add passenger by tapping add button below',
                        ),
                      )
                    : ListView.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: users.length,
                        itemBuilder: (_, i) => users[i],
                      ),
              ),
          floatingActionButton: FloatingActionButton.extended(
                icon: Icon(Icons.person_add, color: Colors.amber,),
                onPressed: onAddForm,
                label: Text('Add more Passenger',
                style: TextStyle(
                  color: Colors.amber,
                ),),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black87,
              ),
        drawer:drawer(context)
      ),
    );
  }

  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = users.map((it) => it.user).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('List of Users'),
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text(data[i].fullName.substring(0, 1)),
                  ),
                  title: Text(data[i].fullName),
                  subtitle: Text(data[i].age),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}