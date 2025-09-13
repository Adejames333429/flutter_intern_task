import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_intern_task/components/constants.dart';
import 'package:flutter_intern_task/screens/posts_page.dart';
import 'package:http/http.dart' as http;
import '../components/container_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Fetch users when widget loads
  }

  Future<void> fetchUsers() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
      headers: {"User-Agent": "FlutterApp/1.0", "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
      });
    } else {
      print("Failed to load users: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: const Color(0xFFF4F4F4),
              floating: true,
              snap: true,
              pinned: false,
              elevation: innerBoxIsScrolled ? 4 : 0,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.dark_mode, color: Colors.black),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.search, color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(radius: 15),
                ),
              ],
            ),
          ];
        },
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Conteúdo diário', style: KTextStyle.homePageText1),
                    Text('Recomendação', style: KTextStyle.homePageText2),
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(users.length, (index) {
                      final user = users[index];
                      final bgImage =
                          'assets/images/background${index % 3 + 1}.jpg';
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => PostsPage(
                                    user: user,
                                    backgroundImage: bgImage,
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          width: 201.0,
                          height: 304.0,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(bgImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
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
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(radius: 10.0),
                                        const SizedBox(width: 12.0),
                                        Text(
                                          user['username'],
                                          style: KTextStyle.cardhomePageText2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
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
                users.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ContainerWidget(user: user);
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
