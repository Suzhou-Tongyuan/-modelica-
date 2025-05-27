within Modelica.Thermal.FluidHeatFlow.Components;
model Valve "简单的阀"
  extends FluidHeatFlow.BaseClasses.TwoPort(m(start=0), final tapT=1);

  parameter Boolean LinearCharacteristic(start=true) 
    "特性类型" 
    annotation(Dialog(group="标准特性"), choices(choice=true "线性", choice=false 
        "指数"));
  parameter Real y1(min=small, start=1) "最大阀门开度" 
    annotation(Dialog(group="标准特性"));
  parameter SI.VolumeFlowRate Kv1(min=small, start=1) 
    "最大体积流量y = y1" 
    annotation(Dialog(group="标准特性"));
  parameter Real kv0(min=small,max=1-small, start=0.01) 
    "泄露流量 / 最大体积流量y = 0" 
    annotation(Dialog(group="标准特性"));
  parameter SI.Pressure dp0(start=1) "标准压降" 
    annotation(Dialog(group="标准特性"));
  parameter SI.Density rho0(start=10) 
    "标准介质密度" 
    annotation(Dialog(group="标准特性"));
  parameter Real frictionLoss(min=0, max=1, start=0) 
    "部分摩擦损失给介质";
protected
  constant SI.VolumeFlowRate unitVolumeFlowRate = 1;
  constant Real small = Modelica.Constants.small;
  constant SI.VolumeFlowRate smallVolumeFlowRate = eps*unitVolumeFlowRate;
  constant Real eps = Modelica.Constants.eps;
  Real yLim = max(min(y,y1),0) "限制阀开度";
  SI.VolumeFlowRate Kv "标准流量";
public
  Modelica.Blocks.Interfaces.RealInput y annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,100})));
initial algorithm
  assert(y1>small, "阀的特性: y1 必须 > 0 !");
  assert(Kv1>smallVolumeFlowRate, "阀的特性: Kv1 必须 > 0 !");
  assert(kv0>small, "阀的特性: kv0 必须 > 0 !");
  assert(kv0<1-eps, "阀的特性: kv0 必须 < 1 !");
equation
  // 评价标准特性
  Kv/Kv1 = if LinearCharacteristic then (kv0 + (1-kv0)*yLim/y1) else kv0*exp(Modelica.Math.log(1/kv0)*yLim/y1);
  // 实际条件下的压降
  dp/dp0 = medium.rho/rho0*(V_flow/Kv)*abs(V_flow/Kv);
  // 不与介质发生能量交换
  Q_flow = frictionLoss*V_flow*dp;
annotation (Documentation(info="<html>
<p>简易控制阀。</p>
<p>
给出了标准条件(dp0, rho0)下的标准特性Kv=<em>f </em>(y),
</p>
<ul>
<li>不是线性的 :<code> Kv/Kv1 = Kv0/Kv1 + (1-Kv0/Kv1) * y/Y1</code></li>
<li>或是指数的:<code> Kv/Kv1 = Kv0/Kv1 * exp[log(Kv1/Kv0) * y/Y1]</code></li>
</ul>
<p>
其中:
</p>
<ul>
<li><code>Kv0 ... min. flow @ y = 0</code></li>
<li><code>Y1 .... max. valve opening</code></li>
<li><code>Kv1 ... max. flow @ y = Y1</code></li>
</ul>
<p>
实际条件下的流动阻力计算公式为
</p>
<blockquote><pre>
V_flow**2 * rho / dp = Kv(y)**2 * rho0 / dp0
</pre></blockquote>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Polygon(
          points={{-90,10},{-60,10},{-60,60},{0,0},{60,60},{60,10},{90,10}, 
              {90,-10},{60,-10},{60,-60},{0,0},{-60,-60},{-60,-10},{-90,-10}, 
              {-90,10}}, 
          lineColor={255,0,0}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{0,80},{0,0}}, color={0,0,127}), 
                                          Text(extent={{-150,-70},{150,-110}}, 
          textString="%name", 
          textColor={0,0,255})}));
end Valve;