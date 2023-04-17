unit U_CadastroFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.UITypes, Vcl.Imaging.pngimage, Vcl.Mask, uDm_Query,
  Vcl.CheckLst, Vcl.WinXPickers, U_Noti, Vcl.StdCtrls;

type

  TFormCadFuncinarios = class(TForm)
    Pnl_Body: TPanel;
    Pnl_Header: TPanel;
    Label1: TLabel;
    Image2: TImage;
    pg_Cadastro: TPageControl;
    tb_InfBasicas: TTabSheet;
    Label2: TLabel;
    lb_rg: TLabel;
    edt_sobrenome: TLabeledEdit;
    edt_Nome: TLabeledEdit;
    edt_Cpf: TMaskEdit;
    dt_nasc: TDatePicker;
    rg_Sexo: TRadioGroup;
    edt_Rg: TMaskEdit;
    tb_Endereco: TTabSheet;
    lb_Cep: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edt_Cep: TMaskEdit;
    edt_numero: TLabeledEdit;
    edt_Complementos: TLabeledEdit;
    edt_Celular: TMaskEdit;
    edt_Telefone: TMaskEdit;
    tb_Func: TTabSheet;
    edt_Senha: TLabeledEdit;
    rg_Cargo: TRadioGroup;
    btn_enviar: TPanel;
    edt_Login: TLabeledEdit;
    btn_Paciente: TPanel;
    lb_dt: TLabel;
    lb_edit: TLabel;
    edt_Crm: TEdit;
    lb_crm: TLabel;
    procedure Image2Click(Sender: TObject);
    procedure btn_enviarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rg_CargoClick(Sender: TObject);
    procedure btn_PacienteClick(Sender: TObject);
    function ValidarCampos(Form: TForm): Boolean;
  private

    { Private declarations }
    procedure Insert;
  public
    SendCpf: string;
    TipoCad: Boolean;
    { Public declarations }
  end;

var
  FormCadFuncinarios: TFormCadFuncinarios;
  username: string;
  senha: string;
  cargo: string;
  cpf: string;
  sobrenome: string;
  rg: string;
  sexo: string;
  DtNasc: string;
  telefone: string;
  cep: string;
  NResidencia: string;
  complemento: string;
  celular: string;
  login: string;
  LastInsertID: integer;
  option: integer;
  item: integer;
  i: integer;

implementation

{$R *.dfm}

uses U_Index, U_Cadastros, uDm_Funcionarios;

procedure TFormCadFuncinarios.btn_enviarClick(Sender: TObject);
var
  senha, login: string;
  option: integer;
  camposValidos: Boolean;
begin
  senha := edt_Senha.Text;
  login := edt_Login.Text;
  option := rg_Cargo.ItemIndex;

  camposValidos := ValidarCampos(Self);
  if not camposValidos then
  begin
    Exit; // abortar a inser��o se a valida��o falhar
  end;

  Insert;

  DmQuery.Query.SQL.Add
    ('INSERT INTO funcionarios (pf_id, login, senha, cargo) VALUES (:pf_id, :login, :senha, :cargo)');
  DmQuery.Query.ParamByName('pf_id').AsInteger := LastInsertID;
  DmQuery.Query.ParamByName('login').AsString := login;
  DmQuery.Query.ParamByName('senha').AsString := senha;
  DmQuery.Query.ParamByName('cargo').AsInteger := option;
  DmQuery.Query.ExecSQL;
  DmQuery.Query.SQL.Clear;
  DmFuncionarios.FDQuery1.refresh;
  Self.close;
  FormNoti.Show;
  FormNoti.lb_noti.Caption := 'Funcion�rio inserido com sucesso!';
  FormNoti.Timer1.Enabled := true;
  FormNoti.btn_Sim.Hide;
  FormNoti.btn_n.Hide;
end;

procedure TFormCadFuncinarios.btn_PacienteClick(Sender: TObject);
begin
  if not ValidarCampos(Self) then
  begin
    Exit; // abortar a inser��o se a valida��o falhar
  end;
  Insert;

  DmQuery.Query.SQL.Add('INSERT INTO pacientes (pf_id) VALUES (:pf_id)');
  DmQuery.Query.ParamByName('pf_id').AsInteger := LastInsertID;
  DmQuery.Query.ExecSQL;
  DmQuery.Query.SQL.Clear;

  Self.close;
  FormNoti.Show;
end;

procedure TFormCadFuncinarios.FormShow(Sender: TObject);

begin
  edt_Cpf.Text := SendCpf;
end;

procedure TFormCadFuncinarios.Image2Click(Sender: TObject);
begin
  Self.close;
end;

procedure TFormCadFuncinarios.Insert;
begin

  username := edt_Nome.Text;
  sobrenome := edt_sobrenome.Text;
  cpf := edt_Cpf.Text;
  rg := edt_Rg.Text;
  telefone := edt_Telefone.Text;
  cep := edt_Cep.Text;
  NResidencia := edt_numero.Text;
  complemento := edt_Complementos.Text;
  celular := edt_Celular.Text;
  item := rg_Sexo.ItemIndex;
  sexo := rg_Sexo.Items[item];
  DtNasc := DateToStr(dt_nasc.Date, TFormatSettings.Create('pt-BR'));
  DmQuery.Query.SQL.Clear;
  if not ValidarCampos(Self) then
    Exit; // abortar a inser��o se a valida��o falhar
  DmQuery.Query.SQL.Add
    ('Insert into pessoa_fisica(nome, sobrenome, cpf, rg, sexo, dt_nasc, telefone, cep, numero_residencia, complementos, celular) VALUES (:nome, :sobrenome, :cpf, :rg, :sexo, :dt_nasc, :telefone, :cep, :numero_residencia, :complemento, :celular) RETURNING id_pf');
  DmQuery.Query.ParamByName('nome').AsString := username;
  DmQuery.Query.ParamByName('sobrenome').AsString := sobrenome;
  DmQuery.Query.ParamByName('cpf').AsString := cpf;
  DmQuery.Query.ParamByName('rg').AsString := rg;
  DmQuery.Query.ParamByName('sexo').AsString := sexo;
  DmQuery.Query.ParamByName('dt_nasc').AsDate := strtodate(DtNasc);
  DmQuery.Query.ParamByName('telefone').AsString := telefone;
  DmQuery.Query.ParamByName('cep').AsString := cep;
  DmQuery.Query.ParamByName('numero_residencia').AsString := NResidencia;
  DmQuery.Query.ParamByName('complemento').AsString := complemento;
  DmQuery.Query.ParamByName('celular').AsString := celular;
  DmQuery.Query.Open;

  LastInsertID := DmQuery.Query.FieldByName('id_pf').AsInteger;

  DmQuery.Query.SQL.Clear;
  U_Index.FormIndex.edt_CpfPaciente.Clear;

end;

procedure TFormCadFuncinarios.rg_CargoClick(Sender: TObject);
begin
  if rg_Cargo.ItemIndex = 0 then
  begin
    edt_Crm.Visible := true;
    lb_crm.Visible := true;
  end
  else
  begin
    edt_Crm.Visible := false;
    lb_crm.Visible := false;
  end;
end;

function TFormCadFuncinarios.ValidarCampos(Form: TForm): Boolean;
var
  i: integer;
begin

  for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TLabeledEdit then
    begin
      if (Form.Components[i] as TLabeledEdit).Text = '' then
      begin
        messageDlg('Prencha todos os campos corretamente!', mtInformation,
          [mbOK], 0);
        Result := false;
        abort;
      end
      else
        Result := true;
    end;
  end;
end;

end.
