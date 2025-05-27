within Modelica.Mechanics.Rotational.Examples.Utilities;
model InverseInertia "反向一维惯性转动组件模型的输入/输出块"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Inertia J=1 "一维惯性转动组件";
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    J=J, 
    phi(start=0), 
    w(start=0))             annotation (Placement(transformation(
          extent={{-10,-10},{10,10}})));
  Components.AngleToTorqueAdaptor 
    angleToTorque 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealInput phi(unit="rad") 
    "驱动一维惯性转动组件的角度" 
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput w(unit="rad/s") 
    "驱动一维惯性转动组件的速度" 
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput a(unit="rad/s2") 
    "驱动一维惯性转动组件的加速度" 
    annotation (Placement(
        transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m") 
    "根据 phi、w、a 驱动法兰所需的扭矩" 
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
equation


  connect(angleToTorque.flange, inertia.flange_a) 
    annotation (Line(points={{-18,0},{-10,0}}));
  connect(phi, angleToTorque.phi) annotation (Line(points={{-120,80},{-40, 
          80},{-40,8},{-24,8}}, color={0,0,127}));
  connect(w, angleToTorque.w) annotation (Line(points={{-120,30},{-60,30}, 
          {-60,2.8},{-24,2.8}}, color={0,0,127}));
  connect(a, angleToTorque.a) annotation (Line(points={{-120,-30},{-60, 
          -30},{-60,-3.2},{-24,-3.2}}, color={0,0,127}));
  connect(tau, angleToTorque.tau) annotation (Line(points={{-110,-80},{
          -40,-80},{-40,-8},{-23,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
        graphics={Text(
                extent={{0,-62},{96,-94}}, 
                textColor={135,135,135}, 
                textString="to FMU"),Text(
                extent={{-94,96},{-10,66}}, 
                horizontalAlignment=TextAlignment.Left, 
          textString="phi"),      Text(
                extent={{-94,46},{-10,16}}, 
                horizontalAlignment=TextAlignment.Left, 
          textString="w"),      Text(
                extent={{-92,-14},{-8,-44}}, 
                horizontalAlignment=TextAlignment.Left, 
                textString="a"),Text(
                extent={{-150,-110},{150,-140}}, 
                textString="J=%J"),Bitmap(extent={{-58,-42},{98,48}}, 
            fileName="modelica://Modelica/Resources/Images/Mechanics/Rotational/InverseInertia.png"), 
          Text( extent={{-90,-64},{-6,-94}}, 
                horizontalAlignment=TextAlignment.Left, 
          textString="tau")}), Documentation(info="<html>
<p>
这是一个具有纯信号接口的旋转组件，可用于 FMU（<a href=\"https://fmi-standard.org\">功能模拟单元</a>）交换。
根据施加在具有一维惯性转动组件的组件上的运动学输入，返回输出扭矩 <code>tau</code>。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.Utilities.DirectInertia\">DirectInertia</a>。
</p>

</html>"));
end InverseInertia;