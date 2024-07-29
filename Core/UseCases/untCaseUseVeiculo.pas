unit untCaseUseVeiculo;

interface

uses
 uVeiculo, untDtoVeiculo, untUseCaseVeiculo, untResponse, untEnums, uUtils, System.SysUtils, untExceptions;

 type
   TCaseUseVeiculo = class(TInterfacedObject, ICaseUseVeiculo)
    function Cadastrar(veiculo: TVeiculo): TResponse;
    function Alterar(veiculo: TVeiculo): TResponse;
    function Excluir(id: Integer): TResponse;
    function Consultar(Dto: DtoVeiculo): TResponse;
    procedure ValidarID(id: Integer);

   end;

implementation

{ TCaseUseVeiculo }

function TCaseUseVeiculo.Alterar(veiculo: TVeiculo): TResponse;
var
  oAlterar: TResponse;
begin
  try
    veiculo.ValidarRegrasNegocios;

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

function TCaseUseVeiculo.Cadastrar(veiculo: TVeiculo): TResponse;
var
  oCadastrar: TResponse;
begin
  try
    veiculo.ValidarRegrasNegocios;

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

function TCaseUseVeiculo.Consultar(Dto: DtoVeiculo): TResponse;
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

function TCaseUseVeiculo.Excluir(id: Integer): TResponse;
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

procedure TCaseUseVeiculo.ValidarID(id: Integer);
begin
  if(id <=0)then
  begin
    ExceptionIdInvalido;
  end;
end;

end.
