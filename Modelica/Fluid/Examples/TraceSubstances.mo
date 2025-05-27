within Modelica.Fluid.Examples;
package TraceSubstances "展示微量物质使用方法的库"
  extends Modelica.Icons.ExamplesPackage;
  model RoomCO2 "展示二氧化碳积聚的空间容积"
    extends Modelica.Icons.Example;
    package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"}, 
                                               C_nominal={1.519E-3}) annotation();
    Modelica.Blocks.Sources.Constant C(k=0.3*1.519E-3) 
      "物质浓度，提高到 1000 PPM CO2" 
      annotation (Placement(transformation(extent={{-94,-28},{-74,-8}})));
    Sources.FixedBoundary boundary4(nPorts=1,redeclare package Medium = Medium) 
      annotation (Placement(transformation(extent={{80,-20},{60,0}})));
    Sensors.TraceSubstances traceVolume(redeclare package Medium = Medium) 
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
    inner System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) 
                                     annotation (Placement(transformation(extent={{52,36}, 
              {72,56}})));
    Sources.MassFlowSource_T boundary1(
      use_C_in=true, 
      m_flow=100/1.2/3600*5, 
      redeclare package Medium = Medium, 
      nPorts=2, 
      X=Medium.X_default) 
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    Modelica.Fluid.Vessels.ClosedVolume volume(
      C_start={1.519E-3}, 
      V=100, 
      redeclare package Medium = Medium, 
      nPorts=2, 
      X_start={0.015,0.085}, 
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, 
      use_portsData=false) 
                annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium = Medium, 
      length=1, 
      diameter=0.15, 
      redeclare model FlowModel = 
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow (
           show_Res=true)) 
      annotation (Placement(transformation(extent={{20,-20},{40,0}})));
    Sensors.TraceSubstances traceSource(redeclare package Medium = Medium) 
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  equation
    connect(C.y, boundary1.C_in[1]) annotation (Line(
        points={{-73,-18},{-60,-18}}, color={0,0,127}));
    connect(pipe.port_b, boundary4.ports[1]) annotation (Line(
        points={{40,-10},{60,-10}}, color={0,127,255}));
    connect(volume.ports[2], pipe.port_a) annotation (Line(
        points={{-8,0},{-8,-10},{20,-10}}, color={0,127,255}));
    connect(traceVolume.port, pipe.port_a) annotation (Line(
        points={{10,20},{10,-10},{20,-10}}, color={0,127,255}));
    connect(boundary1.ports[2], volume.ports[1]) annotation (Line(
        points={{-40,-10.5},{-12,-10.5},{-12,0}}, color={0,127,255}));
    connect(boundary1.ports[1], traceSource.port) annotation (Line(
        points={{-40,-9.5},{-30,-9.5},{-30,20}}, color={0,127,255}));
    annotation (
      experiment(StopTime=3600), 
      Documentation(info="<html><p>
本例中的容积的二氧化碳浓度为 1.519E-3kg/kg，相当于 1000 PPM。有一股二氧化碳浓度约为 300 PPM 的新鲜气流，其中新鲜气流的空气交换率约为每小时 5 次换气。通风 1 小时后，容积内的二氧化碳浓度接近新鲜空气的浓度。
</p>
<p>
微量物质的额定值设置为 <code>C_nominal={1.519E-3}</code>。这将使求解器使用的残差方程达到合适的数量级。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/TraceSubstances/RoomCO2.png\" alt=\"RoomCO2.png\" data-href=\"\" style=\"\">
</p>
</html>"), 
      __Dymola_Commands(file(ensureSimulated=true)= 
          "modelica://Modelica/Resources/Scripts/Dymola/Fluid/RoomCO2/plotConcentrations.mos" 
          "plot concentrations"));
  end RoomCO2;

  model RoomCO2WithControls "展示带有二氧化碳控制功能的空间容积"
    extends Modelica.Icons.Example;
    package Medium = Modelica.Media.Air.MoistAir(extraPropertiesNames = {"CO2"}, 
      C_nominal = {1.519E-1}) annotation();
    Modelica.Blocks.Sources.Constant CAtm(k = 0.3 * 1.519E-3) 
      "大气微量物质浓度，相当于 300 PPM CO2" 
      annotation(Placement(transformation(extent = {{-100, -48}, {-80, -28}})));
    Sources.FixedBoundary boundary4(nPorts = 1, redeclare package Medium = Medium) 
      annotation(Placement(transformation(extent = {{92, -40}, {72, -20}})));
    Sensors.TraceSubstances traceVolume(redeclare package Medium = Medium) 
      annotation(Placement(transformation(extent = {{20, 0}, {40, 20}})));
    inner System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
      use_eps_Re = true, 
      m_flow_nominal = 0.1, 
      eps_m_flow = 1e-2) annotation(Placement(transformation(extent = {{70, 70}, 
      {90, 90}})));
    Sources.MassFlowSource_T freshAir(
      use_C_in = true, 
    redeclare package Medium = Medium, 
      use_m_flow_in = true, 
      nPorts = 2) 
      annotation(Placement(transformation(extent = {{-70, -40}, {-50, -20}})));
    Modelica.Fluid.Vessels.ClosedVolume volume(
      medium(Xi(each nominal = 0.01)), 
      C_start = {1.519E-3}, 
      V = 100, 
    redeclare package Medium = Medium, 
      massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, 
      use_portsData = false, 
      nPorts = 4) annotation(Placement(transformation(extent = {{0, -20}, {20, 0}})));

    Pipes.DynamicPipe ductOut(
      mCs_scaled(each nominal = 0.01), 
      mediums(each Xi(each nominal = 0.01)), 
    redeclare package Medium = Medium, 
      diameter = 0.15, 
    redeclare model FlowModel = 
      Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow(
      show_Res = true), 
      modelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b, 
      length = 5) "出口管道" 
      annotation(Placement(transformation(extent = {{40, -40}, {60, -20}})));

    Sensors.TraceSubstances traceDuctIn(redeclare package Medium = Medium) 
      "管道入口处的微量物质" 
      annotation(Placement(transformation(extent = {{-54, 0}, {-34, 20}})));
    Sources.MassFlowSource_T peopleSource(
      m_flow = 100 / 1.2 / 3600 * 5, 
    redeclare package Medium = Medium, 
      use_m_flow_in = true, 
      use_C_in = false, 
      C = {100}, 
      nPorts = 1) "室内人员排放的二氧化碳。" 
      annotation(Placement(transformation(extent = {{-38, -98}, {-18, -78}})));
    Modelica.Blocks.Sources.CombiTimeTable numberOfPeople(
      table = [0, 0; 9, 10; 11, 2; 13, 15; 15, 5; 18, 0; 24, 0], 
      smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, 
      timeScale = 3600) "会议室人数时间表" 
      annotation(Placement(transformation(extent = {{-100, -90}, {-80, -70}})));
    Modelica.Blocks.Math.Gain gain(k = 8.18E-6 / 100) 
      "二氧化碳质量流量，每 100 人释放量（人源中还有一个 100 因子）。" 
      annotation(Placement(transformation(extent = {{-68, -90}, {-48, -70}})));
    Modelica.Blocks.Math.Gain gain1(k = -100 * 1.2 / 3600 * 5) 
      "额定新鲜空气流量（u=1 时）" 
      annotation(Placement(transformation(extent = {{0, 40}, {20, 60}})));
    Modelica.Blocks.Math.Gain gainSensor(k = 1 / 1.519E-3) 
      "归一化CO2测量信号的增益。 y=1  相当于 1000 PPM" 
      annotation(Placement(transformation(extent = {{60, 0}, {80, 20}})));
    Modelica.Blocks.Sources.Constant CO2Set(k = 1) "归一化 CO2 设定点" 
      annotation(Placement(transformation(extent = {{-80, 40}, {-60, 60}})));
    Modelica.Blocks.Continuous.LimPID PID(
      controllerType = Modelica.Blocks.Types.SimpleController.PI, 
      yMax = 0, 
      yMin = -1, 
      Ti = 10, 
      k = 10) annotation(Placement(transformation(extent = {{-40, 40}, {-20, 60}})));

    Pipes.DynamicPipe ductIn(
      mCs_scaled(each nominal = 0.01), 
      mediums(each Xi(each nominal = 0.01)), 
    redeclare package Medium = Medium, 
      diameter = 0.15, 
    redeclare model FlowModel = 
      Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow(
      show_Res = true), 
      modelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b, 
      length = 5) "进口管道" 
      annotation(Placement(transformation(extent = {{-38, -40}, {-18, -20}})));

    Sensors.TraceSubstances traceDuctOut(redeclare package Medium = Medium) 
      "管道出口处的微量物质" 
      annotation(Placement(transformation(extent = {{-20, 0}, {0, 20}})));
  equation
    connect(CAtm.y, freshAir.C_in[1]) annotation(Line(
      points = {{-79, -38}, {-70, -38}}, color = {0, 0, 127}));
    connect(ductOut.port_b, boundary4.ports[1]) annotation(Line(
      points = {{60, -30}, {72, -30}}, color = {0, 127, 255}));
    connect(numberOfPeople.y[1], gain.u) annotation(Line(
      points = {{-79, -80}, {-70, -80}}, color = {0, 0, 127}));
    connect(gain.y, peopleSource.m_flow_in) annotation(Line(
      points = {{-47, -80}, {-38, -80}}, color = {0, 0, 127}));
    connect(traceVolume.C, gainSensor.u) annotation(Line(
      points = {{41, 10}, {58, 10}}, color = {0, 0, 127}));
    connect(CO2Set.y, PID.u_s) annotation(Line(
      points = {{-59, 50}, {-42, 50}}, color = {0, 0, 127}));
    connect(gainSensor.y, PID.u_m) annotation(Line(
      points = {{81, 10}, {90, 10}, {90, 30}, {-30, 30}, {-30, 38}}, color = {0, 0, 127}));
    connect(PID.y, gain1.u) annotation(Line(
      points = {{-19, 50}, {-2, 50}}, color = {0, 0, 127}));
    connect(gain1.y, freshAir.m_flow_in) annotation(Line(
      points = {{21, 50}, {30, 50}, {30, 70}, {-88, 70}, {-88, -22}, {-70, -22}}, color = {0, 0, 127}));
    connect(ductIn.port_b, volume.ports[1]) annotation(Line(
      points = {{-18, -30}, {7, -30}, {7, -20}}, color = {0, 127, 255}));
    connect(peopleSource.ports[1], volume.ports[2]) annotation(Line(
      points = {{-18, -88}, {9, -88}, {9, -20}}, color = {0, 127, 255}));
    connect(volume.ports[3], ductOut.port_a) annotation(Line(
      points = {{11, -20}, {11, -30}, {40, -30}}, color = {0, 127, 255}));
    connect(volume.ports[4], traceVolume.port) annotation(Line(
      points = {{13, -20}, {13, -26}, {30, -26}, {30, 0}}, color = {0, 127, 255}));
    connect(freshAir.ports[1], traceDuctIn.port) annotation(Line(
      points = {{-50, -29.5}, {-44, -29.5}, {-44, 0}}, color = {0, 127, 255}));
    connect(ductIn.port_a, freshAir.ports[2]) annotation(Line(
      points = {{-38, -30}, {-38, -30.5}, {-50, -30.5}}, color = {0, 127, 255}));
    connect(traceDuctOut.port, ductIn.port_b) annotation(Line(
      points = {{-10, 0}, {-10, -30}, {-18, -30}}, color = {0, 127, 255}));
    annotation(
      experiment(StopTime = 86400, Tolerance = 1e-006), 
      __Dymola_Commands(file(ensureSimulated = true) = "modelica://Modelica/Resources/Scripts/Dymola/Fluid/RoomCO2WithControls/plotStatesWithControl.mos" 
      "plot states and controls"), 
      Documentation(info = "<html><p>
本示例说明了一个带有二氧化碳源和带反馈控制的新鲜空气供应的空间容积。
二氧化碳排放率与空间占用率成正比，占用率由时间表确定。新鲜空气流量受控，室内二氧化碳浓度不超过 <code>1000 PPM (=1.519E-3 kg/kg)</code>。
新鲜空气中的二氧化碳浓度为 <code>300 PPM</code>，相当于室外空气中的典型二氧化碳浓度。
</p>
<p>
居住者排放的二氧化碳作为质量流量源。根据不同的活动和体型，一个人的二氧化碳排放量约为 <code>8.18E-6 kg/s</code>。在模型中，该值乘以居住人数。
由于与二氧化碳源模型相关的质量流量会对容积的能量平衡产生影响，因此该质量流量应保持较小。在二氧化碳源模型中，我们将二氧化碳浓度设为 <code>C={100} kg/kg</code>，并使用以下公式缩放质量流量
</p>
<pre><code >m_flow = 1/100 * nPeo * 8.18E-6 kg/(s*人)
</code></pre><p>
其中，<code>nPeo</code> 是房间内的人数。这导致质量流量比送风流量小大约 5 个数量级，因此其对容积能量平衡的影响可以忽略不计。
</p>
<p>
微量物质的额定值设置为 <code>C_nominal={1.519E-3}</code>。这将使求解器使用的残差方程达到合适的数量级。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/TraceSubstances/RoomCO2WithControls.png\" alt=\"RoomCO2WithControls.png\" data-href=\"\" style=\"\">
</p>
</html>"    ));
  end RoomCO2WithControls;
  annotation();
end TraceSubstances;