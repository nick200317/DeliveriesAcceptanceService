object AddAcceptanceForm: TAddAcceptanceForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'AddAcceptanceForm'
  ClientHeight = 341
  ClientWidth = 407
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 22
  object lblAddAcceptance: TLabel
    Left = 16
    Top = 16
    Width = 369
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'ADD ACCEPTANCE'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSupplier: TLabel
    Left = 16
    Top = 64
    Width = 68
    Height = 22
    Caption = 'Supplier'
  end
  object lblDate: TLabel
    Left = 16
    Top = 144
    Width = 39
    Height = 22
    Caption = 'Date'
  end
  object lblComment: TLabel
    Left = 16
    Top = 220
    Width = 79
    Height = 22
    Caption = 'Comment'
  end
  object DBLookupComboBoxSupplier: TDBLookupComboBox
    Left = 16
    Top = 92
    Width = 369
    Height = 30
    KeyField = 'Fio'
    ListField = 'Fio;INN'
    ListSource = DataSourceSuppliers
    TabOrder = 0
  end
  object dtpDate: TDateTimePicker
    Left = 16
    Top = 172
    Width = 369
    Height = 30
    Date = 45160.000000000000000000
    Time = 0.782235520833637600
    TabOrder = 1
  end
  object btnAddAcceptance: TButton
    Left = 16
    Top = 297
    Width = 369
    Height = 30
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnAddAcceptanceClick
  end
  object edtComment: TEdit
    Left = 16
    Top = 248
    Width = 369
    Height = 30
    TabOrder = 3
  end
  object DataSourceSuppliers: TDataSource
    AutoEdit = False
    DataSet = ADOQuerySuppliers
    Left = 312
    Top = 88
  end
  object ADOQuerySuppliers: TADOQuery
    Connection = DBMainModule.MainADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select Fio, INN, UserID from Users where Type = '#39'Supplier'#39';')
    Left = 168
    Top = 88
  end
end
