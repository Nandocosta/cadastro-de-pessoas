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
     procedure ExcluirPorId(AId: Integer);
     procedure Carregar;

     constructor Create;
    end;

implementation

{ TPessoaController }

uses Model.Pessoa, Repository.Pessoa.SqLite, Dto.Pessoa,
  System.Generics.Collections;

constructor TPessoaController.Create;
begin
  FRepositoryPessoa := TPessoaRepositorySqLite.Create;
end;

procedure TPessoaController.ExcluirPorId(AId: Integer);
begin
  TPessoaModel
    .New(FRepositoryPessoa)
    .ExcluirPorId(AId);
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

procedure TPessoaController.Carregar;
var
  ListaDePessoas: TObjectList<TPessoaDto>;
  PessoaDto: TPessoaDto;
begin
  TPessoaModel.GetListaPessoa.Clear;
  
  ListaDePessoas := TPessoaModel
                      .New(FRepositoryPessoa)
                      .GetPessoas;
  try
    for PessoaDto in ListaDePessoas do
    begin
      TPessoaModel
        .New(FRepositoryPessoa)
        .Nome(PessoaDto.Nome)
        .DataNascimento(PessoaDto.DataNascimento)
        .SaldoDevedor(PessoaDto.SaldoDevedor)
        .GravarEmMemoria;
    end;
  finally
    ListaDePessoas.Free;
  end;

end;

end.
