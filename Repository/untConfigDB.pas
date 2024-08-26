unit untConfigDB;

interface

uses Firedac.Comp.Client, FireDAC.phys.PG, inifiles, System.SysUtils, untExceptions;

type
  TConfigurarDB = class
  private
    Connection: TFDConnection;
    FDPhsysPGDriverLink: TFDPhysPgDriverLink;
    FQuery: TFDQuery;
    procedure SetQuery(const Value: TFDQuery);
  published
    function Conexao: TFDConnection;
    procedure ExecSQL(cSQL: String);
    function Consultar(cSQL: String): Boolean;
    property Query: TFDQuery read FQuery write SetQuery;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TConfigurarDB }

function TConfigurarDB.Conexao: TFDConnection;
begin
  Result := Connection;
end;

function TConfigurarDB.Consultar(cSQL: String): Boolean;
begin
  Result := False;
  try
    FQuery.SQL.Clear;
    FQuery.SQL.Add(cSQL);
    FQuery.Open();

  except on E: Exception do
    begin
      ExceptionDatabase(e.Message);
    end;
  end;

  Result := (not(FQuery.IsEmpty));

end;

constructor TConfigurarDB.Create;
var
  cDir, cServer, cUser, cDataBase, cPassword, cDriver: String;
  oArquivoIni: TIniFile;
begin
  cDir        := ExtractFileDir(GetCurrentDir);
  oArquivoIni := TIniFile.Create(cDir + '\config.ini');
  cServer     := oArquivoIni.ReadString('conexao', 'server', '');
  cUser       := oArquivoIni.ReadString('conexao', 'user', '');
  cDataBase   := oArquivoIni.ReadString('conexao', 'database', '');
  cPassword   := oArquivoIni.ReadString('conexao', 'passaword', '');
  cDriver     := 'PG';

  try
   Connection          := TFDConnection.Create(nil);
   FDPhsysPGDriverLink := FDPhsysPGDriverLink.Create(nil);

   Connection.LoginPrompt := False;
   Connection.Params.Clear;
   Connection.Params.Add('DriverID=' + cDriver);
   Connection.Params.Add('Database=' + cDataBase);
   Connection.Params.Add('PassWord=' + cPassword);
   Connection.Params.Add('User='     + cUser);
   Connection.Params.Add('Server='   + cServer);

   Connection.Open();

   Query := TFDQuery.Create(nil);
   Query.Connection := Connection;
  except
    on E: Exception do
    begin
      Connection.Free;
      FDPhsysPGDriverLink.Free;
      Query.Free;
      ExceptionDatabase(e.Message);
    end;
  end;
end;

destructor TConfigurarDB.Destroy;
begin
  Connection.Free;
  FQuery.Free;
  FDPhsysPGDriverLink.Free;
  inherited;
end;

procedure TConfigurarDB.ExecSQL(cSQL: String);
begin
  try
    FQuery.SQL.Clear;
    FQuery.SQL.Add(cSQL);
    FQuery.ExecSQL();
  except on E: Exception do
    begin
      ExceptionDatabase(e.Message);
    end;
  end;
end;

procedure TConfigurarDB.SetQuery(const Value: TFDQuery);
begin
  FQuery := Value;
end;

end.
