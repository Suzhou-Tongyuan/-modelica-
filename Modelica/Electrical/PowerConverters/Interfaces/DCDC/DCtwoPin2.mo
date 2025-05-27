within Modelica.Electrical.PowerConverters.Interfaces.DCDC;
partial model DCtwoPin2 "输出侧的正负极"
  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p2 
    "正向DC输出" 
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n2 
    "负向DC输出" 
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  SI.Voltage vDC2=dc_p2.v - dc_n2.v "2侧的DC电压";
  SI.Current iDC2=dc_p2.i "2侧的DC电流";
  SI.Power powerDC2=vDC2*iDC2 "2侧的DC功率";
  annotation();
end DCtwoPin2;