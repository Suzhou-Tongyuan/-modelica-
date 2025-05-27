within Modelica.Electrical.Polyphase.Basic;
model VariableCapacitor 
  "具有可变电容的理想线性电容"
  extends Interfaces.TwoPlug;
  parameter SI.Capacitance Cmin[m]=fill(Modelica.Constants.eps, 
      m) "最小电容";
  Modelica.Blocks.Interfaces.RealInput C[m](each unit="F") annotation (
      Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.VariableCapacitor variableCapacitor[m](
      final Cmin=Cmin) annotation (Placement(transformation(extent={{-10,-10}, 
            {10,10}})));
equation
  connect(variableCapacitor.p, plug_p.pin) 
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(variableCapacitor.n, plug_n.pin) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(C, variableCapacitor.C) 
    annotation (Line(points={{0,120},{0,56},{0,12}}, color={0,0,255}));
  annotation (defaultComponentName="capacitor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{-6,0}}, color={0,0,255}), 
        Line(points={{6,0},{90,0}}, color={0,0,255}), 
        Line(points={{-6,28},{-6,-28}}, color={0,0,255}), 
        Line(points={{6,28},{6,-28}}, color={0,0,255}), 
        Text(
          extent={{-150,-80},{150,-40}}, 
          textString="m=%m"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}), 
                              Documentation(info="<html>
<p>
包含m个可变电容器(Modelica.Electrical.Analog.Basic.VariableCapacitor)
</p>
<p>
要求每个C_Port.signal&ge;0，否则会引发断言。为避免变量索引系统，<br>
如果0&le;C_Port.signal&lt;Cmin，则C=Cmin，其中
Cmin是一个默认值为Modelica.Constants.eps的参数。
</p>
</html>"));
end VariableCapacitor;