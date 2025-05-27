within Modelica.Mechanics.Translational.Components;
model Vehicle "简单的车辆模型"
  parameter SI.Mass m "车辆的总质量";
  parameter SI.Acceleration g=Modelica.Constants.g_n "常数重力加速度";
  parameter SI.Inertia J "传动系统的总转动惯量";
  parameter SI.Length R "车轮半径";
  parameter SI.Area A(start=1) "车辆的横截面积" 
    annotation(Dialog(tab="行驶阻力", group="抗阻力特性"));
  parameter Real Cd(start=0.5) "阻力系数" 
    annotation(Dialog(tab="行驶阻力", group="抗阻力特性"));
  parameter SI.Density rho=1.2 "空气密度" 
    annotation(Dialog(tab="行驶阻力", group="抗阻力特性"));
  parameter Boolean useWindInput=false "启用风速信号输入" 
    annotation(Dialog(tab="行驶阻力", group="抗阻力特性"));
  parameter SI.Velocity vWindConstant=0 "恒定风速" 
    annotation(Dialog(tab="行驶阻力", group="抗阻力特性", enable=not useWindInput));
  parameter Boolean useCrInput=false "启用 Cr 信号输入" 
    annotation(Dialog(tab="行驶阻力", group="滚动阻力"));
  parameter Real CrConstant=0.015 "恒定滚动阻力系数" 
    annotation(Dialog(tab="行驶阻力", group="滚动阻力", enable=not useCrInput));
  parameter SI.Velocity vReg=1e-3 "用于围绕零的正则化速度" 
    annotation(Dialog(tab="行驶阻力", group="滚动阻力"));
  parameter Boolean useInclinationInput=false "启用倾斜角信号输入" 
    annotation(Dialog(tab="行驶阻力", group="抗倾角"));
  parameter Real inclinationConstant=0 "常数倾斜角 = tan(angle)" 
    annotation(Dialog(tab="行驶阻力", group="抗倾角", enable=not useInclinationInput));
  SI.Position s(displayUnit="km", start=0)=mass.s "车辆位置";
  SI.Velocity v(displayUnit="km/h", start=0)=mass.v "车辆速度";
  SI.Acceleration a=mass.a "车辆加速度";
protected
  constant SI.Velocity vRef=1 "空气阻力的参考速度";
public
  Sources.QuadraticSpeedDependentForce fDrag(
    final useSupport=true, 
    final f_nominal=-Cd*A*rho*vRef^2/2, 
    final ForceDirection=false, 
    final v_nominal=vRef) "阻力" 
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  RollingResistance fRoll(
    final fWeight=m*g, 
    final useCrInput=useCrInput, 
    final CrConstant=CrConstant, 
    final useInclinationInput=useInclinationInput, 
    final inclinationConstant=inclinationConstant, 
    final reg=Modelica.Blocks.Types.Regularization.Linear, 
    final v0=vReg) "滚动阻力" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={60,0})));
  Sources.Force fGrav "倾斜阻力" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={60,30})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flangeT "一维平动接口" 
    annotation (Placement(transformation(extent={{90,10},{110,-10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flangeR "转动法兰" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Rotational.Components.Inertia inertia(final J=J) 
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  IdealRollingWheel idealRollingWheel(final radius=R) 
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Mass mass(final m=m) annotation (Placement(transformation(extent={{30,50}, 
            {50,70}})));
  Modelica.Blocks.Interfaces.RealInput inclination if useInclinationInput 
    "倾斜角=tan(angle)" 
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput cr if useCrInput 
    "滚动阻力系数" 
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput vWind(unit="m/s") if useWindInput 
    "风速" 
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={60,-120})));
  Sources.Speed windSpeed(s(fixed=true))  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={60,-60})));
  Blocks.Math.Gain gravForceGain(final k=-m*g) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={20,30})));
protected
  Modelica.Blocks.Sources.Constant constInclination(k=inclinationConstant) if not useInclinationInput 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-80,-90})));
  Modelica.Blocks.Sources.Constant constWindSpeed(k=vWindConstant) if not useWindInput 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={40,-90})));
