within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model ACplug "交流多相插头"
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m) 
    "交流输入" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  SI.Voltage vAC[m]=ac.pin[:].v "交流电位";
  SI.Current iAC[m]=ac.pin[:].i "交流电流";
  SI.Power powerAC[m]=vAC.*iAC "交流功率";
  SI.Power powerTotalAC=sum(powerAC) "交流总功率";
  annotation();
end ACplug;