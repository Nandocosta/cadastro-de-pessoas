object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  Caption = 'ViewPrincipal'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Button1: TButton
    Left = 40
    Top = 48
    Width = 153
    Height = 25
    Caption = 'Adicionar em memoria'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 79
    Width = 225
    Height = 25
    Caption = 'Gravar (mem'#243'ria >> banco de dados)'
    TabOrder = 1
    OnClick = Button2Click
  end
end
