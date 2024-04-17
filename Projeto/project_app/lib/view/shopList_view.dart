import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_app/model/items.dart';
import 'package:project_app/model/shopList.dart';
 
class ShopListView extends StatefulWidget {
  const ShopListView({Key? key}) : super(key: key);
 
  @override
  State<ShopListView> createState() => _ShopListViewState();
}

class _ShopListViewState extends State<ShopListView> {

  var formKey = GlobalKey<FormState>();
  List<ShopList> shopLists = [];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<ShopList> filteredLists = shopLists.where((list) {
      return list.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ShopList',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade500,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Pesquisar lista...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(width: 8),
                  
                  TextButton(
                    onPressed: () {
                      _dialogBuilder(context);
                    },
                    child: Text(
                      'Criar uma lista',
                      style: TextStyle(color: Colors.blue.shade500),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            ListView.builder(
              shrinkWrap: true,
              itemCount: filteredLists.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.grey.shade50,
                      child: ListTile(
                        title: Text(filteredLists[index].name),
                        subtitle: Text('Itens: ${filteredLists[index].items?.length ?? 0}'),
                        onTap: () {
                          setState(() {
                            filteredLists[index].showItems = !filteredLists[index].showItems;
                          });
                        },
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: filteredLists[index].isChecked,
                              onChanged: (value){
                                setState(() {
                                  filteredLists[index].isChecked = value!;
                                });
                              },
                            ),

                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editListName(context, index);
                              },
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                _addItem(context, index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _removeList(context, index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (shopLists[index].showItems && shopLists[index].items != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: shopLists[index].items!.map((item) {
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text('Quantidade: ${item.quantity}'),
                            leading: Checkbox(
                              value: item.isChecked,
                              onChanged: (value){
                                setState(() {
                                  item.isChecked = value!;
                                });
                              },
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _editItem(context, index, item);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _removeItem(context, index, item);
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addItem(BuildContext context, int listIndex) async {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemQuantityController = TextEditingController(); // Adiciona um novo TextEditingController para a quantidade
  final formKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Adicionar Item'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: itemNameController,
                decoration: InputDecoration(labelText: 'Nome do item'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome para o item.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: itemQuantityController,
                keyboardType: TextInputType.number, // Define o teclado para número para garantir que apenas números sejam inseridos
                decoration: InputDecoration(labelText: 'Quantidade'), // Adiciona um campo para inserção da quantidade
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade do item.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                String itemName = itemNameController.text;
                int itemQuantity = int.parse(itemQuantityController.text);
                setState(() {
                  if (shopLists[listIndex].items == null) {
                    shopLists[listIndex].items = [];
                  }
                  shopLists[listIndex].items!.add(Items(name: itemName, quantity: itemQuantity)); 
                });
                Navigator.of(context).pop();
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      );
    },
  );
}


  Future<void> _dialogBuilder(BuildContext context) async {
    final TextEditingController txtName = TextEditingController();
    final result = await showDialog<ShopList>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Criando uma lista'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: txtName,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira um nome.';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Criar'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  String nomeLista = txtName.text;
                  if (_isNomeUnico(nomeLista)) {
                    Navigator.of(context).pop(ShopList(name: nomeLista));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('O nome da lista já existe.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        shopLists.add(result);
      });
    }
  }

  bool _isNomeUnico(String nomeLista) {
    for (var lista in shopLists) {
      if (lista.name == nomeLista) {
        return false;
      }
    }
    return true;
  }

  void _editListName(BuildContext context, int index) async {
    final TextEditingController txtName = TextEditingController(text: shopLists[index].name);
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editando o nome da lista'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: txtName,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                labelText: 'Novo nome',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira um nome.';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop(txtName.text);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        shopLists[index].name = result;
      });
    }
  }

  void _removeList(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remover Lista'),
          content: Text('Tem certeza que deseja remover a lista "${shopLists[index].name}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  shopLists.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Remover'),
            ),
          ],
        );
      },
    );
  }

  void _editItem(BuildContext context, int listIndex, Items item) async {
  final TextEditingController itemNameController = TextEditingController(text: item.name);
  final TextEditingController itemQuantityController = TextEditingController(text: item.quantity.toString());
  final formKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar Item'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: itemNameController,
                decoration: InputDecoration(labelText: 'Nome do item'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome para o item.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: itemQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade do item.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                String itemName = itemNameController.text;
                int itemQuantity = int.parse(itemQuantityController.text);
                setState(() {
                  shopLists[listIndex].items![shopLists[listIndex].items!.indexOf(item)] = Items(name: itemName, quantity: itemQuantity);
                });
                Navigator.of(context).pop();
              }
            },
            child: Text('Salvar'),
          ),
        ],
      );
    },
  );
}

void _removeItem(BuildContext context, int listIndex, Items item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remover Item'),
        content: Text('Tem certeza que deseja remover o item "${item.name}"?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                shopLists[listIndex].items!.remove(item);
              });
              Navigator.of(context).pop();
            },
            child: Text('Remover'),
          ),
        ],
      );
    },
  );
}

}