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
import 'package:machine/presentation/shared/tools.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MainBlock(),
                GalleryBlock(),
                TicketBlock(),
                MapBlock(),
                ContactsBlock(),
                Footer()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
