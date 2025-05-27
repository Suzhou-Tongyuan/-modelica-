within Modelica.Thermal.FluidHeatFlow.Sources;
model VolumeFlow "保持恒定体积流量"

  extends FluidHeatFlow.BaseClasses.TwoPort(final tapT=1);
  parameter Boolean useVolumeFlowInput=false 
    "启用/禁用体积流量输入" 
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.VolumeFlowRate constantVolumeFlow(start=1) 
    "体积流量" 
    annotation(Dialog(enable=not useVolumeFlowInput));
  Modelica.Blocks.Interfaces.RealInput volumeFlow(unit="m3/s")=internalVolumeFlow if useVolumeFlowInput 
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,100})));
protected
  SI.VolumeFlowRate internalVolumeFlow;
equation
  if not useVolumeFlowInput then
    internalVolumeFlow = constantVolumeFlow;
  end if;
  Q_flow = 0;
  V_flow = internalVolumeFlow;
  annotation (
    Documentation(info="<html><p>
风扇或泵具有恒定体积流量。压力增加是整个系统的响应。
</p>
<p>
冷却剂的温度和焓流不受影响。
</p>
<p>
将参数 m（风扇/泵内介质的质量）设为零，可忽略温度瞬态项 cv*m*der(T)。
</p>
<p>
热力学方程由 BaseClasses.TwoPort 定义。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Ellipse(
          extent={{-90,90},{90,-90}}, 
          lineColor={255,0,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}}, 
          lineColor={255,0,0}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-40,30},{20,-30}}, 
          textString="V"),                Text(
          extent={{-150,-140},{150,-100}}, 
          textColor={0,0,255}, 
          textString="%name")}));
end VolumeFlow;