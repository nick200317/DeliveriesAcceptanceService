unit AddAcceptanceUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  Vcl.DBCtrls, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh;

type
  TAddAcceptanceForm = class(TForm)
    lblAddAcceptance: TLabel;
    lblSupplier: TLabel;
    DBLookupComboBoxSupplier: TDBLookupComboBox;
    DataSourceSuppliers: TDataSource;
    ADOQuerySuppliers: TADOQuery;
    lblDate: TLabel;
    dtpDate: TDateTimePicker;
    lblComment: TLabel;
    btnAddAcceptance: TButton;
    edtComment: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnAddAcceptanceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddAcceptanceForm: TAddAcceptanceForm;

implementation

{$R *.dfm}

uses DBMainModuleUnit, ClientMainUnit;

procedure TAddAcceptanceForm.btnAddAcceptanceClick(Sender: TObject);
begin
  var supplierID : integer;
  var date : TDate;
  var comment : string;

  supplierID := ADOQuerySuppliers.FieldByName('UserID').AsInteger;
  date := dtpDate.Date;
  comment := edtComment.Text;

  if(supplierID = 0) then MessageDlg('Check supplier!', mtError, [mbOK], 0)
  else
  begin
    try
      DBMainModule.MainADOQuery.SQL.Clear;
      DBMainModule.MainADOQuery.SQL.Add('insert into acceptances values(null, :clientID, :supplierID, :date, :comment);');
      DBMainModule.MainADOQuery.Parameters.ParamByName('clientID').Value := ClientMainForm.UserID;
      DBMainModule.MainADOQuery.Parameters.ParamByName('supplierID').Value := ADOQuerySuppliers.FieldByName('UserID').AsInteger;
      DBMainModule.MainADOQuery.Parameters.ParamByName('date').Value := FormatDateTime('yyyy-mm-dd', dtpDate.Date);
      DBMainModule.MainADOQuery.Parameters.ParamByName('comment').Value := edtComment.Text;
      DBMainModule.MainADOQuery.ExecSQL;

      MessageDlg('The new acceptance has been successfully added!', mtInformation, [mbOk], 0);
      edtComment.Text := '';
      dtpDate.Date := now;
    except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TAddAcceptanceForm.FormShow(Sender: TObject);
begin
  try
    ADOQuerySuppliers.Active := false;
    ADOQuerySuppliers.Active := true;
    ADOQuerySuppliers.FieldByName('Fio').DisplayWidth := 20;

    DBLookupComboBoxSupplier.KeyValue := DBLookupComboBoxSupplier.ListSource.DataSet.FieldByName(DBLookupComboBoxSupplier.KeyField).Value;
  except on ex : Exception do
     MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

end.
