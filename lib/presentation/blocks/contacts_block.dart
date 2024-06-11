import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class ContactsBlock extends StatelessWidget {
  const ContactsBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/sky.jpg'))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      "Контакты магазина автозапчастей 'В ДЕТАЛЯХ'",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Column(
                        children: [
                          Text(
                            "Адрес:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "г. Саратов",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "ул. Астраханская 47",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Divider(
                          height: 2,
                          color: Colors.white,
                        )),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timelapse,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Column(
                        children: [
                          Text(
                            "Время работы:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Пн-вск: 9:00 - 21:00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Divider(
                          height: 2,
                          color: Colors.white,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.call,
                        color: Colors.lightGreen,
                        size: 50,
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Для связи:",
                            style: TextStyle(
                                color: Colors.lightGreen,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "+7 (987) 327-77-34",
                            style: TextStyle(
                                color: Colors.lightGreen,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "v.detalyah64@mail.ru",
                            style: TextStyle(
                                color: Colors.lightGreen,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          Link(
                            target: LinkTarget.blank,
                            uri: Uri.parse('https://vk.com/v.detalah'),
                            builder: (context, followLink) => GestureDetector(
                              onTap: followLink,
                              child: const Text(
                                "https://vk.com/v.detalah",
                                style: TextStyle(
                                    color: Colors.lightGreen,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
