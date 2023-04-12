mixin TaskValidation {
  String? titleAndSubtitleValid(String? value) {
    if(value!.length < 2) {
      return 'Başlık veya açıklama 2 harften az olamaz';
    }
    return null;
  }
}