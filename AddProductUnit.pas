unit AddProductUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.DBCtrls,
  Vcl.StdCtrls;

type
  TAddProductForm = class(TForm)
    lblAddProduct: TLabel;
    lblType: TLabel;
    DataSourceTypes: TDataSource;
    ADOQueryTypes: TADOQuery;
    DBLookupComboBoxTypes: TDBLookupComboBox;
    lblSort: TLabel;
    edtSort: TEdit;
    btnAddProduct: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnAddProductClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddProductForm: TAddProductForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, SupplierMainUnit;

procedure TAddProductForm.btnAddProductClick(Sender: TObject);
begin
  var sort : string;

  sort := trim(edtSort.Text);
  if(trim(DBLookupComboBoxTypes.Text) = '') then MessageDlg('Check type!', mtError, [mbOk], 0)
  else if(sort = '') then MessageDlg('Check sort!', mtError, [mbOk], 0)
  else
  begin
    try
      DBMainModule.MainADOQuery.SQL.Clear;
      DBMainModule.MainADOQuery.SQL.Add('insert into products values(null, :typeID, :supplierID, :sort);');
      DBMainModule.MainADOQuery.Parameters.ParamByName('typeID').Value := ADOQueryTypes.FieldByName('TypeID').AsInteger;
      DBMainModule.MainADOQuery.Parameters.ParamByName('supplierID').Value := SupplierMainForm.UserID;
      DBMainModule.MainADOQuery.Parameters.ParamByName('sort').Value := sort;
      DBMainModule.MainADOQuery.ExecSQL;

      edtSort.Text := '';
      MessageDlg('The new product has been successfully added!', mtInformation, [mbOk], 0);
    except on ex : Exception do
      MessageDlg(ex.Message, mtError, [mbOk], 0);
    end;

  end;
end;

procedure TAddProductForm.FormShow(Sender: TObject);
begin
  try
    ADOQueryTypes.Active := false;
    ADOQueryTypes.Active := true;

    DBLookupComboBoxTypes.KeyValue := DBLookupComboBoxTypes.ListSource.DataSet.FieldByName(DBLookupComboBoxTypes.KeyField).Value;
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

end.
