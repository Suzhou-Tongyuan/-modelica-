within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialTwoFlangesAndSupport 
  "具有两个一维转动接口和一个用于图形建模的支撑的组件的部分模型，即通过从基本组件拖放构建模型"
  parameter Boolean useSupport=false 
    "= true，如果启用支撑一维转动接口，否则隐式接地" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  Flange_a flange_a "左侧轴一维转动接口" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b "右侧轴一维转动接口" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Support support if useSupport "组件的支撑/轴承座" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  Support internalSupport 
    "组件的内部支撑/轴承座（如果useSupport=true，则连接到支撑，否则连接到固定部件，如果useSupport=false）" 
    annotation (Placement(transformation(extent={{-3,-83},{3,-77}})));
  Components.Fixed fixed if not useSupport 
    "固定支撑/轴承座，如果不使用支撑" 
    annotation (Placement(transformation(extent={{10,-94},{30,-74}})));
equation
  connect(support, internalSupport) annotation (Line(
      points={{0,-100},{0,-80}}));
  connect(internalSupport, fixed.flange) annotation (Line(
      points={{0,-80},{20,-80},{20,-84}}));
  annotation (
    Documentation(info="<html>
<p>
这是一个具有两个一维转动接口和一个支撑/轴承座的一维转动组件。
它用于以图形方式构建由多个组件组成的传动系统的部件。
</p>

<p>
如果<em>useSupport=true</em>，则支撑连接器被有条件地启用并需要连接。<br>
如果<em>useSupport=false</em>，则支撑连接器被有条件地禁用，而组件则内部固定到地面。
</p>
</html>"), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-38,-98},{-6,-96}}, 
              textColor={95,95,95}, 
              textString="(如果useSupport)"),Text(
              extent={{24,-97},{64,-98}}, 
              textColor={95,95,95}, 
              textString="(如果不使用支撑)")}), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(
              visible=not useSupport, 
              points={{-50,-120},{-30,-100}}),Line(
              visible=not useSupport, 
              points={{-30,-120},{-10,-100}}),Line(
              visible=not useSupport, 
              points={{-10,-120},{10,-100}}),Line(
              visible=not useSupport, 
              points={{10,-120},{30,-100}}),Line(
              visible=not useSupport, 
              points={{-30,-100},{30,-100}})}));
end PartialTwoFlangesAndSupport;