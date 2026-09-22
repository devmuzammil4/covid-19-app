import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String image, name;
  final int totalCases, totalRecovered, totalDeaths, active, critical, todayDeaths, todayRecovered;

  const DetailScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalRecovered,
    required this.totalDeaths,
    required this.active,
    required this.critical,
    required this.todayDeaths,
    required this.todayRecovered,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .06),
                  child: Card(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                        ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                        ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                        ReusableRow(title: 'Critical', value: widget.critical.toString()),
                        ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Reusable Row Widget agar alag file mein na ho
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