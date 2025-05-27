within Modelica.Mechanics.Rotational.Interfaces;
connector Flange_a 
  "一维转动接口a（实心圆图标）"
  extends Flange;

  annotation (
    defaultComponentName="flange_a", 
    Documentation(info="<html><p>
这是一个用于一维旋转机械系统和模型的连接器，代表轴的机械一维转动接口。此连接器中定义了以下变量：
</p>
<pre><code >phi: Absolute rotation angle of the shaft flange in [rad].
tau: Cut-torque in the shaft flange in [Nm].
</code></pre><p>
还有另一个用于一维转动接口的连接器： <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_b\" target=\"\">Flange_b</a>. 连接器 Flange_a 和 Flange_b 是完全相同的。唯一的区别是图标，以便在图中更容易识别一维转动接口变量。 关于局部力矩 tau 和旋转角度的实际方向的讨论，请参阅 Rotational 用户指南中的 <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SignConventions\" target=\"\">Sign Conventions</a>
</p>
<p>
如果需要，一维转动接口的绝对角速度w和绝对角加速度a可以通过对一维转动接口角度phi进行微分来确定：
</p>
<pre><code >w = der(phi);
a = der(w);
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Ellipse(
        extent={{-100,100},{100,-100}}, 
        fillColor={95,95,95}, 
        fillPattern=FillPattern.Solid)}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-160,90},{40,50}}, 
              textString="%name"),Ellipse(
              extent={{-40,40},{40,-40}}, 
              fillColor={135,135,135}, 
              fillPattern=FillPattern.Solid)}));
end Flange_a;