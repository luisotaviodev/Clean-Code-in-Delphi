unit untUseCaseVeiculo;

interface

uses
 uVeiculo, untResponse, untDtoVeiculo;

type
 ICaseUseVeiculo = interface

 //Cadastrar
 function Cadastrar(cliente: TVeiculo): TResponse;
 //Alterar
 function Alterar(cliente: TVeiculo): TResponse;
 //Excluir
 function Excluir(id: Integer): TResponse;
 //Consultar
 function Consultar(Dto: DtoVeiculo): TResponse;

 end;

implementation

end.