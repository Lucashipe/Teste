unit U_Checkin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, uDm_Query, Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TDbGridPadrao = class(TCustomDBGrid);

  TFormCheckin = class(TForm)
    db_Checkin: TDBGrid;
    pnl_headerCheckin: TPanel;
    ds_Checkin: TDataSource;
    Image2: TImage;
    btn_Checkin: TPanel;
    btn_Cancelar: TPanel;
    pnl_Aviso: TPanel;
    Timer1: TTimer;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure db_CheckinCellClick(Column: TColumn);
    procedure btn_CheckinClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCheckin: TFormCheckin;
  id_consulta: integer;

implementation

{$R *.dfm}

procedure TFormCheckin.db_CheckinCellClick(Column: TColumn);
begin
  id_consulta := DmQuery.Query2.FieldByName('id_consulta').AsInteger;
end;

procedure TFormCheckin.btn_CheckinClick(Sender: TObject);
var
  horaAtual: Tdatetime;
begin
  DmQuery.Query.SQL.Clear;
  DmQuery.Query.SQL.Add('UPDATE consultas SET horario_chegada = :checkin WHERE id_consulta = :id');
  DmQuery.Query.ParamByName('id').AsInteger := id_consulta;
  horaAtual := Now;
  DmQuery.Query.ParamByName('checkin').asdatetime := horaAtual;
  Dmquery.Query.ExecSQL;
  Dmquery.Query2.Refresh;
  pnl_Aviso.Visible := true;
  Timer1.Enabled := true;
end;

procedure TFormCheckin.FormShow(Sender: TObject);
begin
  TDbGridPadrao(db_Checkin).ScrollBars := ssVertical;
end;

procedure TFormCheckin.Image1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormCheckin.Image2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormCheckin.Timer1Timer(Sender: TObject);
begin
  pnl_Aviso.Visible := false;
end;

end.
