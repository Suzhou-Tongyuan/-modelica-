within Modelica.Thermal.FluidHeatFlow.Sources;
model AbsolutePressure "定义绝对压力值"
  extends FluidHeatFlow.BaseClasses.SinglePortLeft(
    final Exchange=false, 
    final T0=293.15, 
    final T0fixed=false);
  parameter SI.Pressure p(start=0) "压力基准";
equation
  // 定义压力
  flowPort.p = p;
  // 没有质量流就没有能量流
  flowPort.H_flow = 0;
  annotation (
    Documentation(info="<html>
<p>绝对压力用于定义封闭式冷却循环的压力水平。</p>
<p>冷却剂的质量流量、温度和焓流量不受影响。</p>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
    graphics={
       Ellipse(extent={{-90,90},{90,-90}}, 
          lineColor={255,0,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}));
end AbsolutePressure;