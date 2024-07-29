unit uLocacao;

interface

uses uCliente, uVeiculo, untExceptions, untEnums, System.DateUtils, System.SysUtils;

type
 TLocacao = class
  private
    FCliente      : TCliente;
    FTotal        : Currency;
    FDataLocacao  : TDateTime;
    FId           : Integer;
    FDataDevolucao: TDateTime;
    FVeiculo      : TVeiculo;
    procedure SetCliente(const Value: TCliente);
    procedure SetDataDevolucao(const Value: TDateTime);
    procedure SetDataLocacao(const Value: TDateTime);
    procedure SetId(const Value: Integer);
    procedure SetTotal(const Value: Currency);
    procedure SetVeiculo(const Value: TVeiculo);
  published
   property Id: Integer read FId write SetId;
   property Cliente: TCliente read FCliente write SetCliente;
   property Veiculo: TVeiculo read FVeiculo write SetVeiculo;
   property DataLocacao: TDateTime read FDataLocacao write SetDataLocacao;
   property DataDevolucao: TDateTime read FDataDevolucao write SetDataDevolucao;
   property Total: Currency read FTotal write SetTotal;

   procedure ValidarRegrasNegocios;
   function CalcularTotal: Currency;

 end;

implementation

{ TLocacao }

function TLocacao.CalcularTotal: Currency;
var
  nTotal: Currency;
  iQtdDias: Integer;
begin
  nTotal   := 0;
  iQtdDias := 1;

  if(FDataLocacao   <> StrToDate('30/12/1899'))and
    (FDataDevolucao <> StrToDate('30/12/1899')) then
  begin
    iQtdDias := DaysBetween(FDataLocacao, FDataDevolucao);

    if iQtdDias <= 0 then
      iQtdDias := 1;

  end;

  nTotal := iQtdDias *  FVeiculo.Valor;

  Result := nTotal;
end;

procedure TLocacao.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TLocacao.SetDataDevolucao(const Value: TDateTime);
begin
  FDataDevolucao := Value;
end;

procedure TLocacao.SetDataLocacao(const Value: TDateTime);
begin
  FDataLocacao := Value;
end;

procedure TLocacao.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TLocacao.SetTotal(const Value: Currency);
begin
  FTotal := Value;
end;

procedure TLocacao.SetVeiculo(const Value: TVeiculo);
begin
  FVeiculo := Value;
end;

procedure TLocacao.ValidarRegrasNegocios;
begin
  if FCliente = nil then
  begin
    ExceptionLocacaoCliente;
  end;

  if FVeiculo = nil then
  begin
    ExceptionLocacaoVeiculo;
  end;

  if FVeiculo.Status = sAlugado then
  begin
    ExceptionValorVeiculo;
  end;
end;

end.
