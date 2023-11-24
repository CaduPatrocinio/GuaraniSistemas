inherited frmCadMarcas: TfrmCadMarcas
  ActiveControl = DbeMarca
  Caption = 'Cadastro de Marcas'
  ClientHeight = 346
  ClientWidth = 629
  OnCreate = FormCreate
  ExplicitWidth = 641
  ExplicitHeight = 384
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 4
    Top = 46
    Width = 55
    Height = 13
    Caption = 'C'#243'd. Marca'
    FocusControl = DbeIdProd
  end
  object Label2: TLabel [1]
    Left = 4
    Top = 86
    Width = 30
    Height = 13
    Caption = 'Marca'
    FocusControl = DbeMarca
  end
  inherited CoolBar1: TCoolBar
    Width = 629
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 29
        Width = 623
      end>
    ExplicitWidth = 562
    inherited ToolBar1: TToolBar
      Width = 614
      ExplicitWidth = 614
      inherited ToolButton2: TToolButton
        Visible = False
      end
    end
  end
  object DbeIdProd: TDBEdit [3]
    Left = 4
    Top = 62
    Width = 134
    Height = 21
    DataField = 'ID_MARCA'
    DataSource = DmDados.DsMarcas
    ReadOnly = True
    TabOrder = 1
  end
  object DbeMarca: TDBEdit [4]
    Tag = 1
    Left = 4
    Top = 102
    Width = 615
    Height = 21
    AutoSelect = False
    DataField = 'MARCA'
    DataSource = DmDados.DsMarcas
    TabOrder = 2
  end
  inherited BbtnPrior: TBitBtn
    Left = 0
    Top = 313
    TabOrder = 3
    ExplicitLeft = 0
    ExplicitTop = 313
  end
  inherited BtnNext: TBitBtn
    Left = 81
    Top = 315
    TabOrder = 4
    ExplicitLeft = 81
    ExplicitTop = 315
  end
  object DbgMarca: TDBGrid [7]
    Left = 4
    Top = 129
    Width = 615
    Height = 184
    BiDiMode = bdLeftToRight
    Color = clWhite
    Ctl3D = False
    DataSource = DmDados.DsMarcas
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
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_MARCA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MARCA'
        Width = 400
        Visible = True
      end>
  end
  inherited DSTabelaMaster: TDataSource
    Left = 318
  end
  inherited ilMasterCad: TImageList
    Left = 427
    Top = 48
  end
  inherited TabelaMaster: TClientDataSet
    Top = 44
  end
end
