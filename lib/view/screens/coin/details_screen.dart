import 'package:flutter/material.dart';
import 'package:intro_flutter/view_model/provider/coin/details_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter_html/flutter_html.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DetailsProvider>(context);
    var data = [
      ChartData("1Y", provider.coinDetails?.percentChange_1y ?? 0),
      ChartData("6M", provider.coinDetails?.percentChange_200 ?? 0),
      ChartData("2M", provider.coinDetails?.percentChange_60 ?? 0),
      ChartData("1M", provider.coinDetails?.percentChange_30 ?? 0),
      ChartData("2W", provider.coinDetails?.percentChange_14 ?? 0),
      ChartData("1W", provider.coinDetails?.percentChange_7d ?? 0),
      ChartData("24H", provider.coinDetails?.percentChange_24h ?? 0),
    ];
    return Scaffold(
      body: SafeArea(
        child: provider.isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 230,
                            child: Image.network(
                              provider.coinDetails?.imgURL ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            provider.coinDetails?.name ?? "",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // rank text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                "Rank ",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    provider.coinDetails?.rank.toString() ?? "",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        provider.coinDetails?.symbol ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // price tab
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Price",
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "\$${provider.coinDetails?.currentPrice ?? ""}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${provider.coinDetails?.percentChange_24h ?? ""} %",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // check if the price is up or down with null safety
                                color:
                                    provider.coinDetails!.percentChange_24h > 0
                                        ? Colors.green
                                        : Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Color(0xff151f2c),
                        ),
                        child: Card(
                          color: Color(0xff151f2c),
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(isVisible: true,
                                majorGridLines: MajorGridLines(width: 1),
                                axisLine: AxisLine(width: 3, color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                                majorTickLines: MajorTickLines(size: 0),
                              ),
                              primaryYAxis: CategoryAxis(isVisible:false),
                              series: <ChartSeries<ChartData, String>>[
                                LineSeries(
                                  dataLabelSettings: DataLabelSettings(isVisible: true),
                                  color: Colors.green,
                                  width: 3,
                                  dataSource: data,
                                  xValueMapper: (ChartData sales, _) => sales.x.toString(),
                                  yValueMapper: (ChartData sales, _) => sales.y,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Description",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Html(
                        data: provider.coinDetails?.description ?? "",
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  String x;
  double y;
}
