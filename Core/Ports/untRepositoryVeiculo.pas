unit untRepositoryVeiculo;

interface

uses uVeiculo, untDtoVeiculo, System.Generics.Collections;

type
  IRepositoryVeiculo = interface
    procedure Cadastrar(oVeiculo: TVeiculo);
    procedure Alterar(oVeiculo: TVeiculo);
    procedure Excluir(id: Integer);
    function Consultar(dtoVeiculo: DtoVeiculo): TObjectList<TVeiculo>;
  end;

implementation

end.
