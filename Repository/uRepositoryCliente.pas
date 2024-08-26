unit uRepositoryCliente;

interface

uses uCliente, untDtoCliente, untRepositoryCliente, System.Generics.Collections, System.SysUtils, untConfigDB, uUtils;

type
  TRepositoryCliente = class (TInterfacedObject, IRepositoryCliente)
  private
    FLista: TObjectList<TCliente>;
    ConfiguracaoDB: TConfigurarDB;
    procedure SetLista(const Value: TObjectList<TCliente>);
  published
    procedure Cadastrar(oCliente: TCliente);
    procedure Alterar(oCliente: TCliente);
    procedure Excluir(id: Integer);
    function Consultar(dtoCliente: DtoCliente): TObjectList<TCliente>;

    property Lista: TObjectList<TCliente> read FLista write SetLista;


    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TRepositoryCliente }

procedure TRepositoryCliente.Alterar(oCliente: TCliente);
var
  cSQL: String;
begin
  cSQL := 'UPDATE CLIENTE        '
      +QL+'   SET NOME        =  ' + QuotedStr(oCliente.Nome)
      +QL+'      ,DOCUMENTO   =  ' + QuotedStr(oCliente.Documento)
      +QL+'      ,CEP         =  ' + QuotedStr(oCliente.Cep)
      +QL+'      ,LOGRADOURO  =  ' + QuotedStr(oCliente.Logradouro)
      +QL+'      ,NUMERO      =  ' + QuotedStr(oCliente.Numero)
      +QL+'      ,COMPLEMENTO =  ' + QuotedStr(oCliente.Complemento)
      +QL+'      ,BAIRRO      =  ' + QuotedStr(oCliente.Bairro)
      +QL+'      ,CIDADE      =  ' + QuotedStr(oCliente.Cidade)
      +QL+'      ,UF          =  ' + QuotedStr(oCliente.UF)
      +QL+'      ,TELEFONE    =  ' + QuotedStr(oCliente.Telefone)
      +QL+' WHERE ID = ' + IntToStr(oCliente.Id);

  ConfiguracaoDB.ExecSQL(cSQL);
end;

procedure TRepositoryCliente.Cadastrar(oCliente: TCliente);
var
  cSQL: String;
begin
  cSQL := 'INSERT INTO CLIENTES (NOME                           '
      +QL+'                     ,DOCUMENTO                      '
      +QL+'                     ,CEP                            '
      +QL+'                     ,LOGRADOURO                     '
      +QL+'                     ,NUMERO                         '
      +QL+'                     ,COMPLEMENTO                    '
      +QL+'                     ,BAIRRO                         '
      +QL+'                     ,CIDADE                         '
      +QL+'                     ,UF                             '
      +QL+'                     ,TELEFONE)                      '
      +QL+'              VALUES( ' + QuotedStr(oCliente.Nome)
      +QL+'                     ,' + QuotedStr(oCliente.Documento)
      +QL+'                     ,' + QuotedStr(oCliente.Cep)
      +QL+'                     ,' + QuotedStr(oCliente.Logradouro)
      +QL+'                     ,' + QuotedStr(oCliente.Numero)
      +QL+'                     ,' + QuotedStr(oCliente.Complemento)
      +QL+'                     ,' + QuotedStr(oCliente.Bairro)
      +QL+'                     ,' + QuotedStr(oCliente.Cidade)
      +QL+'                     ,' + QuotedStr(oCliente.UF)
      +QL+'                     ,' + QuotedStr(oCliente.Telefone)+')';

  ConfiguracaoDB.ExecSQL(cSQL);
end;

function TRepositoryCliente.Consultar(dtoCliente: DtoCliente): TObjectList<TCliente>;
var
  cSQL: String;
  oCliente: TCliente;
begin
  cSQL := 'SELECT * FROM CLIENTES WHERE 1 = 1 ';
  if(dtoCliente.id > 0)then
  begin
    cSQL := cSQL + ' AND ID = ' + IntToStr(dtoCliente.id);
  end
  else
  begin
    if(dtoCliente.Nome <> '')then
    begin
      cSQL := cSQL + ' AND NOME LIKE ' + QuotedStr('%' + dtoCliente.Nome + '%');
    end;

    if(dtoCliente.Documento <> '')then
    begin
      cSQL := cSQL + ' AND DOCUMENTO LIKE ' + QuotedStr('%' + dtoCliente.Documento + '%');
    end;
  end;

  if(ConfiguracaoDB.Consultar(cSQL))then
  begin
    Lista.Clear;

    with ConfiguracaoDB do
    begin
      Query.First;

      while not Query.Eof do
      begin
        oCliente            := TCliente.Create;
        oCliente.Id         := Query.FieldByName('ID').AsInteger;
        oCliente.Nome       := Query.FieldByName('NOME').AsString;
        oCliente.Documento  := Query.FieldByName('DOCUMENTO').AsString;
        oCliente.Cep        := Query.FieldByName('CEP').AsString;
        oCliente.Logradouro := Query.FieldByName('LOGRADOURO').AsString;
        oCliente.Numero     := Query.FieldByName('NUMERO').AsString;
        oCliente.Complemento:= Query.FieldByName('COMPLEMENTO').AsString;
        oCliente.Bairro     := Query.FieldByName('BAIRRO').AsString;
        oCliente.Cidade     := Query.FieldByName('CIDADE').AsString;
        oCliente.UF         := Query.FieldByName('UF').AsString;
        oCliente.Telefone   := Query.FieldByName('TELEFONE').AsString;

        Lista.Add(oCliente);

        Query.Next;
      end;
    end;
  end;

  Result := Lista;
end;

constructor TRepositoryCliente.Create;
begin
  Lista := TObjectList<TCliente>.Create;
  ConfiguracaoDB := TConfigurarDB.Create;
end;

destructor TRepositoryCliente.Destroy;
begin
  Lista.Free;
  ConfiguracaoDB.Free;
  inherited;
end;

procedure TRepositoryCliente.Excluir(id: Integer);
var
  cSQL: String;
begin
  cSQL := 'DELETE FROM CLIENTES WHERE ID = ' + IntToStr(id);
  ConfiguracaoDB.ExecSQL(cSQL);
end;

procedure TRepositoryCliente.SetLista(const Value: TObjectList<TCliente>);
begin
  FLista := Value;
end;

end.
