within Modelica.Thermal.HeatTransfer.Examples;
model GenerationOfFMUs 
  "演示生成 FMU(Functional Mock-up Units)变体的示例"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine1(f=2, amplitude=1000) 
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  HeatTransfer.Examples.Utilities.DirectCapacity directCapacity(C=1.1) 
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  HeatTransfer.Examples.Utilities.InverseCapacity inverseCapacity(C=2.2) 
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  HeatTransfer.Examples.Utilities.Conduction conductor(G=10) 
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  HeatTransfer.Components.HeatCapacitor capacitor3a(C=1.1, T(fixed=true, start= 
          293.15)) 
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  HeatTransfer.Sources.PrescribedHeatFlow heatFlow3 
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  HeatTransfer.Components.GeneralHeatFlowToTemperatureAdaptor heatFlowToTemperature3a(use_pder= 
        false) 
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  HeatTransfer.Components.HeatCapacitor capacitor3b(C=2.2, T(fixed=true, start= 
          293.15)) 
    annotation (Placement(transformation(extent={{70,-70},{90,-50}})));
  HeatTransfer.Components.GeneralHeatFlowToTemperatureAdaptor heatFlowToTemperature3b(use_pder= 
        false) 
    annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
equation
  connect(sine1.y, directCapacity.Q_flowDrive) 
    annotation (Line(points={{-79,50},{-2,50}}, color={0,0,127}));
  connect(directCapacity.T, inverseCapacity.T) 
    annotation (Line(points={{21,58},{38,58}}, color={0,0,127}));
  connect(inverseCapacity.Q_flow, directCapacity.Q_flow) 
    annotation (Line(points={{39,42},{22,42}}, color={0,0,127}));
  connect(heatFlowToTemperature3a.f, conductor.Q_flow1) 
    annotation (Line(points={{3,-78},{19,-78}}, color={0,0,127}));
  connect(conductor.Q_flow2,heatFlowToTemperature3b. f) 
    annotation (Line(points={{41,-78},{57,-78}}, color={0,0,127}));
  connect(heatFlowToTemperature3a.p, conductor.T1) 
    annotation (Line(points={{3,-62},{18,-62}}, color={0,0,127}));
  connect(conductor.T2,heatFlowToTemperature3b. p) 
    annotation (Line(points={{42,-62},{57,-62}}, color={0,0,127}));
  connect(sine1.y, heatFlow3.Q_flow) annotation (Line(points={{-79,50},{-70,50}, 
          {-70,-70},{-60,-70}}, color={0,0,127}));
  connect(heatFlow3.port, capacitor3a.port) 
    annotation (Line(points={{-40,-70},{-20,-70}}, color={191,0,0}));
  connect(capacitor3a.port,heatFlowToTemperature3a. heatPort) 
    annotation (Line(points={{-20,-70},{-2,-70}}, color={191,0,0}));
  connect(heatFlowToTemperature3b.heatPort, capacitor3b.port) 
    annotation (Line(points={{62,-70},{80,-70}}, color={191,0,0}));
  connect(directCapacity.derT, inverseCapacity.derT) annotation (Line(points={{21, 
          53},{28.5,53},{28.5,53},{38,53}}, color={0,0,127}));
  annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html><p>
这个例子演示了如何从各种热传递组件生成输入/输出模块(例如，以一个形式 FMU - <a href=\"https://fmi-standard.org\" target=\"\">Functional Mock-up Unit</a>&nbsp; ) 。目标是从Modelica导出这样一个输入/输出模块，并导入到另一个建模环境中。关键问题在于，在导出之前，必须了解该组件在目标环境中的使用方式。根据目标用途，接口中的不同法兰变量需要具有输入或输出因果关系。请注意，此示例模型可用于测试 Modelica 工具的 FMU 导出/导入功能。只需将图标中标记为“toFMU”的组件导出为 FMU，并将其导入回来。然后，模型应该仍然可以正常工作，并给出与纯 Modelica 模型相同的结果。
</p>
<p>
<strong>连接两个质点</strong><br> 半部分（DirectCapacity、InverseCapacity） 演示了如何导出两个热容量并将它们连接到目标系统中。 连接到目标系统中。这要求其中一个热容量 (这里是：DirectCapacity） 定义为具有状态变量，并在接口中提供温度和温度的导数。 另一个热容量（这里是：InverseCapacity）<span style=\"color: rgb(64, 64, 64);\">根据输入的温度及其导数来计算所需的热流</span>。
</p>
<p>
<strong>连接只需要温度的导热元件</strong><br>下半部分（Conductor）演示了如何导出一个仅需要温度作为其导热规律的导热元件，并将该导热规律连接到目标系统中，连接在两个热容量之间。
</p>
</html>"));
end GenerationOfFMUs;