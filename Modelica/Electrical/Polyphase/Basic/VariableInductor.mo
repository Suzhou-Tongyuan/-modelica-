within Modelica.Electrical.Polyphase.Basic;
model VariableInductor 
  "具有可变电感的理想线性电感"
  extends Interfaces.TwoPlug;
  parameter SI.Inductance Lmin[m]=fill(Modelica.Constants.eps, 
      m) "最小电感";
  Modelica.Blocks.Interfaces.RealInput L[m](each unit="H") annotation (
      Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
  Modelica.Electrical.Analog.Basic.VariableInductor variableInductor[m](
      final Lmin=Lmin) annotation (Placement(transformation(extent={{-10,-10}, 
            {10,10}})));

equation
  connect(variableInductor.p, plug_p.pin) 
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(variableInductor.n, plug_n.pin) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(L, variableInductor.L) 
    annotation (Line(points={{0,120},{0,56},{0,12}}, color={0,0,255}));
  annotation (defaultComponentName="inductor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{-60,0}}, color={0,0,255}), 
        Line(points={{60,0},{90,0}}, color={0,0,255}), 
        Line(
          points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Text(
          extent={{-150,-80},{150,-40}}, 
          textString="m=%m"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}), Documentation(info="<html>
<p>
包含m个可变电感器(Modelica.Electrical.Analog.Basic.VariableInductor)
</p>
<p>
要求每个L_Port.signal&ge;0，否则会引发断言。为避免变量索引系统，<br>
如果0&le;L_Port.signal&lt;Lmin，则L=Lmin，其中
Lmin是一个默认值为Modelica.Constants.eps的参数。
</p>
</html>"));
end VariableInductor;