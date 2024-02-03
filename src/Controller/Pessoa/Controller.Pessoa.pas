unit Controller.Pessoa;

interface

uses Repository.Pessoa.Interfaces;
  type
    TPessoaController = class
    Private
     FRepositoryPessoa: IRepositoryPessoa;
    Public
     procedure GravarEmMemoria(ANome: String; ADataNascimento: TDateTime; ASaldoDevedor: Double);
     procedure GravarListaNoBanco;

     constructor Create;
    end;

implementation

{ TPessoaController }

uses Model.Pessoa, Repository.Pessoa.SqLite;

constructor TPessoaController.Create;
begin
  FRepositoryPessoa := TPessoaRepositorySqLite.Create;
end;

procedure TPessoaController.GravarEmMemoria(ANome: String;
  ADataNascimento: TDateTime; ASaldoDevedor: Double);
begin
  TPessoaModel
    .New(FRepositoryPessoa)
    .Nome(ANome)
    .DataNascimento(ADataNascimento)
    .SaldoDevedor(ASaldoDevedor)
    .GravarEmMemoria;
end;

procedure TPessoaController.GravarListaNoBanco;
begin
 TPessoaModel
  .New(FRepositoryPessoa)
  .GravarListaNoBanco;
end;

end.
