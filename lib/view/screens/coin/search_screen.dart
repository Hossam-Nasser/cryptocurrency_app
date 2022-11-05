import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intro_flutter/view_model/provider/coin/details_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/themes.dart';
import '../../../view_model/provider/coin/search_provider.dart';


class SearchScreen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    var detailsProvider = Provider.of<DetailsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Theme.of(context).cardColor,
                    ),
                    child: TextField(
                      onChanged: (value) {
                        // delay 1 second
                        Future.delayed(const Duration(seconds: 3), () {
                          print(value);
                          Provider.of<SearchProvider>(context, listen: false)
                            .getSearchCoin(value);
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 32,
                        ),
                        suffixIcon: Icon(Icons.cancel),
                        hintText: 'Search....',
                      ),
                    ),
                  ),
                  Expanded(
                    child: provider.searchCoins.length == 0
                        ?  Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/undraw_the_search.svg',
                                  width: 200,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Search for a coin ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //
                              ],
                            ),
                          ) : provider.searchCoins.length == 0 ?
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                        : ListView.builder(
                      physics: BouncingScrollPhysics(),
                            itemCount: provider.searchCoins.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  detailsProvider.getCoinDetails(
                                      provider.searchCoins[index].id);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 10, right: 10),
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Themes.isDarkMode(context)
                                          ? Color(0xff151f2c)
                                          : Colors.blueGrey[600],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            height: 60,
                                            width: 60,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Image.network(provider
                                                  .searchCoins[index].imageUrl),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    provider
                                                        .searchCoins[index].name,
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  provider
                                                      .searchCoins[index].symbol,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              // rank
                                              Column(
                                                children: [
                                                  Text(
                                                    'Rank',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey[200],
                                                    ),
                                                  ),
                                                  Text(
                                                    provider
                                                        .searchCoins[index].rank
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
