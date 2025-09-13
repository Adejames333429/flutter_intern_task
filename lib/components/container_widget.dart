import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ContainerWidget that accepts a user
class ContainerWidget extends StatelessWidget {
  final Map<String, dynamic> user;

  const ContainerWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
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
  }
}
