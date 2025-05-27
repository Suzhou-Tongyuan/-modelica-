within Modelica.Electrical.Machines.Examples.DCMachines;
model DC_CompareCharacteristics 
  "测试示例：比较直流电机的特性"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "实际电枢电压";
  parameter SI.Voltage Ve=100 "实际励磁电压";
  parameter SI.Torque TLoad=63.66 "额定负载转矩";
  parameter SI.Time tStart=0.5 "负载转矩斜坡开始时间";
  parameter SI.Time tRamp=5.0 "负载转矩斜坡";
  parameter SI.Inertia JLoad=0.15 "负载的转动惯量";
  Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va) 
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, 
                                                                   rotation=90, 
        origin={-80,70})));
  Modelica.Electrical.Analog.Basic.Ground groundArmature 
    annotation (Placement(transformation(
        origin={-80,40}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage excitationVoltage(V=Ve) 
    annotation (Placement(transformation(
        origin={-80,0}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation 
    annotation (Placement(transformation(
        origin={-80,-30}, 
        extent={{-10,-10},{10,10}})));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData 
    dcpmData "永磁直流电机的参数" 
    annotation (Placement(transformation(extent={{-30,24},{-10,44}})));
  Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines.DC_PermanentMagnet 
    dcpm(
    TaOperational=dcpmData.TaNominal, 
    VaNominal=dcpmData.VaNominal, 
    IaNominal=dcpmData.IaNominal, 
    wNominal=dcpmData.wNominal, 
    TaNominal=dcpmData.TaNominal, 
    Ra=dcpmData.Ra, 
    TaRef=dcpmData.TaRef, 
    alpha20a=dcpmData.alpha20a, 
    La=dcpmData.La, 
    Jr=dcpmData.Jr, 
    Js=dcpmData.Js, 
    frictionParameters=dcpmData.frictionParameters, 
    phiMechanical(fixed=true, start=0), 
    wMechanical(fixed=true, start=dcpmData.wNominal), 
    coreParameters=dcpmData.coreParameters, 
    strayLoadParameters=dcpmData.strayLoadParameters, 
    brushParameters=dcpmData.brushParameters, 
    ia(fixed=false, start=dcpmData.IaNominal)) 
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad) 
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Mechanics.Rotational.Sources.Torque loadTorque1(useSupport=false) 
    annotation (Placement(transformation(extent={{50,50},{30,70}})));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.DcElectricalExcitedData 
    dceeData "电励磁直流电机的参数" 
    annotation (Placement(transformation(extent={{-30,-36},{-10,-16}})));
  Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines.DC_ElectricalExcited 
    dcee(
    TaOperational=dceeData.TaNominal, 
    VaNominal=dceeData.VaNominal, 
    IaNominal=dceeData.IaNominal, 
    wNominal=dceeData.wNominal, 
    TaNominal=dceeData.TaNominal, 
    Ra=dceeData.Ra, 
    TaRef=dceeData.TaRef, 
    alpha20a=dceeData.alpha20a, 
    La=dceeData.La, 
    Jr=dceeData.Jr, 
    Js=dceeData.Js, 
    frictionParameters=dceeData.frictionParameters, 
    phiMechanical(fixed=true, start=0), 
    wMechanical(start=dceeData.wNominal, fixed=true), 
    coreParameters=dceeData.coreParameters, 
    strayLoadParameters=dceeData.strayLoadParameters, 
    brushParameters=dceeData.brushParameters, 
    ia(fixed=false, start=dceeData.IaNominal), 
    IeNominal=dceeData.IeNominal, 
    Re=dceeData.Re, 
    TeRef=dceeData.TeRef, 
    alpha20e=dceeData.alpha20e, 
    Le=dceeData.Le, 
    sigmae=dceeData.sigmae, 
    TeOperational=dceeData.TeRef, 
    ie(start=dceeData.IeNominal, fixed=false)) 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia2(J=JLoad) 
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque loadTorque2(useSupport=false) 
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.DcSeriesExcitedData 
    dcseData "串励磁直流电机的参数" 
    annotation (Placement(transformation(extent={{-30,-96},{-10,-76}})));
  Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines.DC_SeriesExcited 
    dcse(
    TaOperational=dcseData.TaNominal, 
    VaNominal=dcseData.VaNominal, 
    IaNominal=dcseData.IaNominal, 
    wNominal=dcseData.wNominal, 
    TaNominal=dcseData.TaNominal, 
    Ra=dcseData.Ra, 
    TaRef=dcseData.TaRef, 
    alpha20a=dcseData.alpha20a, 
    La=dcseData.La, 
    Jr=dcseData.Jr, 
    Js=dcseData.Js, 
    frictionParameters=dcseData.frictionParameters, 
    phiMechanical(fixed=true, start=0), 
    wMechanical(fixed=true, start=dcseData.wNominal), 
    coreParameters=dcseData.coreParameters, 
    strayLoadParameters=dcseData.strayLoadParameters, 
    brushParameters=dcseData.brushParameters, 
    ia(fixed=false, start=dcseData.IaNominal), 
    Re=dcseData.Re, 
    TeRef=dcseData.TeRef, 
    alpha20e=dcseData.alpha20e, 
    Le=dcseData.Le, 
    sigmae=dcseData.sigmae, 
    TeNominal=dcseData.TeNominal, 
    TeOperational=dcseData.TeNominal) 
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia3(J=JLoad) 
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Modelica.Mechanics.Rotational.Sources.Torque loadTorque3(useSupport=false) 
    annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=tStart, 
    height=TLoad, 
    duration=tRamp, 
    offset=-TLoad) 
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Blocks.Nonlinear.Limiter limiter(uMax=-0.1*TLoad, uMin=-2*TLoad) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={60,-30})));
equation
  connect(loadInertia1.flange_b, loadTorque1.flange) 
    annotation (Line(points={{20,60},{30,60}}));

  connect(armatureVoltage.n, groundArmature.p) annotation (Line(
      points={{-80,60},{-80,50}}, color={0,0,255}));
  connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
      points={{-80,-10},{-80,-20}}, color={0,0,255}));
  connect(loadInertia2.flange_b,loadTorque2. flange) 
    annotation (Line(points={{20,0},{30,0}}));
  connect(loadInertia3.flange_b,loadTorque3. flange) 
    annotation (Line(points={{20,-60},{30,-60}}));
  connect(armatureVoltage.p, dcpm.pin_ap) 
    annotation (Line(points={{-80,80},{-14,80},{-14,70}}, color={0,0,255}));
  connect(armatureVoltage.p, dcee.pin_ap) annotation (Line(points={{-80,80},{-50, 
          80},{-50,20},{-14,20},{-14,10}}, color={0,0,255}));
  connect(armatureVoltage.p, dcse.pin_ap) annotation (Line(points={{-80,80},{-50, 
          80},{-50,-40},{-14,-40},{-14,-50}}, color={0,0,255}));
  connect(armatureVoltage.n, dcpm.pin_an) annotation (Line(points={{-80,60},{-60, 
          60},{-60,70},{-26,70}}, color={0,0,255}));
  connect(armatureVoltage.n, dcee.pin_an) annotation (Line(points={{-80,60},{-60, 
          60},{-60,10},{-26,10}}, color={0,0,255}));
  connect(armatureVoltage.n, dcse.pin_en) annotation (Line(points={{-80,60},{-60, 
          60},{-60,-66},{-30,-66}}, color={0,0,255}));
  connect(dcse.pin_ep, dcse.pin_an) 
    annotation (Line(points={{-30,-54},{-30,-50},{-26,-50}}, color={0,0,255}));
  connect(excitationVoltage.p, dcee.pin_ep) annotation (Line(points={{-80,10},{-70, 
          10},{-70,6},{-30,6}}, color={0,0,255}));
  connect(excitationVoltage.n, dcee.pin_en) annotation (Line(points={{-80,-10},{
          -70,-10},{-70,-6},{-30,-6}}, color={0,0,255}));
  connect(dcpm.flange, loadInertia1.flange_a) 
    annotation (Line(points={{-10,60},{0,60}}, color={0,0,0}));
  connect(dcee.flange, loadInertia2.flange_a) 
    annotation (Line(points={{-10,0},{0,0}}, color={0,0,0}));
  connect(dcse.flange, loadInertia3.flange_a) 
    annotation (Line(points={{-10,-60},{0,-60}}, color={0,0,0}));
  connect(ramp.y, loadTorque1.tau) 
    annotation (Line(points={{69,0},{60,0},{60,60},{52,60}}, color={0,0,127}));
  connect(ramp.y, loadTorque2.tau) 
    annotation (Line(points={{69,0},{52,0}}, color={0,0,127}));
  connect(ramp.y, limiter.u) 
    annotation (Line(points={{69,0},{60,0},{60,-18}}, color={0,0,127}));
  connect(limiter.y, loadTorque3.tau) 
    annotation (Line(points={{60,-41},{60,-60},{52,-60}}, color={0,0,127}));
  annotation (
    experiment(StopTime=6, Interval=0.001), 
    Documentation(info="<html>
<p>
电机在额定速度启动，然后负载逐渐减小。</p>
<p>该示例的仿真时间为6秒。用户可以在特定界面绘制<code>dcxx.wMechanical</code>(电机转速)与<code>dcxx.tauElectrical</code>(电机转矩)的图像。
使用默认的机器参数。
</p>
<p>
注意，永磁直流电机和电励磁直流电机（在额定励磁下）的特性相同，但串励磁直流电机的速度在负载转矩减小时会上升。
速度的动态增加取决于惯性的总和。
串励磁直流电机的负载转矩不会降低到零，否则速度会无限上升。
</p>
</html>"));
end DC_CompareCharacteristics;