unit untUseCaseLocacao;

interface

uses uLocacao, untResponse, untDtoLocacao;

type
 ICaseUseLocacao = interface
   function Cadastrar(locacao: TLocacao): TResponse;
   function Alterar(locacao: TLocacao): TResponse;
   function Excluir(id: Integer): TResponse;
   function Consultar(Dto: TDtoLocacao): TResponse;
 end;

implementation

end.
