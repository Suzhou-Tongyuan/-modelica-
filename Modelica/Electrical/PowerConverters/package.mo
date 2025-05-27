within Modelica.Electrical;
package PowerConverters "整流器、逆变器、DC/DC和AC/AC变换器"
  extends Modelica.Icons.Package;
  annotation (
    preferredView="info", 
    Documentation(info="<html>
<p>
该库提供了用于直流和交流单相和多相电气系统的功率转换器。PowerConverters库包含四种类型的转换器。
</p>

<ul>
  <li>交流/直流变换器（整流器）</li>
  <li>直流/交流变换器（逆变器）</li>
  <li>直流/直流变换器</li>
  <li>交流/交流变换器</li>
</ul>

<p>
版权所有 &copy; 2013-2020，Modelica Association 和贡献者
</p>
</html>"), 
    Icon(graphics={
        Line(
          points={{-78,0},{80,0}}, 
          color={95,95,95}), 
        Line(
          points={{36,50},{36,-52}}, 
          color={95,95,95}), 
        Polygon(points={{36,0},{-34,50},{-34,-50},{36,0}}, lineColor={95,95,95})}));
end PowerConverters;