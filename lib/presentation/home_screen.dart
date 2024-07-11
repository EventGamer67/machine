import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machine/presentation/app_bar.dart';
import 'package:machine/presentation/blocks/contacts_block.dart';
import 'package:machine/presentation/blocks/footer_block.dart';
import 'package:machine/presentation/blocks/gallery_block.dart';
import 'package:machine/presentation/blocks/main_block.dart';
import 'package:machine/presentation/blocks/map_block.dart';
import 'package:machine/presentation/blocks/ticket_block.dart';
import 'package:machine/presentation/logic/home_provider.dart';
import 'package:machine/presentation/logic/products_provider.dart';
import 'package:machine/presentation/shared/tools.dart';

import 'blocks/products_block.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        controller: ref.watch(homeScreenProvider).scrollController,
        scrollBehavior: MyCustomScrollBehavior(),
        slivers: const [
          MyAppBar(),
          SliverToBoxAdapter(
            child: SelectionArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MainBlock(),
                  GalleryBlock(),
                  // Builder(builder: (context) {
                  //   return ref.watch(productsProvider).when(data: (data) {
                  //     log(data.toString());
                  //     if (data.isEmpty) {
                  //       return const SizedBox.shrink();
                  //     }
                  //     return ProductsBlock(products: data);
                  //   }, error: (error, trace) {
                  //     return const SizedBox.shrink();
                  //   }, loading: () {
                  //     return const SizedBox.shrink();
                  //   });
                  // }),
                  TicketBlock(),
                  MapBlock(),
                  ContactsBlock(),
                  Footer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
