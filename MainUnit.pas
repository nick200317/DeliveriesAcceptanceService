unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Hash;

type
  TAuthForm = class(TForm)
    lblLogin: TLabel;
    edtLogin: TEdit;
    lblAuth: TLabel;
    lblPassword: TLabel;
    edtPassword: TEdit;
    btnSignIn: TButton;
    lblRegistration: TLabel;
    procedure lblRegistrationClick(Sender: TObject);
    procedure btnSignInClick(Sender: TObject);
    procedure SetTypesDefaultValues();
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AuthForm: TAuthForm;

implementation

{$R *.dfm}

uses RegUnit, DBMainModuleUnit, SupplierMainUnit, ClientMainUnit;

// Процедура добавления стандартных значений типов продукции в базу данных.
procedure TAuthForm.SetTypesDefaultValues();
begin
  try
    DBMainModule.MainADOQuery.SQL.Clear;
    DBMainModule.MainADOQuery.SQL.Add('select count(*) as RowsCount from Types;');
    DBMainModule.MainADOQuery.Active := false;
    DBMainModule.MainADOQuery.Active := true;

    if(DBMainModule.MainADOQuery.FieldByName('RowsCount').Value < 2) then
    begin
      DBMainModule.MainADOQuery.SQL.Clear;
      DBMainModule.MainADOQuery.SQL.Add('delete from types');

      DBMainModule.MainADOQuery.SQL.Clear;
      DBMainModule.MainADOQuery.SQL.Add('insert into types values(1, ''Apple''), (2, ''Pear'');');
      DBMainModule.MainADOQuery.ExecSQL;
    end;
  except on ex : Exception do
    MessageDlg(ex.Message, mtError, [mbOk], 0);
  end;
end;

procedure TAuthForm.btnSignInClick(Sender: TObject);
begin
  var login, password : string;

  login := trim(edtLogin.Text);
  password := trim(edtPassword.Text);

  if(login = '') then MessageDlg('Check your Login!', mtError, [mbOK], 0)
  else if(password = '') then MessageDlg('Check your Password!', mtError, [mbOK], 0)
  else if(length(password) < 10) then MessageDlg('The minimum password length is 10 characters!', mtError, [mbOK], 0)
  else
  begin
    try
      password := THashSHA2.GetHashString(password, THashSHA2.TSHA2Version.SHA256);

      DBMainModule.MainADOQuery.Active := false;
      DBMainModule.MainADOQuery.SQL.Clear;
      DBMainModule.MainADOQuery.SQL.Add('select count(*), UserID, Type, Fio from users where binary Login = :login and binary Password = :password;');
      DBMainModule.MainADOQuery.Parameters.ParamByName('login').Value := login;
      DBMainModule.MainADOQuery.Parameters.ParamByName('password').Value := password;
      DBMainModule.MainADOQuery.Active := true;

      if(DBMainModule.MainADOQuery.Fields[0].AsString = '0') then MessageDlg('Wrong login or password!', mtError, [mbOK], 0)
      else if(DBMainModule.MainADOQuery.Fields[2].AsString = 'Supplier') then
      begin
        SupplierMainForm := TSupplierMainForm.Create(Self);
        SupplierMainForm.UserID := DBMainModule.MainADOQuery.Fields[1].AsInteger;
        SupplierMainForm.FIO := DBMainModule.MainADOQuery.Fields[3].AsString;

        Hide();
        SupplierMainForm.ShowModal();
        Show();
      end
      else
      begin
        ClientMainForm := TClientMainForm.Create(Self);
        ClientMainForm.UserID := DBMainModule.MainADOQuery.Fields[1].AsInteger;
        ClientMainForm.FIO := DBMainModule.MainADOQuery.Fields[3].AsString;

        Hide();
        ClientMainForm.ShowModal();
        Show();
      end;
    except on ex : Exception do
      MessageDlg(ex.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TAuthForm.FormShow(Sender: TObject);
begin
  SetTypesDefaultValues();
end;

procedure TAuthForm.lblRegistrationClick(Sender: TObject);
begin
  RegForm := TRegForm.Create(Self);

  Hide();
  RegForm.ShowModal();
  Show();
end;

end.
