object AddPriceForm: TAddPriceForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'AddPriceForm'
  ClientHeight = 431
  ClientWidth = 403
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 22
  object lblAddPrice: TLabel
    Left = 16
    Top = 16
    Width = 369
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'ADD PRICE'
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
  object lblPrice: TLabel
    Left = 16
    Top = 144
    Width = 43
    Height = 22
    Caption = 'Price'
  end
  object lblStartPeriod: TLabel
    Left = 16
    Top = 224
    Width = 98
    Height = 22
    Caption = 'Start period'
  end
  object Label1: TLabel
    Left = 16
    Top = 304
    Width = 90
    Height = 22
    Caption = 'End period'
  end
  object DBLookupComboBoxProducts: TDBLookupComboBox
    Left = 16
    Top = 92
    Width = 369
    Height = 30
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    KeyField = 'Sort'
    ListField = 'Sort;Name'
    ListSource = DataSourceProducts
    ParentFont = False
    TabOrder = 0
  end
  object nbPrice: TNumberBox
    Left = 16
    Top = 172
    Width = 369
    Height = 30
    Mode = nbmFloat
    MinValue = 1.000000000000000000
    MaxValue = 1000000000.000000000000000000
    TabOrder = 1
  end
  object DateTimePickerStartPeriod: TDateTimePicker
    Left = 16
    Top = 252
    Width = 369
    Height = 30
    Date = 45158.000000000000000000
    Time = 0.200914363427727900
    TabOrder = 2
  end
  object DateTimePickerEndPeriod: TDateTimePicker
    Left = 16
    Top = 332
    Width = 369
    Height = 30
    Date = 45158.000000000000000000
    Time = 0.200914363427727900
    TabOrder = 3
  end
  object btnAddPrice: TButton
    Left = 16
    Top = 384
    Width = 369
    Height = 30
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = btnAddPriceClick
  end
  object ADOQueryProducts: TADOQuery
    Connection = DBMainModule.MainADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select ProductID, Types.Name, Sort from Products, Types where Su' +
        'pplierID = 4 and Products.TypeID = Types.TypeID;')
    Left = 208
    Top = 88
  end
  object DataSourceProducts: TDataSource
    AutoEdit = False
    DataSet = ADOQueryProducts
    Left = 328
    Top = 88
  end
end
