import 'package:project_app/model/items.dart';

class ShopList {
  String name;
  List<Items>? items;

  ShopList({required this.name});

   void addItem(Items item) {
    items?.add(item);
  }

  // Método para editar um item na lista de compras
  void editItem(int index, Items newItem) {
    items?[index] = newItem;
  }

  // Método para remover um item da lista de compras
  void removeItem(int index) {
    items?.removeAt(index);
  }
}