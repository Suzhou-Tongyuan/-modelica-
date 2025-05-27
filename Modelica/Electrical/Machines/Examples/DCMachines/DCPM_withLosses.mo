within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_withLosses 
  "测试示例：研究损耗对DCPM电机性能的影响"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Va=100 "实际电枢电压";
  parameter SI.Time tStart=0.2 
    "电枢电压斜坡的开始时间";
  parameter SI.Time tRamp=0.8 "电枢电压斜坡";
  parameter SI.Torque TLoad1=63.66 "额定负载转矩";
  parameter SI.AngularVelocity wLoad1=1425*2*pi/60 
    "额定负载速度";
  parameter SI.Torque TLoad2=61.30 "额定负载转矩";
  parameter SI.AngularVelocity wLoad2=1417.5*2*pi/60 
    "额定负载速度";
  parameter SI.Inertia JLoad=0.15 
    "负载的转动惯量";
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm1(
    VaNominal=dcpmData1.VaNominal, 
    IaNominal=dcpmData1.IaNominal, 
    wNominal=dcpmData1.wNominal, 
    TaNominal=dcpmData1.TaNominal, 
    Ra=dcpmData1.Ra, 
    TaRef=dcpmData1.TaRef, 
    La=dcpmData1.La, 
    Jr=dcpmData1.Jr, 
    useSupport=false, 
    Js=dcpmData1.Js, 
    frictionParameters=dcpmData1.frictionParameters, 
    coreParameters=dcpmData1.coreParameters, 
    strayLoadParameters=dcpmData1.strayLoadParameters, 
    brushParameters=dcpmData1.brushParameters, 
    TaOperational=293.15, 
    alpha20a=dcpmData1.alpha20a, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    ia(fixed=true)) 
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=tRamp, 
    height=Va, 
    startTime=tStart) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-70,70})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-40,70})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-60,30}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J=JLoad) 
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    loadTorque1(
    useSupport=false, 
    tau_nominal=-TLoad1, 
    TorqueDirection=false, 
    w_nominal=wLoad1) annotation (Placement(transformation(extent={{80,0}, 
            {60,20}})));
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm2(
    VaNominal=dcpmData2.VaNominal, 
    IaNominal=dcpmData2.IaNominal, 
    wNominal=dcpmData2.wNominal, 
    TaNominal=dcpmData2.TaNominal, 
    Ra=dcpmData2.Ra, 
    TaRef=dcpmData2.TaRef, 
    La=dcpmData2.La, 
    Jr=dcpmData2.Jr, 
    useSupport=false, 
    Js=dcpmData2.Js, 
    frictionParameters=dcpmData2.frictionParameters, 
    coreParameters=dcpmData2.coreParameters, 
    strayLoadParameters=dcpmData2.strayLoadParameters, 
    brushParameters=dcpmData2.brushParameters, 
    alpha20a=dcpmData2.alpha20a, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    ia(fixed=true), 
    TaOperational=368.15, 
    core(v(start=0))) 
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia2(J=JLoad) 
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    loadTorque2(
    useSupport=false, 
    tau_nominal=-TLoad2, 
    TorqueDirection=false, 
    w_nominal=wLoad2) annotation (Placement(transformation(extent={{80,-60}, 
            {60,-40}})));
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData1 "DC机器1的数据" 
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData2(
    Ra=0.03864, 
    alpha20a(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper, 
    wNominal=148.44025288212, 
    TaNominal=368.15, 
    frictionParameters(PRef=100), 
    coreParameters(PRef=200), 
    strayLoadParameters(PRef=50), 
    brushParameters(V=0.5)) "DC机器2的数据" 
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));

