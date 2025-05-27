within Modelica.Electrical.PowerConverters.Interfaces.DCAC;
partial model ACpin "单个交流引脚"

  Modelica.Electrical.Analog.Interfaces.PositivePin ac "交流输出" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  SI.Voltage vAC=ac.v "交流电势";
  SI.Current iAC=ac.i "交流电流";
  SI.Power powerAC=vAC*iAC "交流功率";
  annotation();
end ACpin;