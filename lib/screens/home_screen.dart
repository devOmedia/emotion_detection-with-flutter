import 'package:emotion_detection/services/apiservice.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;

  final TextEditingController _editingController = TextEditingController();

  ApiService _apiService = ApiService();

  Future<SentAna>? analysis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.004, 1],
            colors: [Color(0xffe100ff), Color(0xFF8e2de2)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Check Mental Health',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 112, 111, 111)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                        ),
                      ]),
                  child: _loading
                      ? Column(
                          children: [
                            TextFormField(
                              controller: _editingController,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Enter the sentence',
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        )
                      : const CircularProgressIndicator()),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      analysis = _apiService
                          .post(query: {"text": _editingController.text});
                    });
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'Find Emotions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<SentAna>(
                future: analysis,
                builder: (context, snapshort) {
                  if (snapshort.hasData) {
                    return Text(
                      'Prediction is: ' + snapshort.data!.emotions.toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    );
                  } else if (snapshort.hasError) {
                    return Text("${snapshort.error}");
                  }

                  return SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
