unit U_Index;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Menus, Vcl.WinXCalendars, Vcl.ComCtrls,
  Vcl.WinXPickers, U_Cadastros, Vcl.WinXCtrls, Vcl.Imaging.jpeg, Vcl.Mask,
  U_CadastroFuncionario, uDm_Query, Vcl.Themes, U_Checkin;

type

  TFormIndex = class(TForm)
    Panel2: TPanel;
    pnl_Container: TPanel;
    PNewPaciente: TPanel;
    PCad: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    PPicPerfil: TPanel;
    Image2: TImage;
    lb_funcionario: TLabel;
    Label1: TLabel;
    Panel5: TPanel;
    Panel11: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    pnl_body: TPanel;
    ToggleSwitch1: TToggleSwitch;
    Image3: TImage;
    edt_CpfPaciente: TMaskEdit;
    lb_Cpf: TLabel;
    Image1: TImage;
    pnl_Toast: TPanel;
    btn_OpenCad: TButton;
    lb_toast: TLabel;
    Btn_CloseToast: TButton;
    Panel16: TPanel;
    CalendarView1: TCalendarView;
    iconHome: TImage;
    procedure PNewPacienteMouseEnter(Sender: TObject);
    procedure PNewPacienteMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel5MouseEnter(Sender: TObject);
    procedure Panel10MouseEnter(Sender: TObject);
    procedure Panel10MouseLeave(Sender: TObject);
    procedure PCadMouseEnter(Sender: TObject);
    procedure PCadMouseLeave(Sender: TObject);
    procedure Panel6MouseEnter(Sender: TObject);
    procedure Panel6MouseLeave(Sender: TObject);
    procedure Panel12MouseEnter(Sender: TObject);
    procedure Panel12MouseLeave(Sender: TObject);
    procedure Panel7MouseLeave(Sender: TObject);
    procedure Panel7MouseEnter(Sender: TObject);
    procedure Panel13MouseEnter(Sender: TObject);
    procedure Panel13MouseLeave(Sender: TObject);
    procedure Panel8MouseLeave(Sender: TObject);
    procedure Panel8MouseEnter(Sender: TObject);
    procedure Panel14MouseEnter(Sender: TObject);
    procedure Panel14MouseLeave(Sender: TObject);
    procedure Panel9MouseEnter(Sender: TObject);
    procedure Panel9MouseLeave(Sender: TObject);
    procedure Panel15MouseEnter(Sender: TObject);
    procedure Panel15MouseLeave(Sender: TObject);
    procedure CalendarView1Change(Sender: TObject);
    procedure PCadClick(Sender: TObject);
    procedure ToggleSwitch1Click(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
    procedure PNewPacienteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel9Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure edt_CpfPacienteChange(Sender: TObject);
    procedure Btn_CloseToastClick(Sender: TObject);
    procedure btn_OpenCadClick(Sender: TObject);
  private
    procedure CloseAllForms;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormIndex: TFormIndex;
  PfCpf: string;

implementation

{$R *.dfm}

uses U_Login, U_Agendamentos, uDm_Login;

procedure DrawControl(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 10, 10);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -4, -4);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;
end;

procedure DrawControl2(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 100, 100);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -4, -4);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;
end;

procedure TFormIndex.Btn_CloseToastClick(Sender: TObject);
begin
  pnl_Toast.Visible := false;
  edt_CpfPaciente.Clear;
end;

procedure TFormIndex.btn_OpenCadClick(Sender: TObject);
begin
  FormCadFuncinarios.SendCpf := edt_CpfPaciente.Text;
  FormCadFuncinarios.tb_Endereco.TabVisible := True;
  FormCadFuncinarios.tb_InfBasicas.TabVisible := True;
  FormCadFuncinarios.btn_Paciente.Visible := True;
  FormCadFuncinarios.ShowModal;

  pnl_Toast.Visible := false;
end;

procedure TFormIndex.CalendarView1Change(Sender: TObject);
var
  CalendarDate: TDate;
  DateToday: TDate;
