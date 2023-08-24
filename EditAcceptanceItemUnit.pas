unit EditAcceptanceItemUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.NumberBox, Data.DB,
  Data.Win.ADODB, Vcl.DBCtrls;

type
  TEditAcceptanceItemForm = class(TForm)
    lblEditAcceptanceItem: TLabel;
    lblProduct: TLabel;
    DBLookupComboBoxPrices: TDBLookupComboBox;
    DataSourcePrices: TDataSource;
    ADOQueryPrices: TADOQuery;
    lblWeight: TLabel;
    nbWeight: TNumberBox;
    btnEditAcceptanceItem: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnEditAcceptanceItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditAcceptanceItemForm: TEditAcceptanceItemForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, AcceptanceItemsUnit;

procedure TEditAcceptanceItemForm.btnEditAcceptanceItemClick(Sender: TObject);
begin
  var priceID, acceptanceItemID : integer;
  var weight : double;

  priceID := ADOQueryPrices.FieldByName('PriceID').AsInteger;
  weight := nbWeight.Value;
  acceptanceItemID := AcceptanceItemsForm.ADOQueryAcceptanceItems.FieldByName('AcceptanceItemID').AsInteger;

  try
    DBMainModule.MainADOQuery.SQL.Clear;
    DBMainModule.MainADOQuery.SQL.Add('update AcceptanceItems set PriceID = :priceID, Weight = :weight where AcceptanceItemID = :acceptanceItemID');
    DBMainModule.MainADOQuery.Parameters.ParamByName('priceID').Value := priceID;
    DBMainModule.MainADOQuery.Parameters.ParamByName('weight').Value := weight;
    DBMainModule.MainADOQuery.Parameters.ParamByName('acceptanceItemID').Value := acceptanceItemID;
    DBMainModule.MainADOQuery.ExecSQL;

    MessageDlg('The item has been successfully updated!', mtInformation, [mbOk], 0);
  except on ex : Exception do
    MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

procedure TEditAcceptanceItemForm.FormShow(Sender: TObject);
begin
  try
    ADOQueryPrices.Parameters.ParamByName('supplierID').Value := AcceptanceItemsForm.SupplierID;
    ADOQueryPrices.Parameters.ParamByName('acceptanceID').Value := AcceptanceItemsForm.AcceptanceID;
    ADOQueryPrices.Active := false;
    ADOQueryPrices.Active := true;

    ADOQueryPrices.Fields[0].DisplayWidth := 0;
    ADOQueryPrices.Fields[1].DisplayWidth := 10;
    ADOQueryPrices.Fields[2].DisplayWidth := 10;

    DBLookupComboBoxPrices.KeyValue := AcceptanceItemsForm.ADOQueryAcceptanceItems.FieldByName('Sort').AsString;
    nbWeight.Value := AcceptanceItemsForm.ADOQueryAcceptanceItems.FieldByName('Weight').AsFloat;
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

end.
