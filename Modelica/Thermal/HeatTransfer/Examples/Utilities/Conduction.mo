within Modelica.Thermal.HeatTransfer.Examples.Utilities;
model Conduction "热传导模型的输入/输出模块"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.ThermalConductance G=1 "热传导";
  HeatTransfer.Components.GeneralTemperatureToHeatFlowAdaptor temperatureToHeatFlow1(use_pder= 
        false) 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealInput T1(unit="K", displayUnit="degC") 
    "传导元件左侧热接口的温度" 
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow1(unit="W") 
    "传导元件产生的热流" 
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
  HeatTransfer.Components.ThermalConductor thermalConductor(G=G) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput T2(unit="K", displayUnit="degC") 
    "导热元件右侧热接口的温度" 
    annotation (Placement(transformation(extent={{140,60},{100,100}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow2(unit="W") 
    "传导元件产生的热流" 
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  HeatTransfer.Components.GeneralTemperatureToHeatFlowAdaptor temperatureToHeatFlow2(use_pder= 
        false) annotation (Placement(transformation(extent={{30,-10},{10,10}})));
equation

  connect(Q_flow1,temperatureToHeatFlow1. f) annotation (Line(points={{-110,-80}, 
          {-60,-80},{-60,-8},{-23,-8}}, color={0,0,127}));
  connect(temperatureToHeatFlow2.f, Q_flow2) annotation (Line(points={{23,-8},{60, 
          -8},{60,-80},{110,-80}}, color={0,0,127}));
  connect(temperatureToHeatFlow1.p, T1) annotation (Line(points={{-23,8},{-60,8}, 
          {-60,80},{-120,80}}, color={0,0,127}));
  connect(temperatureToHeatFlow2.p, T2) annotation (Line(points={{23,8},{60,8},{
          60,80},{120,80}}, color={0,0,127}));
  connect(temperatureToHeatFlow1.heatPort, thermalConductor.port_a) 
    annotation (Line(points={{-18,0},{-10,0}}, color={191,0,0}));
  connect(thermalConductor.port_b,temperatureToHeatFlow2. heatPort) 
    annotation (Line(points={{10,0},{18,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
        graphics={Text(
                extent={{-48,-36},{48,-68}}, 
                textColor={135,135,135}, 
                textString="to FMU"),Text(
                extent={{-94,96},{-10,66}}, 
                horizontalAlignment=TextAlignment.Left, 
          textString="T1"),        Text(
                extent={{-150,-114},{150,-144}}, 
          textString="G=%G"),      Bitmap(extent={{-88,-36},{92,56}}, 
            fileName="modelica://Modelica/Resources/Images/Thermal/HeatTransfer/Conductor.png"), 
          Text( extent={{12,96},{96,66}}, 
                horizontalAlignment=TextAlignment.Right, 
          textString="T2"),        Text(
                extent={{16,-62},{100,-92}}, 
                horizontalAlignment=TextAlignment.Right, 
          textString="Q_flow2"),   Text(
                extent={{-100,-64},{-16,-94}}, 
                horizontalAlignment=TextAlignment.Left, 
          textString="Q_flow1")}));
end Conduction;