import 'package:flutter/material.dart';
import 'package:flutter_intern_task/components/constants.dart';

import 'home_page.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background3.jpg",
            ), // your image here
            fit: BoxFit.cover, // makes it cover the whole screen
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 100.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Novo caminho', style: KTextStyle.pageText1),
                    Text('Blog de Viagem', style: KTextStyle.pageText2),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFAFAFA),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Center(
                        child: Text(
                          'ENTRAR',
                          style: KTextStyle.buttonTextWhite,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E5FDE),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Center(
                        child: Text('ENTRAR', style: KTextStyle.buttonTextBlue),
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
