import 'package:flutter/material.dart';
import 'package:frontend/models/train_model.dart';
import 'package:frontend/services/train_service.dart';
import 'package:frontend/widgets/train_form.dart';
import 'package:frontend/widgets/train_list_item.dart';
import 'package:intl/intl.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class TrainListScreen extends StatefulWidget {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  static const contentStyle = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  @override
  _TrainListScreenState createState() => _TrainListScreenState();
}

class _TrainListScreenState extends State<TrainListScreen> {
  final TrainService _trainService = TrainService();
  late Future<List<Train>> _trains;

  @override
  void initState() {
    super.initState();
    _fetchTrains();
  }

  void _fetchTrains() {
    setState(() {
      _trains = _trainService.getAllTrains();
    });
  }

  void _showTrainForm({Train? train}) {
    showDialog(
      context: context,
      builder: (context) => TrainForm(
        train: train,
        onSave: (Train savedTrain) async {
          if (savedTrain.id.isNotEmpty) {
            await _trainService.updateTrain(savedTrain.id, savedTrain);
          } else {
            await _trainService.addTrain(savedTrain);
          }
          Navigator.of(context).pop();
          _fetchTrains();
        },
      ),
    );
  }

  void _deleteTrain(String id) async {
    try {
      await _trainService.deleteTrain(id);
      _fetchTrains();
      _showSnackbar('Train deleted successfully');
    } catch (error) {
      _showErrorDialog('Failed to delete train: $error');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trains')),
      body: FutureBuilder<List<Train>>(
        future: _trains,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No trains found'));
          }

          return Accordion(
            headerBorderColor: Colors.blueGrey,
            headerBorderColorOpened: Colors.transparent,
            headerBorderWidth: 1,
            headerBackgroundColorOpened: Colors.green,
            contentBackgroundColor: Colors.white,
            contentBorderColor: Colors.green,
            contentBorderWidth: 3,
            contentHorizontalPadding: 20,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            headerPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            sectionClosingHapticFeedback: SectionHapticFeedback.light,
            children: snapshot.data!.map((train) {
              return AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.train, color: Colors.white),
                header: Text('Train: ${train.trainReference}',
                    style: TrainListScreen.headerStyle),
                content: TrainListItem(
                  train: train,
                  onEdit: () => _showTrainForm(train: train),
                  onDelete: () => _deleteTrain(train.id),
                  onEditWagon: (Wagon) {},
                  onAddWagon: (Wagon) {},
                  onDeleteWagon: (String) {},
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTrainForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
