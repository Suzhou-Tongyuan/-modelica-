within Modelica.Media;
package Air "空气介质模型"
     extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
  <p>这个库包含不同的空气介质模型：</p>
<ul>
<li><strong>SimpleAir</strong><br>
    在有限温度范围内的简单干空气介质。</li>
<li><strong>DryAirNasa</strong><br>
    来自Media.IdealGases.MixtureGases.Air的理想气体干空气。</li>
<li><strong>MoistAir</strong><br>
    在三相点温度以下和以上，蒸汽和干空气的理想气体混合物为湿空气。</li>
</ul>
</html>"));
end Air;