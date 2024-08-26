unit untCaseUseLocacao;

interface

uses uLocacao, untDtoLocacao, untResponse, uUtils, System.SysUtils, untUseCaseLocacao, untEnums, untExceptions,
System.Generics.Collections, untRepositoryLocacao;

type
 TCaseUseLocacao =  class(TInterfacedObject, ICaseUseLocacao)
  private
    FRepository: IRepositoryLocacao;
    FListaObject: TObjectList<TObject>;
    FLista: TObjectList<TLocacao>;
    procedure SetLista(const Value: TObjectList<TLocacao>);
    procedure SetListaObject(const Value: TObjectList<TObject>);
  published
   function Cadastrar(locacao: TLocacao): TResponse;
   function Alterar(locacao: TLocacao): TResponse;
   function Excluir(id: Integer): TResponse;
   function Consultar(Dto: TDtoLocacao): TResponse;
   procedure ValidarID(id: Integer);

   property Lista: TObjectList<TLocacao> read FLista write SetLista;
   property ListaObject: TObjectList<TObject> read FListaObject write SetListaObject;

   constructor Create(oRepository: IRepositoryLocacao);
   destructor Destroy; override;
   
 end;

implementation

{ TCaseUseLocacao }

function TCaseUseLocacao.Alterar(locacao: TLocacao): TResponse;
var
  oAlterar: TResponse;
begin
  try
    locacao.ValidarRegrasNegocios;

    FRepository.Alterar(locacao);
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

    locacao.DataLocacao := now;
    FRepository.Cadastrar(locacao);

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
    ListaObject.Clear;
    Lista := FRepository.Consultar(Dto);

    if(Lista.Count > 0)then
    begin
      oConsultar.Success   := True;
      oConsultar.ErrorCode := 0;
      oConsultar.Message   := RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO;
      oConsultar.Data      := ListaLocacaoParaListaObject(ListaObject, Lista);
    end
    else
    begin
      oConsultar.Success   := True;
      oConsultar.ErrorCode := 0;
      oConsultar.Message   := RetornarMsgResponse.CONSULTA_REALIZADA_SEM_RETORNO;
      oConsultar.Data      := nil;
    end;
  except
    on e: Exception do
    begin
      oConsultar := TratarException(e);
    end;
  end;

  Result := oConsultar;
end;


constructor TCaseUseLocacao.Create(oRepository: IRepositoryLocacao);
begin
  FRepository := oRepository;
//  Lista       := TObjectList<TLocacao>.Create;
  ListaObject := TObjectList<TObject>.Create;
end;

destructor TCaseUseLocacao.Destroy;
begin
 // Lista.Free;
 // ListaObject.Free;
  inherited;
end;

function TCaseUseLocacao.Excluir(id: Integer): TResponse;
var
  oExcluir: TResponse;
begin
  try
    ValidarID(id);

    FRepository.Excluir(id);
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

procedure TCaseUseLocacao.SetLista(const Value: TObjectList<TLocacao>);
begin
  FLista := Value;
end;

procedure TCaseUseLocacao.SetListaObject(const Value: TObjectList<TObject>);
begin
  FListaObject := Value;
end;

procedure TCaseUseLocacao.ValidarID(id: Integer);
begin
  if(id <= 0)then
  begin
    ExceptionIdInvalido;
  end;
end;

end.
