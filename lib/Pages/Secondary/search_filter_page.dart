import 'package:dttproperties/app_management/Providers/search_filter_provider.dart';
import 'package:dttproperties/app_management/constants.dart';
import 'package:dttproperties/assets/Icons/custom_icons_icons.dart';
import 'package:dttproperties/Models/search_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchFilterPage extends ConsumerWidget {
  const SearchFilterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchFilter = ref.watch(searchFilterProvider);
    final priceSort = searchFilter.priceSort;
    final minNumberOfBedrooms = searchFilter.minNumberOfBedrooms;
    return Container(
      padding: standardPagePadding.copyWith(top: 30, bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.money_rounded),
                title: Text("Price",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Column(
                children: [
                  ListTile(
                    onTap: () {
                      ref.read(searchFilterProvider.notifier).state =
                          SearchFilter(
                              minNumberOfBedrooms: minNumberOfBedrooms,
                              priceSort: PriceSort.lowToHigh);
                    },
                    leading: Icon(
                      Icons.arrow_upward,
                      color: searchFilter.priceSort == PriceSort.lowToHigh
                          ? secondaryColor
                          : hintColor,
                    ),
                    title: Text("Low - High",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  ListTile(
                    onTap: () {
                      ref.read(searchFilterProvider.notifier).state =
                          SearchFilter(
                              minNumberOfBedrooms: minNumberOfBedrooms,
                              priceSort: PriceSort.highToLow);
                    },
                    leading: Icon(
                      Icons.arrow_downward,
                      color: searchFilter.priceSort == PriceSort.highToLow
                          ? secondaryColor
                          : hintColor,
                    ),
                    title: Text("High - Low",
                        style: Theme.of(context).textTheme.bodyLarge),
                  )
                ],
              )
            ],
          ),
          Container(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(CustomIcons.bed),
                  title: Text("Bedrooms",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                Wrap(
                  children: [
                    for (var i = 1; i < 5; i++)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: ChoiceChip(
                          selectedColor: secondaryColor,
                          label: Text("$i+"),
                          selected: searchFilter.minNumberOfBedrooms == i,
                          onSelected: (value) {
                            ref.read(searchFilterProvider.notifier).state =
                                SearchFilter(
                                    minNumberOfBedrooms: i,
                                    priceSort: priceSort);
                          },
                        ),
                      )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
