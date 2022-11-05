import 'package:flutter/material.dart';
import 'package:intro_flutter/view_model/provider/coin/details_provider.dart';
import 'package:intro_flutter/view_model/provider/coin/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/themes.dart';


class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    var detailsProvider = Provider.of<DetailsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Crypto Currency'),
        ),
        body: provider.coins.length == 0 ? Center(child: CircularProgressIndicator(),): ListView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: provider.coins.length,
            itemBuilder:(context,index){
              return  GestureDetector(
                onTap: (){
                  detailsProvider.getCoinDetails(provider.coins[index].id);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 5, right: 10),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      //blue dark color hex
                      color: Themes.isDarkMode(context) ? Color(0xff151f2c) : Colors.blueGrey[600],
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Row(
                      children: [
                        //rank
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12,
                          ),
                          child: Container(
                            child: Center(
                              child: Text(
                                provider.coins[index].rank.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(provider.coins[index].imgURL),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    provider.coins[index].name,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  provider.coins[index].symbol,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                provider.coins[index].currentPrice.toDouble().toString() + '\$',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                provider.coins[index].priceChange.toDouble() < 0
                                    ? provider.coins[index].priceChange.toDouble().toString() + '\$'
                                    : '+' + provider.coins[index].priceChange.toDouble().toString() + '\$',
                                style: TextStyle(
                                  color: provider.coins[index].priceChange.toDouble() < 0 ? Colors.red : Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                provider.coins[index].priceChangePercentage.toDouble() < 0
                                    ? provider.coins[index].priceChangePercentage.toDouble().toString() + '%'
                                    : '+' + provider.coins[index].priceChangePercentage.toDouble().toString() + '%',
                                style: TextStyle(
                                  color: provider.coins[index].priceChangePercentage.toDouble() < 0
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
    ));
  }





}




