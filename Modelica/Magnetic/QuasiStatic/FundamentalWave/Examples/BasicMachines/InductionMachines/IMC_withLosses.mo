within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_withLosses "感应电机与鼠笼和损耗"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  import Modelica.Units.Conversions.from_rpm;
  import Modelica.Units.Conversions.to_rpm;
  import Modelica.Units.Conversions.from_degC;
  constant Integer m=3 "相数";
  parameter SI.Power PNominal=18500 "名义产出";
  parameter SI.Voltage VNominal=400 "标称均方根电压";
  parameter SI.Current INominal=32.85 "标称均方根电流";
  parameter Real pfNominal=0.898 "标称功率因数";
  parameter SI.Power PsNominal=sqrt(3)*VNominal*INominal*pfNominal "定子标称功率";
  parameter SI.Power lossNominal=PsNominal-PNominal "名义上的损失";
  parameter Real etaNominal=0.9049 "名义上的效率";
  parameter SI.Frequency fNominal=50 "标称频率";
  parameter SI.AngularVelocity wNominal=from_rpm(1462.5) 
    "额定速度";
  parameter SI.Torque TNominal=PNominal/wNominal 
    "额定转矩";
  parameter SI.Temperature TempNominal=from_degC(90) 
    "名义上的温度";
  SI.Power PelQS=electricalPowerSensorQS.apparentPower.re;
  SI.ReactivePower QelQS=electricalPowerSensorQS.apparentPower.im;
  SI.ApparentPower SelQS=sqrt(PelQS^2 + QelQS^2);
protected
  parameter Real Ptable[:]={1E-6,1845,3549,5325,7521,9372,11010,12930, 
      14950,16360,18500,18560,20180,22170} "实测功率数据表";
  parameter Real Itable[:]={11.0,11.20,12.27,13.87,16.41,18.78,21.07, 
      23.92,27.05,29.40,32.85,32.95,35.92,39.35} "测量电流数据表";
  parameter Real wtable[:]=from_rpm({1500,1496,1493,1490,1486,1482,1479,1475,1471, 
      1467,1462,1462,1458,1453}) "Table of measured speed data";
  parameter Real ctable[:]={0.085,0.327,0.506,0.636,0.741,0.797,0.831, 
      0.857,0.875,0.887,0.896,0.896,0.902,0.906} "测量功率因数数据表";
  parameter Real etable[:]={0,0.7250,0.8268,0.8698,0.8929,0.9028,0.9064, 
      0.9088,0.9089,0.9070,0.9044,0.9043,0.9008,0.8972} "测量效率数据表";
