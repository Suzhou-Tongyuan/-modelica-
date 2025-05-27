within Modelica.Electrical.Machines.Examples.DCMachines;
model DCSE_SinglePhase 
  "测试示例：串励磁的直流电机，通过斜坡电压启动"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "实际电枢电压RMS";
  parameter SI.Time tStart=0.1 "电阻斜坡开始时间";
  parameter SI.Time tRamp=0.9 "电阻斜坡";
  parameter SI.Torque TLoad=63.66 "额定负载转矩";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")= 
       1410*2*Modelica.Constants.pi/60 "额定负载转速";
  parameter SI.Inertia JLoad=0.15 
    "负载的转动惯量";
  Machines.BasicMachines.DCMachines.DC_SeriesExcited dcse(
    VaNominal=dcseData.VaNominal, 
    IaNominal=dcseData.IaNominal, 
    wNominal=dcseData.wNominal, 
    TaNominal=dcseData.TaNominal, 
    TeNominal=dcseData.TeNominal, 
    Ra=dcseData.Ra, 
    TaRef=dcseData.TaRef, 
    La=dcseData.La, 
    Jr=dcseData.Jr, 
    useSupport=false, 
    Js=dcseData.Js, 
    frictionParameters=dcseData.frictionParameters, 
    coreParameters=dcseData.coreParameters, 
    strayLoadParameters=dcseData.strayLoadParameters, 
    brushParameters=dcseData.brushParameters, 
    Re=dcseData.Re, 
    TeRef=dcseData.TeRef, 
    Le=dcseData.Le, 
    sigmae=dcseData.sigmae, 
    TaOperational=293.15, 
    alpha20a=dcseData.alpha20a, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    ia(fixed=true), 
    alpha20e=dcseData.alpha20e, 
    TeOperational=293.15) 
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=tRamp, 
    startTime=tStart, 
    height=-1, 
    offset=1) annotation (Placement(transformation(extent={{60,0},{40,20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage constantVoltage(V=sqrt(2) 
        *Va, f=50) annotation (Placement(transformation(extent={{0, 
            50},{-20,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    quadraticLoadTorque(
    w_nominal=wLoad, 
    TorqueDirection=false, 
    tau_nominal=-TLoad, 
    useSupport=false) annotation (Placement(transformation(extent={{90,-50}, 
            {70,-30}})));
  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,10})));
  parameter Utilities.ParameterRecords.DcSeriesExcitedData dcseData "直流机数据" 
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(constantVoltage.n, ground.p) 
    annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) 
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(dcse.pin_an, dcse.pin_ep) annotation (Line(points={{-16,-30},{-20, 
          -30},{-20,-34}}, color={0,0,255}));
  connect(dcse.pin_en, constantVoltage.n) annotation (Line(points={{-20,-46}, 
          {-30,-46},{-30,-20},{-20,-20},{-20,40}}, color={0,0,255}));
  connect(dcse.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  connect(constantVoltage.p, variableResistor.p) annotation (Line(
      points={{0,40},{0,20}}, color={0,0,255}));
  connect(variableResistor.n, dcse.pin_ap) annotation (Line(
      points={{0,0},{0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
  connect(ramp.y, variableResistor.R) annotation (Line(
      points={{39,10},{12,10}}, color={0,0,127}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>

<p>在正弦源电压下，通过电阻限制电枢电流，电阻根据斜坡逐渐减小，导致直流机启动，
并对抗负载扭矩，该扭矩与转速成二次关系，最终达到额定转速。</p>
<p>该示例的仿真时间为2秒，用户可以在特定界面通过勾选绘制以下变量的图像(相对于时间)：
<ul>
<li>dcse.ia：电枢电流</li>
<li>dcse.wMechanical：电机转速</li>
<li>dcse.tauElectrical：电机转矩</li>
</ul>
使用模型<em>DC_SeriesExcited</em>的默认机械参数。</p>
<p><strong>注意：</strong>
由于励磁和电枢电流都是正弦波形，扭矩波形是正弦的平方。
由于附加的感性电压降，与相同电压下的同一电机（DCSE_Start）相比，电机的输出更低。</p>
</html>"));
end DCSE_SinglePhase;