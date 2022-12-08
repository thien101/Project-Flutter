import 'package:flutter/material.dart';
import 'package:conectsqlite/provider/providerCustomer.dart';

import 'model/contacts.dart';

class AddContacts extends StatefulWidget {
  AddContacts({Key? key, this.customer}) : super(key: key);
  //here i add a variable
  //it is not a required, but use this when update
  final Customer? customer;

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  //for TextField
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    //when contact has data, mean is to update
    //instead of create new contact
    if (widget.customer != null) {
      _nameController.text = widget.customer!.name;
      _phoneController.text = widget.customer!.phone;
      _emailController.text = widget.customer!.email;
      _userController.text = widget.customer!.user;
      _passController.text = widget.customer!.pass;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contacts'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(false),
          //to prevent back button pressed without add/update
        ),
      ),
      body: Center(
        //create two text field to key in name and contact
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTextField(_nameController, 'Name'),
              SizedBox(
                height: 30,
              ),
              _buildTextField(_phoneController, 'Phone'),
              SizedBox(
                height: 20,
              ),
              _buildTextField(_emailController, 'Email'),
              SizedBox(
                height: 20,
              ),
              _buildTextField(_userController, 'User'),
              SizedBox(
                height: 20,
              ),
              _buildTextField(_passController, 'Pass'),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                //this button is pressed to add contact
                onPressed: () async {
                  //if contact has data, then update existing list
                  //according to id
                  //else create a new contact
                  if (widget.customer != null) {
                    await DBHelper.updateCustomers(Customer(
                        id: widget.customer!.id, //have to add id here
                        name: _nameController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                        user: _userController.text,
                        pass: _passController.text));

                    Navigator.of(context).pop(true);
                  } else {
                    await DBHelper.createCustomers(Customer(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                        user: _userController.text,
                        pass: _passController.text));

                    Navigator.of(context).pop(true);
                  }
                },
                child: Text('Add to Contact List'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //build a text field method
  TextField _buildTextField(TextEditingController _controller, String hint) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: hint,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
