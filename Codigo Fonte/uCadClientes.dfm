inherited frmCadClientes: TfrmCadClientes
  ActiveControl = DbeNFantasia
  Caption = 'Cadastro de Clientes'
  ClientHeight = 546
  ClientWidth = 754
  OnCreate = FormCreate
  ExplicitWidth = 766
  ExplicitHeight = 584
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 40
    Width = 57
    Height = 13
    Caption = 'C'#243'd. Cliente'
    FocusControl = DbeCodCli
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 80
    Width = 71
    Height = 13
    Caption = 'Nome Fantasia'
    FocusControl = DbeNFantasia
  end
  object Label3: TLabel [2]
    Left = 311
    Top = 80
    Width = 63
    Height = 13
    Caption = 'Raz'#227'o Social'
    FocusControl = DbeRSocial
  end
  object Label4: TLabel [3]
    Left = 614
    Top = 80
    Width = 27
    Height = 13
    Caption = 'CNPJ'
    FocusControl = DbeCNPJ
  end
  object Label5: TLabel [4]
    Left = 8
    Top = 123
    Width = 21
    Height = 13
    Caption = 'CEP'
    FocusControl = DbeCEP
  end
  object Label6: TLabel [5]
    Left = 91
    Top = 120
    Width = 46
    Height = 13
    Caption = 'Endere'#231'o'
    FocusControl = DbeEndereco
  end
  object Label7: TLabel [6]
    Left = 614
    Top = 120
    Width = 12
    Height = 13
    Caption = 'N'#176
    FocusControl = DbeNum
  end
  object Label8: TLabel [7]
    Left = 8
    Top = 161
    Width = 27
    Height = 13
    Caption = 'Bairro'
    FocusControl = DbeBairro
  end
  object Label9: TLabel [8]
    Left = 311
    Top = 161
    Width = 33
    Height = 13
    Caption = 'Cidade'
    FocusControl = DbeCidade
  end
  object Label10: TLabel [9]
    Left = 614
    Top = 161
    Width = 14
    Height = 13
    Caption = 'UF'
    FocusControl = DbeUF
  end
  object Label11: TLabel [10]
    Left = 8
    Top = 202
    Width = 42
    Height = 13
    Caption = 'Telefone'
    FocusControl = DbeTel
  end
  inherited CoolBar1: TCoolBar
    Width = 754
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 29
        Width = 748
      end>
    ExplicitWidth = 763
    inherited ToolBar1: TToolBar
      Width = 739
      ExplicitWidth = 739
      inherited ToolButton2: TToolButton
        Visible = False
      end
      inherited ToolButton9: TToolButton
        Width = 138
        ExplicitWidth = 138
      end
      inherited TBFechar: TToolButton
        Left = 648
        ExplicitLeft = 648
      end
    end
  end
  inherited BbtnPrior: TBitBtn
    Left = 8
    Top = 501
    ExplicitLeft = 8
    ExplicitTop = 501
  end
  inherited BtnNext: TBitBtn
    Left = 83
    Top = 501
    ExplicitLeft = 83
    ExplicitTop = 501
  end
  object DbeCodCli: TDBEdit [14]
    Left = 8
    Top = 56
    Width = 134
    Height = 21
    TabStop = False
    DataField = 'ID_CLIENTE'
    DataSource = DmDados.DsClientes
    Enabled = False
    TabOrder = 3
  end
  object DbeNFantasia: TDBEdit [15]
    Tag = 1
    Left = 8
    Top = 96
    Width = 300
    Height = 21
    AutoSelect = False
    DataField = 'NOME_FANTASIA'
    DataSource = DmDados.DsClientes
    TabOrder = 4
  end
  object DbeRSocial: TDBEdit [16]
    Tag = 1
    Left = 311
    Top = 96
    Width = 300
    Height = 21
    DataField = 'RAZAO_SOCIAL'
    DataSource = DmDados.DsClientes
    TabOrder = 5
  end
  object DbeCNPJ: TDBEdit [17]
    Left = 614
    Top = 96
    Width = 134
    Height = 21
    DataField = 'CNPJ'
    DataSource = DmDados.DsClientes
    TabOrder = 6
  end
  object DbeCEP: TDBEdit [18]
    Left = 8
    Top = 136
    Width = 80
    Height = 21
    DataField = 'CEP'
    DataSource = DmDados.DsClientes
    TabOrder = 7
    OnChange = DbeCEPChange
  end
  object DbeEndereco: TDBEdit [19]
    Left = 91
    Top = 136
    Width = 520
    Height = 21
    DataField = 'ENDERECO'
    DataSource = DmDados.DsClientes
    TabOrder = 8
  end
  object DbeNum: TDBEdit [20]
    Left = 614
    Top = 136
    Width = 134
    Height = 21
    DataField = 'NUMERO'
    DataSource = DmDados.DsClientes
    TabOrder = 9
  end
  object DbeBairro: TDBEdit [21]
    Left = 8
    Top = 177
    Width = 300
    Height = 21
    DataField = 'BAIRRO'
    DataSource = DmDados.DsClientes
    TabOrder = 10
  end
  object DbeCidade: TDBEdit [22]
    Left = 311
    Top = 177
    Width = 300
    Height = 21
    DataField = 'CIDADE'
    DataSource = DmDados.DsClientes
    TabOrder = 11
  end
  object DbeUF: TDBEdit [23]
    Left = 614
    Top = 177
    Width = 30
    Height = 21
    DataField = 'UF'
    DataSource = DmDados.DsClientes
    TabOrder = 12
  end
  object DbeTel: TDBEdit [24]
    Tag = 1
    Left = 8
    Top = 216
    Width = 186
    Height = 21
    DataField = 'TELEFONE'
    DataSource = DmDados.DsClientes
    TabOrder = 13
  end
  object DBGridPesquisa: TDBGrid [25]
    Left = 8
    Top = 243
    Width = 740
    Height = 252
    BiDiMode = bdLeftToRight
    Color = clWhite
    Ctl3D = False
    DataSource = DmDados.DsClientes
    DrawingStyle = gdsClassic
    FixedColor = 14079702
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = False
    TabOrder = 14
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_CLIENTE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_FANTASIA'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RAZAO_SOCIAL'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJ'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
        Visible = True
      end>
  end
  inherited DSTabelaMaster: TDataSource
    Left = 438
    Top = 16
  end
  inherited imgTab: TImageList
    Left = 632
    Top = 16
  end
  inherited ilMasterCad: TImageList
    Left = 571
    Top = 16
  end
  inherited TabelaMaster: TClientDataSet
    Left = 353
    Top = 16
  end
  object IdConsCEP: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 240
    Top = 48
  end
end
