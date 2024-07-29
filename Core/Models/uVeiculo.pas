unit uVeiculo;

interface

uses
 untEnums, System.SysUtils, untExceptions;

type
  TVeiculo = class
  private
    FValor: Currency;
    FId: Integer;
    FStatus: TStatus;
    FPlaca: String;
    FNome: String;
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetPlaca(const Value: String);
    procedure SetStatus(const Value: TStatus);
    procedure SetValor(const Value: Currency);
  published
    property Id    : Integer read FId write SetId;
    property Nome  : String read FNome write SetNome;
    property Placa : String read FPlaca write SetPlaca;
    property Valor : Currency read FValor write SetValor;
    property Status: TStatus read FStatus write SetStatus;

    procedure ValidarRegrasNegocios;
  end;

implementation

{ TVeiculo }

procedure TVeiculo.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TVeiculo.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TVeiculo.SetPlaca(const Value: String);
begin
  FPlaca := Value;
end;

procedure TVeiculo.SetStatus(const Value: TStatus);
begin
  FStatus := Value;
end;

procedure TVeiculo.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

procedure TVeiculo.ValidarRegrasNegocios;
begin
  if(Trim(FNome) = '')then
  begin
    ExceptionNome;
  end;

  if(Length(FNome) <= 4)then
  begin
    ExceptionMinNome;
  end;

  if(Trim(FPlaca) = '')then
  begin
    ExceptionPlacaVeiculo;
  end;

  if(Length(FPlaca) <= 6)then
  begin
    ExceptionMinPlacaVeiculo;
  end;

  if(FValor <= 0)then
  begin
    ExceptionValorVeiculo;
  end;
end;

end.
