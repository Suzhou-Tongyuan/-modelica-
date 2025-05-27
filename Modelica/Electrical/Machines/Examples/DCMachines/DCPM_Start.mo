within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_Start 
  "测试示例：斜坡电压启动的永磁直流电机"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "实际的电枢电压";
  parameter SI.Time tStart=0.2 
    "电枢电压斜坡起始时间";
  parameter SI.Time tRamp=0.8 "电枢电压斜坡时间";
  parameter SI.Torque TLoad=63.66 "额定负载转矩";
  parameter SI.Time tStep=1.5 "负载转矩步进时间";
  parameter SI.Inertia JLoad=0.15 
    "负载的转动惯量";
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
    VaNominal=dcpmData.VaNominal, 
    IaNominal=dcpmData.IaNominal, 
    wNominal=dcpmData.wNominal, 
    TaNominal=dcpmData.TaNominal, 
    Ra=dcpmData.Ra, 
    TaRef=dcpmData.TaRef, 
    La=dcpmData.La, 
    Jr=dcpmData.Jr, 
    useSupport=false, 
    Js=dcpmData.Js, 
    frictionParameters=dcpmData.frictionParameters, 
    coreParameters=dcpmData.coreParameters, 
    strayLoadParameters=dcpmData.strayLoadParameters, 
    brushParameters=dcpmData.brushParameters, 
    TaOperational=293.15, 
    alpha20a=dcpmData.alpha20a, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    ia(fixed=true)) 
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=tRamp, 
    height=Va, 
    startTime=tStart) annotation (Placement(transformation(extent={{-80, 
            60},{-60,80}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage 
    annotation (Placement(transformation(extent={{0,30},{-20,50}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,40}, 
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
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData "DC 机器数据" 
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(ramp.y, signalVoltage.v) annotation (Line(points={{-59,70},{-10,70},{-10,52}}, 
                         color={0,0,255}));
  connect(signalVoltage.p, dcpm.pin_ap) annotation (Line(points={{0,40},{
          0,-20},{-4,-20},{-4,-30}}, color={0,0,255}));
  connect(signalVoltage.n, ground.p) 
    annotation (Line(points={{-20,40},{-60,40}}, color={0,0,255}));
  connect(dcpm.pin_an, signalVoltage.n) annotation (Line(points={{-16,-30}, 
          {-16,-20},{-20,-20},{-20,40}}, color={0,0,255}));
  connect(loadInertia.flange_b, loadTorqueStep.flange) 
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1e-6), Documentation(
        info="<html>

<p>将电压斜坡施加到电枢，导致直流电机启动，并加速惯性。
在时间tStep施加负载步进。</p>
<p>该示例的仿真时间为2秒。用户可以在特定界面通过勾选绘制以下结果变量的图像(相对于时间)：</p>
<ul>
<li>dcpm.ia：电枢电流</li>
<li>dcpm.wMechanical：电机速度</li>
<li>dcpm.tauElectrical：电机转矩</li>
</ul>
使用模型<em>DC_PermanentMagnet</em>的默认机器参数。
</html>"));
end DCPM_Start;