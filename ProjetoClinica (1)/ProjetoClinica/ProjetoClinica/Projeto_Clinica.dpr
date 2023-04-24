program Projeto_Clinica;
uses
  Vcl.Forms,
  U_Index in 'View\U_Index.pas' {Form1},
  U_Agendamentos in 'Movimentos\U_Agendamentos.pas' {FormAgendamentos},
  U_Cadastros in 'View\U_Cadastros.pas' {FormCadastros},
  U_Login in 'View\U_Login.pas' {FormLogin},
  U_CadastroFuncionario in 'View\U_CadastroFuncionario.pas' {FormCadFuncinarios},
  U_UsuarioModel in 'Model\U_UsuarioModel.pas',
  U_UsuarioController in 'Controller\U_UsuarioController.pas',
  uDm_Conn in 'Dao\uDm_Conn.pas' {DataModule1: TDataModule},
  uDm_Login in 'Dao\uDm_Login.pas' {DmLogin: TDataModule},
  U_IndexMedico in 'View\U_IndexMedico.pas' {FormMedico},
  uDm_Funcionarios in 'Dao\uDm_Funcionarios.pas' {DmFuncionarios: TDataModule},
  U_UpdateFuncionario in 'View\U_UpdateFuncionario.pas' {FormUpdateFunc},
  uDm_Query in 'Dao\uDm_Query.pas' {DmQuery: TDataModule},
  U_Noti in 'Notificacoes\U_Noti.pas' {FormNoti},
  Vcl.Themes,
  Vcl.Styles,
  U_Checkin in 'Movimentos\U_Checkin.pas' {FormCheckin};

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormIndex, FormIndex);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormIndex, FormIndex);
  Application.CreateForm(TFormCadFuncinarios, FormCadFuncinarios);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TDmLogin, DmLogin);
  Application.CreateForm(TFormMedico, FormMedico);
  Application.CreateForm(TDmFuncionarios, DmFuncionarios);
  Application.CreateForm(TFormUpdateFunc, FormUpdateFunc);
  Application.CreateForm(TDmQuery, DmQuery);
  Application.CreateForm(TFormNoti, FormNoti);
  Application.CreateForm(TFormCheckin, FormCheckin);
  Application.Run;

end.
