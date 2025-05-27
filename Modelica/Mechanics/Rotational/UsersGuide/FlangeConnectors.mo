within Modelica.Mechanics.Rotational.UsersGuide;
class FlangeConnectors "一维转动接口连接器"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html><p>
一维转动接口由连接器类<strong>一维转动接口a</strong>或<strong>一维转动接口b</strong>描述。 正如在<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.Overview\" target=\"\">Overview</a> 中已经指出的那样，这两个连接器类完全相同。 它们只在图标上有所不同，以便在图形中更容易识别一维转动接口变量。 两个连接器类都包含以下变量：
</p>
<pre><code >SI.Angle       phi  \"Absolute rotation angle of flange\";
flow SI.Torque tau  \"Cut torque in the flange\";
</code></pre><p>
如果需要求其角速度和角加速度，可以通过对一维转动接口旋转角度<code>phi</code>进行微分来求得一维转动接口连接器的角速度<code>w</code>和角加速度<code>a</code>。 其表达式如下所示：
</p>
<pre><code >w = der(phi);    a = der(w);
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"));

end FlangeConnectors;