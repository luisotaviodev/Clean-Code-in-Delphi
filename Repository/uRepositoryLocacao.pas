unit uRepositoryLocacao;

interface

uses uLocacao, untDtoLocacao, untRepositoryLocacao, System.Generics.Collections, System.SysUtils, untConfigDB, uUtils,
uVeiculo, uCliente, untDtoVeiculo, untDtoCliente, untRepositoryCliente, untRepositoryVeiculo;
type
  TRepositoryLocacao = class(TInterfacedObject, IRepositoryLocacao)
  private
    ConfiguracaoDB: TConfigurarDB;
    RepositoryCliente: IRepositoryCliente;
    RepositoryVeiculo: IRepositoryVeiculo;
    FLista: TObjectList<TLocacao>;
    FListaClientes: TObjectList<TCliente>;
    FListaVeiculos: TObjectList<TVeiculo>;
    procedure SetLista(const Value: TObjectList<TLocacao>);
  published
    procedure Cadastrar(oLocacao: TLocacao);
    procedure Alterar(oLocacao: TLocacao);
    procedure Excluir(id: Integer);
    function Consultar(dtoLocacao: TDtoLocacao): TObjectList<TLocacao>;

    property Lista: TObjectList<TLocacao> read FLista write SetLista;

    constructor Create(repositoryCliente: IRepositoryCliente; repositoryVeiculo: IRepositoryVeiculo);
    destructor Destroy; override;
  end;

implementation

{ TRepositoryLocacao }

procedure TRepositoryLocacao.Alterar(oLocacao: TLocacao);
var
  cSql: String;
begin
  cSQL := 'UPDATE LOCACAO         '
      +QL+'   SET IDCLIENTE     = ' + IntToStr(oLocacao.Cliente.Id)
      +QL+'      ,DATADEVOLUCAO = ' + QuotedStr(DateToStr(oLocacao.DataDevolucao))
      +QL+'      ,TOTAL         = ' + StringReplace(CurrToStr(oLocacao.Total), ',', '.', [])
      +QL+' WHERE ID = ' + IntToStr(oLocacao.Id);

  ConfiguracaoDB.ExecSQL(cSQL);

  if(oLocacao.Veiculo.Id <> oLocacao.VeiculoAtual.Id)then
  begin
    cSQL := 'UPDATE LOCACAOVEICULO  '
        +QL+'   SET IDVEICULO     = ' + IntToStr(oLocacao.Veiculo.Id)
        +QL+' WHERE ID = ' + IntToStr(oLocacao.Id);

    ConfiguracaoDB.ExecSQL(cSQL);
  end;

end;

procedure TRepositoryLocacao.Cadastrar(oLocacao: TLocacao);
var
  cSQL: String;
begin
  cSQL := 'INSERT INTO LOCACAO  (IDCLIENTE                                          '
      +QL+'                     ,DATALOCACAO                                        '
      +QL+'                     ,DATADEVOLUCAO                                      '
      +QL+'                     ,TOTAL                                              '
      +QL+'                     ,HASH                                               '
      +QL+'              VALUES( ' + IntToStr(oLocacao.Cliente.Id)
      +QL+'                     ,' + QuotedStr(DateToStr(oLocacao.DataLocacao))
      +QL+'                     ,' + QuotedStr(DateToStr(oLocacao.DataDevolucao))
      +QL+'                     ,' + StringReplace(CurrToStr(oLocacao.Total), ',', '.', [])
      +QL+'                     ,' + QuotedStr(oLocacao.Hash)+')';

  ConfiguracaoDB.ExecSQL(cSQL);

  cSQL := 'SELECT * FROM LOCACAO WHERE HASH = ' + QuotedStr(oLocacao.Hash);

  if(ConfiguracaoDB.Consultar(cSQL))then
  begin
    oLocacao.Id := ConfiguracaoDB.Query.FieldByName('ID').AsInteger;
  end;

  cSQL := 'INSERT INTO LOCACAOVEICULOS  (IDLOCACAO                                          '
      +QL+'                             ,IDVEICULO                                        '
      +QL+'                             ,VALOR                                      '
      +QL+'                      VALUES( ' + IntToStr(oLocacao.Id)
      +QL+'                             ,' + QuotedStr(DateToStr(oLocacao.Veiculo.Id))
      +QL+'                             ,' + StringReplace(CurrToStr(oLocacao.Veiculo.Valor), ',', '.', [])+')';

  ConfiguracaoDB.ExecSQL(cSQL);
