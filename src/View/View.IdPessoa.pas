unit View.IdPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TViewId = class(TForm)
    EditId: TEdit;
    ButtonOk: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Class function GetId: Integer;
  end;


implementation

{$R *.dfm}

{ TViewId }

procedure TViewId.FormCreate(Sender: TObject);
begin
  EditId.Text := '0';
end;

class function TViewId.GetId: Integer;
var
  ViewId: TViewId;
begin
  ViewId := TViewId.Create(Application);
  try
    ViewId.ShowModal;
    Result := StrToIntDef(ViewId.EditId.Text, 0);
  finally
    ViewId.Free;
  end;
end;

end.
