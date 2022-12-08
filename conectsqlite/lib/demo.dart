import 'package:flutter/material.dart';
import 'package:conectsqlite/add_customer.dart';
import 'package:conectsqlite/model/contacts.dart';
import 'package:conectsqlite/provider/providerCustomer.dart';

class Demo extends StatefulWidget {
  Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter SQLite'),
      ),
      //add Future Builder to get contacts
      body: FutureBuilder<List<Customer>>(
        future: DBHelper.readCustomers(), //read contacts list here
        builder:
            (BuildContext context, AsyncSnapshot<List<Customer>> snapshot) {
          //if snapshot has no data yet
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
          //if snapshot return empty [], show text
          //else show contact list
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('No Contact in List yet!'),
                )
              : ListView(
                  children: snapshot.data!.map((customer) {
                    return Center(
                      child: ListTile(
                        title: Text(customer.name),
                        subtitle: Text(customer.email),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await DBHelper.deleteCustomers(customer.id!);
                            setState(() {
                              //rebuild widget after delete
                            });
                          },
                        ),
                        onTap: () async {
                          //tap on ListTile, for update
                          final refresh = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => AddContacts(
                                        customer: Customer(
                                          id: customer.id,
                                          name: customer.name,
                                          phone: customer.phone,
                                          email: customer.email,
                                          user: customer.user,
                                          pass: customer.pass,
                                        ),
                                      )));

                          if (refresh) {
                            setState(() {
                              //if return true, rebuild whole widget
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddContacts()));

          if (refresh) {
            setState(() {
              //if return true, rebuild whole widget
            });
          }
        },
      ),
    );
  }
}
