import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:covid_19_app/services/state_services.dart';
import 'detail_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Container(height: 50, width: 60, color: Colors.grey.shade300),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(height: 10, width: 150, color: Colors.grey.shade300),
                                  const SizedBox(height: 5),
                                  Container(height: 10, width: 100, color: Colors.grey.shade300),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String countryName = snapshot.data![index]['country'];

                        if (searchController.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    todayDeaths: snapshot.data![index]['todayDeaths'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Image.network(
                                    snapshot.data![index]['countryInfo']['flag'],
                                    height: 50,
                                    width: 60,
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index]['country'],
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const SizedBox(height: 5),
                                      Text('Cases: ${snapshot.data![index]['cases']}'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        } else if (countryName.toLowerCase().contains(searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    todayDeaths: snapshot.data![index]['todayDeaths'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Image.network(
                                    snapshot.data![index]['countryInfo']['flag'],
                                    height: 50,
                                    width: 60,
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index]['country'],
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const SizedBox(height: 5),
                                      Text('Cases: ${snapshot.data![index]['cases']}'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}