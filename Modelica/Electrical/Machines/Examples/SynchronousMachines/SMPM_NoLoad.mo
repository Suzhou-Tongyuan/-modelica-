within Modelica.Electrical.Machines.Examples.SynchronousMachines;
model SMPM_NoLoad "无负载下的SMPM"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "相数";
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData 
    smpmData(useDamperCage=false) "同步机数据" 
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet 
    smpm(
    p=smpmData.p, 
    fsNominal=smpmData.fsNominal, 
    Rs=smpmData.Rs, 
    TsRef=smpmData.TsRef, 
    Lszero=smpmData.Lszero, 
    Lssigma=smpmData.Lssigma, 
    Jr=smpmData.Jr, 
    VsOpenCircuit=smpmData.VsOpenCircuit, 
    Lmd=smpmData.Lmd, 
    Lmq=smpmData.Lmq, 
    useDamperCage=smpmData.useDamperCage, 
    Lrsigmad=smpmData.Lrsigmad, 
    Lrsigmaq=smpmData.Lrsigmaq, 
    Rrd=smpmData.Rrd, 
    Rrq=smpmData.Rrq, 
    TrRef=smpmData.TrRef, 
    frictionParameters=smpmData.frictionParameters, 
    statorCoreParameters=smpmData.statorCoreParameters, 
    strayLoadParameters=smpmData.strayLoadParameters, 
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters, 
    TsOperational=293.15, 
    alpha20s=smpmData.alpha20s, 
    phiMechanical(fixed=true, start=(pi + 0*2*pi/m)/smpmData.p), 
    TrOperational=293.15, 
    alpha20r=smpmData.alpha20r) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y", m=m) 
    annotation (Placement(transformation(extent={{-10,6},{10,26}})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Electrical.Polyphase.Sensors.PotentialSensor potentialSensor(m=m) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={0,30})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor(m=m) 
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  SpacePhasors.Blocks.ToPolar toPolar 
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Blocks.Math.Gain toDeg(k=180/pi) 
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Sensors.HallSensor hallSensor(p=smpmData.p) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}}, 
        origin={40,-30})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=2* 
        pi*smpmData.fsNominal/smpmData.p) 
    annotation (Placement(transformation(extent={{52,-10},{32,10}})));

equation
  connect(terminalBox.plug_sn, smpm.plug_sn) 
    annotation (Line(points={{-6,10},{-6,10}}, color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) 
    annotation (Line(points={{6,10},{6,10}}, color={0,0,255}));
  connect(ground.p, terminalBox.starpoint) 
    annotation (Line(points={{-20,10},{-20,12},{-10,12}},color={0,0,255}));
  connect(potentialSensor.plug_p, terminalBox.plugSupply) 
    annotation (Line(points={{0,20},{0,12}}, color={0,0,255}));
  connect(potentialSensor.phi, toSpacePhasor.u) annotation (Line(points={{8.88178e-16, 
          41},{8.88178e-16,50},{8,50}}, color={0,0,127}));
  connect(constantSpeed.flange, smpm.flange) 
    annotation (Line(points={{32,0},{10,0}}));
  connect(smpm.flange, hallSensor.flange) 
    annotation (Line(points={{10,0},{20,0},{20,-30},{30,-30}}));
  connect(toSpacePhasor.y, toPolar.u) 
    annotation (Line(points={{31,50},{38,50}}, color={0,0,127}));
  connect(toPolar.y[2], toDeg.u) 
    annotation (Line(points={{61,50},{68,50}}, color={0,0,127}));
  annotation (experiment(StopTime=0.04, 
        Interval=0.0001), 
    Documentation(info="<html>
<p>
无负载的永磁同步机，以恒定的额定速度驱动。
</p>
<p>
您可以检查端电压=VsOpenCircuit(由空间矢量的长度表示)和频率=fsNominal。
</p>
<p>
此外，您可以检查定子电压相对于机械轴角度的相位移：
</p>
<ul>
<li>如果轴角度从(pi+0*pi/3)/p开始，则通过第1相的通量链路最大，因此该相电压从0开始。</li>
<li>如果轴角度从(pi+2*pi/3)/p开始，则通过第2相的通量链路最大，因此该相电压从0开始。</li>
<li>如果轴角度从(pi+4*pi/3)/p开始，则通过第3相的通量链路最大，因此该相电压从0开始。</li>
</ul>
<p>请注意，电压空间矢量的角度落后于霍尔传感器的角度pi/2，即轴转动pi/2/p后，相1的通量链路为零，感应电压最大。</p>
</html>"));
end SMPM_NoLoad;