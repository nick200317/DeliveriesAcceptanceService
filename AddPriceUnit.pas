unit AddPriceUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  Vcl.DBCtrls, Vcl.NumberBox, Vcl.ComCtrls;

type
  TAddPriceForm = class(TForm)
    lblAddPrice: TLabel;
    lblProduct: TLabel;
    ADOQueryProducts: TADOQuery;
    DataSourceProducts: TDataSource;
    DBLookupComboBoxProducts: TDBLookupComboBox;
    lblPrice: TLabel;
    nbPrice: TNumberBox;
    lblStartPeriod: TLabel;
    DateTimePickerStartPeriod: TDateTimePicker;
    Label1: TLabel;
    DateTimePickerEndPeriod: TDateTimePicker;
    btnAddPrice: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnAddPriceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddPriceForm: TAddPriceForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, SupplierMainUnit;

procedure TAddPriceForm.btnAddPriceClick(Sender: TObject);
begin
  var price : double;
  var productID : integer;
  var startPeriod, endPeriod : TDate;

  price := nbPrice.Value;
  productID := ADOQueryProducts.FieldByName('ProductID').AsInteger;
  startPeriod := DateTimePickerStartPeriod.Date;
  endPeriod := DateTimePickerEndPeriod.Date;

  if(productID = 0) then MessageDlg('Check product!', mtError, [mbOK], 0)
  else if(startPeriod > endPeriod) then MessageDlg('Check date interval!', mtError, [mbOK], 0)
  else
  begin
    try
      DBMainModule.MainADOQuery.SQL.Clear;
      DBMainModule.MainADOQuery.SQL.Add('insert into prices values(null, :supplierID, :productID, :price, :startPeriod, :endPeriod);');
      DBMainModule.MainADOQuery.Parameters.ParamByName('supplierID').Value := SupplierMainForm.UserID;
      DBMainModule.MainADOQuery.Parameters.ParamByName('productID').Value := productID;
      DBMainModule.MainADOQuery.Parameters.ParamByName('price').Value := price;
      DBMainModule.MainADOQuery.Parameters.ParamByName('startPeriod').Value := FormatDateTime('yyyy-mm-dd', startPeriod);
      DBMainModule.MainADOQuery.Parameters.ParamByName('endPeriod').Value := FormatDateTime('yyyy-mm-dd', endPeriod);
      DBMainModule.MainADOQuery.ExecSQL;

      MessageDlg('The new price has been successfully added!', mtInformation, [mbOk], 0);

      nbPrice.Value := 0;
      DateTimePickerStartPeriod.Date := now;
      DateTimePickerEndPeriod.Date := now;
    except on ex : Exception do
      MessageDlg(ex.Message, mtError, [mbOk], 0);
    end;
  end;

end;

procedure TAddPriceForm.FormShow(Sender: TObject);
begin
  ADOQueryProducts.SQL.Clear;
  ADOQueryProducts.SQL.Add('select ProductID, Types.Name, Sort from Products, Types where SupplierID = :id and Products.TypeID = Types.TypeID;');
  ADOQueryProducts.Parameters.ParamByName('id').Value := SupplierMainForm.UserID;

  try
    ADOQueryProducts.Active := false;
    ADOQueryProducts.Active := true;
    ADOQueryProducts.FieldByName('Sort').DisplayWidth := 20;

    DBLookupComboBoxProducts.KeyValue := DBLookupComboBoxProducts.ListSource.DataSet.FieldByName(DBLookupComboBoxProducts.KeyField).Value;
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

end.
