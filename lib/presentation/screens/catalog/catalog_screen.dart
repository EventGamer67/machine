import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine/presentation/admin_screen.dart';
import 'package:machine/presentation/blocks/products_block.dart';
import 'package:machine/presentation/screens/catalog/logic/search_catalog_provider.dart';
import 'package:machine/presentation/widgets/product_tile.dart';

import '../../logic/products_provider.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
          child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            expandedHeight: 85,
            floating: true,
            pinned: true,
            flexibleSpace: Container(
                height: 85,
                padding: const EdgeInsets.all( 10),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.15))
                ]),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/logo.jpg",
                            fit: BoxFit.fitHeight,
                            height: 85,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 45),
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.black.withOpacity(0.6))),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  onChanged: (value) {
                                    ref
                                        .read(searchProductsFilterProvider)
                                        .updateSearchText(value);
                                  },
                                  decoration: const InputDecoration.collapsed(
                                      hintText:
                                          "Введите наименование или артикул товара"),
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                    // const Expanded(child: TextField())
                  ],
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        children: [
                          // const SizedBox(
                          //   width: 260,
                          //   child: Column(
                          //     children: [],
                          //   ),
                          // ),
                          Expanded(
                            child: Builder(builder: (context) {
                              return ref.watch(searchProductsProvider).when(
                                  data: (products) {
                                if (products.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                // return GridView.builder(
                                //     shrinkWrap: true,
                                //     itemCount: products.length,
                                //     gridDelegate:
                                //         const SliverGridDelegateWithMaxCrossAxisExtent(
                                //             mainAxisSpacing: 20,
                                //             crossAxisSpacing: 20,
                                //             maxCrossAxisExtent: 400),
                                //     itemBuilder: (context, index) {
                                //       return ProductTile(
                                //         product: products[index],
                                //       );
                                //     });
                                return GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: 100,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisSpacing: 20,
                                            crossAxisSpacing: 20,
                                            maxCrossAxisExtent: 300),
                                    itemBuilder: (context, index) {
                                      return ProductTile(
                                        product: Product(
                                            id: -1,
                                            name: "name",
                                            desc: "desc",
                                            price: 100,
                                            url:
                                                "https://static.insales-cdn.com/images/products/1/5569/637908417/SUPREME_SYNTHETIC_PRO_SAE_0W-30_1_%D0%BB%D0%B8%D1%82%D1%80.png",
                                            createdAt: DateTime.now()),
                                      );
                                    });
                              }, error: (error, trace) {
                                return const SizedBox.shrink();
                              }, loading: () {
                                return GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: 20,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisSpacing: 20,
                                            crossAxisSpacing: 20,
                                            maxCrossAxisExtent: 400),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.15),
borderRadius: BorderRadius.circular(20)
                                        ),
                                      );
                                    });
                              });
                            }),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          )
        ],
      )),
    );
  }
}
