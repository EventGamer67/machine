import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine/data/ticket_model.dart';
import 'package:machine/presentation/colors.dart';
import 'package:machine/presentation/logic/home_provider.dart';
import 'package:machine/presentation/shared/blur.dart';
import 'package:machine/presentation/widgets/my_textfield.dart';
import 'package:machine/presentation/widgets/triangle_painter.dart';
import 'package:octo_image/octo_image.dart';

final formProvider = ChangeNotifierProvider<FormData2>((ref) {
  return FormData2();
});

class FormData2 extends ChangeNotifier {
  String? name;
  String? vin;
  String? email;
  String? part;
  String? phone;

  bool isFieldsAllNotEmpty() =>
      name != null &&
      name!.isNotEmpty &&
      vin != null &&
      vin!.isNotEmpty &&
      email != null &&
      part!.isNotEmpty &&
      phone != null &&
      phone!.isNotEmpty;

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

class TicketBlock extends ConsumerStatefulWidget {
  const TicketBlock({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketBlockState();
}

class _TicketBlockState extends ConsumerState<TicketBlock> {
  int selectedAnswer = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1350,
      child: Stack(
        children: [
          OctoImage(
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox();
              },
              fit: BoxFit.cover,
              height: 1350,
              width: MediaQuery.of(context).size.width,
              placeholderBuilder:
                  blurHashPlaceholderBuilder("LFD]rG^+M{M{0000xu-;~q~qWBD%"),
              image: const CachedNetworkImageProvider(
                  "https://regionavto164.ru/wp-content/uploads/2021/04/w_f994e09b.jpg")),
          Container(
            padding: const EdgeInsets.only(right: 50, left: 50, top: 300),
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20)),
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    const Icon(
                      Icons.car_crash_sharp,
                      size: 200,
                      color: Colors.white,
                    ),
                    Text(
                      "ОСТАВЬТЕ ЗАЯВКУ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            MediaQuery.sizeOf(context).width > 1000 ? 40 : 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Менеджер свяжется с вами в течении 15 минут.\nОтветит на все вопросы и поможет оформить заказ.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize:
                            MediaQuery.sizeOf(context).width > 1000 ? 24 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    MyTextField(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                      hint: 'Ваше имя *',
                      errorText: ref.watch(formProvider).name == ''
                          ? "Поле не может быть пустым"
                          : null,
                      onChanged: (value) {
                        ref.read(formProvider).name = value;
                        ref.read(formProvider).notifyListeners();
                      },
                    ),
                    MyTextField(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                      hint: 'Ваш телефон *',
                      errorText: ref.watch(formProvider).phone == ''
                          ? "Поле не может быть пустым"
                          : null,
                      onChanged: (value) {
                        ref.read(formProvider).phone = value;
                        ref.read(formProvider).notifyListeners();
                      },
                    ),
                    MyTextField(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                      hint: 'Ваша почта *',
                      errorText: ref.watch(formProvider).email == ''
                          ? "Поле не может быть пустым"
                          : null,
                      onChanged: (value) {
                        ref.read(formProvider).email = value;
                        ref.read(formProvider).notifyListeners();
                      },
                    ),
                    MyTextField(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                      hint: 'VIN номер автомобиля *',
                      errorText: ref.watch(formProvider).vin == ''
                          ? "Поле не может быть пустым"
                          : null,
                      onChanged: (value) {
                        ref.read(formProvider).vin = value;
                        ref.read(formProvider).notifyListeners();
                      },
                    ),
                    MyTextField(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                      hint: 'Запчасть *',
                      errorText: ref.watch(formProvider).part == ''
                          ? "Поле не может быть пустым"
                          : null,
                      onChanged: (value) {
                        ref.read(formProvider).part = value;
                        ref.read(formProvider).notifyListeners();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            "Предпочтительный способ связи:",
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedAnswer = 1;
                                  });
                                },
                                child: AnimatedOpacity(
                                  opacity: selectedAnswer == 1 ? 1 : 0.6,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.phone,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              "Телефон",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.green),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedAnswer = 2;
                                  });
                                },
                                child: AnimatedOpacity(
                                  opacity: selectedAnswer == 2 ? 1 : 0.6,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.email,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Почта",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedAnswer = 3;
                                  });
                                },
                                child: AnimatedOpacity(
                                  opacity: selectedAnswer == 3 ? 1 : 0.6,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.green),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: SvgPicture.asset(
                                                'assets/whatsapp.svg',
                                                width: 40,
                                                height: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Whatsapp",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedAnswer = 4;
                                  });
                                },
                                child: AnimatedOpacity(
                                  opacity: selectedAnswer == 4 ? 1 : 0.6,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            const Color.fromARGB(255, 119, 101, 242)),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: SvgPicture.asset(
                                                'assets/viber.svg',
                                                width: 40,
                                                height: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Viber",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final pr = ref.read(formProvider);
                        if (ref.watch(formProvider).isFieldsAllNotEmpty()) {
                          final ticket = Ticket(
                              name: pr.name,
                              phone: pr.phone,
                              vin: pr.vin,
                              part: pr.part,
                              answer: selectedAnswer,
                              mail: pr.email);

                          ref
                              .read(homeScreenProvider)
                              .sendMessage(ticket, context);
                        } else {}
                      },
                      style: const ButtonStyle(
                          textStyle:
                              WidgetStatePropertyAll<TextStyle>(TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                          foregroundColor:
                              WidgetStatePropertyAll<Color>(Colors.black),
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(Colors.white)),
                      child: const Text("ОТПРАВИТЬ"),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: CustomPaint(
              size: const Size(double.infinity, 120),
              painter: TrianglePainter(
                  flipVertical: true,
                  flipHorizontal: true,
                  color: MyColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
