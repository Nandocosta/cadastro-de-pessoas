program CadastroPessoas;

uses
  Vcl.Forms,
  Model.Pessoa in 'src\Model\Pessoa\Model.Pessoa.pas',
  View.Principal in 'src\View\View.Principal.pas' {ViewPrincipal},
  Dto.Pessoa in 'src\Dto\Pessoa\Dto.Pessoa.pas',
  Model.Pessoa.Interfaces in 'src\Model\Pessoa\Model.Pessoa.Interfaces.pas',
  Controller.Pessoa in 'src\Controller\Pessoa\Controller.Pessoa.pas',
  Repository.Pessoa.Interfaces in 'src\Repository\Pessoa\Repository.Pessoa.Interfaces.pas',
  Repository.Pessoa.SqLite in 'src\Repository\Pessoa\Repository.Pessoa.SqLite.pas',
  Database.Conexao in 'src\Database\Database.Conexao.pas' {DatabaseConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDatabaseConexao, DatabaseConexao);
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
