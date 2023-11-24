inherited frmCadProdutos: TfrmCadProdutos
  ActiveControl = DbeDescProd
  Caption = 'Cadastro de produtos'
  ClientHeight = 450
  ClientWidth = 683
  OnCreate = FormCreate
  ExplicitWidth = 695
  ExplicitHeight = 488
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 40
    Width = 62
    Height = 13
    Caption = 'C'#243'd. Produto'
    FocusControl = DbeCodProd
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 120
    Width = 55
    Height = 13
    Caption = 'C'#243'd. Marca'
    FocusControl = DbeCodMarca
  end
  object Label3: TLabel [2]
    Left = 8
    Top = 80
    Width = 48
    Height = 13
    Caption = 'Descri'#231#227'o'
    FocusControl = DbeDescProd
  end
  object Label4: TLabel [3]
    Left = 8
    Top = 160
    Width = 28
    Height = 13
    Caption = 'Pre'#231'o'
    FocusControl = DbePreco
  end
  object SbLocMarca: TSpeedButton [4]
    Left = 70
    Top = 131
    Width = 23
    Height = 22
    Hint = 'Localizar Marca'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      B78183B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
      83B78183B78183FF00FFFF00FFFF00FF636E7BFEEED4F7E3C5F6DFBCF5DBB4F3
      D7ABF3D3A2F1CF9AF0CF97F0CF98F0CF98F5D49AB78183FF00FFFF00FF5E98C7
      3489D07F859DF6E3CBF5DFC2F4DBBAF2D7B2F1D4A9F1D0A2EECC99EECC97EECC
      97F3D199B78183FF00FFFF00FFFF00FF4BB6FF288BE0858498F5E3CBF5DFC3F3
      DBBBF2D7B2F1D4ABF0D0A3EECC9AEECC97F3D199B78183FF00FFFF00FFFF00FF
      B481764DB5FF278BDE79819AF6E3CAF5DFC2F4DBB9F2D7B2F1D4AAF0D0A1EFCD
      99F3D198B78183FF00FFFF00FFFF00FFBA8E85FFFCF44CB9FF5A91BFA48179BE
      978EAC7E79BE9589D6B49BF1D3AAF0D0A1F3D29BB78183FF00FFFF00FFFF00FF
      BA8E85FFFFFDFBF4ECBFA19FC7A59CE1C9B8F2DFC6E0C3ADC59F90D7B49BF0D4
      A9F5D5A3B78183FF00FFFF00FFFF00FFCB9A82FFFFFFFEF9F5C09C97E3CEC4F9
      EADAF8E7D2FFFFF7E0C2ADBE9589F2D8B2F6D9ACB78183FF00FFFF00FFFF00FF
      CB9A82FFFFFFFFFEFDAC7F7BF8EEE7F9EFE3F8EADAFFFFF0F3DEC7AC7E79F4DB
      B9F8DDB4B78183FF00FFFF00FFFF00FFDCA887FFFFFFFFFFFFC19F9CE6D6D1FB
      F3EBFAEFE2FFFFDEE2C8B8BE978DF7E1C2F0DAB7B78183FF00FFFF00FFFF00FF
      DCA887FFFFFFFFFFFFDFCDCBC9ACA9E6D6D1F8EEE6E3CEC4C7A59CC3A394E6D9
      C4C6BCA9B78183FF00FFFF00FFFF00FFE3B18EFFFFFFFFFFFFFFFFFFDFCDCBC1
      9F9CAC7F7BC09D97D6BAB1B8857AB8857AB8857AB78183FF00FFFF00FFFF00FF
      E3B18EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFFFEF9E3CFC9B8857AE8B2
      70ECA54AC58768FF00FFFF00FFFF00FFEDBD92FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFE4D4D2B8857AFAC577CD9377FF00FFFF00FFFF00FFFF00FF
      EDBD92FCF7F4FCF7F3FBF6F3FBF6F3FAF5F3F9F5F3F9F5F3E1D0CEB8857ACF9B
      86FF00FFFF00FFFF00FFFF00FFFF00FFEDBD92DCA887DCA887DCA887DCA887DC
      A887DCA887DCA887DCA887B8857AFF00FFFF00FFFF00FFFF00FF}
    ParentShowHint = False
    ShowHint = True
    OnClick = SbLocMarcaClick
  end
  inherited CoolBar1: TCoolBar
    Width = 683
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 29
        Width = 677
      end>
    ExplicitWidth = 823
    inherited ToolBar1: TToolBar
      Width = 668
      ExplicitWidth = 668
      inherited TBLocalizar: TToolButton
        Visible = False
      end
      inherited ToolButton9: TToolButton
        Width = 83
        ExplicitWidth = 83
      end
      inherited TBFechar: TToolButton
        Left = 593
        ExplicitLeft = 593
      end
    end
  end
  object DbeCodProd: TDBEdit [6]
    Left = 8
    Top = 56
    Width = 85
    Height = 21
    DataField = 'ID_PRODUTO'
    DataSource = DmDados.DsProdutos
    Enabled = False
    TabOrder = 1
  end
  object DbeCodMarca: TDBEdit [7]
    Tag = 1
    Left = 8
    Top = 133
    Width = 62
    Height = 21
    DataField = 'ID_MARCA'
    DataSource = DmDados.DsProdutos
    TabOrder = 3
    OnChange = DbeCodMarcaChange
  end
  object DbeDescProd: TDBEdit [8]
    Tag = 1
    Left = 8
    Top = 93
    Width = 500
    Height = 21
    AutoSelect = False
    DataField = 'DESCRICAO'
    DataSource = DmDados.DsProdutos
    TabOrder = 2
  end
  object DbePreco: TDBEdit [9]
    Tag = 1
    Left = 8
    Top = 176
    Width = 85
    Height = 21
    DataField = 'VALOR'
    DataSource = DmDados.DsProdutos
    TabOrder = 4
  end
  object PnMarca: TPanel [10]
    Left = 93
    Top = 132
    Width = 414
    Height = 21
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clSilver
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 5
  end
  inherited BbtnPrior: TBitBtn
    Left = 8
    Top = 411
    TabOrder = 6
    ExplicitLeft = 8
    ExplicitTop = 411
  end
  inherited BtnNext: TBitBtn
    Left = 89
    Top = 411
    TabOrder = 7
    ExplicitLeft = 89
    ExplicitTop = 411
  end
  object DbgProduto: TDBGrid [13]
    Left = 8
    Top = 207
    Width = 667
    Height = 199
    BiDiMode = bdLeftToRight
    Color = clWhite
    Ctl3D = False
    DataSource = DmDados.DsProdutos
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
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_PRODUTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Marca'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Width = 80
        Visible = True
      end>
  end
  inherited imgTab: TImageList
    Left = 560
    Top = 32
  end
  inherited ilMasterCad: TImageList
    Left = 427
  end
end
