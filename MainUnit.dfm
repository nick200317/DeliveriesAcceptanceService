object AuthForm: TAuthForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'AuthForm'
  ClientHeight = 267
  ClientWidth = 276
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 22
  object lblLogin: TLabel
    Left = 16
    Top = 64
    Width = 47
    Height = 22
    Caption = 'Login'
  end
  object lblAuth: TLabel
    Left = 16
    Top = 16
    Width = 243
    Height = 32
    Alignment = taCenter
    Caption = 'AUTHORIZATION'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPassword: TLabel
    Left = 16
    Top = 144
    Width = 80
    Height = 22
    Caption = 'Password'
  end
  object lblRegistration: TLabel
    Left = 16
    Top = 222
    Width = 101
    Height = 22
    Cursor = crHandPoint
    Caption = 'Registration'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    OnClick = lblRegistrationClick
  end
  object edtLogin: TEdit
    Left = 16
    Top = 92
    Width = 243
    Height = 30
    Cursor = crIBeam
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 16
    Top = 172
    Width = 243
    Height = 30
    Cursor = crIBeam
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnSignIn: TButton
    Left = 162
    Top = 219
    Width = 97
    Height = 30
    Cursor = crHandPoint
    Caption = 'Sign In'
    Default = True
    TabOrder = 2
    OnClick = btnSignInClick
  end
end
