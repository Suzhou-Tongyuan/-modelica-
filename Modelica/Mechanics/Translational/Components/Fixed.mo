within Modelica.Mechanics.Translational.Components;
model Fixed "固定一维平动接口"
  parameter SI.Position s0=0 "壳体的固定偏移位置";

  Interfaces.Flange_b flange annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
equation
  flange.s = s0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-80,-40},{80,-40}}, color={0,127,0}), 
        Line(points={{80,-40},{40,-80}}, color={0,127,0}), 
        Line(points={{40,-40},{0,-80}}, color={0,127,0}), 
        Line(points={{0,-40},{-40,-80}}, color={0,127,0}), 
        Line(points={{-40,-40},{-80,-80}}, color={0,127,0}), 
        Line(points={{0,-40},{0,-10}}, color={0,127,0}), 
        Text(
          extent={{-150,-90},{150,-130}}, 
          textString="%name", 
          textColor={0,0,255})}), Documentation(info="<html>
<p>
一维平动机械系统的<em>固定</em>在位置s0处的<em>一维平动接口</em>。可用于：
</p>
<ul>
<li>连接一个弹性元件，例如弹簧或减震器，以夹在滑动质量块和壳体之间。</li>
<li>固定一个刚性元件，例如将滑动质量固定到特定位置。</li>
</ul>

</html>"));
end Fixed;