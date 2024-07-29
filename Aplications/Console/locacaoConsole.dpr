program locacaoConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  untMenuPrincipal in 'untMenuPrincipal.pas',
  uCliente in '..\..\Core\Models\uCliente.pas',
  untUseCaseCliente in '..\..\Core\Ports\untUseCaseCliente.pas',
  untResponse in '..\..\Core\Response\untResponse.pas',
  untDtoCliente in '..\..\Core\DTO\untDtoCliente.pas',
  untCaseUseClient in '..\..\Core\UseCases\untCaseUseClient.pas',
  untEnums in '..\..\Core\Enums\untEnums.pas',
  untExceptions in '..\..\Core\Exception\untExceptions.pas',
  uUtils in '..\..\Utils\uUtils.pas',
  uVeiculo in '..\..\Core\Models\uVeiculo.pas',
  untDtoVeiculo in '..\..\Core\DTO\untDtoVeiculo.pas',
  untUseCaseVeiculo in '..\..\Core\Ports\untUseCaseVeiculo.pas',
  untCaseUseVeiculo in '..\..\Core\UseCases\untCaseUseVeiculo.pas',
  uLocacao in '..\..\Core\Models\uLocacao.pas',
  untUseCaseLocacao in '..\..\Core\Ports\untUseCaseLocacao.pas',
  untDtoLocacao in '..\..\Core\DTO\untDtoLocacao.pas',
  untCaseUseLocacao in '..\..\Core\UseCases\untCaseUseLocacao.pas';

begin
  try
    Menu;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
