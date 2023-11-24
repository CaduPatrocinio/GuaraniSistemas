object DmDados: TDmDados
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object IBTransaction: TIBTransaction
    DefaultDatabase = IBDatabase
    Left = 176
    Top = 8
  end
  object IBDatabase: TIBDatabase
    Connected = True
    DatabaseName = 'C:\GuaraniSistemas\DataBase\GUARANI.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 64
    Top = 8
  end
  object PGeral: TDataSetProvider
    DataSet = QGeral
    OnDataRequest = PGeralDataRequest
    Left = 126
    Top = 120
  end
  object CDGeral: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PGeral'
    Left = 215
    Top = 120
  end
  object DSGeral: TDataSource
    DataSet = CDGeral
    Left = 316
    Top = 120
  end
  object QGeral: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 48
    Top = 120
  end
  object PMarcas: TDataSetProvider
    DataSet = QMarcas
    OnDataRequest = PMarcasDataRequest
    Left = 126
    Top = 216
  end
  object CDMarcas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PMarcas'
    AfterInsert = CDMarcasAfterInsert
    OnReconcileError = CDMarcasReconcileError
    Left = 215
    Top = 216
    object CDMarcasID_MARCA: TIntegerField
      DisplayLabel = 'C'#243'd. Marca'
      FieldName = 'ID_MARCA'
      Required = True
      DisplayFormat = '000000'
    end
    object CDMarcasMARCA: TWideStringField
      Tag = 1
      DisplayLabel = 'Marca'
      FieldName = 'MARCA'
      Size = 80
    end
  end
  object DsMarcas: TDataSource
    DataSet = CDMarcas
    Left = 316
    Top = 216
  end
  object QMarcas: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM MARCAS WHERE ID_MARCA IS NULL')
    PrecommittedReads = False
    Left = 48
    Top = 216
  end
  object PProdutos: TDataSetProvider
    DataSet = QProdutos
    OnDataRequest = PProdutosDataRequest
    Left = 126
    Top = 304
  end
  object CDProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PProdutos'
    AfterInsert = CDProdutosAfterInsert
    OnReconcileError = CDProdutosReconcileError
    Left = 215
    Top = 304
    object CDProdutosID_PRODUTO: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'ID_PRODUTO'
      Required = True
      DisplayFormat = '000000'
    end
    object CDProdutosID_MARCA: TIntegerField
      DisplayLabel = 'C'#243'd. Marca'
      FieldName = 'ID_MARCA'
      Required = True
      OnChange = CDProdutosID_MARCAChange
      DisplayFormat = '000000'
    end
    object CDProdutosDESCRICAO: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 80
    end
    object CDProdutosVALOR: TBCDField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'VALOR'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object CDProdutosMarca: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'Marca'
      Size = 80
    end
  end
  object DsProdutos: TDataSource
    DataSet = CDProdutos
    Left = 316
    Top = 304
  end
  object QProdutos: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM PRODUTOS WHERE ID_PRODUTO IS NULL')
    PrecommittedReads = False
    Left = 48
    Top = 304
  end
  object PClientes: TDataSetProvider
    DataSet = QClientes
    OnDataRequest = PClientesDataRequest
    Left = 126
    Top = 396
  end
  object CDClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PClientes'
    AfterInsert = CDClientesAfterInsert
    OnReconcileError = CDProdutosReconcileError
    Left = 215
    Top = 396
    object CDClientesID_CLIENTE: TIntegerField
      DisplayLabel = 'C'#243'd. Cliente'
      FieldName = 'ID_CLIENTE'
      Required = True
      DisplayFormat = '000000'
    end
    object CDClientesNOME_FANTASIA: TWideStringField
      DisplayLabel = 'Nome Fantasia'
      FieldName = 'NOME_FANTASIA'
      Size = 80
    end
    object CDClientesRAZAO_SOCIAL: TWideStringField
      DisplayLabel = 'Raz'#227'o Social'
      FieldName = 'RAZAO_SOCIAL'
      Size = 80
    end
    object CDClientesCNPJ: TWideStringField
      FieldName = 'CNPJ'
      FixedChar = True
      Size = 10
    end
    object CDClientesCEP: TWideStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 9
    end
    object CDClientesENDERECO: TWideStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'ENDERECO'
      Size = 80
    end
    object CDClientesNUMERO: TWideStringField
      DisplayLabel = 'N'#176
      FieldName = 'NUMERO'
      Size = 10
    end
    object CDClientesBAIRRO: TWideStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Size = 40
    end
    object CDClientesCIDADE: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 40
    end
    object CDClientesUF: TWideStringField
      FieldName = 'UF'
      FixedChar = True
      Size = 2
    end
    object CDClientesTELEFONE: TWideStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
      Required = True
      EditMask = '(99)9 9999-9999;0;_'
      FixedChar = True
      Size = 14
    end
  end
  object DsClientes: TDataSource
    DataSet = CDClientes
    Left = 316
    Top = 396
  end
  object QClientes: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM CLIENTES WHERE ID_CLIENTE IS NULL')
    PrecommittedReads = False
    Left = 48
    Top = 396
  end
  object PPedido: TDataSetProvider
    DataSet = QPedido
    OnDataRequest = PPedidoDataRequest
    Left = 630
    Top = 108
  end
  object CDPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PPedido'
    AfterInsert = CDPedidoAfterInsert
    BeforeDelete = CDPedidoBeforeDelete
    OnCalcFields = CDPedidoCalcFields
    OnReconcileError = CDProdutosReconcileError
    Left = 711
    Top = 116
    object CDPedidoID_PEDIDO: TIntegerField
      DisplayLabel = 'N'#176' Pedido'
      FieldName = 'ID_PEDIDO'
      Origin = 'PEDIDO.ID_PEDIDO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      DisplayFormat = '000000'
    end
    object CDPedidoID_CLIENTE: TIntegerField
      DisplayLabel = 'C'#243'd. Cliente'
      FieldName = 'ID_CLIENTE'
      Origin = 'PEDIDO.ID_CLIENTE'
      OnChange = CDPedidoID_CLIENTEChange
      DisplayFormat = '000000'
    end
    object CDPedidoDT_PEDIDO: TDateField
      Alignment = taRightJustify
      DisplayLabel = 'Data Pedido'
      FieldName = 'DT_PEDIDO'
      Origin = 'PEDIDO.DT_PEDIDO'
    end
    object CDPedidoHORA_PEDIDO: TTimeField
      Alignment = taRightJustify
      DisplayLabel = 'Hora Pedido'
      FieldName = 'HORA_PEDIDO'
      Origin = 'PEDIDO.HORA_PEDIDO'
    end
    object CDPedidoSUB_TOTAL: TBCDField
      DisplayLabel = 'Sub-Total'
      FieldName = 'SUB_TOTAL'
      Origin = 'PEDIDO.SUB_TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object CDPedidoDESCONTO: TBCDField
      DisplayLabel = 'Desconto'
      FieldName = 'DESCONTO'
      Origin = 'PEDIDO.DESCONTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object CDPedidoTOTAL: TBCDField
      DisplayLabel = 'Total'
      FieldName = 'TOTAL'
      Origin = 'PEDIDO.TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object CDPedidoQItemPedido: TDataSetField
      FieldName = 'QItemPedido'
    end
    object CDPedidoNomeCli: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'NomeCli'
      Size = 100
    end
  end
  object DsPedido: TDataSource
    DataSet = CDPedido
    Left = 820
    Top = 108
  end
  object QPedido: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM PEDIDO WHERE ID_PEDIDO IS NULL')
    PrecommittedReads = False
    Left = 552
    Top = 108
  end
  object PItemPedido: TDataSetProvider
    DataSet = QItemPedido
    OnDataRequest = PItemPedidoDataRequest
    Left = 630
    Top = 196
  end
  object CDItemPedido: TClientDataSet
    Aggregates = <>
    DataSetField = CDPedidoQItemPedido
    Params = <>
    AfterInsert = CDItemPedidoAfterInsert
    OnCalcFields = CDItemPedidoCalcFields
    Left = 719
    Top = 196
    object CDItemPedidoID_ITEM_PEDIDO: TIntegerField
      FieldName = 'ID_ITEM_PEDIDO'
      Origin = 'ITEM_PEDIDO.ID_ITEM_PEDIDO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDItemPedidoID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      Origin = 'ITEM_PEDIDO.ID_PEDIDO'
    end
    object CDItemPedidoID_PRODUTO: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'ID_PRODUTO'
      Origin = 'ITEM_PEDIDO.ID_PRODUTO'
      OnChange = CDItemPedidoID_PRODUTOChange
    end
    object CDItemPedidoDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldKind = fkInternalCalc
      FieldName = 'Descricao'
      Size = 80
    end
    object CDItemPedidoVALOR_UNITARIO: TBCDField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'VALOR_UNITARIO'
      Origin = 'ITEM_PEDIDO.VALOR_UNITARIO'
      currency = True
      Precision = 18
      Size = 2
    end
    object CDItemPedidoQTDE: TIntegerField
      DisplayLabel = 'Qtde'
      FieldName = 'QTDE'
      Origin = 'ITEM_PEDIDO.QTDE'
      OnChange = CDItemPedidoQTDEChange
    end
    object CDItemPedidoVALOR_TOTAL: TBCDField
      DisplayLabel = 'Total'
      FieldName = 'VALOR_TOTAL'
      Origin = 'ITEM_PEDIDO.VALOR_TOTAL'
      OnChange = CDItemPedidoVALOR_TOTALChange
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object DsItemPedido: TDataSource
    DataSet = CDItemPedido
    Left = 820
    Top = 196
  end
  object QItemPedido: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = DsPedidoItem
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM ITEM_PEDIDO '
      ' WHERE ID_PEDIDO = :ID_PEDIDO ')
    PrecommittedReads = False
    Left = 536
    Top = 196
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_PEDIDO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object DsPedidoItem: TDataSource
    DataSet = QPedido
    Left = 580
    Top = 164
  end
end
