unit Database.Conexao;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TDatabaseConexao = class(TDataModule)
    FDConn: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    Procedure ConfigurarConexao;
  public
    { Public declarations }
  end;

var
  DatabaseConexao: TDatabaseConexao;

implementation
uses
  IniFiles, System.SysUtils, Vcl.Forms, Vcl.Dialogs, System.UITypes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDatabaseConexao.ConfigurarConexao;
var
  Config: TIniFile;
  PathFile: String;
begin
  PathFile := Concat(ExtractFilePath(Application.ExeName), 'config.ini');
  if FileExists(PathFile) then
  begin
    Config := TIniFile.Create(PathFile);
    try
      FDConn.Connected := False;
      FDConn.LoginPrompt := False;
      FDConn.Params.DriverID := Config.ReadString('Database', 'Drive_id', '');
      if SameText(FDConn.Params.DriverID, 'SQLite') then
        FDConn.Params.Database := Config.ReadString('Database', 'Database', '')
      else
      begin
        FDConn.Params.Database := Config.ReadString('Database', 'Database', '');
        FDConn.Params.UserName := Config.ReadString('Database', 'User_name', '');
        FDConn.Params.Password := Config.ReadString('Database', 'Password', '');
        FDConn.Params.Add(Concat('Server=',Config.ReadString('Database', 'Server', '')));
        FDConn.Params.Add(Concat('Port=',Config.ReadString('Database', 'Port', '')));
      end;
      try
        FDConn.Connected := True;
      Except
        on E: Exception do
        begin
          MessageDlg(Concat(E.Message, #13#13, 'Erro ao conectar com o banco de dados revise as configurações no arquivo de configuração e execute novamente o sistema!'), mtError, [TMsgDlgBtn.mbOK], 0);
          Application.Terminate;
        end;
      end;
    finally
      Config.Free;
    end;
  end
  else
  begin
    MessageDlg(Concat('Arquivo de configuração não encontrado no caminho: ', PathFile), mtError, [TMsgDlgBtn.mbOK], 0);
    Application.Terminate;
  end;
end;

procedure TDatabaseConexao.DataModuleCreate(Sender: TObject);
begin
  ConfigurarConexao;
end;

procedure TDatabaseConexao.DataModuleDestroy(Sender: TObject);
begin
  FDConn.Connected := False;
end;

end.
