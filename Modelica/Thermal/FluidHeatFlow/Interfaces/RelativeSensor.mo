within Modelica.Thermal.FluidHeatFlow.Interfaces;
partial model RelativeSensor "相对传感器的基类模型"
  extends RelativeSensorBase;
  Modelica.Blocks.Interfaces.RealOutput y 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
annotation (Documentation(info="<html><p>
相对传感器的基类模型（压降/温差）。
</p>
<p>
介质的压力、质量流量、温度和焓流量不受影响。
</p>
</html>"));
end RelativeSensor;