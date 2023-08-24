unit AddAcceptanceItemUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  Vcl.DBCtrls, Vcl.NumberBox;

type
  TAddAcceptanceItemForm = class(TForm)
    lblAddAcceptanceItem: TLabel;
    lblProduct: TLabel;
    DBLookupComboBoxPrices: TDBLookupComboBox;
    DataSourcePrices: TDataSource;
    ADOQueryPrices: TADOQuery;
    lblWeight: TLabel;
    nbWeight: TNumberBox;
    btnAddAcceptanceItem: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnAddAcceptanceItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddAcceptanceItemForm: TAddAcceptanceItemForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, AcceptanceItemsUnit;

procedure TAddAcceptanceItemForm.btnAddAcceptanceItemClick(Sender: TObject);
begin
  var priceID : integer;
  var weight : double;

  priceID := ADOQueryPrices.FieldByName('PriceID').AsInteger;
  weight := nbWeight.Value;

  if(priceID = 0) then MessageDlg('Check product!', mtError, [mbOK], 0)
  else
  begin
    try
      DBMainModule.MainADOQuery.SQL.Clear;
      DBMainModule.MainADOQuery.SQL.Add('insert into AcceptanceItems values(null, :acceptanceID, :priceID, :weight);');
      DBMainModule.MainADOQuery.Parameters.ParamByName('acceptanceID').Value := AcceptanceItemsForm.AcceptanceID;
      DBMainModule.MainADOQuery.Parameters.ParamByName('priceID').Value := priceID;
      DBMainModule.MainADOQuery.Parameters.ParamByName('weight').Value := weight;
      DBMainModule.MainADOQuery.ExecSQL;

      MessageDlg('The new item has been successfully added!', mtInformation, [mbOk], 0);
      nbWeight.Value := 1;
    except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TAddAcceptanceItemForm.FormShow(Sender: TObject);
begin
  try
    ADOQueryPrices.Parameters.ParamByName('supplierID').Value := AcceptanceItemsForm.SupplierID;
    ADOQueryPrices.Parameters.ParamByName('acceptanceID').Value := AcceptanceItemsForm.AcceptanceID;
    ADOQueryPrices.Active := false;
    ADOQueryPrices.Active := true;

    ADOQueryPrices.Fields[0].DisplayWidth := 0;
    ADOQueryPrices.Fields[1].DisplayWidth := 10;
    ADOQueryPrices.Fields[2].DisplayWidth := 10;

    DBLookupComboBoxPrices.KeyValue := DBLookupComboBoxPrices.ListSource.DataSet.FieldByName(DBLookupComboBoxPrices.KeyField).Value;
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

end.
