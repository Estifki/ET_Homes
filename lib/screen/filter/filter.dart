import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate_project/widgets/filter/property_type.dart';

import '../../const/filter.dart';
import '../../const/const.dart';
import 'filtered_properties.dart';
import '../../widgets/filter/min_area.dart';

enum EPropertyType { Any, Rent, Sale }

enum EBedRoom { Any, One, Two, Three }

enum EBathRoom { Any, One, Two, Three }

class FilterScreen extends StatefulWidget {
  final String ownerIdForFilter;

  const FilterScreen({super.key, required this.ownerIdForFilter});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues values = const RangeValues(0, 20000000);
  final TextEditingController _propertyType = TextEditingController(text: "");
  final TextEditingController _minPrice = TextEditingController(text: "0");
  final TextEditingController _maxPrice =
      TextEditingController(text: "20000000");
  final TextEditingController _bedRoomValue = TextEditingController();
  final TextEditingController _bathRoomValue = TextEditingController();
  var formattedPrice = NumberFormat("###,###.0#", "en_US");
  int _minareaValue = 70;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Looking For",
            style: TextStyle(
              fontSize: 15,
              fontFamily: AppFonts.semiBold,
              color: AppColor.thirdColor,
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => selectedPropertyType(EPropertyType.Any),
                child: SelectableFilterWidget(
                  name: "Any",
                  activeColor: FilterPropertTypeColors.anyPropertTypeColor,
                ),
              ),
              GestureDetector(
                onTap: () => selectedPropertyType(EPropertyType.Rent),
                child: SelectableFilterWidget(
                  name: "Rent",
                  activeColor: FilterPropertTypeColors.firstPropertTypeColor,
                ),
              ),
              GestureDetector(
                onTap: () => selectedPropertyType(EPropertyType.Sale),
                child: SelectableFilterWidget(
                  name: "Sale",
                  activeColor: FilterPropertTypeColors.secondPropertTypeColor,
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.03),
          const Text(
            "Price Range",
            style: TextStyle(
              fontSize: 15,
              fontFamily: AppFonts.semiBold,
              color: AppColor.thirdColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RangeSlider(
              values: values,
              activeColor: AppColor.primaryColorCustom,
              min: 0,
              max: 20000000,
              divisions: 20,
              labels: RangeLabels(
                formattedPrice.format(values.start.toInt()),
                formattedPrice.format(values.end.toInt()),
              ),
              onChanged: (userInput) {
                setState(() {
                  values = userInput;
                  _minPrice.text = userInput.start.round().toString();
                  _maxPrice.text = userInput.end.round().toString();
                });
              },
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          const Text(
            "Bedroom",
            style: TextStyle(
                fontFamily: AppFonts.semiBold,
                color: AppColor.thirdColor,
                fontSize: 15),
          ),
          SizedBox(height: screenSize.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => selectedBedRoom(EBedRoom.Any),
                child: SelectableFilterWidget(
                  name: "Any",
                  activeColor: FilterBedRoomColors.anyPropertTypeColor,
                ),
              ),
              GestureDetector(
                onTap: () => selectedBedRoom(EBedRoom.One),
                child: SelectableFilterWidget(
                  name: "1",
                  activeColor: FilterBedRoomColors.firstPropertTypeColor,
                ),
              ),
              GestureDetector(
                onTap: () => selectedBedRoom(EBedRoom.Two),
                child: SelectableFilterWidget(
                  name: "2",
                  activeColor: FilterBedRoomColors.secondPropertTypeColor,
                ),
              ),
              GestureDetector(
                onTap: () => selectedBedRoom(EBedRoom.Three),
                child: SelectableFilterWidget(
                  name: "3+",
                  activeColor: FilterBedRoomColors.thirdPropertTypeColor,
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.03),
          const Text(
            "Bathroom",
            style: TextStyle(
              fontSize: 15,
              fontFamily: AppFonts.semiBold,
              color: AppColor.thirdColor,
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => selectedBathRoom(EBathRoom.Any),
                child: SelectableFilterWidget(
                  name: "Any",
                  activeColor: FilterBathRoomColors.anyPropertTypeColor,
                ),
              ),
              GestureDetector(
                onTap: () => selectedBathRoom(EBathRoom.One),
                child: SelectableFilterWidget(
                  name: "1",
                  activeColor: FilterBathRoomColors.firstPropertTypeColor,
                ),
              ),
              GestureDetector(
                onTap: () => selectedBathRoom(EBathRoom.Two),
                child: SelectableFilterWidget(
                  name: "2",
                  activeColor: FilterBathRoomColors.secondPropertTypeColor,
                ),
              ),
              GestureDetector(
                onTap: () => selectedBathRoom(EBathRoom.Three),
                child: SelectableFilterWidget(
                  name: "3+",
                  activeColor: FilterBathRoomColors.thirdPropertTypeColor,
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Min area",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppFonts.semiBold,
                  color: AppColor.thirdColor,
                ),
              ),
              MinAreaWidget(
                value: _minareaValue.toString(),
                onPressedminus: () {
                  setState(() {
                    if (_minareaValue <= 10) {
                    } else if (_minareaValue <= 150) {
                      _minareaValue -= 10;
                    } else {
                      _minareaValue -= 20;
                    }
                  });
                },
                onPressedplus: () {
                  setState(() {
                    if (_minareaValue >= 250) {
                    } else if (_minareaValue >= 150) {
                      _minareaValue += 20;
                    } else {
                      _minareaValue += 10;
                    }
                  });
                },
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.05),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilteredPropertyScreen(
                      propertyType: _propertyType.text,
                      minPrice: int.parse(_minPrice.text),
                      maxPrice: int.parse(_maxPrice.text),
                      bedRooms: _bedRoomValue.text,
                      bathRooms: _bathRoomValue.text,
                      minArea: _minareaValue,
                      owner: widget.ownerIdForFilter,
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: screenSize.width * 0.47,
                decoration: BoxDecoration(
                  color: AppColor.primaryColorCustom,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "Apply Filter",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.semiBold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectedPropertyType(EPropertyType type) {
    if (type == EPropertyType.Any) {
      if (FilterPropertTypeColors.anyPropertTypeColor ==
          FilterPropertTypeColors.selectedColor) {
      } else {
        setState(() {
          _propertyType.text = "";
          FilterPropertTypeColors.anyPropertTypeColor =
              FilterPropertTypeColors.selectedColor;
          FilterPropertTypeColors.firstPropertTypeColor =
              FilterPropertTypeColors.unselectedColors;
          FilterPropertTypeColors.secondPropertTypeColor =
              FilterPropertTypeColors.unselectedColors;
        });
      }
    } else if (type == EPropertyType.Rent) {
      if (FilterPropertTypeColors.firstPropertTypeColor ==
          FilterPropertTypeColors.selectedColor) {
      } else {
        setState(() {
          _propertyType.text = "rent";
          FilterPropertTypeColors.firstPropertTypeColor =
              FilterPropertTypeColors.selectedColor;
          FilterPropertTypeColors.anyPropertTypeColor =
              FilterPropertTypeColors.unselectedColors;
          FilterPropertTypeColors.secondPropertTypeColor =
              FilterPropertTypeColors.unselectedColors;
        });
      }
    } else {
      if (FilterPropertTypeColors.secondPropertTypeColor ==
          FilterPropertTypeColors.selectedColor) {
      } else {
        setState(() {
          _propertyType.text = "sale";
          FilterPropertTypeColors.secondPropertTypeColor =
              FilterPropertTypeColors.selectedColor;
          FilterPropertTypeColors.anyPropertTypeColor =
              FilterPropertTypeColors.unselectedColors;
          FilterPropertTypeColors.firstPropertTypeColor =
              FilterPropertTypeColors.unselectedColors;
        });
      }
    }
  }

  void selectedBedRoom(EBedRoom num) {
    if (num == EBedRoom.Any) {
      if (FilterBedRoomColors.anyPropertTypeColor ==
          FilterBedRoomColors.selectedColor) {
      } else {
        setState(() {
          _bedRoomValue.text = "";
          FilterBedRoomColors.anyPropertTypeColor =
              FilterBedRoomColors.selectedColor;
          FilterBedRoomColors.firstPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
          FilterBedRoomColors.secondPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
          FilterBedRoomColors.thirdPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
        });
      }
    } else if (num == EBedRoom.One) {
      if (FilterBedRoomColors.firstPropertTypeColor ==
          FilterBedRoomColors.selectedColor) {
      } else {
        setState(() {
          _bedRoomValue.text = "1";
          FilterBedRoomColors.firstPropertTypeColor =
              FilterBedRoomColors.selectedColor;
          FilterBedRoomColors.anyPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
          FilterBedRoomColors.secondPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
          FilterBedRoomColors.thirdPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
        });
      }
    } else if (num == EBedRoom.Two) {
      if (FilterBedRoomColors.secondPropertTypeColor ==
          FilterBedRoomColors.selectedColor) {
      } else {
        setState(() {
          _bedRoomValue.text = "2";
          FilterBedRoomColors.secondPropertTypeColor =
              FilterBedRoomColors.selectedColor;
          FilterBedRoomColors.anyPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
          FilterBedRoomColors.firstPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
          FilterBedRoomColors.thirdPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
        });
      }
    } else {
      if (FilterBedRoomColors.thirdPropertTypeColor ==
          FilterBedRoomColors.selectedColor) {
      } else {
        setState(() {
          _bedRoomValue.text = "3";
          FilterBedRoomColors.thirdPropertTypeColor =
              FilterBedRoomColors.selectedColor;
          FilterBedRoomColors.anyPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
          FilterBedRoomColors.firstPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
          FilterBedRoomColors.secondPropertTypeColor =
              FilterBedRoomColors.unselectedColors;
        });
      }
    }
  }

  void selectedBathRoom(EBathRoom num) {
    if (num == EBathRoom.Any) {
      if (FilterBathRoomColors.anyPropertTypeColor ==
          FilterBathRoomColors.selectedColor) {
      } else {
        setState(() {
          _bathRoomValue.text = "";
          FilterBathRoomColors.anyPropertTypeColor =
              FilterBathRoomColors.selectedColor;
          FilterBathRoomColors.firstPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
          FilterBathRoomColors.secondPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
          FilterBathRoomColors.thirdPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
        });
      }
    } else if (num == EBathRoom.One) {
      if (FilterBathRoomColors.firstPropertTypeColor ==
          FilterBathRoomColors.selectedColor) {
      } else {
        setState(() {
          _bathRoomValue.text = "1";
          FilterBathRoomColors.firstPropertTypeColor =
              FilterBathRoomColors.selectedColor;
          FilterBathRoomColors.anyPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
          FilterBathRoomColors.secondPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
          FilterBathRoomColors.thirdPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
        });
      }
    } else if (num == EBathRoom.Two) {
      if (FilterBathRoomColors.secondPropertTypeColor ==
          FilterBathRoomColors.selectedColor) {
      } else {
        setState(() {
          _bathRoomValue.text = "2";
          FilterBathRoomColors.secondPropertTypeColor =
              FilterBathRoomColors.selectedColor;
          FilterBathRoomColors.anyPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
          FilterBathRoomColors.firstPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
          FilterBathRoomColors.thirdPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
        });
      }
    } else {
      if (FilterBathRoomColors.thirdPropertTypeColor ==
          FilterBathRoomColors.selectedColor) {
      } else {
        setState(() {
          _bathRoomValue.text = "3";
          FilterBathRoomColors.thirdPropertTypeColor =
              FilterBathRoomColors.selectedColor;
          FilterBathRoomColors.anyPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
          FilterBathRoomColors.firstPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
          FilterBathRoomColors.secondPropertTypeColor =
              FilterBathRoomColors.unselectedColors;
        });
      }
    }
  }
}
