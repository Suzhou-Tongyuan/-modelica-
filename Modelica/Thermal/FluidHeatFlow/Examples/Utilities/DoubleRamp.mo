within Modelica.Thermal.FluidHeatFlow.Examples.Utilities;
model DoubleRamp "上下斜坡"
  extends Modelica.Blocks.Interfaces.SO;
  parameter Real offset=1 "坡道偏移";
  parameter SI.Time startTime=0.2 "第一个斜坡的开始时间";
  parameter SI.Time interval=0.2 
    "第 1 个斜坡结束与第 2 个斜坡开始之间的间隔时间";
  parameter Real height_1=-1 "坡道高度" 
    annotation(Dialog(group="Ramp 1"));
  parameter SI.Time duration_1(min=Modelica.Constants.small)=0.2 
    "斜坡持续时间" 
    annotation(Dialog(group="Ramp 1"));
  parameter Real height_2=1 "坡道高度" 
    annotation(Dialog(group="Ramp 2"));
  parameter SI.Time duration_2(min=Modelica.Constants.small)=0.2 
    "斜坡持续时间" 
    annotation(Dialog(group="Ramp 2"));

  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
          extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    final height=height_1, 
    final duration=duration_1, 
    final startTime=startTime, 
    final offset=offset) 
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    final height=height_2, 
    final duration=duration_2, 
    final startTime=startTime + duration_1 + interval, 
    final offset=0) 
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
equation
  connect(ramp1.y, add.u1) annotation (Line(points={{-9,20},{0,20},{0,6}, 
          {8,6}}, color={0,0,127}));
  connect(ramp2.y, add.u2) annotation (Line(points={{-9,-20},{0,-20},{0, 
          -6},{8,-6}}, color={0,0,127}));
  connect(add.y, y) annotation (Line(points={{31,0},{110,0}}, color={0,0,127}));
  annotation (
    Documentation(info="<html><p>
生成两个斜坡之和的图块。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-80,-60},{-50,-60},{-30,60},{10,60},{30,-20},{70,-20}})}));
end DoubleRamp;