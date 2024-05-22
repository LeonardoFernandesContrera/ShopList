class Tarefa{
  final String uid;
  final String titulo;
  final String descricao;

  Tarefa(this.uid, this.titulo, this.descricao);

  Map<String,dynamic> ToJson(){
    return <String, dynamic>{
      'uid' : uid,
      'titulo' : titulo,
      'descricao' : descricao
    };
  }

  factory Tarefa.fromJson(Map<String, dynamic> dados){
    return Tarefa(
      dados['uid'],
      dados['titulo'],
      dados['descricao'],
    );
  }

}