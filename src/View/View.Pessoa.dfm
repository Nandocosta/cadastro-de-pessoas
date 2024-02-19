object ViewPessoa: TViewPessoa
  Left = 0
  Top = 0
  Caption = 'Pessoas em mem'#243'ria'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 400
    Width = 624
    Height = 41
    Align = alBottom
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object ButtonFechar: TButton
      Left = 548
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = ButtonFecharClick
    end
  end
  object DBGridPessoa: TDBGrid
    Left = 0
    Top = 0
    Width = 624
    Height = 400
    Align = alClient
    DataSource = DataSourcePessoa
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Title.Caption = 'Nome'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 260
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'data_nascimento'
        Title.Caption = 'Data de Nascimento'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'saldo_devedor'
        Title.Caption = 'Saldo Devedor'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -16
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = []
        Width = 110
        Visible = True
      end>
  end
  object DataSourcePessoa: TDataSource
    DataSet = ClientDataSetPessoa
    Left = 304
    Top = 224
  end
  object ClientDataSetPessoa: TClientDataSet
    PersistDataPacket.Data = {
      700000009619E0BD010000001800000004000000000003000000700006636F64
      69676F0400010000000000046E6F6D6502004900000001000557494454480200
      0200FF000F646174615F6E617363696D656E746F08000800000000000D73616C
      646F5F64657665646F7208000400000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 384
    Top = 128
    object ClientDataSetPessoacodigo: TIntegerField
      FieldName = 'codigo'
    end
    object ClientDataSetPessoanome: TStringField
      FieldName = 'nome'
      Size = 255
    end
    object ClientDataSetPessoadata_nascimento: TDateTimeField
      FieldName = 'data_nascimento'
    end
    object ClientDataSetPessoasaldo_devedor: TFloatField
      FieldName = 'saldo_devedor'
    end
  end
end
