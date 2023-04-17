unit U_Agendamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VCLTee.TeCanvas,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uDm_Query;

type
  TDbGridPadrao = class(TCustomGrid);

  TFormAgendamentos = class(TForm)
    Header: TPanel;
    Image1: TImage;
    Body: TPanel;
    ListView1: TListView;
    pnl_Shadow: TPanel;
    db_Consulta2: TDBGrid;
    ds_Consulta: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormShow(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    DataSelecionada: Tdate;
  end;

var
  FormAgendamentos: TFormAgendamentos;

implementation

{$R *.dfm}

procedure TFormAgendamentos.BitBtn1Click(Sender: TObject);
begin
  FormAgendamentos.Close;
end;

procedure TFormAgendamentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(FormAgendamentos);
end;

procedure TFormAgendamentos.FormShow(Sender: TObject);
var
  Hour, Minute: Integer;
  ListItem: TListItem;
begin
  for Hour := 7 to 21 do
  begin
    Minute := 0;
    repeat
      ListItem := ListView1.Items.Add;
      ListItem.Caption := Format('%2.2d:%2.2d%s',
        [Hour, Minute, '', sLineBreak]);
      Minute := Minute + 15;
    until Minute > 45;
  end;
  DmQuery.Consulta.SQL.Clear;
  DmQuery.Consulta.SQL.Add
    ('Select * From consultas left join pacientes on paciente_id = id_pct left join pessoa_fisica on pacientes.pf_id = id_pf left join funcionarios on medico_id = id_funcionario');
  DmQuery.Consulta.SQL.Add
    ('left join pessoa_fisica pessoa_fisica2 on funcionarios.pf_id = pessoa_fisica2.id_pf where data_consulta = :date');
  DmQuery.Consulta.ParamByName('date').AsDate := DataSelecionada;
  DmQuery.Consulta.Open;

end;

procedure TFormAgendamentos.Image1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormAgendamentos.ListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  HorarioSelecionado: string;
begin
  if Selected then
  begin
    HorarioSelecionado := Item.Caption;
  end;
  DmQuery.Consulta.SQL.Clear;
  DmQuery.Consulta.SQL.Add
    ('Select * From consultas left join pacientes on paciente_id = id_pct left join pessoa_fisica on pacientes.pf_id = id_pf left join funcionarios on medico_id = id_funcionario');
  DmQuery.Consulta.SQL.Add
    (' left join pessoa_fisica pessoa_fisica2 on funcionarios.pf_id = pessoa_fisica2.id_pf  WHERE to_char(horario_consulta, ''HH24:MI'') = :horario and data_consulta = :date data_consulta = :date');
  DmQuery.Consulta.ParamByName('horario').Value := HorarioSelecionado;
  DmQuery.Consulta.ParamByName('date').AsDate := DataSelecionada;
  DmQuery.Consulta.Open;
end;

end.
