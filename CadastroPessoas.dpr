program CadastroPessoas;

uses
  Vcl.Forms,
  View.Principal in 'src\View\View.Principal.pas' {ViewPrincipal},
  Model.Pessoa in 'src\Model\Model.Pessoa.pas',
  Dao.Pessoa in 'src\Dao\Dao.Pessoa.pas',
  Database.Conexao in 'src\Database\Database.Conexao.pas' {DatabaseConexao: TDataModule},
  View.Pessoa in 'src\View\View.Pessoa.pas' {ViewPessoa},
  Model.QuartoHotel in 'src\Model\Model.QuartoHotel.pas',
  Service.QuartoHotel in 'src\Service\QuartoHotel\Service.QuartoHotel.pas',
  Service.QuartoHotel.Interfaces in 'src\Service\QuartoHotel\Service.QuartoHotel.Interfaces.pas',
  View.IdPessoa in 'src\View\View.IdPessoa.pas' {ViewId};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDatabaseConexao, DatabaseConexao);
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;

  ReportMemoryLeaksOnShutdown := True;
end.
