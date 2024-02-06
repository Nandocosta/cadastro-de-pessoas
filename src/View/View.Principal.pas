unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Controller.Pessoa,
  Vcl.ComCtrls, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Dto.QuartoHotel, System.Generics.Collections;

type
  TViewPrincipal = class(TForm)
    ButtonAddMemoria: TButton;
    ButtonGravar: TButton;
    ButtonExcluirPorId: TButton;
    ButtonCarregar: TButton;
    ButtonMostrarPessoaMemoria: TButton;
    ButtonBuscarApi: TButton;
    PageControlPrincipal: TPageControl;
    TabSheetPessoa: TTabSheet;
    TabSheetQuartoHotel: TTabSheet;
    GroupBoxCadastro: TGroupBox;
    EditNome: TEdit;
    DateTimePickerDtNascimento: TDateTimePicker;
    EditSaldoDevedor: TEdit;
    GroupBoxBancoDados: TGroupBox;
    DBGrid1: TDBGrid;
    DataSourceQuartoHotel: TDataSource;
    ClientDataSetQuartoHotel: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonAddMemoriaClick(Sender: TObject);
    procedure ButtonGravarClick(Sender: TObject);
    procedure ButtonExcluirPorIdClick(Sender: TObject);
    procedure ButtonCarregarClick(Sender: TObject);
    procedure ButtonMostrarPessoaMemoriaClick(Sender: TObject);
    procedure ButtonBuscarApiClick(Sender: TObject);
  private
    FPessoaController: TPessoaController;

    procedure LimparCampos;
    procedure PopularDataSet(AListaQuartoHotelDto: TObjectList<TQuartoHotelDto>);
    function ValidarCampos: Boolean;
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

uses
  View.Pessoa,
  Service.QuartoHotel,
  View.IdPessoa;

{$R *.dfm}


procedure TViewPrincipal.ButtonAddMemoriaClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    FPessoaController.GravarEmMemoria(EditNome.Text, DateTimePickerDtNascimento.Date, StrToFloatDef(EditSaldoDevedor.Text, 0));
    LimparCampos;
  end;
end;

procedure TViewPrincipal.ButtonGravarClick(Sender: TObject);
begin
  FPessoaController.GravarListaNoBanco
end;

procedure TViewPrincipal.ButtonExcluirPorIdClick(Sender: TObject);
var
  Id: Integer;
begin
  Id := TViewId.GetId;
  FPessoaController.ExcluirPorId(Id);
  ShowMessage('Registro excluído com sucesso');
end;

procedure TViewPrincipal.ButtonCarregarClick(Sender: TObject);
begin
  FPessoaController.Carregar;
end;

procedure TViewPrincipal.ButtonMostrarPessoaMemoriaClick(Sender: TObject);
var
  ViewPessoa: TViewPessoa;
begin
  ViewPessoa := TViewPessoa.create(FPessoaController);
  try
    ViewPessoa.ShowModal;
  finally
    ViewPessoa.Free;
  end;
end;

procedure TViewPrincipal.ButtonBuscarApiClick(Sender: TObject);
var
  QuartoHotelServico: TQuartoHotelServico;
  ListaQuartoHotelDto: TObjectList<TQuartoHotelDto>;
begin
  QuartoHotelServico := TQuartoHotelServico.Create;
  try
    ListaQuartoHotelDto := QuartoHotelServico.Buscar;
    PopularDataSet(ListaQuartoHotelDto);
  finally
    QuartoHotelServico.Free;
  end;
end;

procedure TViewPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FPessoaController.Free;
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  FPessoaController := TPessoaController.Create;
  ClientDataSetQuartoHotel.EmptyDataSet;
end;

procedure TViewPrincipal.LimparCampos;
begin
  EditNome.Text := EmptyStr;
  DateTimePickerDtNascimento.Date := Now;
  EditSaldoDevedor.Text := '0';
end;

procedure TViewPrincipal.PopularDataSet(
  AListaQuartoHotelDto: TObjectList<TQuartoHotelDto>);
var
  QuartoHotelDto: TQuartoHotelDto;
  CaracteristicaDto: TCaracteristicaDto;
begin
  ClientDataSetQuartoHotel.EmptyDataSet;
  for QuartoHotelDto in AListaQuartoHotelDto do
  begin
    ClientDataSetQuartoHotel.Append;
    ClientDataSetQuartoHotel.FieldByName('codigo').AsString := QuartoHotelDto.Codigo;
    ClientDataSetQuartoHotel.FieldByName('nome').AsString := QuartoHotelDto.Nome;
    ClientDataSetQuartoHotel.FieldByName('preco').AsFloat := QuartoHotelDto.Preco;

    for CaracteristicaDto in QuartoHotelDto.Caracteristicas do
    begin
      if ClientDataSetQuartoHotel.FieldByName('caracteristica').AsString = EmptyStr then
        ClientDataSetQuartoHotel.FieldByName('caracteristica').AsString := CaracteristicaDto.Nome
      else
        ClientDataSetQuartoHotel.FieldByName('caracteristica').AsString := ClientDataSetQuartoHotel.FieldByName('caracteristica').AsString + Concat(',', CaracteristicaDto.Nome)
    end;
    ClientDataSetQuartoHotel.Post;
  end;
end;

function TViewPrincipal.ValidarCampos: Boolean;
begin
  Result := True;

  if EditNome.Text = EmptyStr then
  begin
    Result := False;
    ShowMessage('Nome inválido!'+#13+'Nome não pode estar vázio.');
    EditNome.SetFocus;
  end
  else if StrToFloatDef(EditSaldoDevedor.Text,0) < 0 then
  begin
    Result := False;
    ShowMessage('Saldo devedor inválido!'+#13+'Saldo devedor não pode ser menor que 0.');
    EditNome.SetFocus;
  end;
end;

end.
