class Tarefa {
  String? id;
  String? titulo;
  String? nota;
  DateTime? data;
  //Long idUsuario
  bool concluido;

  Tarefa({
    this.id,
    this.titulo,
    this.nota,
    this.data,
    this.concluido = false,
  });
}
