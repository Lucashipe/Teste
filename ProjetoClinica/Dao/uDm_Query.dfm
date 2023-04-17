object DmQuery: TDmQuery
  OldCreateOrder = False
  Height = 150
  Width = 215
  object Query: TFDQuery
    Connection = DataModule1.FDConnection1
    Left = 24
    Top = 16
  end
  object Consulta: TFDQuery
    Active = True
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      
        'Select * From consultas left join pacientes on paciente_id = id_' +
        'pct left join pessoa_fisica on pacientes.pf_id = id_pf left join' +
        ' funcionarios on medico_id = id_funcionario left join pessoa_fis' +
        'ica pessoa_fisica2 on funcionarios.pf_id = pessoa_fisica2.id_pf')
    Left = 96
    Top = 16
  end
  object Paciente_Ds: TFDQuery
    Active = True
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      'Select * from pacientes left join pessoa_fisica on id_pf = pf_id')
    Left = 160
    Top = 24
  end
end
