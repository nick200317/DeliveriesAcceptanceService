unit EditPriceUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.NumberBox, Vcl.DBCtrls, Data.DB, Data.Win.ADODB;

type
  TEditPriceForm = class(TForm)
    lblEditPrice: TLabel;
    lblProduct: TLabel;
    ADOQueryProducts: TADOQuery;
    DataSourceProducts: TDataSource;
    DBLookupComboBoxProducts: TDBLookupComboBox;
    lblPrice: TLabel;
    nbPrice: TNumberBox;
    lblStartPeriod: TLabel;
    DateTimePickerStartPeriod: TDateTimePicker;
    lblEndPeriod: TLabel;
    DateTimePickerEndPeriod: TDateTimePicker;
    btnEditPrice: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnEditPriceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditPriceForm: TEditPriceForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, SupplierMainUnit;

procedure TEditPriceForm.btnEditPriceClick(Sender: TObject);
begin
  var priceID, productID : integer;
  var price : double;
  var startPeriod, endPeriod : TDate;

  priceID := SupplierMainForm.ADOQueryPrices.FieldByName('PriceID').AsInteger;
  productID := ADOQueryProducts.FieldByName('ProductID').AsInteger;
  price := nbPrice.Value;
  startPeriod := DateTimePickerStartPeriod.Date;
  endPeriod := DateTimePickerEndPeriod.Date;

  try
    DBMainModule.MainADOQuery.SQL.Clear;
    DBMainModule.MainADOQuery.SQL.Add('update prices set ProductID = :productID, Price = :price, StartPeriod = :startPeriod, EndPeriod = :endPeriod where PriceID = :priceID;');
    DBMainModule.MainADOQuery.Parameters.ParamByName('productID').Value := productID;
    DBMainModule.MainADOQuery.Parameters.ParamByName('price').Value := price;
    DBMainModule.MainADOQuery.Parameters.ParamByName('startPeriod').Value := FormatDateTime('yyyy-mm-dd', startPeriod);
    DBMainModule.MainADOQuery.Parameters.ParamByName('endPeriod').Value := FormatDateTime('yyyy-mm-dd', endPeriod);
    DBMainModule.MainADOQuery.Parameters.ParamByName('priceID').Value := priceID;
    DBMainModule.MainADOQuery.ExecSQL;

    MessageDlg('The price has been successfully updated!', mtInformation, [mbOk], 0);
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

procedure TEditPriceForm.FormShow(Sender: TObject);
begin
  ADOQueryProducts.SQL.Clear;
  ADOQueryProducts.SQL.Add('select ProductID, Types.Name, Sort from Products, Types where SupplierID = :id and Products.TypeID = Types.TypeID;');
  ADOQueryProducts.Parameters.ParamByName('id').Value := SupplierMainForm.UserID;

  try
    ADOQueryProducts.Active := false;
    ADOQueryProducts.Active := true;
    ADOQueryProducts.FieldByName('Sort').DisplayWidth := 20;

    DBLookupComboBoxProducts.KeyValue := SupplierMainForm.ADOQueryPrices.FieldByName('Sort').AsString;
    nbPrice.Value := SupplierMainForm.ADOQueryPrices.FieldByName('Price').AsFloat;
    DateTimePickerStartPeriod.Date := SupplierMainForm.ADOQueryPrices.FieldByName('StartPeriod').AsDateTime;
    DateTimePickerEndPeriod.Date := SupplierMainForm.ADOQueryPrices.FieldByName('EndPeriod').AsDateTime;
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

end.
