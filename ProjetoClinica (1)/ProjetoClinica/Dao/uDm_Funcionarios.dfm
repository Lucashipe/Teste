object DmFuncionarios: TDmFuncionarios
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDQuery1: TFDQuery
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      
        'select * from funcionarios left join pessoa_fisica on pf_id = id' +
        '_pf')
    Left = 24
    Top = 24
  end
  object Update: TFDQuery
    Connection = DataModule1.FDConnection1
    Left = 88
    Top = 32
  end
  object cb_Especialidades: TFDQuery
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      'Select * from especialidades')
    Left = 160
    Top = 40
  end
  object ds_Medico: TFDQuery
    Active = True
    Connection = DataModule1.FDConnection1
    SQL.Strings = (
      
        'select * from consultas left join pacientes on id_pct = paciente' +
        '_id left join pessoa_fisica on pf_id = id_pf')
    Left = 16
    Top = 80
  end
end
