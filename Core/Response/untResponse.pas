unit untResponse;

interface

uses System.Generics.Collections;

type
  TResponse = Record
    Success   : Boolean;
    ErrorCode : Integer;
    Message   : String;
    Data      : TObjectList<TObject>;
  end;

implementation

end.
