unit untUseCaseCliente;

interface

uses uCliente, untResponse, untDTOCliente;

type
 ICaseUseCliente = interface

 //Cadastrar
 function Cadastrar(cliente: TCliente): TResponse;
 //Alterar
 function Alterar(cliente: TCliente): TResponse;
 //Excluir
 function Excluir(id: Integer): TResponse;
 //Consultar
 function Consultar(Dto: DtoCliente): TResponse;

 end;

implementation

end.
