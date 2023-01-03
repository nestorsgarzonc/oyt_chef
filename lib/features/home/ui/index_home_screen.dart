import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyt_chef/features/historical_orders/ui/historical_orders_tab.dart';
import 'package:oyt_chef/features/inventory/ui/inventory_tab.dart';
import 'package:oyt_chef/features/orders/ui/orders_tab.dart';
import 'package:oyt_front_widgets/drawer/drawer_item_card.dart';
import 'package:oyt_front_widgets/drawer/drawer_layout.dart';
import 'package:oyt_front_widgets/drawer/models/drawer_item.dart';
import 'package:oyt_front_widgets/image/image_api_widget.dart';

class IndexHomeScreen extends ConsumerStatefulWidget {
  const IndexHomeScreen({super.key});

  static const route = '/home';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IndexHomeScreenState();
}

class _IndexHomeScreenState extends ConsumerState<IndexHomeScreen> {
  int _index = 0;

  static final _items = [
    CardItem(
      title: 'Cola de productos',
      icon: FontAwesomeIcons.burger,
      tab: () => const OrdersQueueTab(),
    ),
    CardItem(
      title: 'Historial de ordenes',
      icon: FontAwesomeIcons.fileLines,
      tab: () => const HistoricalOrdersTab(),
    ),
    CardItem(
      title: 'Inventario',
      icon: FontAwesomeIcons.boxesStacked,
      tab: () => const InventoryTab(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrawerLayout(
        drawerChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SafeArea(child: SizedBox.shrink()),
            const ImageApi(
              'https://i0.wp.com/takuma.com.co/wp-content/uploads/2021/06/2021-logo.png',
              width: 185,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 20),
            const Text(
              'Chef',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ..._items.asMap().entries.map(
                  (entry) => DrawerItemCard(
                    item: entry.value,
                    onTap: () => setState(() => _index = entry.key),
                    isSelected: _index == entry.key,
                  ),
                ),
            const Spacer(),
            DrawerItemCard(
              onTap: () {},
              item: CardItem(
                title: 'Cerrar sesión',
                icon: Icons.logout,
                tab: () => const SizedBox(),
              ),
              isSelected: false,
            ),
            const SizedBox(height: 10),
            const Text(
              'On Your Table',
              style: TextStyle(
                fontSize: 14,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SafeArea(top: false, child: SizedBox.shrink()),
          ],
        ),
        bodyChild: _items[_index].tab(),
      ),
    );
  }
}
