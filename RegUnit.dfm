object RegForm: TRegForm
  Left = 0
  Top = 0
  Cursor = crHandPoint
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'RegForm'
  ClientHeight = 755
  ClientWidth = 250
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  Position = poScreenCenter
  TextHeight = 22
  object lblReg: TLabel
    Left = 16
    Top = 16
    Width = 217
    Height = 32
    Caption = 'REGISTRATION'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblFIO: TLabel
    Left = 16
    Top = 64
    Width = 81
    Height = 22
    Caption = 'Full name'
  end
  object lblPhone: TLabel
    Left = 16
    Top = 144
    Width = 51
    Height = 22
    Caption = 'Phone'
  end
  object lblINN: TLabel
    Left = 16
    Top = 224
    Width = 35
    Height = 22
    Caption = 'INN'
  end
  object lblLogin: TLabel
    Left = 16
    Top = 304
    Width = 47
    Height = 22
    Caption = 'Login'
  end
  object lblPassword: TLabel
    Left = 16
    Top = 384
    Width = 80
    Height = 22
    Caption = 'Password'
  end
  object lblConfirmPassword: TLabel
    Left = 16
    Top = 463
    Width = 151
    Height = 22
    Caption = 'Confirm password'
  end
  object edtFIO: TEdit
    Left = 16
    Top = 92
    Width = 217
    Height = 30
    MaxLength = 100
    TabOrder = 0
  end
  object edtINN: TEdit
    Left = 16
    Top = 252
    Width = 217
    Height = 30
    MaxLength = 12
    NumbersOnly = True
    TabOrder = 2
  end
  object edtLogin: TEdit
    Left = 16
    Top = 332
    Width = 217
    Height = 30
    MaxLength = 50
    TabOrder = 3
  end
  object edtPassword: TEdit
    Left = 16
    Top = 412
    Width = 217
    Height = 30
    MaxLength = 50
    PasswordChar = '*'
    TabOrder = 4
  end
  object edtConfirmPassword: TEdit
    Left = 16
    Top = 491
    Width = 217
    Height = 30
    MaxLength = 50
    PasswordChar = '*'
    TabOrder = 5
  end
  object btnReg: TButton
    Left = 16
    Top = 664
    Width = 217
    Height = 30
    Cursor = crHandPoint
    Caption = 'Register'
    Default = True
    TabOrder = 7
    OnClick = btnRegClick
  end
  object btnBackToAuth: TButton
    Left = 16
    Top = 710
    Width = 217
    Height = 30
    Cursor = crHandPoint
    Caption = 'Back'
    TabOrder = 8
    OnClick = btnBackToAuthClick
  end
  object mEdtPhone: TMaskEdit
    Left = 16
    Top = 172
    Width = 217
    Height = 30
    EditMask = '!\8(999\)000-0000;1;_'
    MaxLength = 14
    TabOrder = 1
    Text = '8(   )   -    '
  end
  object rgType: TRadioGroup
    Left = 16
    Top = 543
    Width = 217
    Height = 105
    Caption = 'Type'
    ItemIndex = 0
    Items.Strings = (
      'Client'
      'Supplier')
    TabOrder = 6
  end
end
