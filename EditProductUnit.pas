unit EditProductUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  Vcl.DBCtrls;

type
  TEditProductForm = class(TForm)
    lblAddProduct: TLabel;
    lblType: TLabel;
    DBLookupComboBoxTypes: TDBLookupComboBox;
    DataSourceTypes: TDataSource;
    ADOQueryTypes: TADOQuery;
    lblSort: TLabel;
    edtSort: TEdit;
    btnEditProduct: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnEditProductClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditProductForm: TEditProductForm;

implementation

{$R *.dfm}

uses SupplierMainUnit, DBMainModuleUnit;

procedure TEditProductForm.btnEditProductClick(Sender: TObject);
begin
  var typeID, productID : integer;
  var sort : string;

  typeID := ADOQueryTypes.FieldByName('TypeID').AsInteger;
  sort := trim(edtSort.Text);
  productID := SupplierMainForm.ADOQueryProducts.FieldByName('ProductID').AsInteger;

  try
    DBMainModule.MainADOQuery.SQL.Clear;
    DBMainModule.MainADOQuery.SQL.Add('update products set TypeID = :typeID, Sort = :sort where ProductID = :productID;');
    DBMainModule.MainADOQuery.Parameters.ParamByName('typeID').Value := typeID;
    DBMainModule.MainADOQuery.Parameters.ParamByName('sort').Value := sort;
    DBMainModule.MainADOQuery.Parameters.ParamByName('productID').Value := productID;
    DBMainModule.MainADOQuery.ExecSQL;

    MessageDlg('The product has been successfully updated!', mtInformation, [mbOk], 0);
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

procedure TEditProductForm.FormShow(Sender: TObject);
begin
  try
    ADOQueryTypes.Active := false;
    ADOQueryTypes.Active := true;

    DBLookupComboBoxTypes.KeyValue := SupplierMainForm.ADOQueryProducts.FieldByName('Type').AsString;
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;

  edtSort.Text := SupplierMainForm.ADOQueryProducts.FieldByName('Sort').AsString;
end;

end.
