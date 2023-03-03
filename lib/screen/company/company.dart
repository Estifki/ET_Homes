import 'package:flutter/material.dart';
import 'package:real_estate_project/model/company.dart';
import 'package:real_estate_project/services/company.dart';
import 'package:real_estate_project/utility/shimmer/company.dart';
import 'package:real_estate_project/widgets/company/company.dart';

import '../../const/const.dart';
import '../../widgets/noproperty_found.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  late Future<CompanyListModel> _companies;
  @override
  void initState() {
    _companies = CompanyApi().getCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Agents",
          style: appBarStyle(screenSize),
        ),
      ),
      body: FutureBuilder<CompanyListModel>(
        future: _companies,
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasError) {
              return const NoPropertyFoundWidget(text: "Try Again!");
            } else {
              var data = snapShot.data!.data;
              if (data.isEmpty) {
                return const NoPropertyFoundWidget(
                    text: "Agents Will Be Shown Here");
              }
              return ListView.builder(
                  itemCount: data.length,
                  padding: const EdgeInsets.only(top: 5),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: CompaniesWidget(
                        id: data[index].companyId,
                        name: data[index].name,
                        logo: data[index].logo,
                      ),
                    );
                  });
            }
          } else {
            return ListView.builder(
                itemCount: 7,
                padding: const EdgeInsets.only(top: 8),
                itemBuilder: (context, index) {
                  return const CompanyShimmer();
                });
          }
        },
      ),
    );
  }
}
