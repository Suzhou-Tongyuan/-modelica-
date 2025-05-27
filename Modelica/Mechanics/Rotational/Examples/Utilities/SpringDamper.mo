within Modelica.Mechanics.Rotational.Examples.Utilities;
model SpringDamper "弹簧/阻尼器模型的输入/输出块"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.RotationalSpringConstant c=1e4 
    "弹簧常数";
  parameter SI.RotationalDampingConstant d=1 
    "阻尼常数";
  parameter SI.Angle phi_rel0=0 
    "未拉伸的弹簧角度";

  Components.AngleToTorqueAdaptor 
    angleToTorque1(use_a=false) 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealInput phi1(unit="rad") 
    "力元件左一维转动接口的角度" 
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput w1(unit="rad/s") 
    "力元件左一维转动接口的速度" 
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealOutput tau1(unit="N.m") 
    "力元件生成的扭矩" 
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
  SpringDamperNoRelativeStates springDamper(
    c=c, 
    d=d, 
    phi_rel0=phi_rel0) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput phi2(unit="rad") 
    "力元件右一维转动接口的角度" 
    annotation (Placement(transformation(extent={{140,60},{100,100}})));
  Modelica.Blocks.Interfaces.RealInput w2(unit="rad/s") 
    "力元件右一维转动接口的速度" 
    annotation (Placement(transformation(extent={{140,10},{100,50}})));
  Modelica.Blocks.Interfaces.RealOutput tau2(unit="N.m") 
    "力元件生成的扭矩" 
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Components.AngleToTorqueAdaptor 
    angleToTorque2(use_a=false) 
    annotation (Placement(transformation(extent={{30,-10},{10,10}})));
equation

  connect(springDamper.flange_b, angleToTorque2.flange) 
    annotation (Line(points={{10,0},{18,0}}));
  connect(angleToTorque1.flange, springDamper.flange_a) 
    annotation (Line(points={{-18,0},{-10,0}}));
  connect(phi1, angleToTorque1.phi) annotation (Line(points={{-120,80},{
          -40,80},{-40,8},{-24,8}}, color={0,0,127}));
  connect(w1, angleToTorque1.w) annotation (Line(points={{-120,30},{-60, 
          30},{-60,2.8},{-24,2.8}}, color={0,0,127}));
  connect(tau1, angleToTorque1.tau) annotation (Line(points={{-110,-80},{
          -40,-80},{-40,-8},{-23,-8}}, color={0,0,127}));
  connect(angleToTorque2.phi, phi2) annotation (Line(points={{24,8},{40,8}, 
          {40,80},{120,80}}, color={0,0,127}));
  connect(w2, angleToTorque2.w) annotation (Line(points={{120,30},{60,30}, 
          {60,2.8},{24,2.8}}, color={0,0,127}));
  connect(angleToTorque2.tau, tau2) annotation (Line(points={{23,-8},{40, 
          -8},{40,-80},{110,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
        graphics={Text(
          extent={{-48,-36},{48,-68}}, 
          textColor={128,128,128}, 
          textString="to FMU"),      Text(
                extent={{-94,96},{-10,66}}, 
                horizontalAlignment=TextAlignment.Left, 
          textString="phi1"),      Text(
                extent={{-150,-118},{150,-148}}, 
                textString="c=%c
d=%d"),   Bitmap(extent={{-72,-44},{84,46}}, 
             fileName="modelica://Modelica/Resources/Images/Mechanics/Rotational/SpringDamper.png"), 
          Text( extent={{12,96},{96,66}}, 
                horizontalAlignment=TextAlignment.Right, 
          textString="phi2"),      Text(
                extent={{12,48},{96,18}}, 
                horizontalAlignment=TextAlignment.Right, 
          textString="w2"),      Text(
                extent={{10,-60},{94,-90}}, 
                horizontalAlignment=TextAlignment.Right, 
          textString="tau2"),      Text(
                extent={{-94,46},{-10,16}}, 
                horizontalAlignment=TextAlignment.Left, 
          textString="w1"),      Text(
                extent={{-90,-64},{-6,-94}}, 
                horizontalAlignment=TextAlignment.Left, 
          textString="tau1")}), Documentation(info="<html>
<p>
  一个与纯信号接口并联的线性一维转动弹簧和阻尼器，可用于FMU（<a href=\"https://fmi-standard.org\">Fuctional Mock-up Unit</a>）交换。
</p>
</html>"));
end SpringDamper;