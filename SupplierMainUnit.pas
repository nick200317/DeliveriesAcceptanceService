unit SupplierMainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,
  Data.DB, Data.Win.ADODB;

type
  TSupplierMainForm = class(TForm)
    lblSupplierForm: TLabel;
    pcSuppliersPages: TPageControl;
    tshProducts: TTabSheet;
    tshPrices: TTabSheet;
    pnlProductsActions: TPanel;
    DBGridProducts: TDBGridEh;
    imgDeleteProduct: TImage;
    imgAddProduct: TImage;
    imgEditProduct: TImage;
    DataSourceProducts: TDataSource;
    ADOQueryProducts: TADOQuery;
    pnlPricesActions: TPanel;
    imgDeletePrice: TImage;
    imgAddPrice: TImage;
    imgEditPrice: TImage;
    DBGridPrices: TDBGridEh;
    DataSourcePrices: TDataSource;
    ADOQueryPrices: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure imgDeleteProductClick(Sender: TObject);
    procedure imgAddProductClick(Sender: TObject);
    procedure imgEditProductClic(Sender: TObject);
    procedure pcSuppliersPagesChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure imgDeletePriceClick(Sender: TObject);
    procedure imgAddPriceClick(Sender: TObject);
    procedure imgEditPriceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UserID : integer;
    FIO : string;

  end;

var
  SupplierMainForm: TSupplierMainForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, AddProductUnit, EditProductUnit, AddPriceUnit, EditPriceUnit;

// Процедура обновления продуктов
procedure UpdateProducts();
begin
  var i : integer;

  try
    SupplierMainForm.ADOQueryProducts.Active := false;
    SupplierMainForm.ADOQueryProducts.Active := true;

    for i:=0 to SupplierMainForm.DBGridProducts.Columns.Count-1 do
    begin
      SupplierMainForm.DBGridProducts.Columns[i].OptimizeWidth;
      SupplierMainForm.DBGridProducts.Columns[i].Alignment := taCenter;
    end;
  except on ex : Exception do
    MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

// Процедура обновления прайс-листа
procedure UpdatePrices();
begin
  var i : integer;

  try
    SupplierMainForm.ADOQueryPrices.Active := false;
    SupplierMainForm.ADOQueryPrices.Active := true;

    for i:=0 to SupplierMainForm.DBGridPrices.Columns.Count-1 do
    begin
      SupplierMainForm.DBGridPrices.Columns[i].OptimizeWidth;
      SupplierMainForm.DBGridPrices.Columns[i].Alignment := taCenter;
    end;
  except on ex : Exception do
    MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

procedure TSupplierMainForm.FormShow(Sender: TObject);
begin
  var i : integer;

  lblSupplierForm.Caption := lblSupplierForm.Caption + FIO;

  try
    ADOQueryProducts.SQL.Clear;
    ADOQueryProducts.SQL.Add('select ProductID, Types.Name as Type, Sort from products, types where SupplierID = :id and Products.TypeID = Types.TypeID;');
    ADOQueryProducts.Parameters.ParamByName('id').Value	:= UserID;
    ADOQueryProducts.Active := false;
    ADOQueryProducts.Active := true;

    for i:=0 to DBGridProducts.Columns.Count-1 do
    begin
      DBGridProducts.Columns[i].OptimizeWidth;
      DBGridProducts.Columns[i].Alignment := taCenter;
    end;
  except on ex : Exception do
    MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;

  try
    ADOQueryPrices.SQL.Clear;
    ADOQueryPrices.SQL.Add('select PriceID, Types.Name, Products.Sort, Price, StartPeriod, EndPeriod from prices, products, types where Prices.SupplierID = :id and Prices.ProductID = Products.ProductID and Products.TypeID = Types.TypeID;');
    ADOQueryPrices.Parameters.ParamByName('id').Value	:= UserID;
    ADOQueryPrices.Active := false;
    ADOQueryPrices.Active := true;

    for i:=0 to DBGridPrices.Columns.Count-1 do
    begin
      DBGridPrices.Columns[i].OptimizeWidth;
      DBGridPrices.Columns[i].OptimizeWidth;
    end;
  except on ex : Exception do
      MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;