public
  output SI.Power PmechQS=powerSensorQS.power "机械输出";
  output SI.Power Ps_simQS=sqrt(3)*VNominal*I_simQS*pf_simQS "模拟定子功率";
  output SI.Power Ps_measQS=sqrt(3)*VNominal*I_measQS*pf_measQS "模拟定子功率";
  output SI.Power loss_simQS=Ps_simQS-PmechQS "模拟全损";
  output SI.Power loss_measQS=Ps_measQS-PmechQS "计量总损失";
  output SI.Current I_simQS=currentQuasiRMSSensorQS.I "模拟电流";
  output SI.Current I_measQS=combiTable1DsQS.y[1] "测量电流";
  output SI.AngularVelocity w_simQS(displayUnit="rev/min") = imcQS.wMechanical "模拟的速度";
  output SI.AngularVelocity w_measQS(displayUnit="rev/min")=combiTable1DsQS.y[2] "测量速度";
  output Real pf_simQS=if noEvent(SelQS > Modelica.Constants.small) then PelQS/SelQS else 0 "模拟功率因数";
  output Real pf_measQS=combiTable1DsQS.y[3] "测量功率因数";
  output Real eff_simQS=if noEvent(abs(PelQS) > Modelica.Constants.small) then PmechQS/PelQS else 0 "模拟的效率";
  output Real eff_measQS=combiTable1DsQS.y[4] "测量效率";

  Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage 
    imcQS(
    p=imcData.p, 
    fsNominal=imcData.fsNominal, 
    TsRef=imcData.TsRef, 
    alpha20s(displayUnit="1/K") = imcData.alpha20s, 
    Jr=imcData.Jr, 
    Js=imcData.Js, 
    frictionParameters=imcData.frictionParameters, 
    statorCoreParameters=imcData.statorCoreParameters, 
    strayLoadParameters=imcData.strayLoadParameters, 
    TrRef=imcData.TrRef, 
    TsOperational=TempNominal, 
    TrOperational=TempNominal, 
    wMechanical(fixed=true, start=2*pi*imcData.fsNominal/imcData.p), 
    gammar(fixed=true, start=pi/2), 
    gamma(fixed=true, start=-pi/2), 
    Rs=imcData.Rs*m/3, 
    Lssigma=imcData.Lssigma*m/3, 
    Lm=imcData.Lm*m/3, 
    Lrsigma=imcData.Lrsigma*m/3, 
    Rr=imcData.Rr*m/3, 
    m=m, 
    effectiveStatorTurns=imcData.effectiveStatorTurns, 
    alpha20r=imcData.alpha20r) 
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Utilities.MultiTerminalBox terminalBoxQS(terminalConnection="D", m=m) 
                                                                   annotation (Placement(transformation(extent={{-20,76},{0,96}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor electricalPowerSensorQS(m=m) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-40, 
            90})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m) 
    annotation (Placement(transformation(origin={-70,90}, extent={{-10,10},{10, 
            -10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource sineVoltageQS(
    final m=m, 
    f=fNominal, 
    V=fill(VNominal/sqrt(3), m)) annotation (Placement(transformation(
        origin={-90,70}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(final m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-90,40})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS annotation (Placement(transformation(origin={-90,10}, extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensorQS annotation (Placement(transformation(extent={{10,60},{30,80}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=imcData.Jr) annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Mechanics.Rotational.Sources.Torque torqueQS annotation (Placement(transformation(extent={{90,60},{70,80}})));
  Modelica.Blocks.Math.Gain gainQS(k=-1) annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Modelica.Blocks.Continuous.PI PIQS(
    k=0.01, 
    T=0.01, 
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Math.Feedback feedbackQS annotation (Placement(transformation(extent={{10,20},{30,0}})));
  Modelica.Blocks.Sources.Ramp rampQS(
    height=1.2*PNominal, 
    offset=0, 
    startTime=4.5, 
    duration=5.5) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1DsQS(table={{Ptable[j],Itable[j],wtable[j],ctable[j],etable[j]} for j in 1:size(Ptable, 1)}, smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation (Placement(transformation(extent={{40,30},{60,50}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData 
    imcData(
    statorCoreParameters(PRef=410, VRef=387.9), 
    Jr=0.12, 
    Rs=0.56, 
    alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper, 
    Lssigma=1.52/(2*pi*fNominal), 
    frictionParameters(PRef=180, wRef=wNominal), 
    strayLoadParameters(
      PRef=0.005*sqrt(3)*VNominal*INominal*pfNominal, 
      IRef=INominal/sqrt(3), 
      wRef=wNominal), 
    Lm=66.4/(2*pi*fNominal), 
    Lrsigma=2.31/(2*pi*fNominal), 
    Rr=0.42, 
    alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Aluminium) 
    "感应电机数据" 
    annotation (Placement(transformation(extent={{-60,12},{-40,32}})));

equation
  connect(starQS.pin_n, groundQS.pin) annotation (Line(points={{-90,30},{-90,20}}, color={85,170,255}));
  connect(sineVoltageQS.plug_n, starQS.plug_p) annotation (Line(points={{-90,60},{-90,50}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sn, imcQS.plug_sn) annotation (Line(points={{-16,80},{-16,80}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sp, imcQS.plug_sp) annotation (Line(points={{-4,80},{-4,80}}, color={85,170,255}));

  connect(imcQS.flange, powerSensorQS.flange_a) annotation (Line(points={{0,70},{10,70}}));
  connect(powerSensorQS.flange_b, loadInertiaQS.flange_a) annotation (Line(points={{30,70},{40,70}}));
  connect(torqueQS.flange, loadInertiaQS.flange_b) annotation (Line(points={{70,70},{64,70},{64,70},{68,70},{68,70},{60,70}}));
  connect(sineVoltageQS.plug_p, currentQuasiRMSSensorQS.plug_p) annotation (Line(points={{-90,80},{-90,90},{-80,90}}, color={85,170,255}));
  connect(PIQS.y, gainQS.u) annotation (Line(points={{61,10},{68,10}}, color={85,170,255}));
  connect(currentQuasiRMSSensorQS.plug_n, electricalPowerSensorQS.currentP) annotation (Line(points={{-60,90},{-50,90}}, color={85,170,255}));
  connect(electricalPowerSensorQS.currentN, terminalBoxQS.plugSupply) annotation (Line(points={{-30,90},{-10,90},{-10,82}}, color={85,170,255}));
  connect(electricalPowerSensorQS.currentP, electricalPowerSensorQS.voltageP) annotation (Line(points={{-50,90},{-50,90},{-50,98},{-50,98},{-50,100},{-40,100},{-40,100}}, color={85,170,255}));
  connect(electricalPowerSensorQS.voltageN, starQS.plug_p) annotation (Line(points={{-40,80},{-40,50},{-90,50}}, color={85,170,255}));
  connect(powerSensorQS.power, combiTable1DsQS.u) annotation (Line(points={{12,59},{12,40},{38,40}}, color={0,0,127}));
  connect(powerSensorQS.power, feedbackQS.u2) annotation (Line(points={{12,59},{12,40},{20,40},{20,18}}, color={0,0,127}));
  connect(gainQS.y, torqueQS.tau) annotation (Line(points={{91,10},{100,10},{100,70},{92,70}}, color={0,0,127}));
  connect(rampQS.y, feedbackQS.u1) annotation (Line(points={{1,10},{12,10}}, color={0,0,127}));
  connect(feedbackQS.y, PIQS.u) annotation (Line(points={{29,10},{38,10}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=10, 
      Interval=0.0001, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<ul>
<li>模拟10秒:机器以标称速度启动，随后应用负载斜坡.</li>
<li>通过绘图与PmechQS进行比较:</li>
</ul>
<table>
<tr><td>电流      </td><td>I_simQS   </td><td>I_measQS  </td></tr>
<tr><td>速度        </td><td>w_simQS   </td><td>w_measQS  </td></tr>
<tr><td>功率因数 </td><td>pf_simQS  </td><td>pf_measQS </td></tr>
<tr><td>效率   </td><td>eff_simQS </td><td>eff_measQS</td></tr>
</table>
<p>机器参数取自标准18.5 kW 400v 50hz电机，仿真结果与实测结果进行了比较.</p>
<table>
<tr><td>定子额定电流            </td><td>     32.85  </td><td>A      </td></tr>
<tr><td>功率因数                      </td><td>      0.898 </td><td>       </td></tr>
<tr><td>速度                             </td><td>   1462.5   </td><td>rpm    </td></tr>
<tr><td>电输入                  </td><td> 20,443.95  </td><td>W      </td></tr>
<tr><td>定子铜损耗              </td><td>    770.13  </td><td>W      </td></tr>
<tr><td>定子铁心损耗                </td><td>    410.00  </td><td>W      </td></tr>
<tr><td>转子铜损              </td><td>    481.60  </td><td>W      </td></tr>
<tr><td>杂散负载损耗                 </td><td>    102.22  </td><td>W      </td></tr>
<tr><td>摩擦损失                   </td><td>    180.00  </td><td>W      </td></tr>
<tr><td>机械输出                 </td><td> 18,500.00  </td><td>W      </td></tr>
<tr><td>效率                       </td><td>     90.49  </td><td>%      </td></tr>
<tr><td>额定转矩                    </td><td>    120.79  </td><td>Nm     </td></tr>
</table>
<br>
<table>
<tr><td>每相定子电阻       </td><td>  0.56     </td><td>&Omega;</td></tr>
<tr><td>温度系数           </td><td> copper    </td><td>       </td></tr>
<tr><td>参考温度             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>操作温度             </td><td> 90        </td><td>&deg;C </td></tr>
<tr><td>定子在50hz时漏抗 </td><td>  1.52     </td><td>&Omega;</td></tr>
<tr><td>50hz时主场抗 </td><td> 66.40     </td><td>&Omega;</td></tr>
<tr><td>50hz时转子漏抗 </td><td>  2.31     </td><td>&Omega;</td></tr>
<tr><td>每相转子电阻       </td><td>  0.42     </td><td>&Omega;</td></tr>
<tr><td>温度系数           </td><td> aluminium </td><td>       </td></tr>
<tr><td>参考温度             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>操作温度             </td><td> 90        </td><td>&deg;C </td></tr>
</table>
<p>See:<br>
Anton Haumer, Christian Kral, Hansj&ouml;rg Kapeller, Thomas B&auml;uml, Johannes V. Gragger<br>
<a href=\"https://2009.international.conference.modelica.org/proceedings/pages/papers/0103/0103_FI.pdf\">
The AdvancedMachines Library: Loss Models for Electric Machines</a><br>
Modelica 2009, 7<sup>th</sup> International Modelica Conference</p>
</html>"), 
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={
        Text(
          extent={{-80,40},{0,32}}, 
                  textStyle={TextStyle.Bold}, 
          textString="%m phase quasi-static")}));
end IMC_withLosses;