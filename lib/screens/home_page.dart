import 'package:flutter/material.dart';
import 'package:flutter_intern_task/components/constants.dart';

import '../components/container_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.dark_mode)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(radius: 15),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Conteúdo diário', style: KTextStyle.homePageText1),
                    Text('Recomendação', style: KTextStyle.homePageText2),
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(3, (index) {
                      return Container(
                        width: 201.0,
                        // card width
                        height: 304.0,
                        // card height
                        margin: EdgeInsets.only(right: 16),
                        // space between cards
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/background${index + 1}.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Align(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Passeios em veneza: como gastar economizar',
                                  style: KTextStyle.cardhomePageText,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(radius: 10.0),
                                      SizedBox(width: 12.0),
                                      Text(
                                        'João',
                                        style: KTextStyle.cardhomePageText2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Top', style: KTextStyle.scrollRow2),
                      Text('Popular', style: KTextStyle.scrollRow),
                      Text('Trending', style: KTextStyle.scrollRow),
                      Text('Favoritos', style: KTextStyle.scrollRow),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ContainerWidget(),
                    SizedBox(height: 15.0),
                    ContainerWidget(),
                    SizedBox(height: 15.0),
                    ContainerWidget(),
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
