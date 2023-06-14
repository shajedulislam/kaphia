String getRegsiterAsString(int? typeID) {
  return typeID == 1
      ? "Proprietor"
      : typeID == 2
          ? "Partnership"
          : "Company/LTD.";
}
