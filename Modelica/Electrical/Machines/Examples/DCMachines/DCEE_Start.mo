within Modelica.Electrical.Machines.Examples.DCMachines;
model DCEE_Start 
  "测试示例：电励磁直流电机，通过斜坡电压启动"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "实际电枢电压";
  parameter SI.Time tStart=0.2 
    "电枢电压斜坡开始时间";
  parameter SI.Time tRamp=0.8 "电枢电压斜坡";
  parameter SI.Voltage Ve=100 "实际励磁电压";
  parameter SI.Torque TLoad=63.66 "额定负载转矩";
  parameter SI.Time tStep=1.5 "负载转矩阶跃时间";
  parameter SI.Inertia JLoad=0.15 
    "负载的转动惯量";
  Machines.BasicMachines.DCMachines.DC_ElectricalExcited dcee(
    VaNominal=dceeData.VaNominal, 
    IaNominal=dceeData.IaNominal, 
    wNominal=dceeData.wNominal, 
    TaNominal=dceeData.TaNominal, 
    Ra=dceeData.Ra, 
    TaRef=dceeData.TaRef, 
    La=dceeData.La, 
    Jr=dceeData.Jr, 
    useSupport=false, 
    Js=dceeData.Js, 
    frictionParameters=dceeData.frictionParameters, 
    coreParameters=dceeData.coreParameters, 
    strayLoadParameters=dceeData.strayLoadParameters, 
    brushParameters=dceeData.brushParameters, 
    IeNominal=dceeData.IeNominal, 
    Re=dceeData.Re, 
    TeRef=dceeData.TeRef, 
    Le=dceeData.Le, 
    sigmae=dceeData.sigmae, 
    TaOperational=293.15, 
    alpha20a=dceeData.alpha20a, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    ia(fixed=true), 
    alpha20e=dceeData.alpha20e, 
    TeOperational=293.15, 
    ie(fixed=true)) 
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=tRamp, 
    height=Va, 
    startTime=tStart) annotation (Placement(transformation(extent={{-80, 
            60},{-60,80}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage 
    annotation (Placement(transformation(extent={{0,30},{-20,50}})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(
        origin={-70,40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Ve) 
    annotation (Placement(transformation(
        origin={-40,-40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
      Placement(transformation(
        origin={-70,-50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
    startTime=tStep, 
    stepTorque=-TLoad, 
    useSupport=false, 
    offsetTorque=0) annotation (Placement(transformation(extent={{90,-50}, 
            {70,-30}})));
  parameter Utilities.ParameterRecords.DcElectricalExcitedData dceeData "直流机器数据" 
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(ramp.y, signalVoltage.v) annotation (Line(points={{-59,70},{-10,70},{-10,52}}, 
                         color={0,0,255}));
  connect(signalVoltage.p, dcee.pin_ap) annotation (Line(points={{0,40},{
          0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
  connect(signalVoltage.n, ground.p) 
    annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
  connect(dcee.pin_an, ground.p) annotation (Line(points={{-16,-30},{-16, 
          -20},{-20,-20},{-20,40},{-60,40}}, color={0,0,255}));
  connect(constantVoltage.n, groundExcitation.p) 
    annotation (Line(points={{-40,-50},{-60,-50}}, color={0,0,255}));
  connect(dcee.pin_ep, constantVoltage.p) annotation (Line(points={{-20,-34}, 
          {-30,-34},{-30,-30},{-40,-30}}, color={0,0,255}));
  connect(dcee.pin_en, constantVoltage.n) annotation (Line(points={{-20,-46}, 
          {-30,-46},{-30,-50},{-40,-50}}, color={0,0,255}));
  connect(loadInertia.flange_b, loadTorqueStep.flange) 
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(dcee.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<p>将电压斜坡应用到电枢，导致直流机启动，并加速惯性。
在时间tStep时，施加负载阶跃。</p>
<p>该示例的仿真时间为2秒，用户可以在特定界面绘制以下变量的图像(相对于时间)：
<ul>
<li>dcee.ia：电枢电流</li>
<li>dcee.wMechanical：电机转速</li>
<li>dcee.tauElectrical：电机转矩</li>
<li>dcee.ie：励磁电流</li>
</ul>
使用模型<em>DC_ElectricalExcited</em>的默认机械参数。</p>
</html>"));
end DCEE_Start;