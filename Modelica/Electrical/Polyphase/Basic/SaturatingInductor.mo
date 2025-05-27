within Modelica.Electrical.Polyphase.Basic;
model SaturatingInductor "具有饱和的电感的简单模型"
  extends Interfaces.TwoPlug;
  parameter SI.Current Inom[m](start=fill(1, m)) 
    "额定电流";
  parameter SI.Inductance Lnom[m](start=fill(1, m)) 
    "在额定电流下的额定电感";
  parameter SI.Inductance Lzer[m](start={2*Lnom[j] for j in 1
        :m}) "接近电流=0时的电感";
  parameter SI.Inductance Linf[m](start={Lnom[j]/2 for j in 1
        :m}) "在大电流下的电感";
  Modelica.Electrical.Analog.Basic.SaturatingInductor saturatingInductor[m](
    final Inom=Inom, 
    final Lnom=Lnom, 
    final Lzer=Lzer, 
    final Linf=Linf) annotation (Placement(transformation(extent={{-10,-10}, 
            {10,10}})));
equation
  connect(saturatingInductor.p, plug_p.pin) 
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(saturatingInductor.n, plug_n.pin) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (defaultComponentName="inductor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{60,0},{90,0}}, color={0,0,255}), 
        Line(points={{-90,0},{-60,0}}, color={0,0,255}), 
        Rectangle(
          extent={{-60,-10},{60,-20}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={0,0,255}), 
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
包含m个饱和电感器(Modelica.Electrical.Analog.Basic.SaturatingInductor)
</p>
<p>
<strong>注意!!!</strong><br>
饱和电感器数组的每个元素仅依赖于通过该元素的电流。
</p>
</html>"));
end SaturatingInductor;