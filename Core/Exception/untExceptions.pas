unit untExceptions;

interface

uses System.SysUtils;

type
TExceptionNome                   = class(Exception);
TExceptionMinNome                = class(Exception);
TExceptionDocumento              = class(Exception);
TExceptionMinDocumento           = class(Exception);
TExceptionTelefone               = class(Exception);
TExceptionMinTelefone            = class(Exception);


TExceptionMinNomeVeiculo         = class(Exception);
TExceptionPlacaVeiculo           = class(Exception);
TExceptionMinPlacaVeiculo        = class(Exception);
TExceptionValorVeiculo           = class(Exception);
TExceptionIdInvalido             = class(Exception);

TExceptionLocacaoVeiculo         = class(Exception);
TExceptionLocacaoCliente         = class(Exception);
TExceptionLocacaoVeiculoAlugado  = class(Exception);


//Exceptions Cliente
procedure ExceptionNome;
procedure ExceptionMinNome;
procedure ExceptionDocumento;
procedure ExceptionMinDocumento;
procedure ExceptionTelefone;
procedure ExceptionMinTelefone;

//Exceptions Veiculo
procedure ExceptionMinNomeVeiculo;
procedure ExceptionPlacaVeiculo;
procedure ExceptionMinPlacaVeiculo;
procedure ExceptionValorVeiculo;
procedure ExceptionIdInvalido;

//Exceptions Loca��o
procedure ExceptionLocacaoVeiculo;
procedure ExceptionLocacaoCliente;
procedure ExceptionLocacaoVeiculoAlugado;

implementation

procedure ExceptionNome;
begin
  raise TExceptionNome.Create('Nome deve ser informado.');
end;

procedure ExceptionMinNome;
begin
  raise TExceptionMinNome.Create('Nome deve conter no min�mo 4 caracteres.');
end;

procedure ExceptionDocumento;
begin
  raise TExceptionDocumento.Create('Documento deve ser informado.');
end;

procedure ExceptionMinDocumento;
begin
  raise TExceptionDocumento.Create('Documento deve conter no min�mo 4 caracteres.');
end;

procedure ExceptionTelefone;
begin
  raise TExceptionDocumento.Create('Telefone deve ser informado.');
end;

procedure ExceptionMinTelefone;
begin
  raise TExceptionDocumento.Create('Telefone deve conter no min�mo 8 caracteres.');
end;

procedure ExceptionMinNomeVeiculo;
begin
  raise TExceptionMinNomeVeiculo.Create('Nome do Veiculo deve conter no min�mo 3 caracteres.');
end;

procedure ExceptionPlacaVeiculo;
begin
  raise TExceptionPlacaVeiculo.Create('Placa deve ser informada.');
end;

procedure ExceptionMinPlacaVeiculo;
begin
  raise TExceptionMinPlacaVeiculo.Create('Placa do Veiculo deve conter no min�mo 6 caracteres.');
end;

procedure ExceptionValorVeiculo;
begin
  raise TExceptionValorVeiculo.Create('Valor do Veiculo deve ser maior que zero.');
end;

procedure ExceptionIdInvalido;
begin
  raise TExceptionIdInvalido.Create('ID informado inv�lido.');
end;

procedure ExceptionLocacaoVeiculo;
begin
  raise TExceptionLocacaoVeiculo.Create('Veiculo deve ser informado.');
end;

procedure ExceptionLocacaoCliente;
begin
  raise TExceptionLocacaoCliente.Create('Cliente deve ser informado.');
end;

procedure ExceptionLocacaoVeiculoAlugado;
begin
  raise TExceptionLocacaoVeiculoAlugado.Create('Veiculo j� consta alugado.');
end;

end.