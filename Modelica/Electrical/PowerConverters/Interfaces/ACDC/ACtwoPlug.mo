within Modelica.Electrical.PowerConverters.Interfaces.ACDC;
partial model ACtwoPlug "两个交流多相插头"
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac_p(final m=m) 
    "正交流电位输入" 
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug ac_n(final m=m) 
    "负交流电位输入" 
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  SI.Voltage vAC[m]=ac_p.pin[:].v - ac_n.pin[:].v "交流电压";
  SI.Current iAC[m]=ac_p.pin[:].i "交流电流";
  SI.Power powerAC[m]=vAC.*iAC "交流功率";
  SI.Power powerTotalAC=sum(powerAC) "交流总功率";
  annotation();
end ACtwoPlug;