within Modelica.Mechanics.Translational.Interfaces;
partial model PartialOneFlangeAndSupport 
  "具有一个一维平动接口和支撑的部分模型，用于图形建模，即模型是通过从基本组件中拖放构建"
  parameter Boolean useSupport=false 
    "= true，如果支撑一维平动接口启用，则隐式接地" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  Flange_b flange "部件的一维平动接口" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Support support if useSupport "部件的支撑/壳体" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  Support internalSupport 
    "部件的内部支撑/壳体（如果 useSupport=true，则连接到支撑；如果 useSupport=false，则连接到固定部件）" 
    annotation (Placement(transformation(extent={{-3,-83},{3,-77}})));
  Components.Fixed fixed if not useSupport 
    "如果不使用支撑，则部件的固定支撑/壳体" 
    annotation (Placement(transformation(extent={{10,-94},{30,-74}})));
equation
  connect(fixed.flange, internalSupport) annotation (Line(
      points={{20,-84},{20,-80},{0,-80}}, color={0,127,0}));
  connect(internalSupport, support) 
    annotation (Line(points={{0,-80},{0,-100}}));
  annotation (
    Documentation(info="<html>
<p>
这是一个具有一个一维平动接口和一个支撑/壳体的一维传动组件的部分模型。
它用于以图形方式构建由多个组件组成的传动系统的部件。
</p>

<p>
如果 <em>useSupport=true</em>，则支撑连接器被有条件地启用并且需要连接。<br>
如果 <em>useSupport=false</em>，则支撑连接器被有条件地禁用，并且该组件会内部固定到地面。
</p>

</html>"), 
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={Text(
              extent={{-38,-98},{-6,-96}}, 
              textColor={95,95,95}, 
              textString="(如果使用支撑)"),Text(
              extent={{21,-95},{61,-96}}, 
              textColor={95,95,95}, 
              textString="(如果不使用支撑)")}), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(
              points={{-50,-120},{-30,-100}}, color={0,127,0}), 
                                              Line(
              points={{-30,-120},{-10,-100}}, color={0,127,0}), 
                                              Line(
              points={{-10,-120},{10,-100}}, color={0,127,0}), 
                                             Line(
              points={{10,-120},{30,-100}}, color={0,127,0}), 
                                            Line(
              points={{-30,-100},{30,-100}}, color={0,127,0})}));
end PartialOneFlangeAndSupport;