end;

procedure TSupplierMainForm.imgAddPriceClick(Sender: TObject);
begin
  AddPriceForm := TAddPriceForm.Create(Self);

  AddPriceForm.ShowModal;
  UpdatePrices();
end;

procedure TSupplierMainForm.imgAddProductClick(Sender: TObject);
begin
  AddProductForm := TAddProductForm.Create(Self);

  AddProductForm.ShowModal;
  UpdateProducts();
end;

procedure TSupplierMainForm.imgDeletePriceClick(Sender: TObject);
begin
  var confirmDelete, i : integer;

  if(DBGridPrices.SelectedRows.Count = 0) then MessageDlg('Select row to delete the price.', mtInformation, [mbOK], 0)
  else
  begin
    confirmDelete := MessageDlg('Do you really want to delete the price?', TMsgDlgType.mtConfirmation, mbOKCancel, 0);

    if(confirmDelete = mrOk) then
    begin
      try
        DBMainModule.MainADOQuery.SQL.Clear;
        DBMainModule.MainADOQuery.SQL.Add('delete from prices where PriceID = :priceID and SupplierID = :supplierID;');
        DBMainModule.MainADOQuery.Parameters.ParamByName('priceID').Value := ADOQueryPrices.FieldByName('PriceID').AsInteger;
        DBMainModule.MainADOQuery.Parameters.ParamByName('supplierID').Value := UserID;
        DBMainModule.MainADOQuery.ExecSQL;

        UpdatePrices();
      except on ex : Exception do
        MessageDlg(ex.Message, mtError, [mbOk], 0);
      end;
    end;
  end;
end;

procedure TSupplierMainForm.imgDeleteProductClick(Sender: TObject);
begin
  var confirmDelete, i : integer;

  if(DBGridProducts.SelectedRows.Count = 0) then MessageDlg('Select row to delete the product!', mtInformation, [mbOK], 0)
  else
  begin
    confirmDelete := MessageDlg('Do you really want to delete the product?', TMsgDlgType.mtConfirmation, mbOKCancel, 0);

    if(confirmDelete = mrOk) then
    begin
      try
        DBMainModule.MainADOQuery.SQL.Clear;
        DBMainModule.MainADOQuery.SQL.Add('delete from products where ProductID = :productID and SupplierID = :supplierID;');
        DBMainModule.MainADOQuery.Parameters.ParamByName('productID').Value := ADOQueryProducts.FieldByName('ProductID').AsInteger;
        DBMainModule.MainADOQuery.Parameters.ParamByName('supplierID').Value := UserID;
        DBMainModule.MainADOQuery.ExecSQL;

        UpdateProducts();
      except on ex : Exception do
        MessageDlg(ex.Message, mtError, [mbOk], 0);
      end;
    end;
  end;
end;

procedure TSupplierMainForm.imgEditPriceClick(Sender: TObject);
begin
  if(DBGridPrices.SelectedRows.Count = 0) then MessageDlg('Select row to update the price!', mtInformation, [mbOK], 0)
  else
  begin
    EditPriceForm := TEditPriceForm.Create(Self);

    EditPriceForm.ShowModal;
    UpdatePrices();
  end;
end;

procedure TSupplierMainForm.imgEditProductClic(Sender: TObject);
begin
  if(DBGridProducts.SelectedRows.Count = 0) then MessageDlg('Select row to update the product!', mtInformation, [mbOK], 0)
  else
  begin
    EditProductForm := TEditProductForm.Create(Self);

    EditProductForm.ShowModal;
    UpdateProducts();
  end;
end;

procedure TSupplierMainForm.pcSuppliersPagesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if(pcSuppliersPages.ActivePageIndex	= 0) then UpdateProducts()
  else UpdatePrices();
end;

end.
