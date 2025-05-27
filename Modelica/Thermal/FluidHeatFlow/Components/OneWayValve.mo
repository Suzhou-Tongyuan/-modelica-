within Modelica.Thermal.FluidHeatFlow.Components;
model OneWayValve "简易单向阀"
  extends FluidHeatFlow.BaseClasses.TwoPort(m(start=0), final tapT=1);

  parameter SI.VolumeFlowRate V_flowNominal(start=1) "额定容积流量(正向)";
  parameter SI.Pressure dpForward(displayUnit="bar")=1e-6 "公称流量压降(正向)";
  parameter SI.Pressure dpNominal(displayUnit="bar", start=1e5) "公称压力(反向)";
  parameter SI.VolumeFlowRate V_flowBackward(start=1E-6) "泄漏体积流量(反向)";
  parameter Real frictionLoss(min=0, max=1, start=0) 
    "部分摩擦损失给介质";
  Boolean backward(start=true) "前向状态=false / 后向=true";
protected
  Real s(start=0, final unit="1") 
    "辅助变量为实际位置上的阀门特性";
  /* s < 0: 向后，泄漏流
         s > 0: 向前，压降小 */
  constant SI.VolumeFlowRate unitVolumeFlowRate = 1;
  constant SI.Pressure unitPressureDrop = 1;
equation
  backward = s<0;
  dp     = (s*unitVolumeFlowRate)*(if backward then 1 else dpForward/V_flowNominal);
  V_flow = (s*unitPressureDrop)  *(if backward then V_flowBackward/dpNominal else 1);
  Q_flow = frictionLoss*V_flow*dp;
annotation (Documentation(info="<html><p>
简单的单向阀, 对比电气中的理想二极管 <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealDiode\" target=\"\">ideal diode</a>&nbsp; &nbsp;模型。
</p>
<li>
from flowPort_a to flowPort_b: 小压降，与体积流量呈线性关系</li>
<li>
from flowPort_b to flowPort_a: 小泄漏流量，与压降呈线性关系</li>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Polygon(
          points={{-90,10},{-60,10},{-60,60},{0,0},{60,60},{60,10},{90,10},{90,-10}, 
              {60,-10},{60,-60},{0,0},{-60,-60},{-60,-10},{-90,-10},{-90,10}}, 
          lineColor={255,0,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), Text(extent={{-150,-70},{150,-110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-60,60},{60,-60},{50,-40},{40,-50},{60,-60}}, 
          thickness=0.5), 
        Polygon(
          points={{50,-40},{60,-60},{40,-50},{50,-40}}, 
          fillPattern=FillPattern.Solid)}));
end OneWayValve;