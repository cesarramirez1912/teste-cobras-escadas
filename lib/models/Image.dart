class ImageClass {
  int posicaoInicial;
  int posicaoFinal;
  bool isSnacke;
  String urlImage;

  ImageClass(
      { required this.posicaoInicial,
      required this.posicaoFinal,
       this.isSnacke = false,
      required this.urlImage});
}
