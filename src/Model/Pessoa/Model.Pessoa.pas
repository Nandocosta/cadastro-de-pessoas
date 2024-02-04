unit Model.Pessoa;

interface
uses
  Model.Pessoa.Interfaces,
  System.Generics.Collections,
  Repository.Pessoa.Interfaces,
  Dto.Pessoa;

type
  TPessoaModel = class(TInterfacedObject, IPessoaModel)
  private
    class var FListPessoa: TObjectList<TPessoaModel>;
    FId: Integer;
    FNome: String;
    FDataNascimento: TDateTime;
    FSaldoDevedor: Double;
    FRepositoryPessoa: IRepositoryPessoa;

  Public
    class function New(ARepositoryPessoa: IRepositoryPessoa): IPessoaModel;
    class function GetListaPessoa: TObjectList<TPessoaModel>;
    function Id(AId: Integer): IPessoaModel;
    function Nome(ANome: String): IPessoaModel;
    function DataNascimento(ADataNascimento: TDateTime): IPessoaModel;
    function SaldoDevedor(ASaldoDevedor: Double): IPessoaModel;
    procedure SetRespositoryPessoa(ARepositoryPessoa: IRepositoryPessoa);
    procedure ExcluirPorId(AId: Integer);

    procedure GravarEmMemoria;
    procedure GravarNoBanco;
    procedure GravarListaNoBanco;
    Function GetPessoas: TObjectList<TPessoaDto>;
  end;


implementation

{ TPessoa }

{ TPessoa }

{ TPessoaModel }

function TPessoaModel.DataNascimento(ADataNascimento: TDateTime): IPessoaModel;
begin
  Result := self;
  FDataNascimento := ADataNascimento;
end;

procedure TPessoaModel.ExcluirPorId(AId: Integer);
begin
  FRepositoryPessoa.ExcluirPorId(AId);
end;

class function TPessoaModel.GetListaPessoa: TObjectList<TPessoaModel>;
begin
  if not Assigned(FListPessoa) then
    FListPessoa := TObjectList<TPessoaModel>.Create;
  Result := FListPessoa;
end;

procedure TPessoaModel.GravarEmMemoria;
begin
  TPessoaModel.GetListaPessoa.Add(Self);
end;

procedure TPessoaModel.GravarListaNoBanco;
var
  PessoaModel: TPessoaModel;
begin
  for PessoaModel in GetListaPessoa do
  begin
     PessoaModel.GravarNoBanco;
  end;
end;

procedure TPessoaModel.GravarNoBanco;
var
  PessoaDto: TPessoaDto;
begin
  PessoaDto := TPessoaDto.Create;
  try
    PessoaDto.Nome := FNome;
    PessoaDto.DataNascimento := FDataNascimento;
    PessoaDto.SaldoDevedor := FSaldoDevedor;
    FRepositoryPessoa.Salvar(PessoaDto);
  finally
    PessoaDto.Free;
  end;
end;

function TPessoaModel.Id(AId: Integer): IPessoaModel;
begin
  Result := self;
  FId := AId;
end;

function TPessoaModel.GetPessoas: TObjectList<TPessoaDto>;
begin
  Result := FRepositoryPessoa.GetPessoas;
end;

class function TPessoaModel.New(ARepositoryPessoa: IRepositoryPessoa): IPessoaModel;
begin
  Result := TPessoaModel.Create;
  Result.SetRespositoryPessoa(ARepositoryPessoa);
end;

function TPessoaModel.Nome(ANome: String): IPessoaModel;
begin
  Result := self;
  FNome := ANome;
end;

function TPessoaModel.SaldoDevedor(ASaldoDevedor: Double): IPessoaModel;
begin
  Result := self;
  FSaldoDevedor := ASaldoDevedor;
end;

procedure TPessoaModel.SetRespositoryPessoa(
  ARepositoryPessoa: IRepositoryPessoa);
begin
  FRepositoryPessoa := ARepositoryPessoa;
end;

end.
