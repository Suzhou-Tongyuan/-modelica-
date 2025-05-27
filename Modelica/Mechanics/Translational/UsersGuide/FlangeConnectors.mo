within Modelica.Mechanics.Translational.UsersGuide;
class FlangeConnectors "一维平动接口连接器"
  extends Modelica.Icons.Information;

  annotation (
    DocumentationClass=true, 
    Documentation(info="<html><p>
一个一维平动接口由连接器类<strong>Flange_a</strong> 或<strong>Flange_b</strong>描述。 如前所述，在<a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.Overview\" target=\"\">Overview</a>部分中， 这两个连接器类完全相同。它们的区别只在于图标上，以便更容易在图形状中识别一维平动接口变量。 两个连接器类都包含以下变量：
</p>
<pre><code >SI.Position   s \"Absolutr position of flange \";
flow SI.Force f \"Cut force directed into flange \";
</code></pre><p>
如果需要，可以通过对一维平动接口位置<code>s</code>进行微分来确定一维平动接口连接器的速度<code>v</code>和加速度<code>a</code>：
</p>
<pre><code >v = der(s);    a = der(v);
</code></pre><p>
<br>
</p>
</html>"));

end FlangeConnectors;