unit U_Cadastros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, U_CadastroFuncionario, uDm_Funcionarios,
  U_UpdateFuncionario, Vcl.Imaging.pngimage, uDm_Query, U_Noti;

type
  TDbGridPadrao = class(TCustomGrid);

  TFormCadastros = class(TForm)
    Pg_Cadastros: TPageControl;
    Pg_CadFunc: TTabSheet;
    tb_Pacientes: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Pnl_Bottom: TPanel;
    Pnl_Header: TPanel;
    edt_Pesq: TLabeledEdit;
    Btn_Pesq: TPanel;
    DBGrid1: TDBGrid;
    DsPesq: TDataSource;
    Btn_NovoFuncionario: TPanel;
    Btn_Editar: TPanel;
    Btn_Deletar: TPanel;
    Image1: TImage;
    pnl_HeaderPacientes: TPanel;
    edt_PesqPacientes: TLabeledEdit;
    btn_PesqPacientes: TPanel;
    btn_NovoPaciente: TPanel;
    Panel1: TPanel;
    btn_EditarPacientes: TPanel;
    btn_DesativarPacientes: TPanel;
    db_Pacientes: TDBGrid;
    ds_Paciente: TDataSource;
    btn_Reativar: TPanel;
    Panel7: TPanel;
    Label1: TLabel;
    btn_AtivarPaciente: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Btn_NovoFuncionarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_EditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Image1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure db_PacientesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btn_PesqPacientesClick(Sender: TObject);
    procedure Btn_PesqClick(Sender: TObject);
    procedure Btn_DeletarClick(Sender: TObject);
    procedure btn_ReativarClick(Sender: TObject);
    procedure btn_NovoPacienteClick(Sender: TObject);
    procedure btn_EditarPacientesClick(Sender: TObject);
    procedure db_PacientesCellClick(Column: TColumn);
    procedure btn_DesativarPacientesClick(Sender: TObject);
    procedure btn_AtivarPacienteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastros: TFormCadastros;
  id_funcionario: Integer;
  Nome: string;
  Sobrenome: string;
  Cep: string;
  Rg: string;
  DataNasc: TDate;
  Sexo: string;
  NResidencia: string;
  Telefone: string;
  Celular: string;
  Complemento: string;
  Login: string;
  Senha: string;
  Cargo: string;
  Status: string;
  StatusPaciente: string;

  id_paciente: Integer;

implementation

{$R *.dfm}

procedure TFormCadastros.btn_PesqPacientesClick(Sender: TObject);
begin
  DmQuery.Paciente_Ds.SQL.Clear;
  DmQuery.Paciente_Ds.SQL.add
    ('select * from pacientes left join pessoa_fisica on pf_id = id_pf where nome like :pesq');
  DmQuery.Paciente_Ds.ParamByName('pesq').AsString :=
    '%' + edt_PesqPacientes.Text + '%';
  DmQuery.Paciente_Ds.Open;
  TDbGridPadrao(DBGrid1).ClientHeight :=
    (30 * TDbGridPadrao(db_Pacientes).RowCount) + 30;
  TDbGridPadrao(db_Pacientes).ScrollBars := ssVertical;
  TDbGridPadrao(db_Pacientes).DefaultRowHeight := 30;
  TDbGridPadrao(db_Pacientes).ClientHeight :=
    (30 * TDbGridPadrao(db_Pacientes).RowCount) + 30;
end;

procedure TFormCadastros.DBGrid1CellClick(Column: TColumn);
begin
  id_funcionario := DmFuncionarios.FDQuery1.FieldByName('pf_id').AsInteger;
  Nome := DmFuncionarios.FDQuery1.FieldByName('nome').AsString;
  Sobrenome := DmFuncionarios.FDQuery1.FieldByName('Sobrenome').AsString;
  Cep := DmFuncionarios.FDQuery1.FieldByName('cep').AsString;
  Rg := DmFuncionarios.FDQuery1.FieldByName('rg').AsString;
  Cpf := DmFuncionarios.FDQuery1.FieldByName('Cpf').AsString;
  DataNasc := DmFuncionarios.FDQuery1.FieldByName('dt_nasc').AsDateTime;
  Sexo := DmFuncionarios.FDQuery1.FieldByName('sexo').AsString;
  NResidencia := DmFuncionarios.FDQuery1.FieldByName
    ('numero_residencia').AsString;
  Telefone := DmFuncionarios.FDQuery1.FieldByName('telefone').AsString;
  Celular := DmFuncionarios.FDQuery1.FieldByName('celular').AsString;
  Complemento := DmFuncionarios.FDQuery1.FieldByName('complementos').AsString;
  Login := DmFuncionarios.FDQuery1.FieldByName('login').AsString;
  Senha := DmFuncionarios.FDQuery1.FieldByName('senha').AsString;
  Cargo := DmFuncionarios.FDQuery1.FieldByName('cargo').AsString;
  Status := DmFuncionarios.FDQuery1.FieldByName('status').AsString;
  if Status = 'inativo' then
  begin
    btn_Reativar.Visible := true;
    Btn_Deletar.Visible := false;
  end
  else
  begin
    btn_Reativar.Visible := false;
    Btn_Deletar.Visible := true;
  end;
