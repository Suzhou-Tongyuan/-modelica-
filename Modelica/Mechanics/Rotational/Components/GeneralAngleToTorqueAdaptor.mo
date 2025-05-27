within Modelica.Mechanics.Rotational.Components;
model GeneralAngleToTorqueAdaptor 
  "用于旋转一维转动接口的信号适配器，以扭矩为输出，角度、速度和加速度为输入（特别适用于FMU）"
  extends 
    Modelica.Blocks.Interfaces.Adaptors.PotentialToFlowAdaptor(
    final Name_p="phi", 
    final Name_pder="w", 
    final Name_pder2="a", 
    final Name_f="tau", 
    final Name_fder="der(tau)", 
    final Name_fder2="der2(tau)", 
    final use_fder=false, 
    final use_fder2=false, 
    final p(unit="rad"), 
    final pder(unit="rad/s"), 
    final pder2(unit="rad/s2"), 
    final f(unit="N.m"), 
    final fder(unit="N.m/s"), 
    final fder2(unit="N.m/s2"));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b    flange 
    annotation (Placement(transformation(extent={{10,-10},{30,10}}), 
        iconTransformation(extent={{10,-10},{30,10}})));
equation
  y = flange.tau "output = flow = torque";
  u = flange.phi "input = potential = angle";
  annotation (defaultComponentName="angleToTorqueAdaptor", 
    Documentation(info="<html>
<p>
用于一维转动接口连接器和一维转动接口信号表示之间的适配器。
此组件用于为旋转模型提供纯信号接口，并将此模型以输入/输出块的形式导出，
尤其是作为FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>).
此适配器以角度、角速度和角加速度为输入信号，以扭矩为输出信号。
</p>
<p>
注意，输入信号之间必须相互一致
（w=der(phi), a=der(w)）。
</p>
</html>"), 
    Icon(graphics={
            Rectangle(
              extent={{-20,100},{20,-100}}, 
              lineColor={95,95,95}, 
              radius=10, 
          lineThickness=0.5)}));
end GeneralAngleToTorqueAdaptor;