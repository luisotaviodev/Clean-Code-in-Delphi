unit uUtils;

interface

uses System.SysUtils, untResponse, untExceptions, untEnums;

function TratarException(e: Exception): TResponse;

implementation

function TratarException(e: Exception): TResponse;
var
  oResponse: TResponse;
begin
  oResponse.Success   := False;
  oResponse.Message   := e.Message;
  oResponse.Data      := nil;

  if e.ClassType = TExceptionLocacaoVeiculo then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.VEICULO_NAO_INFORMADO;
  end;

  if e.ClassType = TExceptionLocacaoCliente then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.CLIENTE_NAO_INFORMADO;
  end;

  if e.ClassType = TExceptionLocacaoVeiculoAlugado then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.VEICULO_ALUGADO;
  end;

  if e.ClassType = TExceptionIdInvalido then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.ID_INVALIDO;
  end;

  if(e.ClassType = TExceptionNome)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.NOME_NAO_INFORMADO;
  end;

  if(e.ClassType = TExceptionMinNome)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.NOME_INVALIDO;
  end;

  if(e.ClassType = TExceptionDocumento)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.DOCUMENTO_NAO_INFORMADO;
  end;

  if(e.ClassType = TExceptionMinDocumento)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.DOCUMENTO_INVALIDO;
  end;

  if(e.ClassType = TExceptionTelefone)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.TELEFONE_NAO_INFORMADO;
  end;

  if(e.ClassType = TExceptionMinTelefone)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.TELEFONE_INVALIDO;
  end;

  if(e.ClassType = TExceptionPlacaVeiculo)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.PLACA_NAO_INFORMADA;
  end;

  if(e.ClassType = TExceptionValorVeiculo)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.VALOR_INVALIDO;
  end;

  if(e.ClassType = TExceptionPlacaVeiculo)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.PLACA_INVALIDA;
  end;

  if(e.ClassType = TExceptionMinNomeVeiculo)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.NOME_INVALIDO;
  end;

  Result := oResponse;
end;

end.
