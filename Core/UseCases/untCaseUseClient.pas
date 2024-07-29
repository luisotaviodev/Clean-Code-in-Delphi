unit untCaseUseClient;

interface
 uses untUseCaseCliente, System.SysUtils, untDTOCliente, untResponse, uCliente, untEnums, uUtils, untExceptions;

 type
   TCaseUseClient = class(TInterfacedObject, ICaseUseCliente)
     function Cadastrar(cliente: TCliente): TResponse;
     function Alterar(cliente: TCliente): TResponse;
     function Excluir(id: Integer): TResponse;
     function Consultar(Dto: DtoCliente): TResponse;
     procedure ValidarID(id: Integer);
   end;

implementation

{ TCaseUseClient }

function TCaseUseClient.Alterar(cliente: TCliente): TResponse;
var
  oAlterar: TResponse;
begin
  try
    cliente.ValidarRegrasNegocios;

    oAlterar.Success   := True;
    oAlterar.ErrorCode := 0;
    oAlterar.Message   := RetornarMsgResponse.ALTERADO_COM_SUCESSO;
    oAlterar.Data      := nil;
  except
    on e: Exception do
    begin
      oAlterar := TratarException(e);
    end;
  end;

  Result := oAlterar;
end;

function TCaseUseClient.Cadastrar(cliente: TCliente): TResponse;
var
  oCadastrar: TResponse;
begin
  try
    cliente.ValidarRegrasNegocios;

    oCadastrar.Success   := True;
    oCadastrar.ErrorCode := 0;
    oCadastrar.Message   := RetornarMsgResponse.CADASTRADO_COM_SUCESSO;
    oCadastrar.Data      := nil;
  except
    on e: Exception do
    begin
      oCadastrar := TratarException(e);
    end;
  end;

  Result := oCadastrar;
end;

function TCaseUseClient.Consultar(Dto: DtoCliente): TResponse;
var
  oConsultar: TResponse;
begin
  try
    oConsultar.Success   := True;
    oConsultar.ErrorCode := 0;
    oConsultar.Message   := RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO;
    oConsultar.Data      := nil;
  except
    on e: Exception do
    begin
      oConsultar := TratarException(e);
    end;
  end;

  Result := oConsultar;
end;

function TCaseUseClient.Excluir(id: Integer): TResponse;
var
  oExcluir: TResponse;
begin
  try

    ValidarID(id);

    oExcluir.Success   := True;
    oExcluir.ErrorCode := 0;
    oExcluir.Message   := RetornarMsgResponse.DELETADO_COM_SUCESSO;
    oExcluir.Data      := nil;
  except
    on e: Exception do
    begin
      oExcluir := TratarException(e);
    end;
  end;

  Result := oExcluir;
end;

procedure TCaseUseClient.ValidarID(id: Integer);
begin
  if(id <=0)then
  begin
    ExceptionIdInvalido;
  end;
end;

end.