end;

function TRepositoryLocacao.Consultar(dtoLocacao: TDtoLocacao): TObjectList<TLocacao>;
var
  cSQL: String;
  oLocacao: TLocacao;
  oCliente: DtoCliente;
  oVeiculo: DtoVeiculo;
begin
  cSQL := 'SELECT L.*                                           '
      +QL+' FROM LOCACAO L                                      '
      +QL+'INNER JOIN LOCACAOVEICULOS LV ON LV.IDLOCACAO = L.ID '
      +QL+' WHERE 1 = 1                                         ';

  if(dtoLocacao.Id > 0)then
  begin
    cSQL := cSQL + ' AND L.ID = ' + IntToStr(dtoLocacao.Id);
  end
  else
  begin
    if(dtoLocacao.IdCliente > 0)then
    begin
      cSQL := cSQL + ' AND L.IDCLIENTE = ' + IntToStr(dtoLocacao.IdCliente);
    end;

    if(dtoLocacao.DataLocacao <> StrToDate('30/12/1899'))then
    begin
      cSQL := cSQL + ' AND L.DATALOCACAO = ' + QuotedStr(DateToStr(dtoLocacao.DataLocacao));
    end;

    if(dtoLocacao.DataDevolucao <> StrToDate('30/12/1899'))then
    begin
      cSQL := cSQL + ' AND L.DATADEVOLUCAO = ' + QuotedStr(DateToStr(dtoLocacao.DataDevolucao));
    end;
  end;

  if(ConfiguracaoDB.Consultar(cSQL))then
  begin
    Lista.Clear;

    with ConfiguracaoDB do
    begin
      Query.First;

      while(not Query.Eof)do
      begin
        oLocacao               := TLocacao.Create;
        oLocacao.Id            := Query.FieldByName('id').AsInteger;
        oLocacao.DataLocacao   := Query.FieldByName('DATALOCACAO').AsDateTime;
        oLocacao.DataDevolucao := Query.FieldByName('DATADEVOLUCAO').AsDateTime;

        oCliente.id            := Query.FieldByName('IDCLIENTE').AsInteger;

        FListaClientes := RepositoryCliente.Consultar(oCliente);

        if(FListaClientes.Count > 0)then
        begin
          oLocacao.Cliente := TCliente.Create;
          oLocacao.Cliente := FListaClientes.Items[0];
        end;

        oVeiculo.id        := Query.FieldByName('IDVEICULO').AsInteger;

        FListaVeiculos     := RepositoryVeiculo.Consultar(oVeiculo);

        if(FListaClientes.Count > 0)then
        begin
          oLocacao.Veiculo := TVeiculo.Create;
          oLocacao.Veiculo := FListaVeiculos.Items[0];

          oLocacao.VeiculoAtual := oLocacao.Veiculo;
        end;

        Lista.Add(oLocacao);

        Query.Next;
      end;
    end;
  end;

  Result := Lista;
end;

constructor TRepositoryLocacao.Create(repositoryCliente: IRepositoryCliente; repositoryVeiculo: IRepositoryVeiculo);
begin
  Self.RepositoryCliente := repositoryCliente;
  Self.RepositoryVeiculo := repositoryVeiculo;
  Lista                  := TObjectList<TLocacao>.Create;
  ConfiguracaoDB         := TConfigurarDB.Create;
  FListaClientes         := TObjectList<TCliente>.Create;
  FListaVeiculos         := TObjectList<TVeiculo>.Create;

end;

destructor TRepositoryLocacao.Destroy;
begin
  Lista.Free;
  ConfiguracaoDB.Free;
  inherited;
end;

procedure TRepositoryLocacao.Excluir(id: Integer);
var
  cSQL: String;
begin
  cSQL :=  'DELETE FROM LOCACAO WHERE ID = ' + IntToStr(id);
  ConfiguracaoDB.ExecSQL(cSQL);

  cSQL := 'DELETE FROM LOCACAOVEICULOS WHERE IDLOCACAO = ' + IntToStr(id);
  ConfiguracaoDB.ExecSQL(cSQL);
end;

procedure TRepositoryLocacao.SetLista(const Value: TObjectList<TLocacao>);
begin
  FLista := Value;
end;

end.
