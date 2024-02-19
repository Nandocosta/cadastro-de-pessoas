unit View.Pessoa;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Datasnap.DBClient,
  Model.Pessoa,
  System.Generics.Collections;

type
  TViewPessoa = class(TForm)
    Panel1: TPanel;
    ButtonFechar: TButton;
    DBGridPessoa: TDBGrid;
    DataSourcePessoa: TDataSource;
    ClientDataSetPessoa: TClientDataSet;
    ClientDataSetPessoacodigo: TIntegerField;
    ClientDataSetPessoanome: TStringField;
    ClientDataSetPessoadata_nascimento: TDateTimeField;
    ClientDataSetPessoasaldo_devedor: TFloatField;
    procedure ButtonFecharClick(Sender: TObject);
  private
    procedure CarregarPessoas(ListaPessoaModel: TObjectList<TPessoaModel>);
  public
    constructor Create(ListaPessoaModel: TObjectList<TPessoaModel>);reintroduce;
  end;

implementation

{$R *.dfm}


procedure TViewPessoa.ButtonFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TViewPessoa.CarregarPessoas(ListaPessoaModel: TObjectList<TPessoaModel>);
var
  Pessoa: TPessoaModel;
begin
  ClientDataSetPessoa.EmptyDataSet;

  for Pessoa in ListaPessoaModel do
  begin
    ClientDataSetPessoa.Append;
    ClientDataSetPessoa.FieldByName('codigo').AsInteger := Pessoa.Id;
    ClientDataSetPessoa.FieldByName('nome').AsString := Pessoa.Nome;
    ClientDataSetPessoa.FieldByName('data_nascimento').AsDateTime := Pessoa.DataNascimento;
    ClientDataSetPessoa.FieldByName('saldo_devedor').AsFloat := Pessoa.SaldoDevedor;
    ClientDataSetPessoa.Post;
  end;

end;

constructor TViewPessoa.create(ListaPessoaModel: TObjectList<TPessoaModel>);
begin
  inherited Create(nil);
  CarregarPessoas(ListaPessoaModel);
end;

end.
