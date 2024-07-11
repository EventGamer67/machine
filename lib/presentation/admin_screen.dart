import 'dart:developer';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine/data/ticket_model.dart';
import 'package:machine/domain/api.dart';
import 'package:machine/presentation/blocks/products_block.dart';
import 'package:machine/presentation/home_screen.dart';
import 'package:machine/presentation/logic/home_provider.dart';
import 'package:machine/presentation/logic/products_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final ticketsProvider = FutureProvider.autoDispose<List<Ticket>>((ref) async {
  final response =
      await GetIt.I.get<Supabase>().client.from('Tickets').select('*');

  final res = response.map((e) => Ticket.fromMap(e)).toList();
  res.sort((a, b) => b.created!.compareTo(a.created!));
  return res;
});

final adminPanelProvider = ChangeNotifierProvider<AdminPanelProvider>((ref) {
  return AdminPanelProvider();
});

enum Screens { tickets, products }

class NewProductDialog extends ConsumerStatefulWidget {
  const NewProductDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewProductDialogState();
}

class _NewProductDialogState extends ConsumerState<NewProductDialog> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");
  double? price;
  XFile? image;
  Uint8List? bytes;

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Новый товар",
                    style: GoogleFonts.raleway(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    image = await picker.pickImage(source: ImageSource.gallery);
                    if (image == null) {
                      return;
                    }
                    bytes = await image!.readAsBytes();
                    setState(() {});
                  },
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 200, maxHeight: 200),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: bytes == null
                            ? const Center(
                                child: Text("Выберите изображение"),
                              )
                            : Image.memory(bytes!),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Название'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Описание'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: priceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'))
                    ],
                    decoration: const InputDecoration(labelText: 'Цена'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black.withOpacity(0.4)),
                        child: Center(
                          child: Text("Отмена",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        log("message 1");
                        if (bytes == null) {
                          return;
                        }
                        try {
                          price = double.tryParse(priceController.text);
                        } catch (e) {
                          log(e.toString());
                          return;
                        }

                        log("message 2");

                        if (price == null) {
                          log("null price");
                          return;
                        }

                        String name = const Uuid().v1();
                        log("messsage 9");
                        final img = await GetIt.I
                            .get<Supabase>()
                            .client
                            .storage
                            .from('images')
                            .uploadBinary("$name.png", bytes!);
                        final image = GetIt.I
                            .get<Supabase>()
                            .client
                            .storage
                            .from('images')
                            .getPublicUrl("$name.png");

                        log("message 3");

                        final Product pr = Product(
                            id: -1,
                            name: nameController.text,
                            desc: descController.text,
                            price: price!,
                            url: image,
                            createdAt: DateTime.now());

                        final res = await Api.newProduct(pr);

                        log("message 4");

                        if (res) {
                          Navigator.of(context).pop(res);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Заявка обновлена")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Что-то пошло не так")));
                          return;
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.primary),
                        child: Center(
                          child: Text("Добавить",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditProductDialog extends ConsumerStatefulWidget {
  final Product product;
  const EditProductDialog({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProductDialogState();
}

class _EditProductDialogState extends ConsumerState<EditProductDialog> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");
  double? price;
  XFile? image;
  Uint8List? bytes;

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.product.name);
    descController = TextEditingController(text: widget.product.desc);
    priceController = TextEditingController(
        text: widget.product.price.toString().replaceAll(',', '.'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Новый товар",
                    style: GoogleFonts.raleway(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    image = await picker.pickImage(source: ImageSource.gallery);
                    if (image == null) {
                      return;
                    }
                    bytes = await image!.readAsBytes();
                    setState(() {});
                  },
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 200, maxHeight: 200),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: bytes == null
                            ? CachedNetworkImage(imageUrl: widget.product.url)
                            : Image.memory(bytes!),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Название'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Описание'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: priceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'))
                    ],
                    decoration: const InputDecoration(labelText: 'Цена'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black.withOpacity(0.4)),
                        child: Center(
                          child: Text("Отмена",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        log("message 1");
                        try {
                          price = double.tryParse(priceController.text);
                        } catch (e) {
                          log(e.toString());
                          return;
                        }

                        log("message 2");

                        if (price == null) {
                          log("null price");
                          return;
                        }

                        String? imagess;

                        if (bytes == null) {
                          imagess = widget.product.url;
                        } else {
                          String name = const Uuid().v1();
                          log("messsage 9");
                          final img = await GetIt.I
                              .get<Supabase>()
                              .client
                              .storage
                              .from('images')
                              .uploadBinary("$name.png", bytes!);
                           imagess = GetIt.I
                              .get<Supabase>()
                              .client
                              .storage
                              .from('images')
                              .getPublicUrl("$name.png");
                        }

                        log("message 3");

                        final Product pr = Product(
                            id: widget.product.id,
                            name: nameController.text,
                            desc: descController.text,
                            price: price!,
                            url: imagess??widget.product.url,
                            createdAt: DateTime.now());

                        final res = await Api.editProduct(pr);

                        log("message 4");

                        if (res) {
                          Navigator.of(context).pop(res);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Товар обновлен")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Что-то пошло не так")));
                          return;
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.primary),
                        child: Center(
                          child: Text("Сохранить",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminPanelProvider extends ChangeNotifier {
  Screens currentScreen = Screens.tickets;

  setScreen(Screens screen) {
    currentScreen = screen;
    notifyListeners();
  }

  Future<void> createProduct(BuildContext context) async {
    final bool res = await showDialog(
        context: context,
        builder: (context) {
          return const NewProductDialog();
        });
  }

  Future<void> editProduct(Product pr, BuildContext context) async {
    final res = await await showDialog(
        context: context,
        builder: (context) {
          return EditProductDialog(product: pr,);
        });
    // if (res) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Товар обновлен")));
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Что-то пошло не так")));
    // }
  }

  Future<void> deleteProduct(Product pr, BuildContext context) async {
    final res = await Api.deleteProduct(pr);
    if (res) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Товар удален")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Что-то пошло не так")));
    }
  }
}

