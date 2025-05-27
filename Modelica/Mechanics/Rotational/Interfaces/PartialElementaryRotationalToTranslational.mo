within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialElementaryRotationalToTranslational 
  "将旋转运动转换为平移运动的部分模型"
  parameter Boolean useSupportR=false 
    "= true，如果启用旋转支撑一维转动接口，否则隐式接地" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  parameter Boolean useSupportT=false 
    "= true，如果启用平移支撑一维转动接口，否则隐式接地" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  Rotational.Interfaces.Flange_a flangeR "旋转轴的一维转动接口" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flangeT 
    "平移杆的一维转动接口" annotation (Placement(transformation(
          extent={{90,10},{110,-10}})));
  Rotational.Interfaces.Support supportR if useSupportR 
    "组件的旋转支撑/轴承座" annotation (Placement(
        transformation(extent={{-110,-110},{-90,-90}})));
  Translational.Interfaces.Support supportT if useSupportT 
    "组件的平移支撑/轴承座" 
    annotation (Placement(transformation(extent={{110,-110},{90,-90}})));

protected
  Rotational.Interfaces.InternalSupport internalSupportR(tau=-flangeR.tau) 
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Translational.Interfaces.InternalSupport internalSupportT(f=-flangeT.f) 
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Rotational.Components.Fixed fixedR if not useSupportR 
    annotation (Placement(transformation(extent={{-90,-94},{-70,-74}})));
  Translational.Components.Fixed fixedT if not useSupportT 
    annotation (Placement(transformation(extent={{70,-94},{90,-74}})));
equation
  connect(internalSupportR.flange, supportR) annotation (Line(
      points={{-100,-80},{-100,-100}}));
  connect(internalSupportR.flange, fixedR.flange) annotation (Line(
      points={{-100,-80},{-80,-80},{-80,-84}}));
  connect(fixedT.flange, internalSupportT.flange) annotation (Line(
      points={{80,-84},{80,-80},{100,-80}}, 
                                   color={0,127,0}));
  connect(internalSupportT.flange, supportT) annotation (Line(
      points={{100,-80},{100,-100}}, color={0,127,0}));
  annotation (Documentation(info="<html>

<p>
这是一个一维旋转组件，具有
</p>

<ul>
<li> 一个旋转一维转动接口，</li>
<li> 一个旋转支撑/轴承座，</li>
<li> 一个平移一维转动接口，和</li>
<li> 一个平移支撑/轴承座</li>
</ul>

<p>
该模型用于构建驱动传动系统的基本组件，将旋转运动转换为平移运动，并附有文本层中的方程。
</p>

<p>
如果<em>useSupportR=true</em>，则旋转支撑连接器条件性启用，并且需要连接。<br>
如果<em>useSupportR=false</em>，则旋转支撑连接器条件性禁用，并且旋转部分将内部固定到地面。<br>
如果<em>useSupportT=true</em>，则平移支撑连接器条件性启用，并且需要连接。<br>
如果<em>useSupportT=false</em>，则平移支撑连接器条件性禁用，并且平移部分将内部固定到地面。
</p>
</html>"), 
       Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(
          visible=not useSupportT, 
          points={{85,-110},{95,-100}}, color={0,127,0}), 
        Line(
          visible=not useSupportT, 
          points={{95,-110},{105,-100}}, color={0,127,0}), 
        Line(
          visible=not useSupportT, 
          points={{105,-110},{115,-100}}, color={0,127,0}), 
        Line(
          visible=not useSupportT, 
          points={{85,-100},{115,-100}}, color={0,127,0}), 
        Line(
          visible=not useSupportR, 
          points={{-115,-110},{-105,-100}}), 
        Line(
          visible=not useSupportR, 
          points={{-105,-110},{-95,-100}}), 
        Line(
          visible=not useSupportR, 
          points={{-95,-110},{-85,-100}}), 
        Line(
          visible=not useSupportR, 
          points={{-115,-100},{-85,-100}})}));
end PartialElementaryRotationalToTranslational;