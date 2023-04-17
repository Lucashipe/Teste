unit U_UpdateFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDm_Query, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, uDm_Funcionarios, U_Noti;

type
  TFormUpdateFunc = class(TForm)
    pnl_Footer: TPanel;
    edt_Login: TLabeledEdit;
    edt_Cargo: TLabeledEdit;
    edt_Senha: TLabeledEdit;
    pnl_Mid: TPanel;
    edt_Cep: TLabeledEdit;
    edt_NResidencia: TLabeledEdit;
    edt_Complementos: TLabeledEdit;
    edt_Telefone: TLabeledEdit;
    edt_Celular: TLabeledEdit;
    pnl_Top: TPanel;
    edt_Nome: TLabeledEdit;
    edt_Sobrenome: TLabeledEdit;
    edt_Cpf: TLabeledEdit;
    edt_Rg: TLabeledEdit;
    edt_Sexo: TLabeledEdit;
    edt_DtNasc: TLabeledEdit;
    Image1: TImage;
    lb_Tittle: TLabel;
    lb_Basics: TLabel;
    lb_Mid: TLabel;
    lb_Footer: TLabel;
    Btn_Editar: TPanel;
    btn_SavePaciente: TPanel;
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Btn_EditarClick(Sender: TObject);
    procedure btn_SavePacienteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Id_FuncRecebido: integer;
    NomeRecebido: string;
    SobrenomeRecebido: string;
    CepRecebido: string;
    CpfRecebido: string;
    RgRecebido: string;
    DataNascRecebido: TDate;
    SexoRecebido: string;
    NResideciaRecebido: string;
    TelefoneRecebido: string;
    CelularRecebido: string;
    ComplementoRecebido: string;
    LoginRecebido: string;
    SenhaRecebido: string;
    CargoRecebido: string;
    StatusRecebido: string;

    Id_Paciente : integer;
  end;

var
  FormUpdateFunc: TFormUpdateFunc;

implementation

{$R *.dfm}

procedure TFormUpdateFunc.btn_SavePacienteClick(Sender: TObject);
begin
  DmQuery.Query.SQL.Clear;
  DmQuery.Query.SQL.Add
    ('Update pessoa_fisica set nome = :nome, sobrenome = :sobrenome, cep = :cep, cpf = :cpf, rg = :rg, dt_nasc = :DtNasc, sexo = :sexo, numero_residencia = :NResidencia, telefone = :telefone, celular = :celular, complementos = :complementos Where id_pf = :id');
  DmQuery.Query.ParamByName('nome').AsString := edt_Nome.Text;
  DmQuery.Query.ParamByName('sobrenome').AsString := edt_Sobrenome.Text;
  DmQuery.Query.ParamByName('cep').AsString := edt_Cep.Text;
  DmQuery.Query.ParamByName('rg').AsString := edt_Rg.Text;
  DmQuery.Query.ParamByName('DtNasc').AsDate := strtodate(edt_DtNasc.Text);
  DmQuery.Query.ParamByName('cpf').AsString := edt_Cpf.Text;
  DmQuery.Query.ParamByName('sexo').AsString := edt_Sexo.Text;
  DmQuery.Query.ParamByName('NResidencia').AsString := edt_NResidencia.Text;
  DmQuery.Query.ParamByName('telefone').AsString := edt_Telefone.Text;
  DmQuery.Query.ParamByName('celular').AsString := edt_Celular.Text;
  DmQuery.Query.ParamByName('complementos').AsString := edt_Complementos.Text;
  DmQuery.Query.ParamByName('id').AsInteger := Id_Paciente;
  DmQuery.Query.ExecSQL;
  DmQuery.Paciente_Ds.Refresh;
  DmQuery.Query.SQL.Clear;

  self.Close;
  FormNoti.Show;
  FormNoti.lb_noti.Caption := 'Cadastro atualizado com sucesso!';
  FormNoti.Timer1.Enabled := true;
  FormNoti.btn_Sim.Visible := false;
  FormNoti.btn_n.Visible := false;
end;

procedure TFormUpdateFunc.FormShow(Sender: TObject);
begin
  edt_Nome.SetFocus;
  edt_Nome.Text := NomeRecebido;
  edt_Sobrenome.Text := SobrenomeRecebido;
  edt_Cep.Text := CepRecebido;
  edt_Cpf.Text := CpfRecebido;
  edt_Rg.Text := RgRecebido;
  edt_DtNasc.Text := DateToStr(DataNascRecebido);
  edt_Sexo.Text := SexoRecebido;
  edt_NResidencia.Text := NResideciaRecebido;
  edt_Telefone.Text := TelefoneRecebido;
  edt_Celular.Text := CelularRecebido;
  edt_Complementos.Text := ComplementoRecebido;
  edt_Login.Text := LoginRecebido;
  edt_Senha.Text := SenhaRecebido;
  edt_Cargo.Text := CargoRecebido;

end;

procedure TFormUpdateFunc.Btn_EditarClick(Sender: TObject);
begin
  DmQuery.Query.SQL.Clear;
  DmQuery.Query.SQL.Add
    ('Update pessoa_fisica set nome = :nome, sobrenome = :sobrenome, cep = :cep, cpf = :cpf, rg = :rg, dt_nasc = :DtNasc, sexo = :sexo, numero_residencia = :NResidencia, telefone = :telefone, celular = :celular, complementos = :complementos Where id_pf = :id');
  DmQuery.Query.ParamByName('nome').AsString := edt_Nome.Text;
  DmQuery.Query.ParamByName('sobrenome').AsString := edt_Sobrenome.Text;
  DmQuery.Query.ParamByName('cep').AsString := edt_Cep.Text;
  DmQuery.Query.ParamByName('rg').AsString := edt_Rg.Text;
  DmQuery.Query.ParamByName('DtNasc').AsDate := strtodate(edt_DtNasc.Text);
  DmQuery.Query.ParamByName('cpf').AsString := edt_Cpf.Text;
  DmQuery.Query.ParamByName('sexo').AsString := edt_Sexo.Text;
  DmQuery.Query.ParamByName('NResidencia').AsString := edt_NResidencia.Text;
  DmQuery.Query.ParamByName('telefone').AsString := edt_Telefone.Text;
  DmQuery.Query.ParamByName('celular').AsString := edt_Celular.Text;
  DmQuery.Query.ParamByName('complementos').AsString := edt_Complementos.Text;
  DmQuery.Query.ParamByName('id').AsInteger := Id_FuncRecebido;
  DmQuery.Query.ExecSQL;
  DmFuncionarios.FDQuery1.Refresh;
  DmQuery.Query.SQL.Clear;

  self.Close;
  FormNoti.Show;
  FormNoti.lb_noti.Caption := 'Cadastro atualizado com sucesso!';
  FormNoti.Timer1.Enabled := true;
  FormNoti.btn_Sim.Visible := false;
  FormNoti.btn_n.Visible := false;
end;

procedure TFormUpdateFunc.Image1Click(Sender: TObject);
begin
  self.Close;
end;

end.
