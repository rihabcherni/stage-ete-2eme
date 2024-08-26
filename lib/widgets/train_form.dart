import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/models/train_model.dart';
import 'service_start_date_field.dart';

class TrainForm extends StatefulWidget {
  final Train? train;
  final Function(Train) onSave;

  const TrainForm({Key? key, this.train, required this.onSave}) : super(key: key);

  @override
  _TrainFormState createState() => _TrainFormState();
}

class _TrainFormState extends State<TrainForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _serviceStartDateController =
      TextEditingController();

  Train? _selectedTrain;
  String? _selectedStatus;
  DateTime? _serviceStartDate;

  @override
  void initState() {
    super.initState();
    _selectedTrain = widget.train;
    _selectedStatus = _selectedTrain?.status;
    _serviceStartDate = _selectedTrain?.serviceStartDate;

    if (_serviceStartDate != null) {
      _serviceStartDateController.text =
          DateFormat('yyyy-MM-dd').format(_serviceStartDate!);
    }
  }

  @override
  void dispose() {
    _serviceStartDateController.dispose();
    super.dispose();
  }

  void _saveTrain() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSave(_selectedTrain!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.train == null ? 'Add Train' : 'Update Train'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _selectedTrain?.trainReference,
              decoration: const InputDecoration(labelText: 'Train Reference'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a train reference' : null,
              onSaved: (value) => _selectedTrain =
                  _selectedTrain?.copyWith(trainReference: value!) ??
                      Train(
                        id: '',
                        trainReference: value!,
                        status: 'available',
                        modeleTrain: '',
                        carbonEmissions: 0.0,
                        serviceStartDate: _serviceStartDate ?? DateTime.now(),
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(labelText: 'Status'),
              items: ['available', 'in transit', 'maintenance'].map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                  _selectedTrain =
                      _selectedTrain?.copyWith(status: value ?? 'available') ??
                          Train(
                            id: '',
                            trainReference: '',
                            status: value ?? 'available',
                            modeleTrain: '',
                            carbonEmissions: 0.0,
                            serviceStartDate:
                                _serviceStartDate ?? DateTime.now(),
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          );
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a status' : null,
            ),
            TextFormField(
              initialValue: _selectedTrain?.modeleTrain,
              decoration: const InputDecoration(labelText: 'Model'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a model' : null,
              onSaved: (value) => _selectedTrain =
                  _selectedTrain?.copyWith(modeleTrain: value!) ??
                      Train(
                        id: '',
                        trainReference: '',
                        status: _selectedStatus ?? 'available',
                        modeleTrain: value!,
                        carbonEmissions: 0.0,
                        serviceStartDate: _serviceStartDate ?? DateTime.now(),
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
            ),
            TextFormField(
              initialValue: _selectedTrain?.carbonEmissions.toString(),
              decoration: const InputDecoration(labelText: 'Carbon Emissions'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter carbon emissions' : null,
              onSaved: (value) => _selectedTrain = _selectedTrain?.copyWith(
                      carbonEmissions: double.parse(value!)) ??
                  Train(
                    id: '',
                    trainReference: '',
                    status: _selectedStatus ?? 'available',
                    modeleTrain: '',
                    carbonEmissions: double.parse(value!),
                    serviceStartDate: _serviceStartDate ?? DateTime.now(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
            ),
            ServiceStartDateField(
              controller: _serviceStartDateController,
              onDateSelected: (date) {
                setState(() {
                  _serviceStartDate = date;
                  _selectedTrain = _selectedTrain?.copyWith(
                        serviceStartDate: date,
                      ) ??
                      Train(
                        id: '',
                        trainReference: '',
                        status: _selectedStatus ?? 'available',
                        modeleTrain: '',
                        carbonEmissions: 0.0,
                        serviceStartDate: date,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _saveTrain,
          child: Text(widget.train == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
