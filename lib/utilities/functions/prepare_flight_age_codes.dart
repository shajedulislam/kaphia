List<int> prepareFlightAgeCode({
  required List<int> oldList,
  required int index,
}) {
  List<int> listTemp = oldList;
  if (index == 0) {
    return [];
  } else if (index > listTemp.length) {
    if (index == 1) {
      listTemp.add(11);
    } else {
      for (int i = listTemp.length; i < index; i++) {
        listTemp.add(11);
      }
    }
  } else if (index < listTemp.length) {
    for (int i = listTemp.length - 1; i >= index; i--) {
      listTemp.removeAt(i);
    }
  }
  return listTemp;
}
