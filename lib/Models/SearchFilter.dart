class SearchFilter {
  PriceSort priceSort;
  int minNumberOfBedrooms;
  SearchFilter(
      {this.priceSort = PriceSort.lowToHigh, this.minNumberOfBedrooms = 0});
}

enum PriceSort { lowToHigh, highToLow }
