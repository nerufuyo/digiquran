import 'package:digiquran/common/color.dart';
import 'package:digiquran/common/font.dart';
import 'package:digiquran/common/gap.dart';
import 'package:digiquran/data/repository/repostiory.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});
  static const routeName = '/quran-page';

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  late TabController tabController;
  int surahNumber = 1;
  List<String> surahLatin = [];

  void getSurahLatin() {
    Repository().getSurahList().then((value) {
      for (var item in value) {
        surahLatin.add(item.latin.toString());
      }
    });
  }

  @override
  void initState() {
    getSurahLatin();
    tabController = TabController(length: 114, vsync: this);
    tabController.addListener(() {
      setState(() {
        surahNumber = tabController.index + 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: FutureBuilder(
        future:
            Repository().getSurahByNumber(surahNumber: surahNumber.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return NestedScrollView(
              headerSliverBuilder: (context, index) {
                return [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: secondaryColor,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_left_rounded,
                        color: tertiaryColor,
                        size: 40,
                      ),
                    ),
                    title: Text(
                      'Quran',
                      style: firaSansH2.copyWith(
                        color: tertiaryColor,
                      ),
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Bootstrap.search,
                          color: tertiaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(44),
                      child: TabBar(
                        controller: tabController,
                        automaticIndicatorColorAdjustment: true,
                        indicator: UnderlineTabIndicator(
                          borderSide: const BorderSide(
                            color: primaryColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          insets: const EdgeInsets.symmetric(vertical: 4),
                        ),
                        indicatorPadding: EdgeInsets.zero,
                        isScrollable: true,
                        indicatorWeight: 0,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: primaryColor,
                        labelColor: primaryColor,
                        unselectedLabelColor: tertiaryColor,
                        tabs: List.generate(
                          surahLatin.length,
                          (index) => Tab(
                            child: Text(
                              surahLatin[index],
                              style: firaSansH5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: tabController,
                children: surahLatin.map((e) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data!.arabic.toString(),
                              style: firaSansH3.copyWith(color: secondaryColor),
                            ),
                            Text(
                              '${data.totalAyat} Aya, ${data.location}',
                              style: firaSansH4.copyWith(color: secondaryColor),
                            ),
                          ],
                        ),
                      ),
                      const VerticalGap10(),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 1.25,
                          ),
                          itemCount: data.ayat!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        data.ayat![index].arabic.toString(),
                                        style: firaSansH3.copyWith(
                                          color: primaryColor,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                const VerticalGap10(),
                                Text(
                                  data.ayat![index].latin.toString(),
                                  style: firaSansH5.copyWith(
                                    color: primaryColor,
                                  ),
                                ),
                                const VerticalGap10(),
                                Text(
                                  data.ayat![index].translation.toString(),
                                  style: firaSansS3.copyWith(
                                    color: tertiaryColor,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString(), style: firaSansH4),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
