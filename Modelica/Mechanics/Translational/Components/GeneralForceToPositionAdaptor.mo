within Modelica.Mechanics.Translational.Components;
model GeneralForceToPositionAdaptor 
  "信号适配器，用于将位置、速度、加速度作为输出，力作为输入的一维平动接口(特别适用于FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.FlowToPotentialAdaptor(
    final Name_p="s", 
    final Name_pder="v", 
    final Name_pder2="a", 
    final Name_f="f", 
    final Name_fder="der(f)", 
    final Name_fder2="der2(f)", 
    final use_fder=false, 
    final use_fder2=false, 
    final p(unit="m"), 
    final pder(unit="m/s"), 
    final pder2(unit="m/s2"), 
    final f(unit="N"), 
    final fder(unit="N/s"), 
    final fder2(unit="N/s2"));
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
equation
  y = flange.s "输出 = 势能 = 位置";
  u = flange.f "输入 = 流量 = 力";
  annotation (
    defaultComponentName="forceToPositionAdaptor", 
    Documentation(info="<html>
<p>
一维平动接口 连接器与一维平动接口 信号表示之间的适配器。
此组件用于提供纯信号接口围绕平移模型并以输入/输出块的形式导出此模型，
特别是作为FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)。
在<a href=\"modelica://Modelica.Mechanics.Translational.Examples.GenerationOfFMUs\">Translational.Examples.GenerationOfFMUs</a>中提供了此适配器的使用示例。
此适配器将力作为输入，并将位置、速度和加速度作为输出信号。
</p>
</html>"), Icon(graphics={
            Rectangle(
              extent={{-20,100},{20,-100}}, 
              lineColor={0,127,0}, 
              radius=10, 
          lineThickness=0.5)}));
end GeneralForceToPositionAdaptor;