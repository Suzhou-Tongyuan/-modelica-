within Modelica.Electrical.Analog.Basic;
model GeneralVoltageToCurrentAdaptor 
  "电气一端信号适配器，具有电流和电流导数作为输出，电压和电压导数作为输入(特别适用于FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.PotentialToFlowAdaptor(
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
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n 
    annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
equation
  v = pin_p.v - pin_n.v;
  i = pin_p.i;
  pin_p.i + pin_n.i = 0;
  y = i "output = flow = current";
  u = v "input = potential = voltage";
  annotation (defaultComponentName="voltageToCurrentAdaptor", Documentation(info="<html>
<p>
这种适配器是电气开放端与一端信号表示之间的桥梁。它设计用于封装电气模型，提供纯信号接口，将模型转换为输入/输出(I/O)块的形式，特别适合于作为Functional Mock-up Unit(FMU)导出，以便在仿真环境中进行交互和集成。(<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
用法查看
<a href=\"modelica://Modelica.Electrical.Analog.Examples.GenerationOfFMUs\">Electrical.Analog.Examples.GenerationOfFMUs</a>.
这个适配器的输入信号包括电压和电压的导数(例如，电流的瞬时变化率)，而输出信号则是电流和电流的导数(可能是电压的瞬时变化率)。它本质上是一个将电压控制和状态信息转化为电流控制和状态信息的转换器。
</p>
<p>
请注意，输入信号必须一致(dv=der(v)).
</p>
<p>
请注意，这个组件包含<strong>no ground</strong>。 请记住，将物理组件分离并通过适配器信号连接时，需要放置适当的<a href=\"modelica://Modelica.Electrical.Analog.Basic.Ground\">ground components</a>以在子电路中定义电位。
</p>
</html>"), 
         Icon(graphics={
            Rectangle(
              extent={{-20,100},{20,-100}}, 
              lineColor={0,0,255}, 
              radius=10, 
          lineThickness=0.5)}));
end GeneralVoltageToCurrentAdaptor;