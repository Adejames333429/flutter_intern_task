import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,

      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween, // space between text and avatar
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Acampamento na represa: como se proteger!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 8.0), // adjust radius if needed
                          SizedBox(width: 8),
                          Text(
                            'João',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF929292),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 15.0),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Color(0xFF929292),
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
