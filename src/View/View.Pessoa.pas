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
  Vcl.DBGrids, Datasnap.DBClient, Controller.Pessoa;

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
    procedure FormShow(Sender: TObject);
  private
    FPessoaController: TPessoaController;
    procedure CarregarPessoas;
  public
    { Public declarations }
    constructor create(APessoaController: TPessoaController);
  end;

implementation

{$R *.dfm}

uses Dto.Pessoa, System.Generics.Collections;

procedure TViewPessoa.ButtonFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TViewPessoa.CarregarPessoas;
var
  ListaPessoaDto: TObjectList<TPessoaDto>;
  PessoaDto: TPessoaDto;
begin
  ClientDataSetPessoa.EmptyDataSet;
  ListaPessoaDto := FPessoaController.GetListaPessoaMemoria;
  for PessoaDto in ListaPessoaDto do
  begin
    ClientDataSetPessoa.Append;
    ClientDataSetPessoa.FieldByName('codigo').AsInteger := PessoaDto.Id;
    ClientDataSetPessoa.FieldByName('nome').AsString := PessoaDto.Nome;
    ClientDataSetPessoa.FieldByName('data_nascimento').AsDateTime := PessoaDto.DataNascimento;
    ClientDataSetPessoa.FieldByName('saldo_devedor').AsFloat := PessoaDto.SaldoDevedor;
    ClientDataSetPessoa.Post;
  end;

end;

constructor TViewPessoa.create(APessoaController: TPessoaController);
begin
  inherited Create(nil);
  FPessoaController := APessoaController;
end;

procedure TViewPessoa.FormShow(Sender: TObject);
begin
  CarregarPessoas;
end;

end.
