unit untPresenter;

interface

uses untResponse, uCliente, uVeiculo, uLocacao, System.Generics.Collections;

type
  TPresenter = Interface
    function ConverterResponse(oResponse: TResponse): String;
    function ConverterCliente(oCliente: TCliente): String;
    function ConverterVeiculo(oVeiculo: TVeiculo): String;
    function ConverterLocacao(oLocacao: TLocacao): String;
    function ConverterLista(oLista: TList<TObject>): String;
  End;

implementation

end.
