within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialElementaryOneFlangeAndSupport2 
    "具有一个一维转动接口和一个用于文本建模的支撑的部分模型，即用于基本模型"
  parameter Boolean useSupport=false 
    "= true，如果启用支撑一维转动接口，否则隐式接地" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  Flange_b flange "轴的一维转动接口" annotation (Placement(transformation(
          extent={{90,-10},{110,10}})));
  Support support(phi=phi_support, tau=-flange.tau) if useSupport 
    "组件的支撑/轴承座" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  SI.Angle phi_support "支撑一维转动接口的绝对角度";
equation
  if not useSupport then
    phi_support = 0;
  end if;
  annotation (Documentation(info="<html>
<p>
这是一个具有一个一维转动接口和一个支撑/轴承座的一维旋转组件。
它用于在文本层中使用方程构建传动系统的基本组件。
</p>

<p>
如果<em>useSupport=true</em>，则支撑连接器被有条件地启用并需要连接。<br>
如果<em>useSupport=false</em>，则支撑连接器被有条件地禁用，而组件则内部固定到地面。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}),graphics={Line(
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
end PartialElementaryOneFlangeAndSupport2;