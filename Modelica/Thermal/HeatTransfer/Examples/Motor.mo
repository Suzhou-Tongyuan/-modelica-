within Modelica.Thermal.HeatTransfer.Examples;
model Motor "电机的二阶热模型"
  extends Modelica.Icons.Example;
  parameter SI.Temperature TAmb(displayUnit="degC") = 293.15 
    "环境温度";

  Modelica.Blocks.Sources.CombiTimeTable lossTable(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic, 
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, 
    table=[0,100,500; 360,1000,500; 600,100,500]) annotation (Placement(transformation(
        origin={-40,70}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  HeatTransfer.Sources.PrescribedHeatFlow windingLosses(T_ref=368.15, alpha= 
        3.03E-3) annotation (Placement(transformation(
        origin={-80,10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  HeatTransfer.Components.HeatCapacitor winding(C=2500, T(start=TAmb, fixed= 
          true)) 
    annotation (Placement(transformation(extent={{-90,-20},{-70,-40}})));
  HeatTransfer.Celsius.TemperatureSensor Twinding annotation (Placement(
        transformation(
        origin={-60,-50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  HeatTransfer.Components.ThermalConductor winding2core(G=10) 
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  HeatTransfer.Sources.PrescribedHeatFlow coreLosses annotation (Placement(
        transformation(
        origin={0,10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  HeatTransfer.Components.HeatCapacitor core(C=25000, T(start=TAmb, fixed=true)) 
    annotation (Placement(transformation(extent={{-10,-20},{10,-40}})));
  HeatTransfer.Celsius.TemperatureSensor Tcore annotation (Placement(
        transformation(
        origin={-20,-50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Blocks.Sources.Constant convectionConstant(k=25) 
    annotation (Placement(transformation(
        origin={40,30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  HeatTransfer.Components.Convection convection 
    annotation (Placement(transformation(extent={{30,-20},{50,0}})));
  HeatTransfer.Sources.FixedTemperature environment(T=TAmb) annotation (
      Placement(transformation(
        origin={80,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
equation
  connect(windingLosses.port, winding.port) annotation (Line(points={{-80,0}, 
          {-80,-20}}, color={191,0,0}));
  connect(coreLosses.port, core.port) annotation (Line(points={{0,0},{0, 
          -10},{0,-20}}, color={191,0, 
          0}));
  connect(winding.port, winding2core.port_a) 
                                   annotation (Line(points={{-80,-20},{-80, 
          -10},{-50,-10}}, color={191,0,0}));
  connect(winding2core.port_b, core.port) 
                                annotation (Line(points={{-30,-10},{0,-10}, 
          {0,-20}}, color={191,0,0}));
  connect(winding.port, Twinding.port) annotation (Line(points={{-80,-20}, 
          {-80,-10},{-60,-10},{-60,-40}}, color={191,0,0}));
  connect(core.port, Tcore.port) annotation (Line(points={{0,-20},{0,-10}, 
          {-20,-10},{-20,-40}}, color={191,0,0}));
  connect(winding2core.port_b, convection.solid) 
                                      annotation (Line(points={{-30,-10},{
          30,-10}}, color={191,0,0}));
  connect(convection.fluid, environment.port) annotation (Line(points={{50,-10}, 
          {60,-10},{70,-10}}, color={191,0,0}));
  connect(convectionConstant.y, convection.Gc) 
    annotation (Line(points={{40,19},{40,0}}, color={0,0,127}));
  connect(lossTable.y[1], windingLosses.Q_flow) annotation (Line(points={{-40,59}, 
          {-40,40},{-80,40},{-80,20}}, color={0,0,127}));
  connect(lossTable.y[2], coreLosses.Q_flow) annotation (Line(points={{-40,59}, 
          {-40,40},{0,40},{0,20}}, color={0,0, 
          127}));
  annotation (Documentation(info="<html><p>
该示例包含一个简单的二阶电机热模型。 周期性功率损耗由表格 \"lossTable\" 描述:
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">时间</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">绕组损耗</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">核心损失</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> &nbsp; 0</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 100</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> &nbsp; &nbsp; &nbsp; &nbsp;500</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 360</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 100</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> &nbsp; &nbsp; &nbsp; &nbsp;500</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 360</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1000</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> &nbsp; &nbsp; &nbsp; &nbsp;500</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 600</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1000</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> &nbsp; &nbsp; &nbsp; &nbsp;500</td></tr></tbody></table><p>
由于假设恒定转速，铁芯损耗保持不变 而绕组损耗在，6 分钟内（空载）较低，在 4 分钟内（过载）较高。
</p>
<p>
绕组损耗按 (1 + alpha*（T - T_ref）) 进行修正，因为绕组电阻与温度有关，而铁芯损耗保持不变 (alpha = 0).
</p>
<p>
向环境散失的功率通过绕组和铁芯之间的热导率、绕组和铁芯的热容量部分储存热量、以及最终通过强制对流散失到环境的热流来近似。<br>由于假设速度恒定，对流传导保持恒定。<br>使用 Modelica.Thermal.FluidHeatFlow 也可以建立冷却剂气流模型 (而不是简单地耗散到恒定的环境温度)。
</p>
<p>
模拟 7200 秒；绘制 Twinding.T 和 Tcore.T 图。
</p>
</html>"), 
    experiment(StopTime=7200, Interval=0.01));
end Motor;