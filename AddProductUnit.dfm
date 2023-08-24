object AddProductForm: TAddProductForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'AddProductForm'
  ClientHeight = 268
  ClientWidth = 415
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 22
  object lblAddProduct: TLabel
    Left = 16
    Top = 16
    Width = 377
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'ADD PRODUCT'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblType: TLabel
    Left = 16
    Top = 64
    Width = 40
    Height = 22
    Caption = 'Type'
  end
  object lblSort: TLabel
    Left = 16
    Top = 144
    Width = 35
    Height = 22
    Caption = 'Sort'
  end
  object DBLookupComboBoxTypes: TDBLookupComboBox
    Left = 16
    Top = 92
    Width = 377
    Height = 30
    DataField = 'Name'
    KeyField = 'Name'
    ListField = 'Name'
    ListFieldIndex = 1
    ListSource = DataSourceTypes
    TabOrder = 0
  end
  object edtSort: TEdit
    Left = 16
    Top = 174
    Width = 377
    Height = 30
    TabOrder = 1
  end
  object btnAddProduct: TButton
    Left = 16
    Top = 224
    Width = 377
    Height = 30
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnAddProductClick
  end
  object DataSourceTypes: TDataSource
    AutoEdit = False
    DataSet = ADOQueryTypes
    Left = 320
    Top = 80
  end
  object ADOQueryTypes: TADOQuery
    Connection = DBMainModule.MainADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT Name, TypeID from Types ORDER BY Name')
    Left = 216
    Top = 80
  end
end