public
  Blocks.Math.Atan atan annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-40,30})));
  Blocks.Math.Sin sin annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-10,30})));

equation
  connect(idealRollingWheel.flangeT, mass.flange_a) 
    annotation (Line(points={{10,60},{30,60}}, 
                                             color={0,127,0}));
  connect(constWindSpeed.y, windSpeed.v_ref) 
    annotation (Line(points={{51,-90},{60,-90},{60,-72}}, color={0,0,127}));
  connect(vWind, windSpeed.v_ref) 
    annotation (Line(points={{60,-120},{60,-72}}, color={0,0,127}));
  connect(fDrag.support, windSpeed.flange) 
    annotation (Line(points={{60,-40},{60,-50}}, color={0,127,0}));
  connect(mass.flange_b, flangeT) annotation (Line(points={{50,60},{80,60},{80,0},{100,0}}, 
                    color={0,127,0}));
  connect(sin.u, atan.y) 
    annotation (Line(points={{-22,30},{-29,30}},   color={0,0,127}));
  connect(gravForceGain.u, sin.y) annotation (Line(points={{8,30},{1,30}},     color={0,0,127}));
  connect(gravForceGain.y, fGrav.f) 
    annotation (Line(points={{31,30},{48,30}}, color={0,0,127}));
  connect(mass.flange_b, fDrag.flange) annotation (Line(points={{50,60},{80,60},{80,-30},{70,-30}}, 
                                  color={0,127,0}));
  connect(mass.flange_b, fRoll.flange) annotation (Line(points={{50,60},{80,60},{80,0},{70,0}}, 
                              color={0,127,0}));
  connect(mass.flange_b, fGrav.flange) annotation (Line(points={{50,60},{80,60},{80,30},{70,30}}, 
                                color={0,127,0}));
  connect(inertia.flange_b, idealRollingWheel.flangeR) 
    annotation (Line(points={{-30,60},{-10,60}}, color={0,0,0}));
  connect(flangeR, inertia.flange_a) annotation (Line(points={{-100,0},{-80,0},{
          -80,60},{-50,60}}, color={0,0,0}));
  connect(cr,fRoll.cr) 
    annotation (Line(points={{0,-120},{0,-6},{48,-6}}, color={0,0,127}));
  connect(inclination, fRoll.inclination) 
    annotation (Line(points={{-60,-120},{-60,6},{48,6}}, color={0,0,127}));
  connect(inclination, atan.u) annotation (Line(points={{-60,-120},{-60,30}, 
          {-52,30}}, color={0,0,127}));
  connect(atan.u, constInclination.y) annotation (Line(points={{-52,30},{
          -60,30},{-60,-90},{-69,-90}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
    Line(points={{-80,-70},{80,-70}}, color={0,127,0}), 
    Line(points={{-80,0},{85.607,-1.19754}}, 
      color={0,127,0}, origin={-3,-49}, rotation=15), 
    Ellipse(extent={{-130,-120},{-30,-20}}, lineColor={0,127,0}, 
      startAngle=0, endAngle=15, 
      closure=EllipseClosure.None), 
    Polygon(points={{-70,15},{-70,-25},{50,-25},{50,15},{38,25},{-60,25},{-70,15}}, 
      lineColor={0,127,0}, fillColor={160,215,160}, fillPattern=FillPattern.Solid, origin={0,-9}, rotation=15), 
    Line(points={{-40,0},{40,0}}, color={95,127,95}, origin={-40,32}, rotation=15), 
    Polygon(points={{15,0},{-15,10},{-15,-10},{15,0}}, lineColor={95,127,95}, fillColor={95,127,95}, 
      fillPattern = FillPattern.Solid, origin={11,46}, rotation=15), 
    Text(extent={{-150,100},{150,60}}, textString="%name", textColor={0,0,255}), 
    Polygon(points={{-20,0},{0,10},{0,4},{20,4},{20,-4},{0,-4},{0,-10},{-20,0}}, lineColor={0,127,0}, fillColor={160,215,160}, 
      fillPattern = FillPattern.Solid, origin={68,18}, rotation=15), 
    Text(
      extent={{-80,-80},{-40,-100}}, 
      textColor={64,64,64}, 
      textString="inc."), 
    Text(
      extent={{-20,-80},{20,-100}}, 
      textColor={64,64,64}, 
      textString="cr"), 
    Text(
      extent={{30,-80},{90,-100}}, 
      textColor={64,64,64}, 
      textString="wind"), 
    Ellipse(extent={{-50,-34},{-26,-58}},lineColor={0,127,0}, fillPattern=FillPattern.Sphere, fillColor={160,215,160}), 
    Ellipse(extent={{20,-16},{44,-40}},  lineColor={0,127,0}, fillPattern=FillPattern.Sphere, fillColor={160,215,160}), 
    Ellipse(extent={{26,-22},{38,-34}},  lineColor={0,127,0}, fillPattern=FillPattern.Solid, 
      fillColor={255,255,255}), 
    Ellipse(extent={{-44,-40},{-32,-52}},lineColor={0,127,0}, fillPattern=FillPattern.Solid, 
      fillColor={255,255,255})}), 
    Documentation(info="<html><p>
这是一个简单的地面车辆模型，包括质量、空气阻力、滚动阻力和倾斜阻力（由道路坡度引起）。 对于所有特定的阻力，重要变量可以是参数给定，也可以是时间可变信号输入。
</p>
<p>
车辆可以在一维转动组件接口 <code>flangeR</code> 驱动，例如通过电动机和变速箱。 也可以将车辆用作被动拖车，保持一维转动组件接口 <code>flangeR</code> 未连接。
</p>
<p>
在一维平动接口 <code>flangeT</code> 上，车辆可以与另一个车辆连接，例如作为拖车或拉拖车。 也可以将一维平动接口 <code>flangeT</code> 保持未连接。
</p>
<p>
提供车辆的速度 <code>v</code> 和行驶距离 <code>s</code> 作为变量； 可以使用这些变量初始化车辆。
</p>
<h4>质量和惯性</h4><p>
当车辆加速时，既有平动车辆质量又有旋转惯量（例如车轮被加速时）。 这种特性通常在基本车辆分析中考虑，这些分析通常在旋转或平动领域进行，例如在分析车辆传动时。 然后，车辆质量 <code>m</code> 可以表达为额外的等效惯量 <sup><code>J_eq = m * R2</code></sup> 或者 反之旋转惯量 <code>J</code> 作为额外的等效质量 <sup><code>m_eq = J/R2</code></sup>， 其中 <code>R</code> 是车轮半径。 由于这个模型还引入了滚动阻力和倾斜阻力，其中只有车辆质量起作用， 所以等效质量/惯量的方法会导致不正确的模拟结果，因此在这里不应用这种方法。
</p>
<h4>空气阻力</h4><pre><code >fDrag = Cd*rho*A*(v - vWind)^2/2
</code></pre><p>
风速在与 <code>flangeT</code> 的速度相同的方向上测量。 风速可以是恒定的，也可以由输入 <code>vWind</code> 指定。
</p>
<h4>滚动阻力</h4><pre><code >fRoll = Cr*m*g*cos(alpha)
</code></pre><p>
滚动阻力系数 &nbsp;可以是常数或由输入 <code>cr</code> 指定。 滚动阻力在 <code>[-vReg, vReg]</code> 范围内从正到负速度进行交叉。
</p>
<p>
倾斜角度 &nbsp;可以是常数或由输入 <code>inclination</code> = tan() 指定。 这对应于 100 米行驶距离上的路面上升。 例如，对于每 100 米上升 10 米的路面，坡度为 10%，因此参数 <code>inclinationConstant = 0.1</code>。 正的倾斜角意味着上坡行驶，负的倾斜角意味着下坡行驶（在正的车辆速度情况下）。
</p>
<h4>倾斜阻力</h4><pre><code >fGrav = m*g*sin(alpha)
</code></pre><p>
倾斜角度 &nbsp;如上所述。
</p>
<p>
<br>
</p>
</html>"));
end Vehicle;