class AdminPanel extends ConsumerStatefulWidget {
  const AdminPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminPanelState();
}

class _AdminPanelState extends ConsumerState<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ListView(
                children: [
                  const Header(),
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Builder(builder: (context) {
                    switch (ref.watch(adminPanelProvider).currentScreen) {
                      case Screens.tickets:
                        return ref.watch(ticketsProvider).when(data: (data) {
                          return TicketsVIew(data: data);
                        }, error: (error, trace) {
                          return Center(
                            child: Text(error.toString()),
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      case Screens.products:
                        return ref.watch(productsProvider).when(data: (data) {
                          return ProductsView(products: data);
                        }, error: (error, trace) {
                          return Center(
                            child: Text(error.toString()),
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      default:
                        return const SizedBox.shrink();
                    }
                  }),
                ],
              )),
        ),
      ),
    );
  }
}

class ProductsView extends ConsumerStatefulWidget {
  final List<Product> products;
  const ProductsView({super.key, required this.products});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () async {
              await ref.read(adminPanelProvider).createProduct(context);
              ref.refresh(productsProvider);
            },
            child: Container(
              height: 60,
              width: 150,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.primary),
              child: Center(
                child: Text("Новый товар",
                    style:
                        GoogleFonts.roboto(color: Colors.white, fontSize: 20)),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
              spacing: 10,
              children: List.generate(widget.products.length, (index) {
                return ProductTileAdmin(
                  product: widget.products[index],
                );
              })),
        )
      ],
    );
  }
}

class ProductTileAdmin extends ConsumerWidget {
  final Product product;
  const ProductTileAdmin({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 190,
            height: 190,
            alignment: Alignment.center,
            child: CachedNetworkImage(
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
                imageUrl: product.url),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                product.name,
                style: const TextStyle(color: Colors.black, fontSize: 30),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                product.desc,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 1,
              )),
          const Expanded(child: SizedBox()),
          Align(
              alignment: Alignment.bottomRight,
              child: Text("${product.price}₽",
                  style: const TextStyle(color: Colors.black, fontSize: 30))),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await ref
                        .read(adminPanelProvider)
                        .deleteProduct(product, context);
                    ref.refresh(productsProvider);
                  },
                  icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () async {
                    await ref.read(adminPanelProvider).editProduct(product, context);
                    ref.refresh(productsProvider);
                  },
                  icon: const Icon(Icons.edit))
            ],
          )
        ],
      ),
    );
  }
}

