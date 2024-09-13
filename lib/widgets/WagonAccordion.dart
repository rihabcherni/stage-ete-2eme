import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/train_model.dart';
import 'package:frontend/models/wagon.dart';
import 'package:frontend/screens/admin/AdminTrainsScreen.dart';
import 'package:frontend/widgets/wagon_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WagonAccordion extends StatefulWidget {
  final Train train;
  final void Function(Wagon) onAddWagon;
  final void Function(Wagon) onEditWagon;
  final void Function(String) onDeleteWagon;

  const WagonAccordion({
    Key? key,
    required this.train,
    required this.onAddWagon,
    required this.onEditWagon,
    required this.onDeleteWagon,
  }) : super(key: key);

  @override
  _WagonAccordionState createState() => _WagonAccordionState();
}

class _WagonAccordionState extends State<WagonAccordion> {
  List<Wagon> wagons = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWagons();
  }

  Future<void> fetchWagons() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/api/wagon/train/${widget.train.id}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> wagonData = jsonDecode(response.body);
      setState(() {
        wagons = wagonData.map((data) => Wagon.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (wagons.isEmpty) {
      return Center(child: Text('No wagons found.'));
    }

    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _showWagonForm(null),
        ),
        Accordion(
          paddingListTop: 0,
          paddingListBottom: 0,
          maxOpenSections: 1,
          headerBackgroundColorOpened: Colors.black54,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          children: wagons.map((wagon) {
            return AccordionSection(
              isOpen: false,
              leftIcon:
                  const Icon(Icons.directions_railway, color: Colors.white),
              headerBackgroundColor: Colors.black38,
              headerBackgroundColorOpened: Colors.black54,
              header: Text('Wagon: ${wagon.wagonReference}',
                  style: AdminTrainsScreen.headerStyle),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Capacity: ${wagon.capacity}',
                      style: AdminTrainsScreen.contentStyle),
                  Text('Current Load: ${wagon.currentLoad}',
                      style: AdminTrainsScreen.contentStyle),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showWagonForm(wagon);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteWagon(wagon.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              contentHorizontalPadding: 20,
              contentBorderColor: Colors.black54,
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showWagonForm(Wagon? wagon) {
    showDialog(
      context: context,
      builder: (context) {
        return WagonForm(
          wagon: wagon,
          onSubmit: (newWagon) {
            if (wagon == null) {
              _addWagon(newWagon);
            } else {
              _editWagon(wagon.id, newWagon);
            }
          },
        );
      },
    );
  }

  Future<void> _addWagon(Wagon wagon) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/wagon/wagons'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'trainId': widget.train.id,
          'wagon_reference': wagon.wagonReference,
          'capacity': wagon.capacity,
          'currentLoad': wagon.currentLoad,
        }),
      );

      if (response.statusCode == 201) {
        final newWagon = Wagon.fromJson(jsonDecode(response.body));
        setState(() {
          wagons.add(newWagon);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wagon added successfully')),
        );
      } else {
        final responseBody = response.body;
        final errorMessage =
            response.headers['content-type']?.contains('application/json') ==
                    true
                ? jsonDecode(responseBody)['error'] ?? 'Failed to add wagon'
                : 'Unexpected error: $responseBody';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      print('An error occurred: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }

  Future<void> _editWagon(String id, Wagon wagon) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:5000/api/wagon/wagons/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'wagon_reference': wagon.wagonReference,
        'capacity': wagon.capacity,
        'currentLoad': wagon.currentLoad,
      }),
    );

    if (response.statusCode == 200) {
      final updatedWagon = Wagon.fromJson(jsonDecode(response.body));
      setState(() {
        final index = wagons.indexWhere((w) => w.id == id);
        if (index != -1) {
          wagons[index] = updatedWagon;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wagon updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update wagon')),
      );
    }
  }

  Future<void> _deleteWagon(String id) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:5000/api/wagon/wagons/$id'),
    );

    if (response.statusCode == 200) {
      setState(() {
        wagons.removeWhere((wagon) => wagon.id == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wagon deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete wagon')),
      );
    }
  }
}