begin
  DateToday := Date;
  CalendarDate := CalendarView1.Date;
  if CalendarDate < DateToday then
  begin
    FormAgendamentos := TFormAgendamentos.Create(self);
    FormAgendamentos.pnl_MarcarConsulta.Visible := false;
    FormAgendamentos.db_Consulta.Align := alclient;
    FormAgendamentos.Parent := pnl_Container;
    FormAgendamentos.Align := alclient;
    FormAgendamentos.BorderStyle := bsNone;
    FormAgendamentos.DataSelecionada := CalendarDate;
    FormAgendamentos.Show;
  end
  else
  begin
    FormAgendamentos := TFormAgendamentos.Create(self);
    FormAgendamentos.Parent := pnl_Container;
    FormAgendamentos.Align := alclient;
    FormAgendamentos.BorderStyle := bsNone;
    FormAgendamentos.DataSelecionada := CalendarDate;
    DmQuery.especialidades.SQL.Clear;
    DmQuery.especialidades.SQL.Add('select * from especialidades');
    DmQuery.especialidades.Open;
    FormAgendamentos.Show;
  end;

end;

procedure TFormIndex.FormCreate(Sender: TObject);
begin
  PNewPaciente.BorderStyle := bsNone;
  DrawControl(PNewPaciente);
  PCad.BorderStyle := bsNone;
  DrawControl(PCad);
  Panel6.BorderStyle := bsNone;
  DrawControl(Panel6);
  Panel7.BorderStyle := bsNone;
  DrawControl(Panel7);
  Panel8.BorderStyle := bsNone;
  DrawControl(Panel8);
  Panel9.BorderStyle := bsNone;
  DrawControl(Panel9);
  PPicPerfil.BorderStyle := bsNone;
  DrawControl2(PPicPerfil);

end;

procedure TFormIndex.FormShow(Sender: TObject);
begin
  lb_funcionario.caption := DmLogin.FDQuery1.FieldByName('nome').AsString;
end;

procedure TFormIndex.Image1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormIndex.Panel10MouseEnter(Sender: TObject);
begin
  Panel10.Color := $00777724;
end;

procedure TFormIndex.Panel10MouseLeave(Sender: TObject);
begin
  Panel10.Color := clGray;
end;

procedure TFormIndex.Panel12MouseEnter(Sender: TObject);
begin
  Panel12.Color := $00777724;
end;

procedure TFormIndex.Panel12MouseLeave(Sender: TObject);
begin
  Panel12.Color := clGray;
end;

procedure TFormIndex.Panel13MouseEnter(Sender: TObject);
begin
  Panel13.Color := $00777724;
end;

procedure TFormIndex.Panel13MouseLeave(Sender: TObject);
begin
  Panel13.Color := clGray;
end;

procedure TFormIndex.Panel14MouseEnter(Sender: TObject);
begin
  Panel14.Color := $00777724;
end;

procedure TFormIndex.Panel14MouseLeave(Sender: TObject);
begin
  Panel14.Color := clGray;
end;

procedure TFormIndex.Panel15MouseEnter(Sender: TObject);
begin
  Panel15.Color := $00777724;
end;

procedure TFormIndex.Panel15MouseLeave(Sender: TObject);
begin
  Panel15.Color := clGray;
end;

procedure TFormIndex.Panel5Click(Sender: TObject);
begin
  CloseAllForms;
end;

procedure TFormIndex.Panel5MouseEnter(Sender: TObject);
begin
  Panel5.Color := $00777724;
end;

procedure TFormIndex.Panel6MouseEnter(Sender: TObject);
begin
  Panel12.Color := $00777724;
end;

procedure TFormIndex.Panel6MouseLeave(Sender: TObject);
begin
  Panel12.Color := clGray;
end;

procedure TFormIndex.Panel7MouseEnter(Sender: TObject);
begin
  Panel13.Color := $00777724;
end;

procedure TFormIndex.Panel7MouseLeave(Sender: TObject);
begin
  Panel13.Color := clGray;
end;

procedure TFormIndex.Panel8MouseEnter(Sender: TObject);
begin
  Panel14.Color := $00777724;
end;

procedure TFormIndex.Panel8MouseLeave(Sender: TObject);
begin
  Panel14.Color := clGray;
