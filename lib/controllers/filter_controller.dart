import 'package:get/get.dart';

class FilterController extends GetxController {
  bool isGrid = true;
  var isLoading = false.obs;
  String? selectedFilter;
  bool isFilterActive = false;
  bool isDescending = true;
  bool isOnSale = false;
  bool isFeatured = false;
  String? orderBy;
  String? minPrice;
  String? maxPrice;
  var matchFilter = [
    'Latest',
    'Oldest',
  ];

  void changeOrder() {
    try {
      isLoading(true);
      if (selectedFilter == 'Oldest') {
        isDescending = false;
      }
    } finally {
      isLoading(false);
    }
  }

  void changeOnSale() {
    try {
      isLoading(true);
      isOnSale = !isOnSale;
    } finally {
      isLoading(false);
    }
  }

  void changeFeatured() {
    try {
      isLoading(true);
      isFeatured = !isFeatured;
    } finally {
      isLoading(false);
    }
  }

  void changeOrderBy(String? value) {
    try {
      isLoading(true);
      orderBy = value;
      isOnSale = false;
      isFeatured = false;
    } finally {
      isLoading(false);
    }
  }

  void resetFilter() {
    try {
      isLoading(true);
      orderBy = null;
      isOnSale = false;
      isFeatured = false;
      minPrice = null;
      maxPrice = null;
    } finally {
      isLoading(false);
    }
  }

  void changeMin(String? value) {
    try {
      isLoading(true);
      minPrice = value;
    } finally {
      isLoading(false);
    }
  }

  void changeMax(String? value) {
    try {
      isLoading(true);
      maxPrice = value;
    } finally {
      isLoading(false);
    }
  }

  void changeGrid() {
    try {
      isLoading(true);
      isGrid = !isGrid;
    } finally {
      isLoading(false);
    }
  }

  void changeFilterActive() {
    try {
      isLoading(true);
      isFilterActive = !isFilterActive;
    } finally {
      isLoading(false);
    }
  }

  void changeFilter(String? value) {
    try {
      isLoading(true);
      selectedFilter = value;
    } finally {
      isLoading(false);
    }
  }
}