equation
  connect(ramp.y, signalVoltage.v) 
    annotation (Line(points={{-59,70},{-52,70}}, color={0,0,255}));
  connect(signalVoltage.n, ground.p) annotation (Line(points={{-40,60},{-40, 
          60},{-40,40},{-60,40}}, color={0,0,255}));
  connect(loadInertia1.flange_b, loadTorque1.flange) 
    annotation (Line(points={{50,10},{60,10}}));
  connect(dcpm1.flange, loadInertia1.flange_a) annotation (Line(
      points={{20,10},{30,10}}));
  connect(loadInertia2.flange_b, loadTorque2.flange) 
    annotation (Line(points={{50,-50},{60,-50}}));
  connect(dcpm2.flange, loadInertia2.flange_a) annotation (Line(
      points={{20,-50},{30,-50}}));
  connect(signalVoltage.p, dcpm1.pin_ap) annotation (Line(
      points={{-40,80},{-20,80},{-20,40},{16,40},{16,20}}, color={0,0,255}));
  connect(signalVoltage.p, dcpm2.pin_ap) annotation (Line(
      points={{-40,80},{-20,80},{-20,-20},{16,-20},{16,-40}}, color={0,0,255}));
  connect(signalVoltage.n, dcpm1.pin_an) annotation (Line(
      points={{-40,60},{-40,20},{4,20}}, color={0,0,255}));
  connect(signalVoltage.n, dcpm2.pin_an) annotation (Line(
      points={{-40,60},{-40,-40},{4,-40}}, color={0,0,255}));
  annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6), Documentation(
        info="<html>
<p>
两台电机均通过施加到电枢的电压斜坡启动，导致DC机器启动，并加速惯量。两台机器均加载二次速度相关的负载转矩。</p>
第一台机器<code>dcpm1</code>使用模型<em>DC_PermanentMagnet</em>的默认机器参数，第二台机器<code>dcpm2</code>参数化了额外的损耗：<br>
<table>
<tr><td>                            </td><td>   dcpm1</td><td>   dcpm2</td><td>     </td></tr>
<tr><td>电枢电压                  </td><td>     100</td><td>     100</td><td>    V</td></tr>
<tr><td>电枢电流                  </td><td>     100</td><td>     100</td><td>    A</td></tr>
<tr><td>内部电压                  </td><td>    95.0</td><td>    94.5</td><td>    V</td></tr>
<tr><td>额定速度                  </td><td>  1425.0</td><td>  1417.5</td><td>  rpm</td></tr>
<tr><td>电枢电阻                  </td><td> 0.05000</td><td> 0.03864</td><td>  Ohm</td></tr>
<tr><td>温度系数                  </td><td>     n/a</td><td> 0.00392</td><td>  1/K</td></tr>
<tr><td>参考温度                  </td><td>     n/a</td><td>      20</td><td> degC</td></tr>
<tr><td>操作温度                  </td><td>     n/a</td><td>      95</td><td> degC</td></tr>
<tr><td>刷电压降                  </td><td>     n/a</td><td>     0.5</td><td>    V</td></tr>
<tr><td>电气输入                  </td><td>  10,000</td><td>  10,000</td><td>    W</td></tr>
<tr><td>电枢铜损耗                </td><td>     500</td><td>     500</td><td>    W</td></tr>
<tr><td>铁损耗                     </td><td>     n/a</td><td>     200</td><td>    W</td></tr>
<tr><td>杂散负载损耗             </td><td>     n/a</td><td>      50</td><td>    W</td></tr>
<tr><td>摩擦损耗                  </td><td>     n/a</td><td>     100</td><td>    W</td></tr>
<tr><td>刷损耗                     </td><td>     n/a</td><td>      50</td><td>    W</td></tr>
<tr><td>机械输出                  </td><td>   9,500</td><td>   9,100</td><td>    W</td></tr>
<tr><td>额定转矩                  </td><td>   63,66</td><td>   61,30</td><td>   Nm</td></tr>
</table>
<br>
注意：参考值(电压、电流、速度)已经传播到损耗记录中，使用额定工作点。<br>
参见：<br>
Anton Haumer, Christian Kral, Hansj&ouml;rg Kapeller, Thomas B&auml;uml, Johannes V. Gragger<br>
<a href=\"https://2009.international.conference.modelica.org/proceedings/pages/papers/0103/0103_FI.pdf\">
The AdvancedMachines Library: Loss Models for Electric Machines</a><br>
Modelica 2009, 7<sup>th</sup> International Modelica Conference
</html>"));
end DCPM_withLosses;