import 'package:flutter/material.dart';
import 'package:frontend/models/order_model.dart';
import 'package:frontend/services/order_service.dart';

class OrderForm extends StatefulWidget {
  final Order? order;
  final OrderService orderService;

  const OrderForm({Key? key, this.order, required this.orderService})
      : super(key: key);

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController originController;
  late TextEditingController destinationController;
  late TextEditingController estimatedDeliveryTimeController;
  late List<OrderItem> orderItems;

  @override
  void initState() {
    super.initState();
    originController = TextEditingController(text: widget.order?.origin ?? '');
    destinationController =
        TextEditingController(text: widget.order?.destination ?? '');
    estimatedDeliveryTimeController = TextEditingController(
      text: widget.order?.estimatedDeliveryTime?.toIso8601String() ?? '',
    );
    orderItems = widget.order?.orderItems ?? [];
  }

  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();
    estimatedDeliveryTimeController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final order = Order(
        id: widget.order?.id ?? '',
        clientId: '66a3c502f0fbe3ae24f5d7f3', // Replace with actual clientId
        origin: originController.text,
        destination: destinationController.text,
        status: widget.order?.status ?? 'pending', // Set status
        orderItems: orderItems, // Include the list of order items
        estimatedDeliveryTime:
            DateTime.parse(estimatedDeliveryTimeController.text),
        createdAt: widget.order?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.order == null) {
        await widget.orderService.addOrder(order);
      } else {
        await widget.orderService.updateOrder(order.id, order);
      }

      Navigator.pop(context, true);
    }
  }

  void _addOrderItem() {
    setState(() {
      orderItems.add(OrderItem(itemName: '', quantity: 1, unit: ''));
    });
  }

  void _removeOrderItem(int index) {
    setState(() {
      orderItems.removeAt(index);
    });
  }

  Widget _buildOrderItemFields(int index) {
    final item = orderItems[index];
    return Column(
      children: [
        TextFormField(
          initialValue: item.itemName,
          decoration: const InputDecoration(labelText: 'Item Name'),
          onChanged: (value) => setState(() {
            orderItems[index] = OrderItem(
                itemName: value, quantity: item.quantity, unit: item.unit);
          }),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an item name';
            }
            return null;
          },
        ),
        TextFormField(
          initialValue: item.quantity.toString(),
          decoration: const InputDecoration(labelText: 'Quantity'),
          keyboardType: TextInputType.number,
          onChanged: (value) => setState(() {
            orderItems[index] = OrderItem(
              itemName: item.itemName,
              quantity: int.parse(value),
              unit: item.unit,
            );
          }),
          validator: (value) {
            if (value == null || value.isEmpty || int.tryParse(value) == null) {
              return 'Please enter a valid quantity';
            }
            return null;
          },
        ),
        TextFormField(
          initialValue: item.unit,
          decoration: const InputDecoration(labelText: 'Unit (e.g., kg, tons)'),
          onChanged: (value) => setState(() {
            orderItems[index] = OrderItem(
                itemName: item.itemName, quantity: item.quantity, unit: value);
          }),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a unit';
            }
            return null;
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: () => _removeOrderItem(index),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order == null ? 'Add Order' : 'Edit Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: originController,
                decoration: const InputDecoration(labelText: 'Origin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an origin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: destinationController,
                decoration: const InputDecoration(labelText: 'Destination'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a destination';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: estimatedDeliveryTimeController,
                decoration:
                    const InputDecoration(labelText: 'Estimated Delivery Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an estimated delivery time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text('Order Items'),
              ...List.generate(
                  orderItems.length, (index) => _buildOrderItemFields(index)),
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: _addOrderItem,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child:
                    Text(widget.order == null ? 'Add Order' : 'Update Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
