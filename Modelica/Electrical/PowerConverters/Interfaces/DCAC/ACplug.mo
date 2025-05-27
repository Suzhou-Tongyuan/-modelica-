within Modelica.Electrical.PowerConverters.Interfaces.DCAC;
partial model ACplug "交流多相插头"
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac(final m=m) 
    "AC输出" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  SI.Voltage vAC[m]=ac.pin[:].v "交流电势";
  SI.Current iAC[m]=ac.pin[:].i "交流电流";
  SI.Power powerAC[m]=vAC.*iAC "交流功率";
  SI.Power powerTotalAC=sum(powerAC) "总交流功率";
  annotation();
end ACplug;