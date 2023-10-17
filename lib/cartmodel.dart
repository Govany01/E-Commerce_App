class CartModel {
  List<int> indexes = [];

  setInd(int ind) {
    indexes.add(ind);
  }

  List<int> getInd() {
    return indexes;
  }
}
