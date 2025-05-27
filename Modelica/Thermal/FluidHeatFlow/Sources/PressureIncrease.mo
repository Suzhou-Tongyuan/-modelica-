within Modelica.Thermal.FluidHeatFlow.Sources;
model PressureIncrease "强制保持恒定压升"

  extends FluidHeatFlow.BaseClasses.TwoPort(final tapT=1);
  parameter Boolean usePressureIncreaseInput=false 
    "启用/禁用增压输入" 
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.Pressure constantPressureIncrease(start=1) 
    "增压" 
    annotation(Dialog(enable=not usePressureIncreaseInput));
  Modelica.Blocks.Interfaces.RealInput pressureIncrease(unit="Pa")=internalPressureIncrease if usePressureIncreaseInput 
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,100})));
protected
  SI.Pressure internalPressureIncrease;
equation
  if not usePressureIncreaseInput then
    internalPressureIncrease = constantPressureIncrease;
  end if;
  Q_flow = 0;
  dp = -internalPressureIncrease;
  annotation (
    Documentation(info="<html><p>
风扇和泵的压力持续增加。质量流量和体积流量是整个系统的响应。
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
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Ellipse(
          extent={{-90,90},{90,-90}}, 
          lineColor={255,0,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}}, 
          lineColor={0,0,255}, 
          fillColor={255,0,0}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-40,30},{20,-30}}, 
          textString="dp"),               Text(
          extent={{-150,-100},{150,-140}}, 
          textColor={0,0,255}, 
          textString="%name")}));
end PressureIncrease;