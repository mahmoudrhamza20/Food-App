import 'package:flutter/material.dart';
import 'package:flutter_food_app/providers/providers.dart';
import 'package:flutter_food_app/screens/screens.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';

class AddDeliveryAddressScreen extends StatefulWidget {
  const AddDeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddressScreen> createState() =>
      _AddDeliveryAddressScreenState();
}

enum AddressType { home, office, other }

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {
  late CheckoutProvider checkoutProvider;

  var addressType = AddressType.home;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alternatePhoneController = TextEditingController();
  TextEditingController stressAddressController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final _formAddressKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    checkoutProvider = Provider.of<CheckoutProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Address Details'),
      bottomNavigationBar: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppColors.primaryColor,
          child: Text(
            'Add Address',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: AppColors.textColor,
            ),
          ),
          onPressed: () {
            if (!_formAddressKey.currentState!.validate()) {
              return;
            } else {
              checkoutProvider.addDeliveryAddress(
                context: context,
                name: nameController.text,
                phoneNumber: phoneController.text,
                altPhoneNumber: alternatePhoneController.text,
                streetAddress: stressAddressController.text,
                zipCode: zipCodeController.text,
                city: cityController.text,
                addressType: addressType.name,
              );
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formAddressKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: nameController,
                hintText: 'Ex. Mahmoud Reda Hamza',
                labelText: 'Full Name *',
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: phoneController,
                hintText: 'Ex. +201017....',
                labelText: 'Mobile Number *',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone number is required';
                  } else if (value.length != 11) {
                    return 'Phone number must be 11 digit';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: alternatePhoneController,
                hintText: 'Ex. +201017....',
                labelText: 'Alternate Mobile Number *',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ' Alternative Phone number is required';
                  } else if (value.length != 11) {
                    return 'Phone number must be 11 digit';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: stressAddressController,
                hintText: 'Ex. House No 15, Road No...',
                labelText: 'Street Address *',
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Street address is required';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: zipCodeController,
                hintText: 'Ex. 0000',
                labelText: 'Zip Code (PIN Code) *',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Zip code is required';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: cityController,
                hintText: 'Ex. Mansoura',
                labelText: 'City *',
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'City is required';
                  }
                  return null;
                },
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => const GoogleMapScreen(),
                        ),
                      )
                      .then((value) => setState(() {}));
                },
                child: SizedBox(
                  height: 47,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      checkoutProvider.setLocation?.latitude == null
                          ? Text(
                              'Set Locations (Maps)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textColor,
                              ),
                            )
                          : Text(
                              'Location (${checkoutProvider.setLocation?.latitude?.toStringAsFixed(2)}, ${checkoutProvider.setLocation?.longitude?.toStringAsFixed(2)})',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textColor,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Divider(color: AppColors.textColor),
              ListTile(
                title: Text(
                  'Address Type',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textColor,
                  ),
                ),
              ),
              RadioListTile(
                tileColor:
                    addressType == AddressType.home ? Colors.white : null,
                activeColor: AppColors.primaryColor,
                value: AddressType.home,
                groupValue: addressType,
                onChanged: (AddressType? value) {
                  setState(() {
                    addressType = value!;
                  });
                },
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: AppColors.textColor,
                  ),
                ),
                secondary: Icon(
                  Icons.add_home,
                  color: AppColors.textColor,
                ),
              ),
              RadioListTile(
                tileColor:
                    addressType == AddressType.office ? Colors.white : null,
                activeColor: AppColors.primaryColor,
                value: AddressType.office,
                groupValue: addressType,
                onChanged: (AddressType? value) {
                  setState(() {
                    addressType = value!;
                  });
                },
                title: Text(
                  'Office',
                  style: TextStyle(
                    color: AppColors.textColor,
                  ),
                ),
                secondary: Icon(
                  Icons.work,
                  color: AppColors.textColor,
                ),
              ),
              RadioListTile(
                tileColor:
                    addressType == AddressType.other ? Colors.white : null,
                activeColor: AppColors.primaryColor,
                value: AddressType.other,
                groupValue: addressType,
                onChanged: (AddressType? value) {
                  setState(() {
                    addressType = value!;
                  });
                },
                title: Text(
                  'Other',
                  style: TextStyle(
                    color: AppColors.textColor,
                  ),
                ),
                secondary: Icon(
                  Icons.add_home_work_rounded,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
