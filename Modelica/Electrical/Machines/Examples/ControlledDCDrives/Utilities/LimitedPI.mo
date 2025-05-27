within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
block LimitedPI 
  "带有反馈环和前馈的有限积分-比例控制器"
  extends Modelica.Blocks.Interfaces.SISO;
  import Modelica.Blocks.Types.Init;
  import Modelica.Constants.inf;
  Modelica.Blocks.Interfaces.RealInput u_m "测量信号的连接器" 
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput feedForward if useFF 
    "前馈信号的连接器" 
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120}), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput kFF if useFF and not useConstantKFF 
    "前馈因子的连接器" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={60,-120}), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={60,-120})));
  Modelica.Blocks.Interfaces.RealInput yMaxVar if not constantLimits 
    "yMax输入信号的连接器" annotation (Placement(transformation(
        origin={120,60}, 
        extent={{20,-20},{-20,20}})));
  Modelica.Blocks.Interfaces.RealInput yMinVar if not constantLimits and not symmetricLimits 
    "yMin输入信号的连接器" annotation (Placement(transformation(
        origin={120,-60}, 
        extent={{20,-20},{-20,20}})));
  output Real controlError = u - u_m 
    "控制误差（设定值 - 测量值）";
  parameter Real k(unit="1")=1 "增益";
  parameter Boolean useI=true "是否使用积分项" annotation(Evaluate=true);
  parameter SI.Time Ti(min=Modelica.Constants.small)=1 
    "积分时间常数（T>0 required）" annotation(Dialog(enable=useI));
  parameter Boolean useFF=false "使用前馈？" 
    annotation(Dialog(group="Feed-forward"));
  parameter Boolean useConstantKFF=true "使用恒定的前馈因子？" 
    annotation(Dialog(group="Feed-forward", enable=useFF));
  parameter Real KFF(unit="1")=1 "前馈增益" 
    annotation(Dialog(group="Feed-forward", enable=useFF and useConstantKFF));
  parameter Boolean constantLimits=true "使用恒定限制？" 
    annotation(Dialog(group="Limitation"));
  parameter Boolean symmetricLimits=true "使用对称限制？" 
    annotation(Dialog(group="Limitation"));
  parameter Real yMax = inf "输出的上限" 
    annotation(Dialog(group="Limitation", enable=constantLimits));
  parameter Real yMin=-yMax "输出的下限" 
    annotation(Dialog(group="Limitation", enable=constantLimits and not symmetricLimits));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit 
    "初始化类型（1：无初始化，2：稳态，3：初始状态，4：初始输出）" 
    annotation(Evaluate=true, 
      Dialog(group="Initialization"));
  parameter Real x_start=0 "状态的初始或猜测值" 
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0 "输出的初始值" 
    annotation(Dialog(enable=initType == Init.SteadyState or initType == Init.InitialOutput, group= 
          "Initialization"));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-80,0})));

  Modelica.Blocks.Math.Add addAntiWindup(k1=1, k2=-1/k) 
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=1/Ti, initType=Modelica.Blocks.Types.Init.NoInit) if useI 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Blocks.Math.Add3 add3(
    k1=k, 
    k2=k, 
    k3=1) 
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter 
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Math.Feedback addSat annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={50,-20})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={10,-70})));
protected
  Modelica.Blocks.Sources.Constant zeroI(k=0) if not useI 
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Sources.Constant zeroFF(k=0) if not useFF 
    annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
  Modelica.Blocks.Sources.Constant constantKFF(k=KFF) if not useFF or 
    useConstantKFF 
    annotation (Placement(transformation(extent={{90,-100},{70,-80}})));
  Modelica.Blocks.Sources.Constant yMaxConst(k=yMax) if constantLimits 
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Blocks.Sources.Constant yMinConst(k=yMin) if constantLimits and not symmetricLimits 
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Modelica.Blocks.Math.Gain gain(k=-1) if symmetricLimits annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}}, 
        rotation=270, 
        origin={58,10})));

initial equation
  if initType == Init.SteadyState and useI then
    der(add3.u2) = 0;
  elseif initType == Init.InitialState and useI then
    add3.u2 = x_start;
  elseif initType == Init.InitialOutput then
    add3.y = y_start;
  end if;

