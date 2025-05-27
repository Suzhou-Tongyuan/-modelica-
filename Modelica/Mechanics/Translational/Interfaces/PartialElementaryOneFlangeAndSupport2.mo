within Modelica.Mechanics.Translational.Interfaces;
partial model PartialElementaryOneFlangeAndSupport2 
  "用于具有一个一维平动接口和支撑的组件的部分模型，用于文本建模，即用于基本模型"
  parameter Boolean useSupport=false 
    "= true，如果启用了支撑一维平动接口，否则隐式接地" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  SI.Length s 
    "一维平动接口和支撑之间的距离 (= flange.s - support.s)";
  Flange_b flange "组件的一维平动接口" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Support support(s=s_support, f=-flange.f) if useSupport 
    "组件的支撑/壳" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  SI.Length s_support "支撑一维平动接口的绝对位置";
equation
  s = flange.s - s_support;
  if not useSupport then
    s_support = 0;
  end if;
  annotation (Documentation(info="<html>
<p>
这是一个具有一个一维平动接口和支撑/壳的一维传动组件的部分模型。
它用于在文本层中使用方程构建传动系统的基本组件。
</p>

<p>
如果 <em>useSupport=true</em>，则支撑连接器将被有条件地启用，并且需要连接。<br>
如果 <em>useSupport=false</em>，则支撑连接器将被有条件地禁用，并且组件将被内部固定到地面。
</p>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), 
      graphics={
        Line(
          visible=not useSupport, 
          points={{-50,-120},{-30,-100}}, color={0,127,0}), 
        Line(
          visible=not useSupport, 
          points={{-30,-120},{-10,-100}}, color={0,127,0}), 
        Line(
          visible=not useSupport, 
          points={{-10,-120},{10,-100}}, color={0,127,0}), 
        Line(
          visible=not useSupport, 
          points={{10,-120},{30,-100}}, color={0,127,0}), 
        Line(
          visible=not useSupport, 
          points={{-30,-100},{30,-100}}, color={0,127,0})}));
end PartialElementaryOneFlangeAndSupport2;