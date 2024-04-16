import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_app/model/shopList.dart';
 
class ShopListView extends StatefulWidget {
  const ShopListView({super.key});
 
  @override
  State<ShopListView> createState() => _ShopListViewState();
}

class _ShopListViewState extends State<ShopListView> {
  var formKey = GlobalKey<FormState>();
  List<ShopList> shopLists = [];

  @override
  Widget build(BuildContext context) {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _dialogBuilder(context);
                    },
                    child: Text(
                      'Criar uma lista',
                      style: TextStyle(color: Colors.blue.shade500),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            // Exibir as listas de compras
            ListView.builder(
              shrinkWrap: true,
              itemCount: shopLists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(shopLists[index].name),
                  subtitle: Text('Itens: ${shopLists[index].items?.length ?? 0}'),
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editListName(context, index);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removeList(context, index);
                    },
                  ),
                );
              },
            ),

          ],
        ),
      ),
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
}
