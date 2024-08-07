unit uCliente;

interface

uses System.SysUtils, untExceptions;
type

Tcliente = class
  private
    FLogradouro: String;
    FBairro: String;
    FUF: String;
    FCep: String;
    FDocumento: String;
    FId: Integer;
    FNumero: String;
    FComplemento: String;
    FNome: String;
    FCidade: String;
    FTelefone: String;
    procedure SetBairro(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetDocumento(const Value: String);
    procedure SetId(const Value: Integer);
    procedure SetLogradouro(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetUF(const Value: String);
  published

  property Id: Integer read FId write SetId;
  property Nome: String read FNome write SetNome;
  property Documento: String read FDocumento write SetDocumento;
  property Cep: String read FCep write SetCep;
  property Logradouro: String read FLogradouro write SetLogradouro;
  property Numero: String read FNumero write SetNumero;
  property Complemento: String read FComplemento write SetComplemento;
  property Bairro: String read FBairro write SetBairro;
  property Cidade: String read FCidade write SetCidade;
  property UF: String read FUF write SetUF;
  property Telefone: String read FTelefone write SetTelefone;

  procedure ValidarRegrasNegocios;
end;

implementation

{ Tcliente }

procedure Tcliente.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure Tcliente.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure Tcliente.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure Tcliente.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure Tcliente.SetDocumento(const Value: String);
begin
  FDocumento := Value;
end;

procedure Tcliente.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure Tcliente.SetLogradouro(const Value: String);
begin
  FLogradouro := Value;
end;

procedure Tcliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure Tcliente.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure Tcliente.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

procedure Tcliente.SetUF(const Value: String);
begin
  FUF := Value;
end;

procedure Tcliente.ValidarRegrasNegocios;
begin
  if(Trim(FNome) = '')then
  begin
    ExceptionNome;
  end;

  if(Length(FNome) <= 4)then
  begin
    ExceptionMinNome;
  end;

  if(Trim(FDocumento) = '')then
  begin
    ExceptionDocumento;
  end;

  if(Length(FDocumento) <= 4)then
  begin
    ExceptionMinDocumento;
  end;

  if(Trim(FTelefone) = '')then
  begin
    ExceptionTelefone;
  end;

  if(Length(FTelefone) <= 8)then
  begin
    ExceptionMinTelefone;
  end;
end;

end.
