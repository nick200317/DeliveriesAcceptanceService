unit ReportsMainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Data.Win.ADODB;

type
  TReportsMainForm = class(TForm)
    lblReportsForm: TLabel;
    lblStartPeriod: TLabel;
    dtpStartPeriod: TDateTimePicker;
    lblEmdPeriod: TLabel;
    dtpEndPeriod: TDateTimePicker;
    btnReportPreview: TButton;
    btnExportPDF: TButton;
    procedure btnReportPreviewClick(Sender: TObject);
    procedure btnExportPDFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportsMainForm: TReportsMainForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, ReportProductsUnit, ClientMainUnit;

procedure TReportsMainForm.btnExportPDFClick(Sender: TObject);
begin
  var startPeriod, endPeriod : TDate;

  startPeriod := dtpStartPeriod.Date;
  endPeriod := dtpEndPeriod.Date;

  try
    ReportProductsForm.startPeriod := startPeriod;
    ReportProductsForm.endPeriod := endPeriod;
    ReportProductsForm.PrepareReport();
    ReportProductsForm.frxReport.Export(ReportProductsForm.frxPDFExport);

    MessageDlg('The report has been successfully saved!', mtInformation, [mbOk], 0);
  except on ex : Exception do
    MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

procedure TReportsMainForm.btnReportPreviewClick(Sender: TObject);
begin
  var startPeriod, endPeriod : TDate;

  startPeriod := dtpStartPeriod.Date;
  endPeriod := dtpEndPeriod.Date;

  if(startPeriod > endPeriod) then MessageDlg('Check date interval!', mtError, [mbOK], 0)
  else
  begin
    ReportProductsForm := TReportProductsForm.Create(Self);
    ReportProductsForm.startPeriod := startPeriod;
    ReportProductsForm.endPeriod := endPeriod;

    ReportProductsForm.ShowModal();
  end;
end;

end.
