within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model DCpin "单个直流引脚"

  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p 
    "正直流输出" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  SI.Voltage vDC=dc_p.v "直流电势";
  SI.Current iDC=dc_p.i "直流电流";
  SI.Power powerDC=vDC*iDC "直流功率";
  annotation();
end DCpin;