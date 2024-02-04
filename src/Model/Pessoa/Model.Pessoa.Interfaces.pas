unit Model.Pessoa.Interfaces;

interface

uses Repository.Pessoa.Interfaces, Dto.Pessoa, System.Generics.Collections;
type
  IPessoaModel = Interface
    ['{7F2B2FFE-C986-463A-9CBD-2AB197013E0F}']

    function Id(AId: Integer): IPessoaModel;
    function Nome(ANome: String): IPessoaModel;
    function DataNascimento(ADataNascimento: TDateTime): IPessoaModel;
    function SaldoDevedor(ASaldoDevedor: Double): IPessoaModel;
    procedure GravarEmMemoria;
    procedure GravarNoBanco;
    procedure GravarListaNoBanco;
    procedure SetRespositoryPessoa(ARepositoryPessoa: IRepositoryPessoa);
    procedure ExcluirPorId(AId: Integer);
    Function GetPessoas: TObjectList<TPessoaDto>;
  End;

implementation

end.