end;

procedure TFormIndex.Panel9Click(Sender: TObject);
begin
  CloseAllForms;
  U_Login.FormLogin.Height := 768;
  U_Login.FormLogin.Width := 1366;
  U_Login.FormLogin.Edt_Username.Clear;
  U_Login.FormLogin.Edt_Password.Clear;

  close;
end;

procedure TFormIndex.Panel9MouseEnter(Sender: TObject);
begin
  Panel15.Color := $00777724;
end;

procedure TFormIndex.Panel9MouseLeave(Sender: TObject);
begin
  Panel15.Color := clGray;
end;

procedure TFormIndex.CloseAllForms;
var
  i: integer;
begin
  for i := 0 to pnl_Container.ControlCount - 1 do
  begin
    if pnl_Container.Controls[i] is TForm then
    begin
      TForm(pnl_Container.Controls[i]).close;
    end;

  end;
end;

procedure TFormIndex.edt_CpfPacienteChange(Sender: TObject);
var
  nome, sobrenome: string;
begin
  if Length(edt_CpfPaciente.Text) = 11 then
  begin
    PfCpf := edt_CpfPaciente.Text;
    DmQuery.Query.SQL.Clear;
    DmQuery.Query.Params.Clear;
    DmQuery.Query.SQL.Add
      ('SELECT * FROM pessoa_fisica left join pacientes on pf_id = id_pf WHERE cpf = :cpf');
    DmQuery.Query.ParamByName('cpf').AsString := PfCpf;
    DmQuery.Query.Open;
    if not DmQuery.Query.IsEmpty then
    begin
      DmQuery.Query2.SQL.Clear;
      DmQuery.Query2.SQL.Add
        ('SELECT * FROM consultas left join pacientes on paciente_id = id_pct left join pessoa_fisica on id_pf = pf_id');
      DmQuery.Query2.SQL.Add
        ('Left join medicos on id_medico = medico_id left join funcionarios on func_id = id_funcionario left join pessoa_fisica pessoa_fisica2 on funcionarios.pf_id = pessoa_fisica2.id_pf WHERE paciente_id = :id and consultas.status = ''ativa''');
      DmQuery.Query2.ParamByName('id').asinteger :=
        DmQuery.Query.FieldByName('id_pct').asinteger;
      DmQuery.Query2.Open;
      if not DmQuery.Query2.IsEmpty then
      begin
        nome := DmQuery.Query2.FieldByName('nome').AsString;
        sobrenome := DmQuery.Query2.FieldByName('sobrenome').AsString;
        FormCheckin.pnl_headerCheckin.caption :=
          'Consultas agendadas para o paciente: ' + nome + ' ' + sobrenome;
        FormCheckin.ShowModal;
      end;
    end
    else
    begin
      pnl_Toast.Visible := True;
    end;
  end;
end;

procedure TFormIndex.PCadClick(Sender: TObject);
begin
  CloseAllForms;
  FormCadastros := TFormCadastros.Create(self);
  FormCadastros.Parent := pnl_Container;
  FormCadastros.Align := alclient;
  FormCadastros.BorderStyle := bsNone;
  FormCadastros.Show;
end;

procedure TFormIndex.PCadMouseEnter(Sender: TObject);
begin
  Panel10.Color := $00777724;
end;

procedure TFormIndex.PCadMouseLeave(Sender: TObject);
begin
  Panel10.Color := clGray;
end;

procedure TFormIndex.PNewPacienteClick(Sender: TObject);
begin
  CloseAllForms;
end;

procedure TFormIndex.PNewPacienteMouseEnter(Sender: TObject);
begin
  Panel5.Color := $00777724;
end;

procedure TFormIndex.PNewPacienteMouseLeave(Sender: TObject);
begin
  Panel5.Color := clGray;
end;

procedure TFormIndex.ToggleSwitch1Click(Sender: TObject);
begin
  if ToggleSwitch1.State = tssOn then
  begin
    TStyleManager.TrySetStyle('Carbon');
  end
  else
  begin
    TStyleManager.TrySetStyle('Windows');
  end;
end;

end.
