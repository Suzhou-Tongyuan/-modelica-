within Modelica.Thermal.HeatTransfer.Components;
model HeatCapacitor "集总热容元件"
  parameter SI.HeatCapacity C 
    "元件的热容(= cp*m)";
  SI.Temperature T(start=293.15, displayUnit="degC") 
    "元件温度";
  SI.TemperatureSlope der_T(start=0) 
    "温度的时间导数 (= der(T))";
  Interfaces.HeatPort_a port annotation (Placement(transformation(
        origin={0,-100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
equation
  T = port.T;
  der_T = der(T);
  C*der(T) = port.Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,110},{150,70}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Polygon(
          points={{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72, 
              13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65}, 
              {-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22, 
              -89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{
              70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54, 
              33},{44,41},{36,57},{26,65},{0,67}}, 
          lineColor={160,160,164}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{
              -76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18, 
              -83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42, 
              -77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12, 
              -73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35}, 
              {-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52, 
              27},{-48,35},{-44,45},{-40,57},{-58,35}}, 
          fillColor={160,160,164}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-69,7},{71,-24}}, 
          textString="%C")}), 
    Documentation(info="<html><p>
这是一个材料热容量的通用模型。 除了总体积和整个体积的均匀温度外，没有假定具体的几何形状。 整个体积温度均匀。 此外，还假设热容量是常数（与温度无关）。
</p>
<p>
该组件的温度 T [K] 是一个 <strong>状态变量</strong>。 默认值为 T = 25 ℃ (= Modelica.Units.Conversions.from_degC(25)) 作为初始化的起始值。 这通常意味着在积分开始时，该元件的温度为 25 &nbsp;℃ 。 当然，您也可以定义不同的温度作为初始化的起始值。另外, 设置参数<strong>steadyStateStart</strong> 为 <strong>true</strong>这种情况下，初始化会使用附加方程\\\\\\\\\\'<strong>der(T) = 0</strong>\\\\\\\\\\' , 即<span style=\"color: rgb(0, 0, 0);\">通过计算使得组件的温度T在初始时刻即处于</span><span style=\"color: rgb(0, 0, 0);\"><strong>稳态</strong></span>。<span style=\"color: rgb(0, 0, 0);\">这种设置适用于用户希望直接从合适的工作点开始仿真，而无需通过长时间积分才能到达该稳态点的情况</span>。
</p>
<p>
请注意，参数 <strong>steadyStateStart（稳态启动）</strong> 在仿真窗口的参数菜单中不可用。 因为该参数的值会在模型编译阶段被使用，其设置不同会导致生成完全不同的方程组。 因此，只能在编译模型之前更改该参数的值。
</p>
<p>
此组件可用于复杂的几何形状，其中热容C是由测量结果决定的。若组件主要由单一材料构成，则可通过测量或计算其质量m，并乘以材料对应的比热容cp来计算热容量（即采用公式C = m·cp）:
</p>
<p>
<br>
</p>
<pre><code >C = cp*m.
Typical values for cp at 20 degC in J/(kg.K):
   aluminium   896
   concrete    840
   copper      383
   iron        452
   silver      235
   steel       420 ... 500 (V2A)
   wood       2500
</code></pre><p>
<br>
</p>
</html>"));
end HeatCapacitor;