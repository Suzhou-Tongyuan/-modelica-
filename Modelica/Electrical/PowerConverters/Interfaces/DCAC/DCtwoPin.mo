within Modelica.Electrical.PowerConverters.Interfaces.DCAC;
partial model DCtwoPin "正负直流引脚"

  Modelica.Electrical.Analog.Interfaces.PositivePin dc_p 
    "正直流输入" 
    annotation (Placement(transformation(extent={{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin dc_n 
    "负直流输入" 
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  SI.Voltage vDC=dc_p.v - dc_n.v "直流电压";
  SI.Current iDC=dc_p.i "直流电流";
  SI.Power powerDC=vDC*iDC "直流功率";
  annotation();
end DCtwoPin;