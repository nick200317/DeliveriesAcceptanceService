unit ClientMainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.DBCtrls, Data.DB, Data.Win.ADODB,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TClientMainForm = class(TForm)
    lblClientForm: TLabel;
    pcClientPages: TPageControl;
    Suppliers: TTabSheet;
    Acceptances: TTabSheet;
    DataSourceSuppliers: TDataSource;
    ADOQuerySuppliers: TADOQuery;
    DBGridPrices: TDBGridEh;
    DataSourcePrices: TDataSource;
    ADOQueryPrices: TADOQuery;
    DBLookupListBoxSuppliers: TDBLookupListBox;
    pnlAcceptancesActions: TPanel;
    imgDeleteAcceptance: TImage;
    imgAddAcceptance: TImage;
    imgEditAcceptance: TImage;
    DBGridAcceptances: TDBGridEh;
    DataSourceAcceptances: TDataSource;
    ADOQueryAcceptances: TADOQuery;
    Label1: TLabel;
    imgOpenAcceptanceItems: TImage;
    ActionToolBar: TActionToolBar;
    ActionManager: TActionManager;
    ShowReportsAction: TAction;
    ExitAction: TAction;
    procedure FormShow(Sender: TObject);
    procedure DBLookupListBoxSuppliersClick(Sender: TObject);
    procedure imgDeleteAcceptanceClick(Sender: TObject);
    procedure imgAddAcceptanceClick(Sender: TObject);
    procedure imgOpenAcceptanceItemsClick(Sender: TObject);
    procedure imgEditAcceptanceClick(Sender: TObject);
    procedure ShowReportsActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UserID : integer;
    FIO : string;
  end;

var
  ClientMainForm: TClientMainForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, AddAcceptanceUnit, AcceptanceItemsUnit, EditAcceptanceUnit, ReportsMainUnit;

// Процедура обновления приёмок.
procedure UpdateAcceptances();
begin
  var i : integer;

  try
    ClientMainForm.ADOQueryAcceptances.SQL.Clear;
    ClientMainForm.ADOQueryAcceptances.SQL.Add('select AcceptanceID, Users.UserID as SupplierID, Users.Fio as Supplier, Users.INN, (select sum(Weight * Prices.Price / 1000) from AcceptanceItems ');
    ClientMainForm.ADOQueryAcceptances.SQL.Add('Join Prices on AcceptanceItems.PriceID = Prices.PriceID where AcceptanceItems.AcceptanceID = Acceptances.AcceptanceID) as TotalPrice, ');
    ClientMainForm.ADOQueryAcceptances.SQL.Add('(select sum(weight) from AcceptanceItems Join Prices on AcceptanceItems.PriceID = Prices.PriceID where AcceptanceItems.AcceptanceID = Acceptances.AcceptanceID) as TotalWeight, ');
    ClientMainForm.ADOQueryAcceptances.SQL.Add('Date, Comment from Acceptances Join Users on Acceptances.SupplierID = Users.UserID where Acceptances.ClientID = :id');
    ClientMainForm.ADOQueryAcceptances.Parameters.ParamByName('id').Value := ClientMainForm.UserID;
    ClientMainForm.ADOQueryAcceptances.Active := false;
    ClientMainForm.ADOQueryAcceptances.Active := true;

    for i:=0 to ClientMainForm.DBGridAcceptances.Columns.Count-1 do
    begin
      if(ClientMainForm.DBGridAcceptances.Columns[i].Title.Caption = 'SupplierID') then
      begin
        ClientMainForm.DBGridAcceptances.Columns[i].Visible := false;
      end;

      ClientMainForm.DBGridAcceptances.Columns[i].OptimizeWidth;
      ClientMainForm.DBGridAcceptances.Columns[i].Alignment := taCenter;
    end;
  except on ex : Exception do
    MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;

end;

