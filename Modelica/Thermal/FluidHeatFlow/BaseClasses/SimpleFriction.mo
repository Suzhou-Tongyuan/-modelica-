within Modelica.Thermal.FluidHeatFlow.BaseClasses;
partial model SimpleFriction "简单摩擦模型"
  parameter SI.VolumeFlowRate V_flowLaminar(min=Modelica.Constants.small, start=0.1) 
    "层流体积流" 
    annotation(Dialog(group="Simple friction"));
  parameter SI.Pressure dpLaminar(start=0.1) 
    "层流压降" 
    annotation(Dialog(group="Simple friction"));
  parameter SI.VolumeFlowRate V_flowNominal(start=1) 
    "额定流量" 
    annotation(Dialog(group="Simple friction"));
  parameter SI.Pressure dpNominal(start=1) 
    "额定压降" 
    annotation(Dialog(group="Simple friction"));
  parameter Real frictionLoss(min=0, max=1) = 0 
    "输入介质的部分摩擦损耗" 
    annotation(Dialog(group="Simple friction"));
  SI.Pressure pressureDrop;
  SI.VolumeFlowRate volumeFlow;
  SI.Power Q_friction;
protected
  parameter SI.Pressure dpNomMin=dpLaminar/V_flowLaminar*V_flowNominal;
  parameter Real k(final unit="Pa.s2/m6", fixed=false);
initial algorithm
  assert(V_flowNominal>V_flowLaminar, 
    "SimpleFriction: V_flowNominal has to be > V_flowLaminar!");
  assert(dpNominal>=dpNomMin, 
    "SimpleFriction: dpNominal has to be > dpLaminar/V_flowLaminar*V_flowNominal!");
  k:=(dpNominal - dpNomMin)/(V_flowNominal - V_flowLaminar)^2;
equation
  if volumeFlow > +V_flowLaminar then
    pressureDrop = +dpLaminar/V_flowLaminar*volumeFlow + k*(volumeFlow - V_flowLaminar)^2;
  elseif volumeFlow < -V_flowLaminar then
    pressureDrop = +dpLaminar/V_flowLaminar*volumeFlow - k*(volumeFlow + V_flowLaminar)^2;
  else
    pressureDrop =  dpLaminar/V_flowLaminar*volumeFlow;
  end if;
  Q_friction = frictionLoss*volumeFlow*pressureDrop;
annotation (Documentation(info="<html>
<p>
压降与体积流量关系的定义:
</p>
<ul>
<li>-V_flowLaminar &lt; VolumeFlow &lt; +V_flowLaminar: laminar, i.e., 压降与流量的线性关系。</li>
<li>-V_flowLaminar &gt; VolumeFlow or VolumeFlow &lt; +V_flowLaminar: turbulent, i.e., 压降与流量的二次方关系。</li>
</ul>
<div>
<img src=\"modelica://Modelica/Resources/Images/Thermal/FluidHeatFlow/BaseClasses/SimpleFriction.png\"
     alt=\"SimpleFriction.png\">
</div>
<p>
线性相关和二次相关在 V_flowLaminar / dpLaminar 处平滑耦合。
四次相关性由名义体积流量和压降（V_flowNominal / dpNominal）定义。
另请参见图层草图。
</p>
</html>"));
end SimpleFriction;