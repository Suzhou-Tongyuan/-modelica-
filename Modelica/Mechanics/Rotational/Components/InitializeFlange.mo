within Modelica.Mechanics.Rotational.Components;
model InitializeFlange 
   "使用预定义的角度、速度和角加速度初始化一个一维转动接口（通常，这是来自控制总线的参考数据）"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean use_phi_start=true 
    "= true，如果初始角度由输入 phi_start 定义，否则未初始化";
  parameter Boolean use_w_start=true 
    "= true，如果初始速度由输入 w_start 定义，否则未初始化";
  parameter Boolean use_a_start=true 
    "= true，如果初始角加速度由输入 a_start 定义，否则未初始化";

  parameter StateSelect stateSelect=StateSelect.default 
    "使用一维转动接口角度和速度作为状态的优先级";

  Modelica.Blocks.Interfaces.RealInput phi_start(unit="rad") if use_phi_start 
    "一维转动接口的初始角度" annotation (Placement(transformation(extent={
            {-140,60},{-100,100}}), iconTransformation(extent={
            {-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput w_start(unit="rad/s") if use_w_start 
    "一维转动接口的初始速度" annotation (Placement(transformation(extent={
            {-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput a_start(unit="rad/s2") if use_a_start 
    "一维转动接口的初始角加速度" annotation (Placement(
        transformation(extent={{-140,-100},{-100,-60}}), 
        iconTransformation(extent={{-140,-100},{-100,-60}})));
  Interfaces.Flange_b flange "初始化的一维转动接口" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));

  SI.Angle phi_flange(stateSelect=stateSelect) = flange.phi 
    "一维转动接口角度";
  SI.AngularVelocity w_flange(stateSelect=stateSelect) = der(
    phi_flange) "= der(phi_flange)";

protected
  encapsulated model Set_phi_start "设置 phi_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput phi_start(unit="rad") 
      "起始角度" 
      annotation (HideResult=true, Placement(transformation(extent={{-140,-20}, 
              {-100,20}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));
    annotation();
  initial equation
    flange.phi = phi_start;
  equation
    flange.tau = 0;

  end Set_phi_start;

  encapsulated model Set_w_start "设置起始角速度"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput w_start(unit="rad/s") 
      "起始角加速度" 
      annotation (HideResult=true, Placement(transformation(extent={{-140,-20}, 
              {-100,20}})));

    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));
    annotation();
  initial equation
    der(flange.phi) = w_start;
  equation
    flange.tau = 0;

  end Set_w_start;

  encapsulated model Set_a_start "设置 a_start"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Blocks.Interfaces.RealInput a_start(unit="rad/s2") 
      "起始角加速度" annotation (HideResult=true, Placement(
          transformation(extent={{-140,-20},{-100,20}})));

    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange(phi(
          stateSelect=StateSelect.avoid)) annotation (Placement(
          transformation(extent={{90,-10},{110,10}})));

    Modelica.Units.SI.AngularVelocity w=der(flange.phi) 
      annotation (HideResult=true);
    annotation();
  initial equation
    der(w) = a_start;
  equation
    flange.tau = 0;
  end Set_a_start;

  encapsulated model Set_flange_tau "将 flange.tau 设置为零"
    import Modelica;
    extends Modelica.Blocks.Icons.Block;
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));
    annotation();
  equation
    flange.tau = 0;
  end Set_flange_tau;
protected
  Set_phi_start set_phi_start if use_phi_start annotation (Placement(
        transformation(extent={{-20,70},{0,90}})));
  Set_w_start set_w_start if use_w_start annotation (Placement(
        transformation(extent={{-20,-10},{0,10}})));
  Set_a_start set_a_start if use_a_start annotation (Placement(
        transformation(extent={{-20,-90},{0,-70}})));
  Set_flange_tau set_flange_tau annotation (Placement(transformation(extent= 
           {{96,-90},{76,-70}})));
equation
  connect(set_phi_start.phi_start, phi_start) annotation (Line(
      points={{-22,80},{-120,80}}, color={0,0,127}));
  connect(set_phi_start.flange, flange) annotation (Line(
      points={{0,80},{60,80},{60,0},{100,0}}));
  connect(set_w_start.flange, flange) annotation (Line(
      points={{0,0},{100,0}}));
  connect(set_w_start.w_start, w_start) annotation (Line(
      points={{-22,0},{-120,0}}, color={0,0,127}));
  connect(set_a_start.a_start, a_start) annotation (Line(
      points={{-22,-80},{-120,-80}}, color={0,0,127}));
  connect(set_a_start.flange, flange) annotation (Line(
      points={{0,-80},{60,-80},{60,0},{100,0}}));
  connect(set_flange_tau.flange, flange) annotation (Line(
      points={{76,-80},{60,-80},{60,0},{100,0}}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{-94,94},{66,66}}, 
          textString="phi_start", 
          textColor={128,128,128}), 
        Text(
          extent={{-94,16},{60,-14}}, 
          textString="w_start", 
          textColor={128,128,128}), 
        Text(
          extent={{-92,-66},{60,-94}}, 
          textString="a_start", 
          textColor={128,128,128})}), 
    Documentation(info="<html><p>
该组件用于以可选方式初始化连接到该组件的一维转动接口的角度、速度和/或角加速度。 通过参数 use_phi_start、use_w_start、use_a_start，相应的输入信号 phi_start、w_start、a_start 被有条件地激活。 如果输入被激活，则相应的一维转动接口属性在起始时间被初始化为输入值。
</p>
<p>
例如，如果\"use_phi_start = true\"，那么在起始时间，flange.phi 将被初始化为输入信号 \"phi_start\" 的值。
</p>
<p>
此外，可以通过参数 \"stateSelection\" 以可选地方式定义一维转动接口角度和一维转动接口速度的 \"StateSelect\" 属性。
</p>
<p>
当需要根据控制器的参考信号（通过信号总线提供）来设置一维转动接口的初始值时（该组件在此种情况下非常便利）。
</p>
</html>"));
end InitializeFlange;