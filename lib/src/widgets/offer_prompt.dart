/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:tiki_sdk_flutter/src/widgets/trade_your_data.dart';

import '../../tiki_sdk.dart';
import '../../ui/offer.dart';
import 'button.dart';
import 'ending.dart';
import 'learn_more_btn.dart';
import 'offer_card.dart';
import 'terms.dart';
import 'used_for.dart';

class OfferPrompt extends StatelessWidget {

  late final List<Permission> permissions;

  OfferPrompt();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TikiSdk.instance.activeTheme.getSecondaryBackgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 15.0, right: 15, bottom: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TradeYourData(),
                    ),
                    LearnMoreButton()
                  ])),
          OfferCard(TikiSdk.instance.offers.values.toList()[0]),
          UsedFor(TikiSdk.instance.offers.values.toList()[0].getBullets),
          Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 15, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Button("Back Off", () => _decline(context, TikiSdk.instance.offers.values.toList()[0]))),
                    Padding(padding: EdgeInsets.symmetric(horizontal:12)),
                    Expanded(child: Button.solid(
                      "I'm in",
                      () => _accept(context, TikiSdk.instance.offers.values.toList()[0]),
                    ))
                  ]))
        ],
      ),
    );
  }

  _decline(BuildContext context, Offer offer) {
    Navigator.of(context).pop();
    if(!TikiSdk.instance.isDeclineEndingDisabled) {
      showModalBottomSheet<dynamic>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) => Ending.declined());
    }
  }

  _accept(BuildContext context, Offer offer) async {
    String terms = await DefaultAssetBundle.of(context).loadString(offer.getTerms);
    bool? termsAccepted = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Terms(terms)));
    if(termsAccepted == true){
      permissions = offer.getPermissions;
      if(permissions.isNotEmpty){
        _showErrorEnding(context);
        _handlePermissions(context);
      }else{
        _showAcceptedEnding(context);
      }
    }
  }

  Future<void> _handlePermissions(BuildContext context) async {
    if(permissions.isEmpty){
      _showAcceptedEnding(context);
    }else{
      Permission permission = permissions.first;
      if(await permission.request().isGranted){
        permissions.removeAt(0);
        _handlePermissions(context);
        return;
      }
    }
  }

  void _showErrorEnding(BuildContext context) {
    Navigator.of(context).pop();
    if(!TikiSdk.instance.isAcceptEndingDisabled) {
      showModalBottomSheet<dynamic>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) => Ending.error());
    }
  }

  void _showAcceptedEnding(BuildContext context) {
    Navigator.of(context).pop();
    if(!TikiSdk.instance.isAcceptEndingDisabled) {
      showModalBottomSheet<dynamic>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) => Ending.accepted());
    }
  }
}
