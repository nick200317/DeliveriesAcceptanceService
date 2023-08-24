object ReportsMainForm: TReportsMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ReportsMainForm'
  ClientHeight = 318
  ClientWidth = 354
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Times New Roman'
  Font.Style = [fsBold]
  Position = poScreenCenter
  TextHeight = 22
  object lblReportsForm: TLabel
    Left = 16
    Top = 16
    Width = 321
    Height = 32
    Alignment = taCenter
    AutoSize = False
    Caption = 'REPORTS FORM'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblStartPeriod: TLabel
    Left = 16
    Top = 64
    Width = 98
    Height = 22
    Caption = 'Start period'
  end
  object lblEmdPeriod: TLabel
    Left = 16
    Top = 144
    Width = 90
    Height = 22
    Caption = 'End period'
  end
  object dtpStartPeriod: TDateTimePicker
    Left = 16
    Top = 92
    Width = 321
    Height = 30
    Date = 45162.000000000000000000
    Time = 0.114991111113340600
    TabOrder = 0
  end
  object dtpEndPeriod: TDateTimePicker
    Left = 16
    Top = 172
    Width = 321
    Height = 30
    Date = 45162.000000000000000000
    Time = 0.114991111113340600
    TabOrder = 1
  end
  object btnReportPreview: TButton
    Left = 16
    Top = 224
    Width = 321
    Height = 30
    Caption = 'PREVIEW'
    Default = True
    TabOrder = 2
    OnClick = btnReportPreviewClick
  end
  object btnExportPDF: TButton
    Left = 16
    Top = 272
    Width = 321
    Height = 30
    Caption = 'EXPORT TO PDF'
    TabOrder = 3
    OnClick = btnExportPDFClick
  end
end
