import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/models/visit_model.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("visits").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount:
                      snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final List<VisitModel> visitModels = snapshot.data!.docs
                        .map((e) => VisitModel.fromFirestore(e))
                        .toList();
                    final vmodel = visitModels[index];
                    return ListTile(
                      title: Text(vmodel.purpose),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(vmodel.doctor.name),
                          Text(vmodel.date),
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
