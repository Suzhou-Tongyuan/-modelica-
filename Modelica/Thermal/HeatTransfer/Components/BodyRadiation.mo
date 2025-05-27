within Modelica.Thermal.HeatTransfer.Components;
model BodyRadiation "用于热辐射的集总热元件"
  extends Interfaces.Element1D;
  parameter Real Gr(unit="m2") 
    "两个表面之间的净辐射传导系数（见文档）";
equation
  Q_flow = Gr*Modelica.Constants.sigma*(port_a.T^4 - port_b.T^4);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{50,80},{90,-80}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Backward), 
        Rectangle(
          extent={{-90,80},{-50,-80}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Backward), 
        Line(points={{-36,10},{36,10}}, color={191,0,0}), 
        Line(points={{-36,10},{-26,16}}, color={191,0,0}), 
        Line(points={{-36,10},{-26,4}}, color={191,0,0}), 
        Line(points={{-36,-10},{36,-10}}, color={191,0,0}), 
        Line(points={{26,-16},{36,-10}}, color={191,0,0}), 
        Line(points={{26,-4},{36,-10}}, color={191,0,0}), 
        Line(points={{-36,-30},{36,-30}}, color={191,0,0}), 
        Line(points={{-36,-30},{-26,-24}}, color={191,0,0}), 
        Line(points={{-36,-30},{-26,-36}}, color={191,0,0}), 
        Line(points={{-36,30},{36,30}}, color={191,0,0}), 
        Line(points={{26,24},{36,30}}, color={191,0,0}), 
        Line(points={{26,36},{36,30}}, color={191,0,0}), 
        Text(
          extent={{-150,125},{150,85}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-90},{150,-120}}, 
          textString="Gr=%Gr"), 
        Rectangle(
          extent={{-50,80},{-44,-80}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{45,80},{50,-80}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html><p>
这是一个描述热辐射的模型，即两个物体之间因温度不同而发出的电磁辐射。 使用的构成方程如下:
</p>
<p>
<br>
</p>
<pre><code >Q_flow = Gr*sigma*(port_a.T^4 - port_b.T^4);
</code></pre><p>
<br>
</p>
<p>
其中，Gr 是辐射传导系数，sigma 是斯蒂芬-玻尔兹曼常数（= Modelica.Constants.sigma)。Gr 可通过测量确定，并假定其在工作范围内恒定不变。
</p>
<p>
对于简单的情况，Gr 可以通过分析计算得出。解析方程采用物体发射率ε（取值范围0至1） ，Epsilon=1 表示物体吸收所有辐射（= 黑体）。 Epsilon=0 表示物体反射所有辐射，无任何吸收。
</p>
<p>
<br>
</p>
<pre><code >Typical values for epsilon:
aluminium, polished    0.04
copper, polished       0.04
gold, polished         0.02
paper                  0.09
rubber                 0.95
silver, polished       0.02
wood                   0.85..0.9
</code></pre><p>
<br>
</p>
<p>
<strong>Gr 的分析方程</strong>
</p>
<p>
<strong>大空间中的小型凸面出物</strong> (如，室内高温设备):
</p>
<p>
<br>
</p>
<pre><code >Gr = e*A
where
   e: 物体的发射率 (0~1)
   A: 物体发生热辐射的表面积
</code></pre><p>
<br>
</p>
<p>
<strong>两个平行板</strong>:
</p>
<p>
<br>
</p>
<pre><code >Gr = A/(1/e1 + 1/e2 - 1)
where
   e1: 平板的发射率1 (0~1)
   e2: 平板的发射率2 (0~1)
   A : 平板 1 的面积 (= 平板 2 的面积)
</code></pre><p>
<br>
</p>
<p>
<strong>两个长圆柱体互相套在一起</strong>, 辐射从内圆柱体到外圆柱体:
</p>
<p>
<br>
</p>
<pre><code >Gr = 2*pi*r1*L/(1/e1 + (1/e2 - 1)*(r1/r2))
where
   pi: = Modelica.Constants.pi
   r1: 内筒半径
   r2: 外筒半径
   L : 两个筒体的长度
   e1: 内筒发射率(0~1)
   e2: 外筒发射率(0~1)
</code></pre><p>
<br>
</p>
</html>"));
end BodyRadiation;