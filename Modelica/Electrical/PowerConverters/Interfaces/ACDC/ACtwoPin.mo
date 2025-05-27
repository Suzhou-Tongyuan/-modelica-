within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model ACtwoPin "正负交流引脚"

  Modelica.Electrical.Analog.Interfaces.PositivePin ac_p 
    "正交流输入" 
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin ac_n 
    "负交流输入" 
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  SI.Voltage vAC=ac_p.v - ac_n.v "交流电压";
  SI.Current iAC=ac_p.i "交流电流";
  SI.Power powerAC=vAC*iAC "交流功率";
  annotation();
end ACtwoPin;