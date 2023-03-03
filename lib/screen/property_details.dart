import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/provider/properties.dart';
import 'package:real_estate_project/services/provider/save_for_later.dart';
import 'package:real_estate_project/model/property_detail.dart';
import 'package:real_estate_project/widgets/noproperty_found.dart';

import '../services/auth/auth.dart';
import '../utility/shimmer/properties_detail.dart';
import '../widgets/property_detail/property_detail.dart';

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({Key? key}) : super(key: key);

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  late Future _getProperty;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<SaveForLaterProvider>(context, listen: false).cleanData();
      Provider.of<SaveForLaterProvider>(context, listen: false)
          .getSavedProperties(
              Provider.of<AuthProvider>(context, listen: false).userId);
      var propertyID = ModalRoute.of(context)!.settings.arguments as List;

      _getProperty = Provider.of<PropertiesProvider>(context, listen: false)
          .getSingleProperty(propertyID[0]);
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
          future: _getProperty,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const NoPropertyFoundWidget(text: "Try Again!");
              } else {
                PropertyDetailsModel? data = snapshot.data;
                return PropertyDetailWidget(
                  id: data!.data.id,
                  propertyName: data.data.name,
                  price: data.data.price,
                  paymentStatus: data.data.paymentDescription,
                  isFurnished: data.data.isFurnished,
                  city: data.data.address.city,
                  ownerName: data.data.owner.name,
                  ownerID: data.data.owner.id,
                  imgUrl: data.data.images,
                  bathRoom: data.data.details.bathroom,
                  bedRoom: data.data.details.bedroom,
                  yearBuilt: data.data.details.yearbuilt,
                  description: data.data.description,
                  area: data.data.details.area.toString(),
                  address: data.data.address.location,
                  propertyType: data.data.type,
                  longtitude: data.data.address.loc[0],
                  latitude: data.data.address.loc[1],
                  agent: data.data.agents,
                  amenties: data.data.amenities,
                  relatedProperties: data.related,
                  companyNameForAgent: data.agentCompany,
                );
              }
            } else {
              return const PropertiesDetailsShimmer();
            }
          }),
    ));
  }
}
