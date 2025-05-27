within Modelica.Electrical.Analog.Basic;
model GeneralCurrentToVoltageAdaptor 
  "一种电气一端口信号适配器，输出电压和电压微分，输入电流和电流微分(特别适用于 FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.FlowToPotentialAdaptor(
    final Name_p="v", 
    final Name_pder="dv", 
    final Name_pder2="d2v", 
    final Name_f="i", 
    final Name_fder="di", 
    final Name_fder2="d2i", 
    final use_pder2=false, 
    final use_fder2=false, 
    final p(unit="V"), 
    final pder(unit="V/s"), 
    final pder2(unit="V/s2"), 
    final f(unit="A"), 
    final fder(unit="A/s"), 
    final fder2(unit="A/s2"));
  SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
  SI.Current i "Current flowing from pin p to pin n";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p 
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n 
    annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
equation
  v = pin_p.v - pin_n.v;
  i = pin_p.i;
  pin_p.i + pin_n.i = 0;
  y = v "output = potential = voltage";
  u = i "input = flow = current";
  annotation (defaultComponentName="currentToVoltageAdaptor", Documentation(info="<html>
<p>
这个适配器是电气一端口与信号表示之间的桥梁。它设计用于为电气模型提供一个纯粹的信号接口，将模型封装为输入/输出模块的形式。这种组件特别适用于将模型转换为功能模拟单元(FMU)(<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)，这是一种在仿真和系统集成中常见的格式，这种格式允许模型以标准格式被其他软件工具调用和交互。
使用方法查看<a href=\"modelica://Modelica.Electrical.Analog.Examples.GenerationOfFMUs\">Electrical.Analog.Examples.GenerationOfFMUs</a>
这个适配器将电流和电流的导数作为输入信号，将电压和电压的导数作为输出信号。</p>
<p>
请注意，输入信号必须一致。
(di=der(i))。
</p>
<p>
请注意，这个组件包含<strong>no ground</strong>。

请记住，将物理组件分离并通过适配器信号连接时，需要放置适当的<a href=\"modelica://Modelica.Electrical.Analog.Basic.Ground\">接地</a>组件，以在子电路中定义电位。
</p>
</html>"), Icon(graphics={
            Rectangle(
              extent={{-20,100},{20,-100}}, 
              lineColor={0,0,255}, 
              radius=10, 
          lineThickness=0.5)}));
end GeneralCurrentToVoltageAdaptor;