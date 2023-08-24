unit ReportProductsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxPreview, frxDBSet, Data.DB,
  Data.Win.ADODB, frxExportBaseDialog, frxExportPDF;

type
  TReportProductsForm = class(TForm)
    frxReport: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    frxPreview: TfrxPreview;
    DataSourceReportProducts: TDataSource;
    ADOQueryReportProducts: TADOQuery;
    frxPDFExport: TfrxPDFExport;
    procedure FormShow(Sender: TObject);
    procedure PrepareReport();
  private
    { Private declarations }
  public
    { Public declarations }
    startPeriod, endPeriod : TDate;
  end;

var
  ReportProductsForm: TReportProductsForm;

implementation

{$R *.dfm}

uses ReportsMainUnit, ClientMainUnit;

// Подготавливаем отчёт для представления.
procedure TReportProductsForm.PrepareReport();
begin
  try
    ADOQueryReportProducts.SQL.Clear;
    ADOQueryReportProducts.SQL.Add('select Users.Fio as Supplier, Users.INN, Types.Name as Type, Products.Sort, sum(Prices.Price * AcceptanceItems.Weight / 1000) as TotalCost, ');
    ADOQueryReportProducts.SQL.Add('sum(AcceptanceItems.Weight) as TotalWeight from AcceptanceItems join Acceptances on AcceptanceItems.AcceptanceID = Acceptances.AcceptanceID ');
    ADOQueryReportProducts.SQL.Add('join Users on Acceptances.SupplierID = Users.UserID join Prices on AcceptanceItems.PriceID = Prices.PriceID join Products on Prices.ProductID = Products.ProductID ');
    ADOQueryReportProducts.SQL.Add('join Types on Products.TypeID = Types.TypeID where Acceptances.ClientID = :clientID and Acceptances.Date between :startPeriod and :endPeriod group by Products.ProductID order by Supplier;');
    ADOQueryReportProducts.Parameters.ParamByName('clientID').Value := ClientMainForm.UserID;
    ADOQueryReportProducts.Parameters.ParamByName('startPeriod').Value := FormatDateTime('yyyy-mm-dd', startPeriod);
    ADOQueryReportProducts.Parameters.ParamByName('endPeriod').Value := FormatDateTime('yyyy-mm-dd', endPeriod);

    frxReport.Variables['StartPeriod'] := '''' + FormatDateTime('dd.mm.yyyy', startPeriod) + '''';
    frxReport.Variables['EndPeriod'] := '''' + FormatDateTime('dd.mm.yyyy', endPeriod) + '''';

    ADOQueryReportProducts.Active := false;
    ADOQueryReportProducts.Active := true;

    frxReport.ShowReport();
  except on ex : Exception do
    MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

procedure TReportProductsForm.FormShow(Sender: TObject);
begin
  PrepareReport();
end;

end.
