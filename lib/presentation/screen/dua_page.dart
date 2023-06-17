import 'package:digiquran/common/color.dart';
import 'package:digiquran/common/font.dart';
import 'package:digiquran/common/gap.dart';
import 'package:digiquran/data/repository/repostiory.dart';
import 'package:flutter/material.dart';

class DuaPage extends StatefulWidget {
  const DuaPage({super.key});
  static const routeName = '/dua-page';

  @override
  State<DuaPage> createState() => _DuaPageState();
}

class _DuaPageState extends State<DuaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_left_rounded,
            size: 40,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Daily Dua',
          style: firaSansH2.copyWith(
            color: secondaryColor,
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Repository().getDuaList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => const VerticalGap5(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: secondaryColor,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            data.name,
                            style: firaSansH3.copyWith(color: primaryColor),
                          ),
                          const VerticalGap10(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  data.arabic,
                                  style: firaSansS1,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          const VerticalGap5(),
                          Text(
                            data.latin,
                            style: firaSansH5.copyWith(
                              color: primaryColor,
                            ),
                          ),
                          const VerticalGap5(),
                          Text(data.translation, style: firaSansS2),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
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
