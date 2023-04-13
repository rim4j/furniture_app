List<SortByNameAndPrice> sortByNameAndPriceListData = [
  SortByNameAndPrice(title: "lowest price", value: "lowestPrice"),
  SortByNameAndPrice(title: "highest price", value: "highestPrice"),
  SortByNameAndPrice(title: "name A-Z", value: "nameA-Z"),
  SortByNameAndPrice(title: "name Z-A", value: "nameZ-A"),
];

class SortByNameAndPrice {
  String? title;
  String? value;

  SortByNameAndPrice({required this.title, required this.value});
}
