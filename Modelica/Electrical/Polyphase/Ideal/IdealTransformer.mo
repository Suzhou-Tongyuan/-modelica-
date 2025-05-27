within Modelica.Electrical.Polyphase.Ideal;
model IdealTransformer "多相理想变压器"
  extends Interfaces.FourPlug; // 继承四插头接口
  parameter Real n[m](start=fill(1, m)) "主:次电压变比";
  parameter Boolean considerMagnetization=false 
    "选择是否考虑磁化";
  parameter SI.Inductance Lm1[m](start=fill(1, m)) 
    "相对于主侧的磁化电感";
  Modelica.Electrical.Analog.Ideal.IdealTransformer idealTransformer[m](
    final n=n, 
    each final considerMagnetization=considerMagnetization, 
    final Lm1=Lm1) annotation (Placement(transformation(extent={{-10,-10},{
            10,10}}))); // 理想变压器模型
equation
  connect(plug_p1.pin, idealTransformer.p1) annotation (Line(points={{-100,100},{-10,100},{-10,10}}, color={0,0,255}));
  connect(plug_p2.pin, idealTransformer.p2) 
    annotation (Line(points={{100,100},{10,100},{10,10}}, color={0,0,255}));
  connect(plug_n1.pin, idealTransformer.n1) annotation (Line(points={{-100,-100},{-10,-100},{-10,-10}}, color={0,0,255}));
  connect(plug_n2.pin, idealTransformer.n2) annotation (Line(points={{100,-100},{10,-100},{10,-10}}, color={0,0,255}));
  annotation (defaultComponentName="transformer", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,-110},{150,-150}}, 
          textString="m=%m"), 
        Line(points={{-40,60},{-40,100},{-90,100}}, color={0,0,255}), 
        Line(points={{40,60},{40,100},{90,100}}, color={0,0,255}), 
        Line(points={{-40,-60},{-40,-100},{-90,-100}}, color={0,0,255}), 
        Line(points={{40,-60},{40,-100},{90,-100}}, color={0,0,255}), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-33,45}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-33,15}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-33,-15}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-33,-45}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={33,45}, 
          rotation=90), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={33,15}, 
          rotation=90), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={33,-15}, 
          rotation=90), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={33,-45}, 
          rotation=90), 
        Text(
          extent={{-100,20},{-60,-20}}, 
          textColor={0,0,255}, 
          textString="1"), 
        Text(
          extent={{60,20},{100,-20}}, 
          textColor={0,0,255}, 
          textString="2"), 
        Text(
          extent={{-150,149},{150,109}}, 
          textString="%name", 
          textColor={0,0,255})}), 
                              Documentation(info="<html>
<p>
包含m个理想变压器(Modelica.Electrical.Analog.Ideal.IdealTransformer)。
</p>
<p>
<strong>注意：</strong>由于上述方程，连直流信号也会被转换！
</p>
</html>"));
end IdealTransformer;