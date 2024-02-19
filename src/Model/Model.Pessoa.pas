unit Model.Pessoa;

interface

type

TPessoaModel = class
  private
    FId: Integer;
    FNome: String;
    FDataNascimento: TDateTime;
    FSaldoDevedor: Double;
  public
    property Id: Integer read FId write FId;
    property Nome: String read FNome write FNome;
    property DataNascimento: TDateTime read FDataNascimento write FDataNascimento;
    property SaldoDevedor: Double read FSaldoDevedor write FSaldoDevedor;

end;

implementation

end.
