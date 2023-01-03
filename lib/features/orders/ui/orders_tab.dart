import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_widgets/dropdown/custom_dropdown_field.dart';
import 'package:oyt_front_orders_queue/models/order_status.dart';
import 'package:oyt_front_widgets/tabs/tab_header.dart';

class OrdersQueueTab extends ConsumerStatefulWidget {
  const OrdersQueueTab({super.key});

  @override
  ConsumerState<OrdersQueueTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends ConsumerState<OrdersQueueTab> {
  final _scrollController = ScrollController();
  OrderStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TabHeader(
          title: 'Cola de productos',
          subtitle:
              'Acá puedes ver la cola de los productos y manejar los estados de los productos.',
        ),
        const SizedBox(height: 14),
        const Text(
          'Filtrar por:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        CustomDropdownField<OrderStatus>(
          items: OrderStatus.values,
          value: _selectedStatus,
          itemAsString: (item) => item.label,
          onChanged: (value) => setState(() => _selectedStatus = value),
          labelText: 'Estado del producto',
          hintText: 'Selecciona un estado',
        ),
        const Divider(),
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 50,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  onTap: () {},
                  title: Text('Producto $index'),
                  trailing: const Text('Estado: \nPendiente'),
                  subtitle: Text('Mesa: $index'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
