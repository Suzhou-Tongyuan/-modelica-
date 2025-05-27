within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_QuasiStatic 
  "测试示例：比较DCPM电机瞬态和准静态"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "实际电枢电压";
  parameter SI.Voltage Ve=100 "实际励磁电压";
  parameter SI.AngularVelocity w0= 
      Modelica.Units.Conversions.from_rpm(1500) "空载转速";
  parameter SI.Torque TLoad=63.66 "额定负载转矩";
  parameter SI.Inertia JLoad=0.15 
    "负载的转动惯量";
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm1(
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
    phiMechanical(fixed=true), 
    ia(fixed=true), 
    TaOperational=293.15, 
    alpha20a=dcpmData.alpha20a, 
    wMechanical(fixed=true, start=w0)) 
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va) 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,50})));
  Modelica.Electrical.Analog.Basic.Ground groundArmature annotation (
      Placement(transformation(
        origin={-80,20}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad) 
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Mechanics.Rotational.Sources.Torque loadTorque1(useSupport= 
        false) annotation (Placement(transformation(extent={{60,20},{40, 
            40}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-1.5*TLoad, 
    offset=0, 
    period=1) 
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Machines.BasicMachines.QuasiStaticDCMachines.DC_PermanentMagnet dcpm2(
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
    phiMechanical(fixed=true), 
    wMechanical(fixed=true, start=w0), 
    TaOperational=293.15, 
    alpha20a=dcpmData.alpha20a) 
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia2(J=JLoad) 
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Mechanics.Rotational.Sources.Torque loadTorque2(useSupport= 
        false) annotation (Placement(transformation(extent={{60,-40},{40, 
            -20}})));
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData "DC机器数据" 
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(loadInertia1.flange_b, loadTorque1.flange) 
    annotation (Line(points={{30,30},{30,30},{40,30}}));
  connect(dcpm1.flange, loadInertia1.flange_a) annotation (Line(
      points={{0,30},{10,30}}));
  connect(armatureVoltage.n, groundArmature.p) annotation (Line(
      points={{-80,40},{-80,30}}, color={0,0,255}));
  connect(armatureVoltage.p, dcpm1.pin_ap) annotation (Line(
      points={{-80,60},{-4,60},{-4,40}}, color={0,0,255}));
  connect(armatureVoltage.n, dcpm1.pin_an) annotation (Line(
      points={{-80,40},{-16,40}}, color={0,0,255}));
  connect(pulse.y, loadTorque1.tau) annotation (Line(
      points={{79,0},{70,0},{70,30},{62,30}}, color={0,0,127}));
  connect(loadInertia2.flange_b, loadTorque2.flange) annotation (Line(
        points={{30,-30},{30,-30},{40,-30}}));
  connect(dcpm2.flange, loadInertia2.flange_a) annotation (Line(
      points={{0,-30},{10,-30}}));
  connect(pulse.y, loadTorque2.tau) annotation (Line(
      points={{79,0},{70,0},{70,-30},{62,-30}}, color={0,0,127}));
  connect(armatureVoltage.p, dcpm2.pin_ap) annotation (Line(
      points={{-80,60},{-40,60},{-40,0},{-4,0},{-4,-20}}, color={0,0,255}));
  connect(armatureVoltage.n, dcpm2.pin_an) annotation (Line(
      points={{-80,40},{-60,40},{-60,-20},{-16,-20}}, color={0,0,255}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<p>
电机从空载转速开始，然后施加负载脉冲。</p>
<p>该示例的仿真时间为2秒，用户可以在特定界面通过勾选绘制以下变量的图像(相对于时间)：

<li>dcpm1.ia：瞬态模型的电枢电流</li>
<li>dcpm1.wMechanical：瞬态模型的电机速度</li>
<li>dcpm1.tauElectrical：瞬态模型的电机转矩</li>
<li>dcpm2.ia：准静态模型的电枢电流</li>
<li>dcpm2.wMechanical：准静态模型的电机速度</li>
<li>dcpm2.tauElectrical：准静态模型的电机转矩</li>
</p>
</html>"));
end DCPM_QuasiStatic;