// Процедура обновления прайс-листа.
procedure UpdatePrices();
begin
  var i : integer;

  try
    ClientMainForm.ADOQueryPrices.Active := false;
    ClientMainForm.ADOQueryPrices.SQL.Clear;
    ClientMainForm.ADOQueryPrices.SQL.Add('select PriceID, Types.Name, Products.Sort, Price, StartPeriod, EndPeriod from prices, products, types where Prices.SupplierID = :id and Prices.ProductID = Products.ProductID and Products.TypeID = Types.TypeID;');
    ClientMainForm.ADOQueryPrices.Parameters.ParamByName('id').Value	:= ClientMainForm.ADOQuerySuppliers.FieldByName('UserID').AsInteger;
    ClientMainForm.ADOQueryPrices.Active := true;

    for i:=0 to ClientMainForm.DBGridPrices.Columns.Count-1 do
    begin
      ClientMainForm.DBGridPrices.Columns[i].OptimizeWidth;
      ClientMainForm.DBGridPrices.Columns[i].Alignment := taCenter;
    end;
  except on ex : Exception do
    MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;

end;

procedure TClientMainForm.DBLookupListBoxSuppliersClick(Sender: TObject);
begin
  UpdatePrices();
end;

procedure TClientMainForm.ExitActionExecute(Sender: TObject);
begin
  Close;
end;

procedure TClientMainForm.FormShow(Sender: TObject);
begin
  lblClientForm.Caption := lblClientForm.Caption + FIO;

  try
    ADOQuerySuppliers.Active := false;
    ADOQuerySuppliers.Active := true;

    ADOQuerySuppliers.FieldByName('Fio').DisplayWidth := 10;

    UpdatePrices();
    UpdateAcceptances();
  except on ex : Exception do
      MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

procedure TClientMainForm.imgAddAcceptanceClick(Sender: TObject);
begin
  AddAcceptanceForm := TAddAcceptanceForm.Create(Self);

  AddAcceptanceForm.ShowModal();
  UpdateAcceptances();
end;

procedure TClientMainForm.imgDeleteAcceptanceClick(Sender: TObject);
begin
  var confirmDelete, i : integer;

  if(DBGridAcceptances.SelectedRows.Count = 0) then MessageDlg('Select row to delete the acceptance!', mtInformation, [mbOK], 0)
  else
  begin
    confirmDelete := MessageDlg('Do you really want to delete the acceptance?', TMsgDlgType.mtConfirmation, mbOKCancel, 0);

    if(confirmDelete = mrOk) then
    begin
      try
        DBMainModule.MainADOQuery.SQL.Clear;
        DBMainModule.MainADOQuery.SQL.Add('delete from Acceptances where AcceptanceID = :acceptanceID and ClientID = :clientID;');
        DBMainModule.MainADOQuery.Parameters.ParamByName('acceptanceID').Value := ADOQueryAcceptances.FieldByName('AcceptanceID').AsInteger;
        DBMainModule.MainADOQuery.Parameters.ParamByName('clientID').Value := UserID;
        DBMainModule.MainADOQuery.ExecSQL;

        UpdateAcceptances();
      except on ex : Exception do
        MessageDlg(ex.Message, mtError, [mbOk], 0);
      end;
    end;
  end;
end;

procedure TClientMainForm.imgEditAcceptanceClick(Sender: TObject);
begin
  if(DBGridAcceptances.SelectedRows.Count = 0) then MessageDlg('Select row to update the acceptance!', mtInformation, [mbOK], 0)
  else
  begin
    EditAcceptanceForm := TEditAcceptanceForm.Create(Self);

    EditAcceptanceForm.ShowModal();
    UpdateAcceptances();
  end;
end;

procedure TClientMainForm.imgOpenAcceptanceItemsClick(Sender: TObject);
begin
  if(DBGridAcceptances.SelectedRows.Count = 0) then MessageDlg('Select row to open items!', mtInformation, [mbOK], 0)
  else
  begin
    AcceptanceItemsForm := TAcceptanceItemsForm.Create(Self);
    AcceptanceItemsForm.AcceptanceID := ADOQueryAcceptances.FieldByName('AcceptanceID').AsInteger;
    AcceptanceItemsForm.SupplierID := ADOQueryAcceptances.FieldByName('SupplierID').AsInteger;
    AcceptanceItemsForm.AcceptanceDate := ADOQueryAcceptances.FieldByName('Date').AsDateTime;

    AcceptanceItemsForm.ShowModal();
    UpdateAcceptances();
  end;
end;

procedure TClientMainForm.ShowReportsActionExecute(Sender: TObject);
begin
  ReportsMainForm := TReportsMainForm.Create(Self);

  ReportsMainForm.ShowModal();
end;

end.
