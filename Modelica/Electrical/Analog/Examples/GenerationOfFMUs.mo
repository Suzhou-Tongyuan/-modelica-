within Modelica.Electrical.Analog.Examples;
model GenerationOfFMUs 
  "用于演示生成FMU(功能模拟单元)不同方法的示例"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine12(f=2, amplitude=1) 
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Modelica.Electrical.Analog.Examples.Utilities.DirectCapacitor 
    directCapacitor1(C=1e-3) 
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  Modelica.Electrical.Analog.Examples.Utilities.InverseCapacitor 
    inverseCapacitor1(C=2e-3) 
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Electrical.Analog.Examples.Utilities.Resistor resistor2(R=10) 
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2a(v(start=0, fixed=true), C=1e-3) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-20,40})));
  Modelica.Electrical.Analog.Sources.SignalCurrent current2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-50,40})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor currentToVoltage2a(
      use_pder=false, use_fder=false) 
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2b(v(fixed=true, start=0), C=2e-3) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={80,40})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor currentToVoltage2b(
      use_pder=false, use_fder=false) 
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  Modelica.Electrical.Analog.Basic.Ground ground2a 
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground3b 
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  Modelica.Blocks.Sources.Sine sine34(f=2, amplitude=1) 
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Electrical.Analog.Examples.Utilities.DirectInductor directInductor3(
      L=1e-3) annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Modelica.Electrical.Analog.Examples.Utilities.InverseInductor 
    inverseInductor3(L=2e-3) 
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage voltage4 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-50,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground4a annotation (
      Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor4a(i(fixed=true, start=0), L=1e-3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-30,-50})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor voltageToCurrent4a(
      use_pder=false, use_fder=false) 
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
  Modelica.Electrical.Analog.Examples.Utilities.Conductor conductor4(G=10) 
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor voltageToCurrent4b(
      use_pder=false, use_fder=false) 
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor4b(i(fixed=true, start=0), L=2e-3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={80,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground4b 
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
equation
  connect(sine12.y, directCapacitor1.iDrive) 
    annotation (Line(points={{-79,80},{-2,80}}, color={0,0,127}));
  connect(directCapacitor1.v, inverseCapacitor1.v) 
    annotation (Line(points={{21,88},{38,88}}, color={0,0,127}));
  connect(directCapacitor1.dv, inverseCapacitor1.dv) 
    annotation (Line(points={{21,83},{38,83}}, color={0,0,127}));
  connect(directCapacitor1.i, inverseCapacitor1.i) 
    annotation (Line(points={{22,72},{39,72}}, color={0,0,127}));
  connect(sine12.y, current2.i) annotation (Line(points={{-79,80},{-70, 
          80},{-70,40},{-62,40}}, color={0,0,127}));
  connect(current2.n, capacitor2a.p) 
    annotation (Line(points={{-50,50},{-20,50}}, color={0,0,255}));
  connect(capacitor2a.p, currentToVoltage2a.pin_p) annotation (Line(points={{-20, 
          50},{-10,50},{-10,48},{-2,48}}, color={0,0,255}));
  connect(capacitor2a.n, currentToVoltage2a.pin_n) annotation (Line(points={{-20, 
          30},{-12,30},{-12,32},{-2,32}}, color={0,0,255}));
  connect(currentToVoltage2a.p,resistor2. v1) 
    annotation (Line(points={{3,48},{18,48}}, color={0,0,127}));
  connect(currentToVoltage2a.f,resistor2. i1) 
    annotation (Line(points={{3,32},{19,32}}, color={0,0,127}));
  connect(resistor2.v2, currentToVoltage2b.p) 
    annotation (Line(points={{42,48},{57,48}}, color={0,0,127}));
  connect(resistor2.i2, currentToVoltage2b.f) 
    annotation (Line(points={{41,32},{57,32}}, color={0,0,127}));
  connect(currentToVoltage2b.pin_p, capacitor2b.p) annotation (Line(points={{62, 
          48},{70,48},{70,50},{80,50}}, color={0,0,255}));
  connect(current2.p, ground2a.p) 
    annotation (Line(points={{-50,30},{-30,30}}, color={0,0,255}));
  connect(ground2a.p, capacitor2a.n) 
    annotation (Line(points={{-30,30},{-20,30}}, color={0,0,255}));
  connect(currentToVoltage2b.pin_n, ground3b.p) 
    annotation (Line(points={{62,32},{70,32},{70,30}}, color={0,0,255}));
  connect(ground3b.p, capacitor2b.n) 
    annotation (Line(points={{70,30},{80,30}}, color={0,0,255}));
  connect(sine34.y, directInductor3.vDrive) 
    annotation (Line(points={{-79,-20},{-2,-20}}, color={0,0,127}));
  connect(directInductor3.v, inverseInductor3.v) 
    annotation (Line(points={{22,-12},{39,-12}}, color={0,0,127}));
  connect(directInductor3.di, inverseInductor3.di) annotation (Line(
        points={{21,-23},{30.5,-23},{30.5,-23},{38,-23}}, color={0,0, 
          127}));
  connect(directInductor3.i, inverseInductor3.i) 
    annotation (Line(points={{21,-28},{38,-28}}, color={0,0,127}));
  connect(inductor4a.n, voltageToCurrent4a.pin_p) annotation (Line(
        points={{-20,-50},{-10,-50},{-10,-52},{-2,-52}}, color={0,0,255}));
  connect(ground4a.p, voltageToCurrent4a.pin_n) annotation (Line(points= 
         {{-30,-70},{-10,-70},{-10,-68},{-2,-68}}, color={0,0,255}));
  connect(voltageToCurrent4b.pin_p, inductor4b.p) annotation (Line(
        points={{62,-52},{70,-52},{70,-50},{80,-50}}, color={0,0,255}));
  connect(voltageToCurrent4b.pin_n, ground4b.p) annotation (Line(points= 
         {{62,-68},{70,-68},{70,-70}}, color={0,0,255}));
  connect(ground4b.p, inductor4b.n) annotation (Line(points={{70,-70},{
          76,-70},{76,-70},{80,-70}}, color={0,0,255}));
  connect(sine34.y, voltage4.v) annotation (Line(points={{-79,-20},{-70, 
          -20},{-70,-60},{-62,-60}}, color={0,0,127}));
  connect(voltageToCurrent4a.f, conductor4.i1) 
    annotation (Line(points={{3,-68},{18,-68}}, color={0,0,127}));
  connect(voltageToCurrent4a.p, conductor4.v1) 
    annotation (Line(points={{3,-52},{19,-52}}, color={0,0,127}));
  connect(conductor4.v2, voltageToCurrent4b.p) 
    annotation (Line(points={{41,-52},{57,-52}}, color={0,0,127}));
  connect(conductor4.i2, voltageToCurrent4b.f) 
    annotation (Line(points={{42,-68},{57,-68}}, color={0,0,127}));
  connect(voltage4.p, inductor4a.p) 
    annotation (Line(points={{-50,-50},{-40,-50}}, color={0,0,255}));
  connect(ground4a.p, voltage4.n) 
    annotation (Line(points={{-30,-70},{-50,-70}}, color={0,0,255}));
  annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>这个例子展示了如何从多种电气组件中生成输入/输出块(例如，以FMU的形式<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)。
这个例子的构建目标是从Modelica中导出这样的输入/输出块，并将其导入到其他建模环境中。但是，对于用户来说导出输入/输出模块之前知道该组件如何在目标环境中使用是十分关键的。用户可以根据目标使用方式，在模块接口中设置不同的连接器变量，这些变量的功能可以是输入功能或输出功能。
请注意，这个示例模型可用于测试Modelica工具(FMU)的导出/导入。用户只需将带有图标中“toFMU”标记的组件导出为FMU，然后将它们重新导入。这样操作后，模型仍然能发挥作用，并且在纯Modelica模型中给出导出/导入前相同的结果。</p>

<p>下面将分为四段介绍如何在目标系统中导出或者连接不同的电路元件:</p>
<p><strong>连接两个电容器</strong><br>
这个第一段(DirectCapacitor、InverseCapacitor)演示了如何导出两个电容器并在目标系统中将它们连接在一起。这需要一个capacitor(DirectCapacitor)被定义为具有状态，并且在接口中提供电压和电压的导数。另一个capacitor(InverseCapacitor)需要根据提供的输入电压和电压的导数来提供电流。</p>

<p><strong>将一个电阻元件连接在两个电容器之间</strong><br>
第二部分展示了如何导出一个仅依赖电压来确定其电阻特性的电阻元件(Resistor2),并在目标体系中将这个电阻连接于两个电容器之间，形成一个电路模型。</p>

<p>
<strong>连接两个电感</strong><br>
第三部分展示了如何将两个电感(DirectInductor, InverseInductor)导出并在目标系统中将他们连接起来。这要求DirectInductor被定义为有状态，并且其接口提供电流及电流的变化率。InverseInductor根据提供给它的电流及其变化率决定所需的电压。</p>

<p>
<strong>在两个电感器之间接入一个电导元件</strong><br>
第四部分展示了如何导出一个电导元件(Conductor4)，该元件根据其仅依赖于电流的特性进行工作。在这个示例中，该电导元件被连接在两个电感器之间，以便实现电流控制。这种配置通常出现在模拟电路和测试电路中，用于探究电导元件会对其他电气组件产生什么影响。</p>
<p>请记住，如果你想将物理组件(例如电子元件)分离开来，但又想让它们能够通过某种信号(例如电信号)相互连接和交互，那么你需要放置适当的<a href=\"modelica://Modelica.Electrical.Analog.Basic.Ground\">接地组件</a>来定义子电路内的电势。
。
</p>
</html>"));
end GenerationOfFMUs;