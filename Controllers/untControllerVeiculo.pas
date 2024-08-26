unit untControllerVeiculo;

interface

uses uRepositoryVeiculo, untCaseUseVeiculo, untUseCaseVeiculo, untResponse, untDtoVeiculo, uVeiculo, untEnums, uUtils, untPresenter;

type
  TControllerCliente = class
  private
    FCaseUse: TCaseUseVeiculo;
    FPresenter: TPresenter;
    procedure SetCaseUse(const Value: TCaseUseVeiculo);
    procedure SetPresenter(const Value: TPresenter);
  published
    function Cadastrar(cNome, cPlaca: String; nValor: Currency): String;
    function Alterar(id: Integer; cNome, cPlaca, cStatus: String; nValor: Currency): String;
    function Excluir(id: Integer): String;
    function Consultar(id: Integer; cNome, cPlaca: String): String;

    property CaseUse: TCaseUseVeiculo read FCaseUse write SetCaseUse;
    property Presenter: TPresenter read FPresenter write SetPresenter;
    constructor Create(oRepository: TRepositoryVeiculo; oPresenter: TPresenter);
    destructor Destroy;override;
  end;
implementation

{ TControllerCliente }

function TControllerCliente.Alterar(id: Integer; cNome, cPlaca, cStatus: String;
  nValor: Currency): String;
  var
    oVeiculo: TVeiculo;
    oResponse: TResponse;
    oDtoVeiculo: DtoVeiculo;
begin
  oDtoVeiculo.id := id;

  oResponse := CaseUse.Consultar(oDtoVeiculo);

  if((oResponse.Success)and(oResponse.Message = RetornarMsgResponse.CONSULTA_REALIZADA_COM_SUCESSO))then
  begin
    oVeiculo := TVeiculo(oResponse.Data[0]);

    if(cNome <> '')then
      oVeiculo.Nome := cNome;

    if(cPlaca <> '')then
      oVeiculo.Placa := cPlaca;

    if(cStatus <> '')then
      oVeiculo.Status := ConverterStrStatus(cStatus);

    if(nValor > 0)then
      oVeiculo.Valor := nValor;

    oResponse := CaseUse.Alterar(oVeiculo);
  end;

  Result := Presenter.ConverterResponse(oResponse);
end;

function TControllerCliente.Cadastrar(cNome, cPlaca: String;
  nValor: Currency): String;
  var
    oVeiculo: TVeiculo;
    oResponse: TResponse;
begin
  oVeiculo         := TVeiculo.Create;
  oVeiculo.Nome    := cNome;
  oVeiculo.Placa   := cPlaca;
  oVeiculo.Valor   := nValor;
  oVeiculo.Status  := Disponivel;

  oResponse := CaseUse.Cadastrar(oVeiculo);

  oVeiculo.Free;

  Result := Presenter.ConverterResponse(oResponse);
end;

function TControllerCliente.Consultar(id: Integer; cNome,
  cPlaca: String): String;
var
  oResponse: TResponse;
  oDtoVeiculo: DtoVeiculo;
begin
  oDtoVeiculo.id    := id;
  oDtoVeiculo.Nome  := cNome;
  oDtoVeiculo.Placa := cPlaca;

  oResponse := CaseUse.Consultar(oDtoVeiculo);

  Result := Presenter.ConverterResponse(oResponse);
end;

constructor TControllerCliente.Create(oRepository: TRepositoryVeiculo; oPresenter: TPresenter);
begin
  Self.Presenter := oPresenter;
  CaseUse        := TCaseUseVeiculo.Create(oRepository);
end;

destructor TControllerCliente.Destroy;
begin
  CaseUse.Free;
  inherited;
end;

function TControllerCliente.Excluir(id: Integer): String;
var
  oResponse: TResponse;
begin
  oResponse := CaseUse.Excluir(id);
  Result    := Presenter.ConverterResponse(oResponse);
end;


procedure TControllerCliente.SetCaseUse(const Value: TCaseUseVeiculo);
begin
  FCaseUse := Value;
end;

procedure TControllerCliente.SetPresenter(const Value: TPresenter);
begin
  FPresenter := Value;
end;

end.