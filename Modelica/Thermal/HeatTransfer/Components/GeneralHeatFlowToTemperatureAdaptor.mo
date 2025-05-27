within Modelica.Thermal.HeatTransfer.Components;
model GeneralHeatFlowToTemperatureAdaptor 
  "热接口的信号适配器，输出为温度及其时间导数，输入为热流量(尤其适用于FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.FlowToPotentialAdaptor(
    final Name_p="T", 
    final Name_pder="dT", 
    final Name_pder2="d2T", 
    final Name_f="Q", 
    final Name_fder="der(Q)", 
    final Name_fder2="der2(Q)", 
    final use_pder2=false, 
    final use_fder=false, 
    final use_fder2=false, 
    p(unit="K", displayUnit="degC"), 
    final pder(unit="K/s"), 
    final pder2(unit="K/s2"), 
    final f(unit="W"), 
    final fder(unit="W/s"), 
    final fder2(unit="W/s2"));
  HeatTransfer.Interfaces.HeatPort_a heatPort 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
equation
  y = heatPort.T "输出=势能=温度";
  u = heatPort.Q_flow "输入=流量=热流";
  annotation (defaultComponentName="heatFlowToTemperatureAdaptor", 
    Documentation(info="<html><p>
热接口与法兰信号之间的适配器。该组件用于为传热模型提供纯信号接口，并以输入/输出信号的形式输出该模型, 特别是 FMU (<a href=\"https://fmi-standard.org\" target=\"\">Functional Mock-up Unit</a>&nbsp; &nbsp;)。该适配器的使用示例见 <a href=\"modelica://Modelica.Thermal.HeatTransfer.Examples.GenerationOfFMUs\" target=\"\">HeatTransfer.Examples.GenerationOfFMUs</a>&nbsp;。该适配器的输入信号为热流，输出信号为温度及其时间多导数。
</p>
</html>"), 
    Icon(graphics={
            Rectangle(
          extent={{-20,100},{20,-100}}, 
          lineColor={191,0,0}, 
          radius=10, 
          lineThickness=0.5)}));
end GeneralHeatFlowToTemperatureAdaptor;