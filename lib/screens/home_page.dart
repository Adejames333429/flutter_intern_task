import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_intern_task/components/constants.dart';
import 'package:flutter_intern_task/screens/posts_page.dart';
import 'package:http/http.dart' as http;
import '../components/container_widget.dart';
import '../data/notifier.dart';

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
    fetchUsers();
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
    final theme = Theme.of(context); // Theme-aware colors
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: isDarkMode ? Color(0xFF151515) : Color(0xFFF4F4F4),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor:
                      isDarkMode ? Color(0xFF151515) : Color(0xFFF4F4F4),
                  floating: true,
                  snap: true,
                  pinned: false,
                  elevation: innerBoxIsScrolled ? 4 : 0,
                  leading: IconButton(
                    onPressed: () {
                      isDarkModeNotifier.value = !isDarkModeNotifier.value;
                    },
                    icon: ValueListenableBuilder(
                      valueListenable: isDarkModeNotifier,
                      builder: (context, isDarkMode, child) {
                        return Icon(
                          isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          color: theme.iconTheme.color,
                        );
                      },
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.search, color: theme.iconTheme.color),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(radius: 15),
                    ),
                  ],
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conteúdo diário',
                        style: KTextStyle.homePageText1.copyWith(
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                      Text(
                        'Recomendação',
                        style: KTextStyle.homePageText2.copyWith(
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
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
                                      style: KTextStyle.cardhomePageText
                                          .copyWith(
                                            color:
                                                theme.brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.white,
                                          ),
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
                                            style: KTextStyle.cardhomePageText2
                                                .copyWith(
                                                  color:
                                                      theme.brightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : Colors.white,
                                                ),
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
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top',
                          style: KTextStyle.scrollRow2.copyWith(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                        Text(
                          'Popular',
                          style: KTextStyle.scrollRow.copyWith(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                        Text(
                          'Trending',
                          style: KTextStyle.scrollRow.copyWith(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                        Text(
                          'Favoritos',
                          style: KTextStyle.scrollRow.copyWith(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  users.isEmpty
                      ? Center(
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.primary,
                        ),
                      )
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
        );
      },
    );
  }
}
