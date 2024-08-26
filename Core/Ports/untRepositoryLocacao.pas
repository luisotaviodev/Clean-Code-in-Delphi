unit untRepositoryLocacao;

interface

uses uLocacao, untDtoLocacao, System.Generics.Collections;
type
  IRepositoryLocacao = interface
    procedure Cadastrar(oLocacao: TLocacao);
    procedure Alterar(oLocacao: TLocacao);
    procedure Excluir(id: Integer);
    function Consultar(dtoLocacao: TDtoLocacao): TObjectList<TLocacao>;
  end;

implementation

end.
