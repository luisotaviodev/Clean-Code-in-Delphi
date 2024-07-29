unit untCaseUseLocacao;

interface

uses uLocacao, untDtoLocacao, untResponse, uUtils, System.SysUtils, untUseCaseLocacao, untEnums, untExceptions;

type
 TCaseUseLocacao =  class(TInterfacedObject, ICaseUseLocacao)

   function Cadastrar(locacao: TLocacao): TResponse;
   function Alterar(locacao: TLocacao): TResponse;
   function Excluir(id: Integer): TResponse;
   function Consultar(Dto: TDtoLocacao): TResponse;
  private
    procedure ValidarID(id: Integer);
 end;

implementation

{ TCaseUseLocacao }

function TCaseUseLocacao.Alterar(locacao: TLocacao): TResponse;
var
  oAlterar: TResponse;
begin
  try
    locacao.ValidarRegrasNegocios;

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

function TCaseUseLocacao.Cadastrar(locacao: TLocacao): TResponse;
var
  oCadastrar: TResponse;
begin
  try
    locacao.ValidarRegrasNegocios;

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

function TCaseUseLocacao.Consultar(Dto: TDtoLocacao): TResponse;
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


function TCaseUseLocacao.Excluir(id: Integer): TResponse;
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

procedure TCaseUseLocacao.ValidarID(id: Integer);
begin
  if(id <= 0)then
  begin
    ExceptionIdInvalido;
  end;
end;

end.