end;

procedure TFormCadastros.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if DBGrid1.DataSource.DataSet.FieldByName('status').AsString = 'inativo' then
  begin
    DBGrid1.Canvas.Brush.Color := clred; // cinza escuro
  end
  else if Odd(DBGrid1.DataSource.DataSet.RecNo) then
  begin
    DBGrid1.Canvas.Brush.Color := clsilver;
  end
  else
  begin
    DBGrid1.Canvas.Brush.Color := clwhite;
  end;

  if (gdSelected in State) then
  begin
    DBGrid1.Canvas.Brush.Color := $00BA2F00;
    DBGrid1.Canvas.Font.Color := clwhite;
  end;

  DBGrid1.Canvas.FillRect(Rect);
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  DBGrid1.Canvas.TextRect(Rect, Rect.Left + 3, Rect.Top + 8,
    Column.Field.DisplayText);
end;

procedure TFormCadastros.db_PacientesCellClick(Column: TColumn);
begin
  id_paciente := DmQuery.Paciente_Ds.FieldByName('pf_id').AsInteger;
  Nome := DmQuery.Paciente_Ds.FieldByName('nome').AsString;
  Sobrenome := DmQuery.Paciente_Ds.FieldByName('Sobrenome').AsString;
  Cep := DmQuery.Paciente_Ds.FieldByName('cep').AsString;
  Rg := DmQuery.Paciente_Ds.FieldByName('rg').AsString;
  Cpf := DmQuery.Paciente_Ds.FieldByName('Cpf').AsString;
  DataNasc := DmQuery.Paciente_Ds.FieldByName('dt_nasc').AsDateTime;
  Sexo := DmQuery.Paciente_Ds.FieldByName('sexo').AsString;
  NResidencia := DmQuery.Paciente_Ds.FieldByName('numero_residencia').AsString;
  Telefone := DmQuery.Paciente_Ds.FieldByName('telefone').AsString;
  Celular := DmQuery.Paciente_Ds.FieldByName('celular').AsString;
  Complemento := DmQuery.Paciente_Ds.FieldByName('complementos').AsString;
  StatusPaciente := DmQuery.Paciente_Ds.FieldByName('status').AsString;

  if db_Pacientes.DataSource.DataSet.FieldByName('status').AsString = 'inativo'
  then
  begin
    btn_AtivarPaciente.Visible := true;
    btn_DesativarPacientes.Visible := false;
  end
  else
  begin
    btn_AtivarPaciente.Visible := false;
    btn_DesativarPacientes.Visible := true;
  end;
end;

procedure TFormCadastros.db_PacientesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if db_Pacientes.DataSource.DataSet.FieldByName('status').AsString = 'inativo'
  then
  begin
    db_Pacientes.Canvas.Brush.Color := clred; // cinza escuro
  end
  else if Odd(db_Pacientes.DataSource.DataSet.RecNo) then
  begin
    db_Pacientes.Canvas.Brush.Color := clsilver;
  end
  else
  begin
    db_Pacientes.Canvas.Brush.Color := clwhite;
  end;

  if (gdSelected in State) then
  begin
    db_Pacientes.Canvas.Brush.Color := $00BA2F00;
    db_Pacientes.Canvas.Font.Color := clwhite;
  end;

  db_Pacientes.Canvas.FillRect(Rect);
  db_Pacientes.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  db_Pacientes.Canvas.TextRect(Rect, Rect.Left + 3, Rect.Top + 8,
    Column.Field.DisplayText);
