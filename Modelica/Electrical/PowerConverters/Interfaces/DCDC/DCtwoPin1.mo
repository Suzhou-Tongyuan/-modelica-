within Modelica.Electrical.PowerConverters.Interfaces.DCDC;
partial model DCtwoPin1 "输入侧的正负极"
  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p1 
    "正向DC输入" 
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n1 
    "负向DC输入" 
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  SI.Voltage vDC1=dc_p1.v - dc_n1.v "1侧的DC电压";
  SI.Current iDC1=dc_p1.i "1侧的DC电流";
  SI.Power powerDC1=vDC1*iDC1 "1侧的DC功率";
  annotation();
end DCtwoPin1;