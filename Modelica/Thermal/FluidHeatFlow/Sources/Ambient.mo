within Modelica.Thermal.FluidHeatFlow.Sources;
model Ambient "具有恒定属性的环境"

  extends FluidHeatFlow.BaseClasses.SinglePortLeft(
    final Exchange=true, 
    final T0=293.15, 
    final T0fixed=false);
  parameter Boolean usePressureInput=false 
    "启用/禁用压力输入" 
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.Pressure constantAmbientPressure(start=0) 
    "环境压力" 
    annotation(Dialog(enable=not usePressureInput));
  parameter Boolean useTemperatureInput=false 
    "启用/禁用温度输入" 
    annotation(Evaluate=true, choices(checkBox=true));
  parameter SI.Temperature constantAmbientTemperature(start=293.15, displayUnit="degC") 
    "环境温度" 
    annotation(Dialog(enable=not useTemperatureInput));
  Modelica.Blocks.Interfaces.RealInput ambientPressure=pAmbient if usePressureInput 
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=180, 
        origin={100,60}), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=180, 
        origin={100,60})));
  Modelica.Blocks.Interfaces.RealInput ambientTemperature=TAmbient if useTemperatureInput 
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=180, 
        origin={100,-60}), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=180, 
        origin={100,-60})));
protected
  SI.Pressure pAmbient;
  SI.Temperature TAmbient;

equation
  if not usePressureInput then
    pAmbient = constantAmbientPressure;
  end if;
  if not useTemperatureInput then
    TAmbient = constantAmbientTemperature;
  end if;
  flowPort.p = pAmbient;
  T = TAmbient;
annotation (Documentation(info="<html>
<p>(无限）恒压恒温环境。</p>
<p>热力学方程由 BaseClasses.SinglePortLeft 定义。</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
          extent={{-90,90},{90,-90}}, 
          lineColor={255,0,0}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), Text(
          extent={{20,80},{80,20}}, 
          textString="p"), Text(
          extent={{20,-20},{80,-80}}, 
          textString="T")}));
end Ambient;