end;

procedure TFormCadastros.btn_AtivarPacienteClick(Sender: TObject);
begin
  DmFuncionarios.Update.SQL.Clear;
  DmFuncionarios.Update.SQL.add
    ('Update pessoa_fisica set status = ''ativo'' Where id_pf = :id');
  DmFuncionarios.Update.ParamByName('id').AsInteger := id_paciente;
  DmFuncionarios.Update.ExecSQL;
  DmQuery.Paciente_Ds.Refresh;
  FormNoti.lb_noti.Caption := 'Paciente ativado com sucesso!';
  FormNoti.btn_Sim.Visible := false;
  FormNoti.btn_n.Visible := false;
  FormNoti.Timer1.Enabled := true;
  FormNoti.ShowModal;
end;

procedure TFormCadastros.Btn_DeletarClick(Sender: TObject);
begin
  DmFuncionarios.Update.SQL.Clear;
  DmFuncionarios.Update.SQL.add
    ('Update pessoa_fisica set status = ''inativo'' Where id_pf = :id');
  DmFuncionarios.Update.ParamByName('id').AsInteger := id_funcionario;
  DmFuncionarios.Update.ExecSQL;
  DmFuncionarios.FDQuery1.Refresh;
  FormNoti.lb_noti.Caption := 'Funcionário desativado com sucesso!';
  FormNoti.btn_Sim.Visible := false;
  FormNoti.btn_n.Visible := false;
  FormNoti.Timer1.Enabled := true;
  FormNoti.ShowModal;

end;

procedure TFormCadastros.btn_DesativarPacientesClick(Sender: TObject);
begin
  DmFuncionarios.Update.SQL.Clear;
  DmFuncionarios.Update.SQL.add
    ('Update pessoa_fisica set status = ''inativo'' Where id_pf = :id');
  DmFuncionarios.Update.ParamByName('id').AsInteger := id_paciente;
  DmFuncionarios.Update.ExecSQL;
  DmQuery.Paciente_Ds.Refresh;
  FormNoti.lb_noti.Caption := 'Paciente desativado com sucesso!';
  FormNoti.btn_Sim.Visible := false;
  FormNoti.btn_n.Visible := false;
  FormNoti.Timer1.Enabled := true;
  FormNoti.ShowModal;

end;

procedure TFormCadastros.Btn_EditarClick(Sender: TObject);
begin
  FormUpdateFunc.btn_SavePaciente.Visible := false;

  FormUpdateFunc.id_FuncRecebido := id_funcionario;
  FormUpdateFunc.NomeRecebido := Nome;
  FormUpdateFunc.SobrenomeRecebido := Sobrenome;
  FormUpdateFunc.CepRecebido := Cep;
  FormUpdateFunc.CpfRecebido := Cpf;
  FormUpdateFunc.RgRecebido := Rg;
  FormUpdateFunc.DataNascRecebido := DataNasc;
  FormUpdateFunc.SexoRecebido := Sexo;
  FormUpdateFunc.RgRecebido := Rg;
  FormUpdateFunc.NResideciaRecebido := NResidencia;
  FormUpdateFunc.TelefoneRecebido := Telefone;
  FormUpdateFunc.CelularRecebido := Celular;
  FormUpdateFunc.ComplementoRecebido := Complemento;
  FormUpdateFunc.LoginRecebido := Login;
  FormUpdateFunc.SenhaRecebido := Senha;
  FormUpdateFunc.CargoRecebido := Cargo;

  if id_funcionario <> 0 then
  begin
    FormUpdateFunc.pnl_Footer.Visible := true;
    FormUpdateFunc.ShowModal;
  end
  else
  begin
    ShowMessage('Selecione um usuario');
  end;
end;

