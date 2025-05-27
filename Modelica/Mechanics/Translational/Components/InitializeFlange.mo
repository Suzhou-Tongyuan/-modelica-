within Modelica.Mechanics.Translational.Components;
model InitializeFlange 
  "初始化一个一维平动接口，具有预定义的位置、速度和加速度（通常，这是来自控制总线的参考数据）"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean use_s_start=true 
    "= true，如果初始位置由输入 s_start 定义，否则不初始化";
  parameter Boolean use_v_start=true 
    "= true，如果初始速度由输入 v_start 定义，否则不初始化";
  parameter Boolean use_a_start=true 
    "= true，如果初始加速度由输入 a_start 定义，否则不初始化";

  parameter StateSelect stateSelect=StateSelect.default 
    "使用一维平动接口角和速度作为状态的优先级";

  Modelica.Blocks.Interfaces.RealInput s_start(unit="m") if use_s_start 
    "一维平动接口的初始位置" annotation (Placement(transformation(
          extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput v_start(unit="m/s") if use_v_start 
    "一维平动接口的初始速度" annotation (Placement(transformation(extent={
            {-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput a_start(unit="m/s2") if use_a_start 
    "一维平动接口的初始角加速度" annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}})));
  Interfaces.Flange_b flange "被初始化的一维平动接口" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));

  SI.Position s_flange(stateSelect=stateSelect) = flange.s 
    "一维平动接口位置";
  SI.Velocity v_flange(stateSelect=stateSelect) = der(
    s_flange) "= der(s_flange)";

protected
  encapsulated model Set_s_start "设置 s_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput s_start(unit="m") "起始位置" 
      annotation (HideResult=true, Placement(transformation(extent={{-140,-20}, 
              {-100,20}})));

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
       Placement(transformation(extent={{90,-10},{110,10}})));
    annotation();
  initial equation
    flange.s = s_start;
  equation
    flange.f = 0;

  end Set_s_start;

  encapsulated model Set_v_start "设置 v_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput v_start(unit="m/s") 
      "起始速度" annotation (HideResult=true, Placement(
          transformation(extent={{-140,-20},{-100,20}})));

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
       Placement(transformation(extent={{90,-10},{110,10}})));
    annotation();
  initial equation
    der(flange.s) = v_start;
  equation
    flange.f = 0;

  end Set_v_start;

  encapsulated model Set_a_start "设置 a_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput a_start(unit="m/s2") 
      "起始加速度" annotation (HideResult=true, Placement(
          transformation(extent={{-140,-20},{-100,20}})));

    Modelica.Mechanics.Translational.Interfaces.Flange_b flange(s(
          stateSelect=StateSelect.avoid)) annotation (Placement(
          transformation(extent={{90,-10},{110,10}})));
    Modelica.Units.SI.Velocity v=der(flange.s) annotation (HideResult=true);
    annotation();
  initial equation
    der(v) = a_start;
  equation
    flange.f = 0;

  end Set_a_start;

  encapsulated model Set_flange_f "将 flange_f 设置为零"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
       Placement(transformation(extent={{90,-10},{110,10}})));
    annotation();
  equation
    flange.f = 0;
  end Set_flange_f;
protected
  Set_s_start set_s_start if use_s_start annotation (Placement(
        transformation(extent={{-20,50},{0,70}})));
  Set_v_start set_v_start if use_v_start annotation (Placement(
        transformation(extent={{-20,-10},{0,10}})));
  Set_a_start set_a_start if use_a_start annotation (Placement(
        transformation(extent={{-20,-70},{0,-50}})));
  Set_flange_f set_flange_f annotation (Placement(transformation(extent={{
            20,-100},{40,-80}})));
equation
  connect(set_s_start.flange, flange) annotation (Line(
      points={{0,60},{60,60},{60,0},{100,0}}));
  connect(set_v_start.flange, flange) annotation (Line(
      points={{0,0},{100,0}}));
  connect(set_a_start.flange, flange) annotation (Line(
      points={{0,-60},{60,-60},{60,0},{100,0}}));
  connect(set_flange_f.flange, flange) annotation (Line(
      points={{40,-90},{60,-90},{60,0},{100,0}}));
  connect(s_start, set_s_start.s_start) annotation (Line(
      points={{-120,60},{-22,60}}, color={0,0,127}));
  connect(v_start, set_v_start.v_start) annotation (Line(
      points={{-120,0},{-22,0}}, color={0,0,127}));
  connect(a_start, set_a_start.a_start) annotation (Line(
      points={{-120,-60},{-22,-60}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Text(
              extent={{-94,74},{68,46}}, 
              textString="s_start"),Text(
              extent={{-94,16},{70,-14}}, 
              textString="v_start"),Text(
              extent={{-94,-46},{66,-74}}, 
              textString="a_start")}), Documentation(info="<html>
<p>
此组件用于可选地初始化连接到此组件的一维平动接口的位置、速度和/或加速度。
通过参数 use_s_start、use_v_start、use_a_start 来条件激活相应的输入信号 s_start、v_start、a_start。
如果激活了输入，则在启动时间将相应的一维平动接口属性初始化为输入值。

例如，如果 \"use_s_start = true\"，则一维平动接口的 s 将在启动时间使用输入信号 \"s_start\" 的值初始化。

另外，还可以通过参数 \"stateSelection\" 可选地定义一维平动接口位置和一维平动接口速度的 \"StateSelect\" 属性。

当需要根据控制器的参考信号设置一维平动接口的初始值时，此组件特别有用。
</p>

</html>"));
end InitializeFlange;