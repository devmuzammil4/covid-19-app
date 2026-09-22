import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covid_19_app/services/state_services.dart';

import 'countries_screen.dart';

class StateScreen extends StatefulWidget {
  const StateScreen({super.key});

  @override
  State<StateScreen> createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> with TickerProviderStateMixin {
  StatesServices statesServices = StatesServices();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            // Yahan humne FutureBuilder laga diya hai
            child: FutureBuilder(
              future: statesServices.fetchWorldStatesRecords(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 1. Jab data load ho raha ho toh loading spinner dikhao
                  return Expanded(
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 50.0,
                        controller: _controller,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // 2. Agar koi error aa jaye toh error message dikhao
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  // 3. Jab data kamyabi se aa jaye toh UI render karo
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'World States UI Layout',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),

                        // Pie Chart mein Asli Data (snapshot se)
                        PieChart(
                          dataMap: {
                            "Total": double.parse(snapshot.data['cases'].toString()),
                            "Recovered": double.parse(snapshot.data['recovered'].toString()),
                            "Deaths": double.parse(snapshot.data['deaths'].toString()),
                          },
                          animationDuration: const Duration(milliseconds: 1200),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 4.8,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 20,
                          legendOptions: const LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.left,
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                            decimalPlaces: 1,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Saari Rows Card ke andar (Asli Data ke sath)
                        Card(
                          child: Column(
                            children: [
                              ReusableRow(title: 'Total Cases', value: snapshot.data['cases'].toString()),
                              ReusableRow(title: 'Deaths', value: snapshot.data['deaths'].toString()),
                              ReusableRow(title: 'Recovered', value: snapshot.data['recovered'].toString()),
                              ReusableRow(title: 'Active', value: snapshot.data['active'].toString()),
                              ReusableRow(title: 'Critical', value: snapshot.data['critical'].toString()),
                              ReusableRow(title: 'Today Deaths', value: snapshot.data['todayDeaths'].toString()),
                              ReusableRow(title: 'Today Recovered', value: snapshot.data['todayRecovered'].toString()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Track Countries Button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable Row Widget
class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}