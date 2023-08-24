object EditAcceptanceItemForm: TEditAcceptanceItemForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'EditAcceptanceItemForm'
  ClientHeight = 269
  ClientWidth = 408
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 22
  object lblEditAcceptanceItem: TLabel
    Left = 16
    Top = 16
    Width = 369
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'EDIT ACCEPTANCE ITEM'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblProduct: TLabel
    Left = 16
    Top = 64
    Width = 65
    Height = 22
    Caption = 'Product'
  end
  object lblWeight: TLabel
    Left = 16
    Top = 144
    Width = 58
    Height = 22
    Caption = 'Weight'
  end
  object DBLookupComboBoxPrices: TDBLookupComboBox
    Left = 16
    Top = 92
    Width = 369
    Height = 30
    KeyField = 'Sort'
    ListField = 'Sort;Type;Price'
    ListSource = DataSourcePrices
    TabOrder = 0
  end
  object nbWeight: TNumberBox
    Left = 16
    Top = 172
    Width = 369
    Height = 30
    Mode = nbmFloat
    MinValue = 1.000000000000000000
    MaxValue = 1000000000.000000000000000000
    TabOrder = 1
    Value = 1.000000000000000000
  end
  object btnEditAcceptanceItem: TButton
    Left = 16
    Top = 224
    Width = 369
    Height = 30
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnEditAcceptanceItemClick
  end
  object DataSourcePrices: TDataSource
    AutoEdit = False
    DataSet = ADOQueryPrices
    Left = 312
    Top = 88
  end
  object ADOQueryPrices: TADOQuery
    Connection = DBMainModule.MainADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'supplierID'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 128
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'acceptanceID'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 128
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      
        'select PriceID, Types.Name as Type, Products.Sort, Price from Ac' +
        'ceptances, Prices Join Products on Prices.ProductID = Products.P' +
        'roductID Join Types on Products.TypeID = Types.TypeID where Pric' +
        'es.SupplierID = :supplierID And Acceptances.AcceptanceID = :acce' +
        'ptanceID and Acceptances.Date between Prices.StartPeriod and Pri' +
        'ces.EndPeriod;')
    Left = 192
    Top = 88
  end
end
