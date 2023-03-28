import 'package:flutter/material.dart';

CategoryNotifier categoryNotifier = CategoryNotifier();

class CategoryNotifier extends ChangeNotifier {

  String _selectedCateogoryInEng = 'none';

  String get currentCategoryInEng => _selectedCateogoryInEng;
  String get currentCategoryInKor =>
      categoriesMapEngToKor[_selectedCateogoryInEng]!;

  void setNewCategoryWithEng(String newCategory){
    if(categoriesMapEngToKor.keys.contains(newCategory)){
      _selectedCateogoryInEng = newCategory;
      notifyListeners();
    }
  }

  void setNewCategoryWithKor(String newCategory){
    if(categoriesMapEngToKor.values.contains(newCategory)){
      _selectedCateogoryInEng = categoriesMapKorToEng[newCategory]!;
      notifyListeners();
    }
  }
}

enum CategoryEnum{
  none,
  furniture,
  electronics,
  kids,
  sprots,
  woman,
  man,
  makeup,
}

const Map<String, String> categoriesMapEngToKor = {
  'none' : '선택',
  'furniture' : '가구',
  'electronics' : '전자기기',
  'kids' : '유아동',
  'sprots' : '스포츠',
  'woman' : '여성',
  'man' : '남성',
  'makeup' : '메이크업'
};

const Map<String, String> categoriesMapKorToEng = {
  '선택' : 'none',
  '가구' : 'furniture',
  '전자기기' : 'electronics',
  '유아동' : 'kids',
  '스포츠' : 'sprots',
  '여성' : 'woman',
  '남성' : 'man',
  '메이크업' : 'makeup'
};
// Map<String, String> categoriesMapKorToEng =
//     categoriesMapEngToKor.map((key, value) => MapEntry(key, value));