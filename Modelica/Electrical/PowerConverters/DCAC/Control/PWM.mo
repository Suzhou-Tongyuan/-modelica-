within Modelica.Electrical.PowerConverters.DCAC.Control;
block PWM "脉冲宽度调制"
  extends Modelica.Blocks.Icons.Block;
  constant Integer m=3 "相数";
  parameter PowerConverters.Types.PWMType pwmType=PowerConverters.Types.PWMType.SVPWM 
    "PWM类型" annotation (Evaluate=true);
  parameter SI.Frequency f "开关频率";
  parameter SI.Time startTime=0 "PWM开始时间";
  parameter Real uMax "信号的最大幅值";
  parameter PowerConverters.Types.ReferenceType refType=PowerConverters.Types.ReferenceType.Triangle3 
    "参考信号的类型" annotation (Evaluate=true, Dialog(enable=pwmType 
           == PowerConverters.Types.PWMType.Intersective));
  Modelica.Blocks.Interfaces.RealInput u[2] "参考空间相量" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_p[m] "正火信号" 
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire_n[m] "负火信号" 
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  PowerConverters.DCAC.Control.SVPWM svPWM(
    f=f, 
    startTime=startTime, 
    uMax=uMax) if pwmType == PowerConverters.Types.PWMType.SVPWM 
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  PowerConverters.DCAC.Control.IntersectivePWM intersectivePWM(
    f=f, 
    startTime=startTime, 
    uMax=uMax, 
    refType=refType) if pwmType == PowerConverters.Types.PWMType.Intersective 
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
equation
  connect(u, svPWM.u) annotation (Line(points={{-120,0},{-60,0},{-60,40},{-12,40}}, 
        color={0,0,127}));
  connect(u, intersectivePWM.u) annotation (Line(points={{-120,0},{-60,0},{-60,-40}, 
          {-12,-40}}, color={0,0,127}));
  connect(svPWM.fire_p, fire_p) annotation (Line(points={{11,46},{40,46},{40,60}, 
          {110,60}}, color={255,0,255}));
  connect(intersectivePWM.fire_p, fire_p) annotation (Line(points={{11,-34},{40, 
          -34},{40,60},{110,60}}, color={255,0,255}));
  connect(svPWM.fire_n, fire_n) annotation (Line(points={{11,34},{60,34},{60,-60}, 
          {110,-60}}, color={255,0,255}));
  connect(intersectivePWM.fire_n, fire_n) annotation (Line(points={{11,-46},{60, 
          -46},{60,-60},{110,-60}}, color={255,0,255}));
  annotation (defaultComponentName="pwm", Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-70,80},{70,40}}, 
          textString="PWM"), Text(
          extent={{-70,-40},{70,-80}}, 
          textString="f=%f"), Text(
          extent={{-70,20},{70,-20}}, 
          textString="%pwmType")}),    Documentation(info="<html>
<p>
让用户从以下选项中选择PWM类型：
</p>
<ul>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM\">空间矢量脉冲宽度调制</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.IntersectivePWM\">相交脉冲宽度调制</a></li>
</ul>
</html>"));
end PWM;