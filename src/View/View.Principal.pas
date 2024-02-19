unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Model.Pessoa,
  Vcl.ComCtrls, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Model.QuartoHotel, System.Generics.Collections;

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
    FListaPessoaModel: TObjectList<TPessoaModel>;

    procedure LimparCampos;
    procedure PopularDataSet(AListaQuartoHotel: TObjectList<TQuartoHotelModel>);
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
  View.IdPessoa, Dao.Pessoa;

{$R *.dfm}


procedure TViewPrincipal.ButtonAddMemoriaClick(Sender: TObject);
var
  PessoaModel: TPessoaModel;
begin
  if ValidarCampos then
  begin
    PessoaModel := TPessoaModel.Create;
    try
      PessoaModel.Id := -1;
      PessoaModel.Nome := EditNome.Text;
      PessoaModel.DataNascimento := DateTimePickerDtNascimento.DateTime;
      PessoaModel.SaldoDevedor := StrToFloatDef(EditSaldoDevedor.Text, 0);
      FListaPessoaModel.Add(PessoaModel);
      LimparCampos;
    except
      PessoaModel.Free;
    end;
  end;
end;

procedure TViewPrincipal.ButtonGravarClick(Sender: TObject);
var
  PessoaModel: TPessoaModel;
  PessoaDao: TPessoaDao;
begin
  if FListaPessoaModel.Count > 0 then
  begin
    PessoaDao := TPessoaDao.Create;
    try
      for PessoaModel in FListaPessoaModel do
      begin
        if PessoaModel.Id = -1 then
        begin
          PessoaDao.Inserir(PessoaModel);
          PessoaModel.Id := 0;
        end;
      end;
    finally
      PessoaDao.Free;
    end;
  end;
end;

procedure TViewPrincipal.ButtonExcluirPorIdClick(Sender: TObject);
var
  Id: Integer;
  PessoaDao: TPessoaDao;
begin
  Id := TViewId.GetId;
  PessoaDao := TPessoaDao.Create;
  try
    PessoaDao.ExcluirPorId(Id);
    ShowMessage('Registro excluído com sucesso');
  finally
    PessoaDao.Free;
  end;
end;

procedure TViewPrincipal.ButtonCarregarClick(Sender: TObject);
var
  PessoaDao: TPessoaDao;
begin
  PessoaDao := TPessoaDao.Create;
  try
    if Assigned(FListaPessoaModel) then
      FListaPessoaModel.Free;

    FListaPessoaModel := PessoaDao.GetPessoas;

    if FListaPessoaModel.Count > 0 then
      ShowMessage('Lista carregada com sucesso!')
    else
      ShowMessage('Lista carregada, porém sem registros!');
  finally
    PessoaDao.Free;
  end;
end;

procedure TViewPrincipal.ButtonMostrarPessoaMemoriaClick(Sender: TObject);
var
  ViewPessoa: TViewPessoa;
begin
  ViewPessoa := TViewPessoa.create(FListaPessoaModel);
  try
    ViewPessoa.ShowModal;
  finally
    ViewPessoa.Free;
  end;
end;

procedure TViewPrincipal.ButtonBuscarApiClick(Sender: TObject);
var
  QuartoHotelServico: TQuartoHotelServico;
  ListaQuartoHotelDto: TObjectList<TQuartoHotelModel>;
begin
  QuartoHotelServico := TQuartoHotelServico.Create;
  try
    ListaQuartoHotelDto := QuartoHotelServico.Buscar;
    try
      PopularDataSet(ListaQuartoHotelDto);
    finally
      ListaQuartoHotelDto.Free;
    end;
  finally
    QuartoHotelServico.Free;
  end;
end;

procedure TViewPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FListaPessoaModel.Free;
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  FListaPessoaModel := TObjectList<TPessoaModel>.Create;
  ClientDataSetQuartoHotel.EmptyDataSet;
end;

procedure TViewPrincipal.LimparCampos;
begin
  EditNome.Text := EmptyStr;
  DateTimePickerDtNascimento.Date := Now;
  EditSaldoDevedor.Text := '0';
end;

procedure TViewPrincipal.PopularDataSet(
  AListaQuartoHotel: TObjectList<TQuartoHotelModel>);
var
  QuartoHotel: TQuartoHotelModel;
  Caracteristica: TCaracteristicaModel;
begin
  ClientDataSetQuartoHotel.EmptyDataSet;
  for QuartoHotel in AListaQuartoHotel do
  begin
    ClientDataSetQuartoHotel.Append;
    ClientDataSetQuartoHotel.FieldByName('codigo').AsString := QuartoHotel.Codigo;
    ClientDataSetQuartoHotel.FieldByName('nome').AsString := QuartoHotel.Nome;
    ClientDataSetQuartoHotel.FieldByName('preco').AsFloat := QuartoHotel.Preco;

    for Caracteristica in QuartoHotel.Caracteristicas do
    begin
      if ClientDataSetQuartoHotel.FieldByName('caracteristica').AsString = EmptyStr then
        ClientDataSetQuartoHotel.FieldByName('caracteristica').AsString := Caracteristica.Nome
      else
        ClientDataSetQuartoHotel.FieldByName('caracteristica').AsString := ClientDataSetQuartoHotel.FieldByName('caracteristica').AsString + Concat(',', Caracteristica.Nome)
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
