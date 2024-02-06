object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste pr'#225'tico'
  ClientHeight = 432
  ClientWidth = 716
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object PageControlPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 716
    Height = 432
    ActivePage = TabSheetPessoa
    Align = alClient
    TabOrder = 0
    object TabSheetPessoa: TTabSheet
      Caption = 'Parte 1'
      object GroupBoxCadastro: TGroupBox
        Left = 0
        Top = 0
        Width = 708
        Height = 80
        Align = alTop
        Caption = 'Cadastro'
        TabOrder = 0
        object EditNome: TEdit
          Left = 8
          Top = 25
          Width = 305
          Height = 23
          ImeName = 'EditNome'
          TabOrder = 0
        end
        object DateTimePickerDtNascimento: TDateTimePicker
          Left = 319
          Top = 25
          Width = 98
          Height = 23
          Date = 45327.000000000000000000
          Time = 0.862630659721617100
          TabOrder = 1
        end
        object EditSaldoDevedor: TEdit
          Left = 423
          Top = 25
          Width = 121
          Height = 23
          NumbersOnly = True
          TabOrder = 2
        end
        object ButtonAddMemoria: TButton
          Left = 550
          Top = 24
          Width = 153
          Height = 25
          Caption = 'Adicionar em mem'#243'ria'
          TabOrder = 3
          OnClick = ButtonAddMemoriaClick
        end
      end
      object GroupBoxBancoDados: TGroupBox
        Left = 0
        Top = 80
        Width = 708
        Height = 65
        Align = alTop
        Caption = 'Banco de dados'
        TabOrder = 1
        object ButtonGravar: TButton
          Left = 8
          Top = 19
          Width = 225
          Height = 25
          Caption = 'Gravar (mem'#243'ria >> banco de dados)'
          TabOrder = 0
          OnClick = ButtonGravarClick
        end
        object ButtonExcluirPorId: TButton
          Left = 243
          Top = 19
          Width = 86
          Height = 25
          Caption = 'Excluir por id'
          TabOrder = 1
          OnClick = ButtonExcluirPorIdClick
        end
        object ButtonCarregar: TButton
          Left = 335
          Top = 19
          Width = 231
          Height = 25
          Caption = 'Carregar(bancod de dados >> memoria)'
          TabOrder = 2
          OnClick = ButtonCarregarClick
        end
      end
      object ButtonMostrarPessoaMemoria: TButton
        Left = 3
        Top = 151
        Width = 185
        Height = 25
        Caption = 'Mostrar Pessoas em memoria'
        TabOrder = 2
        OnClick = ButtonMostrarPessoaMemoriaClick
      end
    end
    object TabSheetQuartoHotel: TTabSheet
      Caption = 'Parte 2'
      ImageIndex = 1
      object ButtonBuscarApi: TButton
        Left = 3
        Top = 15
        Width = 100
        Height = 34
        Caption = 'Buscar'
        TabOrder = 0
        OnClick = ButtonBuscarApiClick
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 63
        Width = 708
        Height = 339
        Align = alBottom
        DataSource = DataSourceQuartoHotel
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
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'preco'
            Title.Caption = 'Pre'#231'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'caracteristica'
            Title.Caption = 'Caracter'#237'sticas'
            Visible = True
          end>
      end
    end
  end
  object DataSourceQuartoHotel: TDataSource
    DataSet = ClientDataSetQuartoHotel
    Left = 592
    Top = 288
  end
  object ClientDataSetQuartoHotel: TClientDataSet
    PersistDataPacket.Data = {
      7F0000009619E0BD0100000018000000040000000000030000007F0006636F64
      69676F0100490000000100055749445448020002001400046E6F6D6501004900
      0000010005574944544802000200140005707265636F08000400000000000E63
      6172616374657269737469636101004900000001000557494454480200020014
      000000}
    Active = True
    Aggregates = <>
    FileName = 'ClientDataSet1'
    FieldDefs = <
      item
        Name = 'codigo'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'preco'
        DataType = ftFloat
      end
      item
        Name = 'caracteristica'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 368
    Top = 272
  end
end
