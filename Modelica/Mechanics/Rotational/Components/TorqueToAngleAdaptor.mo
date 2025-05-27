within Modelica.Mechanics.Rotational.Components;
model TorqueToAngleAdaptor 
  "一个信号适配器，用于带有角度、速度和加速度作为输出以及扭矩作为输入的旋转一维转动接口（特别适用于FMU）"
  parameter Boolean use_w=true 
    "= true，启用输出连接器w（角速度）" annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  parameter Boolean use_a=true 
    "= true，启用输出连接器a（角加速度）" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealOutput phi(unit="rad") 
   "由于扭矩tau的作用，一维转动接口以角度phi移动" 
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s") if use_w 
    "由于扭矩tau的作用，一维转动接口以速度w移动" 
    annotation (Placement(transformation(extent={{20,40},{40,60}}), iconTransformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2") if use_a 
   "由于扭矩tau的作用，一维转动接口以角加速度a移动" 
    annotation (Placement(transformation(extent={{20,10},{40,30}}), iconTransformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Interfaces.RealInput tau(unit="N.m") 
   "驱动一维转动接口的扭矩" 
    annotation (Placement(transformation(extent={{60,-110},{20,-70}}), iconTransformation(extent={{40,-90},{20,-70}})));
protected
  Modelica.Blocks.Interfaces.RealInput w_internal(unit="rad/s") 
   "用于连接到条件连接器w";
  Modelica.Blocks.Interfaces.RealInput a_internal(unit="rad/s2") 
    "用于连接到条件连接器a";
equation
  connect(w, w_internal);
  connect(a, a_internal);
  phi = flange.phi;
  if use_w then
    w_internal = der(phi);
  else
    w_internal = 0.0;
  end if;
  if use_a then
    a_internal = der(w_internal);
  else
    a_internal = 0.0;
  end if;
  flange.tau = tau;

  annotation (defaultComponentName="torqueToAngleAdaptor", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
      graphics={
        Rectangle(
          extent={{-20,100},{20,-100}}, 
          lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          radius=10), 
        Rectangle(
          extent={{-20,100},{20,-100}}, 
          lineColor={95,95,95}, 
          radius=10, 
          lineThickness=0.5), 
        Text(
          extent={{-20,92},{20,70}}, 
          fillPattern=FillPattern.Solid, 
          textString="phi"), 
        Text(
          visible=use_w, 
          extent={{-20,62},{20,40}}, 
          fillPattern=FillPattern.Solid, 
          textString="w"), 
        Text(
          visible=use_a, 
          extent={{-20,32},{20,10}}, 
          fillPattern=FillPattern.Solid, 
          textString="a"), 
        Text(
          extent={{-20,-68},{20,-90}}, 
          fillPattern=FillPattern.Solid, 
          textString="tau"), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
一维转动接口连接器与一维转动接口信号表示之间的适配器。
此组件用于为model Rotational提供纯信号接口，并将此模型以输入/输出块的形式导出，
尤其是作为FMU(<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
此适配器的使用示例可以在
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.GenerationOfFMUs\">Rotational.Examples.GenerationOfFMUs</a>中找到.
此适配器将扭矩作为输入信号，将角度、角速度和角加速度作为输出信号。</p>
</html>"));
end TorqueToAngleAdaptor;