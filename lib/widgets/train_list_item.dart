import 'package:flutter/material.dart';
import 'package:frontend/models/train_model.dart';
import 'package:frontend/models/wagon.dart';
import 'package:frontend/widgets/WagonAccordion.dart';
import 'package:frontend/widgets/wagon_form.dart';
import 'package:intl/intl.dart';

class TrainListItem extends StatelessWidget {
  final Train train;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(Wagon) onAddWagon;
  final Function(Wagon) onEditWagon;
  final Function(String) onDeleteWagon;

  const TrainListItem({
    Key? key,
    required this.train,
    required this.onEdit,
    required this.onDelete,
    required this.onAddWagon,
    required this.onEditWagon,
    required this.onDeleteWagon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0, right: 0.0),
          child: ListTile(
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${train.status}'),
                Text('Model: ${train.modeleTrain ?? 'N/A'}'),
                Text('Carbon Emissions: ${train.carbonEmissions}'),
                Text(
                    'Service Start Date: ${DateFormat('yyyy-MM-dd').format(train.serviceStartDate)}'),
                WagonAccordion(
                  train: train,
                  onEditWagon: (Wagon wagon) {
                    // Implement the edit wagon functionality
                  },
                  onDeleteWagon: (String id) {},
                  onAddWagon: (Wagon) {},
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
