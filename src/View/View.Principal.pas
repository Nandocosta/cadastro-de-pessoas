unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Controller.Pessoa;

type
  TViewPrincipal = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    FPessoaController: TPessoaController;
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.dfm}

procedure TViewPrincipal.Button1Click(Sender: TObject);
begin
  FPessoaController.GravarEmMemoria('Fernando', Now, 5000);
end;

procedure TViewPrincipal.Button2Click(Sender: TObject);
begin
  FPessoaController.GravarListaNoBanco
end;

procedure TViewPrincipal.Button3Click(Sender: TObject);
begin
  FPessoaController.ExcluirPorId(1);
end;

procedure TViewPrincipal.Button4Click(Sender: TObject);
begin
  FPessoaController.Carregar;
end;

procedure TViewPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FPessoaController.Free;
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  FPessoaController := TPessoaController.Create;
end;

end.
