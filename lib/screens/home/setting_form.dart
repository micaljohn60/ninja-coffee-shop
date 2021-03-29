import 'package:flutter/material.dart';
import 'package:ninja_coffee_shop/models/Customer.dart';
import 'package:ninja_coffee_shop/services/database.dart';
import 'package:ninja_coffee_shop/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {

  final formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4','5'];

  int _currentStrength;
  String _currentSugars;
  String _currentName;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Customer>(context);
    return StreamBuilder<CustomerData>(
      stream: DatabaseService(uid: user.cid).customerData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          CustomerData customerData = snapshot.data;
            return Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your Preferences',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: customerData.name,
                  validator: (val) => val.isEmpty ? 'Please Enter a name' : null,
                  onChanged: (val) => setState(()=> _currentName = val),
                ),
                SizedBox(height: 10.0,),
                DropdownButtonFormField(
                  value: _currentSugars ?? customerData.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(), 
                  onChanged: (val) => setState(() => _currentSugars = val),
                ),
                SizedBox(height: 10.0,),
                Slider(
                  value: (_currentStrength ?? customerData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? customerData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? customerData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(()=> _currentStrength = val.round() ) ,
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    if(formKey.currentState.validate()){
                      await DatabaseService(uid: user.cid).updateUserDate(
                        _currentSugars ?? customerData.sugars,
                         _currentName ?? customerData.name, 
                         _currentStrength ?? customerData.strength
                        
                        );
                        Navigator.pop(context);
                    }else{

                    }
                  },
                )
              ],
            ),
          );
        }
        else{
          return Loading();
        }
        
      }
    );
  }
}