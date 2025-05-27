within Modelica.Mechanics.Translational.Interfaces;
partial model PartialElementaryTwoFlangesAndSupport2 
  "用于具有一维平动接口和支撑的组件的部分模型，用于文本建模，即用于基本模型"
  parameter Boolean useSupport=false 
    "= true，如果启用了支撑一维平动接口，否则隐式接地" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  extends Translational.Interfaces.PartialTwoFlanges;
  Support support(s=s_support, f=-flange_a.f - flange_b.f) if useSupport 
    "组件的支撑/壳" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  SI.Length s_a "左侧一维平动接口和支撑之间的距离";
  SI.Length s_b "右侧一维平动接口和支撑之间的距离";
protected
  SI.Length s_support "支撑一维平动接口的绝对位置";
equation
  s_a = flange_a.s - s_support;
  s_b = flange_b.s - s_support;
  if not useSupport then
    s_support = 0;
  end if;

  annotation (Documentation(info="<html>
<p>
这是一个具有两个一维平动接口和一个额外支撑的一维传动组件的部分模型。
它用于在文本层中使用方程构建基本的理想齿轮组件。组件包含力平衡，
即连接器的力之和为零（因此，基于 PartialGear 的组件不能具有质量）。
支撑连接器需要连接，以避免不物理的行为，即需要支撑力为零（如果未连接连接器，则为默认值）。
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
end PartialElementaryTwoFlangesAndSupport2;