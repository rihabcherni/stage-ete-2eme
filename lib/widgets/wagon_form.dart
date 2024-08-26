import 'package:flutter/material.dart';
import 'package:frontend/models/wagon.dart';

class WagonForm extends StatefulWidget {
  final Wagon? wagon;
  final void Function(Wagon) onSubmit;

  const WagonForm({Key? key, this.wagon, required this.onSubmit})
      : super(key: key);

  @override
  _WagonFormState createState() => _WagonFormState();
}

class _WagonFormState extends State<WagonForm> {
  final _formKey = GlobalKey<FormState>();
  late String wagonReference;
  late int capacity;
  late int currentLoad;

  @override
  void initState() {
    super.initState();
    wagonReference = widget.wagon?.wagonReference ?? '';
    capacity = widget.wagon?.capacity ?? 0;
    currentLoad = widget.wagon?.currentLoad ?? 0;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newWagon = Wagon(
        wagonReference: wagonReference,
        capacity: capacity,
        currentLoad: currentLoad, 
        id: '',
      );
      widget.onSubmit(newWagon);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.wagon == null ? 'Add Wagon' : 'Edit Wagon'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: wagonReference,
              decoration: InputDecoration(labelText: 'Wagon Reference'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a wagon reference';
                }
                return null;
              },
              onSaved: (value) => wagonReference = value!,
            ),
            TextFormField(
              initialValue: capacity.toString(),
              decoration: InputDecoration(labelText: 'Capacity'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.tryParse(value) == null) {
                  return 'Please enter a valid capacity';
                }
                return null;
              },
              onSaved: (value) => capacity = int.parse(value!),
            ),
            TextFormField(
              initialValue: currentLoad.toString(),
              decoration: InputDecoration(labelText: 'Current Load'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.tryParse(value) == null) {
                  return 'Please enter a valid current load';
                }
                return null;
              },
              onSaved: (value) => currentLoad = int.parse(value!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