equation
  connect(addAntiWindup.y, integrator.u) annotation (Line(points={{-29,-20}, 
          {-22,-20}},      color={0,0,127}));
  connect(integrator.y, add3.u2) annotation (Line(points={{1,-20},{6,-20},{
          6,0},{18,0}}, 
                      color={0,0,127}));
  connect(add3.y, variableLimiter.u) 
    annotation (Line(points={{41,0},{68,0}}, color={0,0,127}));
  connect(variableLimiter.y, y) 
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(add3.y, addSat.u1) 
    annotation (Line(points={{41,0},{50,0},{50,-12}}, color={0,0,127}));
  connect(variableLimiter.y, addSat.u2) annotation (Line(points={{91,0},{94, 
          0},{94,-20},{58,-20}}, 
                             color={0,0,127}));
  connect(add3.u2, zeroI.y) annotation (Line(points={{18,0},{6,0},{6,30},{1,30}}, 
                 color={0,0,127}));
  connect(u, feedback.u1) 
    annotation (Line(points={{-120,0},{-88,0}}, color={0,0,127}));
  connect(feedback.y, add3.u1) annotation (Line(points={{-71,0},{-60,0},{
          -60,8},{18,8}}, 
                   color={0,0,127}));
  connect(feedback.y, addAntiWindup.u1) annotation (Line(points={{-71,0},{
          -60,0},{-60,-14},{-52,-14}}, 
                                color={0,0,127}));
  connect(u_m, feedback.u2) annotation (Line(points={{-60,-120},{-60,-90},{
          -80,-90},{-80,-8}}, 
                     color={0,0,127}));
  connect(addSat.y, addAntiWindup.u2) annotation (Line(points={{50,-29},{50, 
          -40},{-60,-40},{-60,-26},{-52,-26}}, color={0,0,127}));
  connect(yMinVar, variableLimiter.limit2) annotation (Line(points={{120, 
          -60},{64,-60},{64,-8},{68,-8}}, color={0,0,127}));
  connect(variableLimiter.limit2, yMinConst.y) annotation (Line(points={{68, 
          -8},{64,-8},{64,-60},{61,-60}}, color={0,0,127}));
  connect(yMaxVar, variableLimiter.limit1) annotation (Line(points={{120,60}, 
          {64,60},{64,8},{68,8}}, color={0,0,127}));
  connect(variableLimiter.limit1, yMaxConst.y) annotation (Line(points={{68, 
          8},{64,8},{64,60},{61,60}}, color={0,0,127}));
  connect(variableLimiter.limit2, gain.y) 
    annotation (Line(points={{68,-8},{58,-8},{58,5.6}}, color={0,0,127}));
  connect(variableLimiter.limit1, gain.u) annotation (Line(points={{68,8},{
          64,8},{64,20},{58,20},{58,14.8}}, 
                                      color={0,0,127}));
  connect(product.y, add3.u3) 
    annotation (Line(points={{10,-59},{10,-8},{18,-8}}, color={0,0,127}));
  connect(feedForward, product.u1) annotation (Line(points={{0,-120},{0,-90},{4, 
          -90},{4,-82}}, color={0,0,127}));
  connect(product.u1, zeroFF.y) 
    annotation (Line(points={{4,-82},{4,-90},{-9,-90}}, color={0,0,127}));
  connect(constantKFF.y, product.u2) 
    annotation (Line(points={{69,-90},{16,-90},{16,-82}}, color={0,0,127}));
  connect(product.u2, kFF) annotation (Line(points={{16,-82},{16,-90},{60,-90},{
          60,-120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}), 
        Line(visible=useI, points={{-80,-80},{-80,-20},{40.8594,66.3281}, 
              {60,66}},                                          color = {0,0,127}), 
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}), 
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{0,6},{60,-56}}, 
          textColor={192,192,192}, 
          textString="PI", visible=useI), 
        Text(
          extent={{0,6},{60,-56}}, 
          textColor={192,192,192}, 
          textString="P", visible=not useI), 
        Line(visible=not useI, points={{-80,-80},{-80,24},{56,24}},  color = {0,0,127})}), 
    Documentation(info="<html>
<p>
带有反馈环和前馈的有限积分-比例控制器，输出进行限制。
</p>
<p>
积分部分可以关闭以获得有限的比例控制器。
</p>
<p>
前馈增益可以是恒定的，也可以由可选的输入kFF给出。
</p>
<p>
当输出被限制时，控制器无法将控制误差减小到零，积分器将不会停止积分。
为了避免这种<strong>风扇效应</strong>，实现了一个<strong>反风扇效应</strong>环：
无限制和有限制的输出之间的差异被反馈到积分器的输入。
</p>
</html>"));
end LimitedPI;