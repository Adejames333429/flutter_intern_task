import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_intern_task/data/notifier.dart';
import 'package:http/http.dart' as http;

// ContainerWidget that accepts a user
class ContainerWidget extends StatelessWidget {
  final Map<String, dynamic> user;

  const ContainerWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(18.0),
            // boxShadow: [
            //   BoxShadow(
            //     color:
            //         isDarkMode
            //             ? Colors.white.withOpacity(
            //               0.1,
            //             ) // subtle light shadow in dark mode
            //             : Colors.black.withOpacity(
            //               0.1,
            //             ), // subtle dark shadow in light mode
            //     offset: const Offset(0, 3), // horizontal, vertical offset
            //     blurRadius: 6.0, // how soft the shadow is
            //     spreadRadius: 0.0, // how much the shadow spreads
            //   ),
            // ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Image.asset(
                    'assets/images/background3.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['company']['catchPhrase'], // catchPhrase
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        const CircleAvatar(radius: 8.0),
                        const SizedBox(width: 8),
                        Text(
                          user['username'], // username
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF929292),
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        const Icon(
                          Icons.access_time,
                          color: Color(0xFF929292),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '5min',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF929292),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
