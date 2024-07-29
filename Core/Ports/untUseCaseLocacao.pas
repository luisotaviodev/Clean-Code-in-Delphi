unit untUseCaseLocacao;

interface

uses uLocacao, untResponse, untDtoLocacao;

type
 ICaseUseLocacao = interface
   function Cadastrar(locacao: TLocacao): TResponse;
   function Alterar(locacao: TLocacao): TResponse;
   function Excluir(locacao: TLocacao): TResponse;
   function Consultar(Dto: TDtoLocacao): TResponse;
 end;

implementation

end.
