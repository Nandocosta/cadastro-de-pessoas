object ViewId: TViewId
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Informe o ID para excluir'
  ClientHeight = 111
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 119
    Height = 15
    Caption = 'Informe Id para excluir'
  end
  object EditId: TEdit
    Left = 8
    Top = 32
    Width = 161
    Height = 23
    NumbersOnly = True
    TabOrder = 0
  end
  object ButtonOk: TButton
    Left = 175
    Top = 31
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    ModalResult = 1
    TabOrder = 1
  end
end