class TicketsVIew extends StatelessWidget {
  final List<Ticket> data;
  const TicketsVIew({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: List.generate(data.length, (index) {
              final ticket = data[index];
              return TicketTile(ticket: ticket);
            }),
          ),
        ),
      ],
    );
  }
}

class Header extends ConsumerWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenName =
        ref.watch(adminPanelProvider).currentScreen == Screens.tickets
            ? "Заявки"
            : "Товары";
    return SizedBox(
      child: MediaQuery.sizeOf(context).width > 650
          ? Row(
              children: [
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      screenName,
                      maxLines: 1,
                      style: GoogleFonts.raleway(
                          fontSize: 60,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    ref.read(adminPanelProvider).setScreen(Screens.products);
                  },
                  child: Container(
                    height: 60,
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primary),
                    child: Center(
                      child: Text("Товары",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    ref.read(adminPanelProvider).setScreen(Screens.tickets);
                  },
                  child: Container(
                    height: 60,
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primary),
                    child: Center(
                      child: Text("Заявки",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primary),
                    child: Center(
                      child: Text("Главный экран",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    await GetIt.I.get<Supabase>().client.auth.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.redAccent),
                    child: Center(
                      child: Text("Выйти из аккаунта",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
              ],
            )
          : Column(children: [
              Text(
                screenName,
                maxLines: 1,
                style: GoogleFonts.raleway(
                    fontSize: 60,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.primary),
                        child: Center(
                          child: Text("Главный экран",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.redAccent),
                        child: Center(
                          child: Text("Выйти из аккаунта",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
    );
  }
}

class TicketTile extends ConsumerWidget {
  const TicketTile({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 3)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Статус: ",
                style: GoogleFonts.raleway(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                ticket.getStatus.$1,
                style: TextStyle(
                    fontSize: 24,
                    color: ticket.getStatus.$2,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () async {
                    log("message");
                    final int res = await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Выберите новый статус заявки",
                                      style: GoogleFonts.roboto(
                                        fontSize: 24,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context, 0);
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.blue),
                                        child: Center(
                                          child: Text("Новая заявка",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context, 1);
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.yellow),
                                        child: Center(
                                          child: Text("В работе",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context, 2);
                                      },
                                      child: Container(
                                        width: 220,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.green),
                                        child: Center(
                                          child: Text("Завершена",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                        });
                    log(res.toString());

                    ticket.status = res;
                    await ref
                        .read(homeScreenProvider)
                        .updateTicket(ticket, context);
                    ref.refresh(ticketsProvider);
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          Text(
            "Имя",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.name ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          // Text(
          //   "Почта",
          //   style: GoogleFonts.raleway(
          //       fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          // ),
          // Text(
          //   ticket.mail ?? '',
          //   style: const TextStyle(fontSize: 20),
          // ),
          Text(
            "Телефон",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.phone ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "VIN",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.vin ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Запчасть",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.part ?? '',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Способ связи",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            ticket.answer == 1
                ? "Телефон"
                : ticket.answer == 3
                    ? "Whatsapp"
                    : ticket.answer == 4
                        ? "Viber"
                        : "Почта",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Отправлена",
            style: GoogleFonts.raleway(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            '${ticket.created!.year}.${ticket.created!.month}.${ticket.created!.day} - ${ticket.created!.hour > 9 ? ticket.created!.hour : '0${ticket.created!.hour}'}:${ticket.created!.minute > 9 ? ticket.created!.minute : '0${ticket.created!.minute}'}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final res = await showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Вы действительно хотите удалить заявку?",
                                    style: GoogleFonts.roboto(
                                      fontSize: 24,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context, false);
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          child: Center(
                                            child: Text("Нет",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context, true);
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.redAccent),
                                          child: Center(
                                            child: Text("Да",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                      });

                  if (res) {
                    await ref
                        .read(homeScreenProvider)
                        .deleteTicket(ticket, context);
                    ref.refresh(ticketsProvider);
                  }
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.redAccent.withOpacity(0.7)),
                  child: Center(
                    child: Text("Удалить заявку",
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