procedure TFormCadastros.btn_EditarPacientesClick(Sender: TObject);
begin

  FormUpdateFunc.btn_SavePaciente.Visible := true;

  FormUpdateFunc.id_paciente := id_paciente;
  FormUpdateFunc.NomeRecebido := Nome;
  FormUpdateFunc.SobrenomeRecebido := Sobrenome;
  FormUpdateFunc.CepRecebido := Cep;
  FormUpdateFunc.CpfRecebido := Cpf;
  FormUpdateFunc.RgRecebido := Rg;
  FormUpdateFunc.DataNascRecebido := DataNasc;
  FormUpdateFunc.SexoRecebido := Sexo;
  FormUpdateFunc.RgRecebido := Rg;
  FormUpdateFunc.NResideciaRecebido := NResidencia;
  FormUpdateFunc.TelefoneRecebido := Telefone;
  FormUpdateFunc.CelularRecebido := Celular;
  FormUpdateFunc.ComplementoRecebido := Complemento;
  FormUpdateFunc.LoginRecebido := Login;
  FormUpdateFunc.SenhaRecebido := Senha;
  FormUpdateFunc.CargoRecebido := Cargo;

  if id_paciente <> 0 then
  begin
    FormUpdateFunc.Btn_Editar.Visible := true;
    FormUpdateFunc.pnl_Footer.Visible := false;
    FormUpdateFunc.ShowModal;
  end
  else
  begin
    ShowMessage('Selecione um usuario');
  end;
end;

procedure TFormCadastros.Btn_NovoFuncionarioClick(Sender: TObject);
begin
  FormCadFuncinarios.tb_Func.TabVisible := true;

  FormCadFuncinarios.tb_InfBasicas.TabVisible := true;
  FormCadFuncinarios.tb_Endereco.TabVisible := true;
  FormCadFuncinarios.btn_Paciente.Visible := false;
  FormCadFuncinarios.ShowModal;

end;

procedure TFormCadastros.btn_NovoPacienteClick(Sender: TObject);
begin
  FormCadFuncinarios.tb_Endereco.TabVisible := true;
  FormCadFuncinarios.tb_InfBasicas.TabVisible := true;
  FormCadFuncinarios.btn_Paciente.Visible := true;
  FormCadFuncinarios.ShowModal;
end;

procedure TFormCadastros.Btn_PesqClick(Sender: TObject);
begin
  DmFuncionarios.FDQuery1.SQL.Clear;
  DmFuncionarios.FDQuery1.SQL.add
    ('select * from funcionarios left join pessoa_fisica on pf_id = id_pf where nome like :pesq');
  DmFuncionarios.FDQuery1.ParamByName('pesq').AsString :=
    '%' + edt_Pesq.Text + '%';
  DmFuncionarios.FDQuery1.Open;
  TDbGridPadrao(DBGrid1).ClientHeight :=
    (30 * TDbGridPadrao(DBGrid1).RowCount) + 30;
  TDbGridPadrao(DBGrid1).ScrollBars := ssVertical;
  TDbGridPadrao(DBGrid1).DefaultRowHeight := 30;
  TDbGridPadrao(DBGrid1).ClientHeight :=
    (30 * TDbGridPadrao(DBGrid1).RowCount) + 30;
end;

procedure TFormCadastros.btn_ReativarClick(Sender: TObject);
begin
  DmFuncionarios.Update.SQL.Clear;
  DmFuncionarios.Update.SQL.add
    ('Update pessoa_fisica set status = ''ativo'' Where id_pf = :id');
  DmFuncionarios.Update.ParamByName('id').AsInteger := id_funcionario;
  DmFuncionarios.Update.ExecSQL;
  DmFuncionarios.FDQuery1.Refresh;
  FormNoti.lb_noti.Caption := 'Funcionário ativado com sucesso!';
  FormNoti.btn_Sim.Visible := false;
  FormNoti.btn_n.Visible := false;
  FormNoti.Timer1.Enabled := true;
  FormNoti.ShowModal;

end;

procedure TFormCadastros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FormCadastros);
end;

procedure TFormCadastros.FormShow(Sender: TObject);
begin
  DmFuncionarios.FDQuery1.Open;
  TDbGridPadrao(DBGrid1).ScrollBars := ssVertical;
  TDbGridPadrao(DBGrid1).DefaultRowHeight := 30;
  TDbGridPadrao(DBGrid1).ClientHeight :=
    (30 * TDbGridPadrao(db_Pacientes).RowCount) + 30;
  TDbGridPadrao(db_Pacientes).ScrollBars := ssVertical;
  TDbGridPadrao(db_Pacientes).DefaultRowHeight := 30;
  TDbGridPadrao(db_Pacientes).ClientHeight :=
    (30 * TDbGridPadrao(db_Pacientes).RowCount) + 30;
end;

procedure TFormCadastros.Image1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
