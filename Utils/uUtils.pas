unit uUtils;

interface

uses System.SysUtils, untResponse, untExceptions, untEnums, uCliente, System.Generics.Collections, System.TypInfo, uVeiculo, uLocacao;

function TratarException(e: Exception): TResponse;
function QL: String;
function ListaClienteParaListaObject(ListaObject: TObjectList<TObject>; ListaCliente: TObjectList<TCliente>): TObjectList<TObject>;
function ConverterStatusStr(oStatus: TStatus): String;
function ConverterStrStatus(cStatus: String): TStatus;
function ListaVeiculoParaListaObject(ListaObject: TObjectList<TObject>; ListaVeiculo: TObjectList<TVeiculo>): TObjectList<TObject>;
function ListaLocacaoParaListaObject(ListaObject: TObjectList<TObject>; ListaLocacao: TObjectList<TLocacao>): TObjectList<TObject>;
implementation

function ListaLocacaoParaListaObject(ListaObject: TObjectList<TObject>; ListaLocacao: TObjectList<TLocacao>): TObjectList<TObject>;
var
  oLocacao: TLocacao;
begin
  if(ListaLocacao.Count > 0)then
  begin
    for oLocacao in ListaLocacao do
    begin
      ListaObject.Add(oLocacao);
    end;

  end;
  Result := ListaObject;
end;

function ListaVeiculoParaListaObject(ListaObject: TObjectList<TObject>; ListaVeiculo: TObjectList<TVeiculo>): TObjectList<TObject>;
var
  oVeiculo: TVeiculo;
begin
  if(ListaVeiculo.Count > 0)then
  begin
    for oVeiculo in ListaVeiculo do
    begin
      ListaObject.Add(oVeiculo);
    end;

  end;
  Result := ListaObject;
end;

function ConverterStrStatus(cStatus: String): TStatus;
begin
  Result := TStatus(GetEnumValue(TypeInfo(TStatus), cStatus));
end;

function ConverterStatusStr(oStatus: TStatus): String;
begin
  Result := GetEnumName(TypeInfo(TStatus), Integer(oStatus));
end;

function ListaClienteParaListaObject(ListaObject: TObjectList<TObject>; ListaCliente: TObjectList<TCliente>): TObjectList<TObject>;
var
  oCliente: TCliente;
begin
  if(ListaCliente.Count > 0)then
  begin
    for oCliente in ListaCliente do
    begin
      ListaObject.Add(oCliente);
    end;

  end;
  Result := ListaObject;
end;

function TratarException(e: Exception): TResponse;
var
  oResponse: TResponse;
begin
  oResponse.Success   := False;
  oResponse.Message   := e.Message;
  oResponse.Data      := nil;

  if(e.ClassType = TExceptionDatabase)then
  begin
    oResponse.ErrorCode := RetornarErrorsCode.ERROR_BANCO_DADOS;
  end;

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

function QL: String;
begin
  Result := #13#10;
end;


end.
