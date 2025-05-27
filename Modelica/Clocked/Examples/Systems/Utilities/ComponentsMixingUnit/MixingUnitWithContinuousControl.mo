within Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit;
model MixingUnitWithContinuousControl "一个简单的混合单元示例，其中使用（连续的）非线性逆被控系统模型作为前馈控制器"
  extends Modelica.Icons.Example;

  parameter SI.Frequency freq = 1/300 "滤波器的临界频率";
  parameter Real c0(unit="mol/l") = 0.848 "额定浓度";
  parameter SI.Temperature T0 = 308.5 "额定温度";
  parameter Real a1_inv =  0.2674 "逆受控对象模型的过程参数（参见帮助中的参考资料）";
  parameter Real a21_inv = 1.815 "逆受控对象模型的过程参数（参见帮助中的参考资料）";
  parameter Real a22_inv = 0.4682 "逆受控对象模型的过程参数（参见帮助中的参考资料）";
  parameter Real b_inv =   1.5476 "逆受控对象模型的过程参数（参见帮助中的参考资料）";
  parameter Real k0_inv =  1.05e14 "逆受控对象模型的过程参数（参见帮助中的参考资料）";
  parameter Real eps = 34.2894 "过程参数（请参阅帮助中的参考资料）";

  parameter Real x10 = 0.42 "额定浓度与初始浓度之间的相对偏移量";
  parameter Real x20 = 0.01 "额定温度与初始温度之间的相对偏差";
  parameter Real u0 = -0.0224 "初始冷却温度与额定温度之间的相对偏差";

  final parameter Real c_start(unit="mol/l") = c0*(1-x10) "初始浓度";
  final parameter SI.Temperature T_start = T0*(1+x20) "初始温度";
  final parameter Real c_high_start(unit="mol/l") = c0*(1-0.72) "参考浓度";
  final parameter Real T_c_start = T0*(1+u0) "初始冷却温度";

  parameter Real pro=1.1 
    "受控对象参数与逆受控对象参数的偏差";
  final parameter Real a1=a1_inv*pro "设备模型的过程参数（参见帮助中的参考资料）";
  final parameter Real a21=a21_inv*pro "设备模型的过程参数（参见帮助中的参考资料）";
  final parameter Real a22=a22_inv*pro "设备模型的过程参数（参见帮助中的参考资料）";
  final parameter Real b=b_inv*pro "设备模型的过程参数（参见帮助中的参考资料）";
  final parameter Real k0=k0_inv*pro "设备模型的过程参数（参见帮助中的参考资料）";

  Utilities.ComponentsMixingUnit.MixingUnit invMixingUnit(
    c0= c0, 
    T0= T0, 
    a1= a1_inv, 
    a21=a21_inv, 
    a22=a22_inv, 
    b = b_inv, 
    k0= k0_inv, 
    eps=eps, 
    c(start=c_start, fixed=true), 
    T(start=T_start, 
      fixed=true, 
      stateSelect=StateSelect.always), 
    T_c(start=T_c_start, fixed=true)) 
    annotation (Placement(transformation(extent={{-14,14},{-34,34}})));
  Modelica.Blocks.Math.Add add 
    annotation (Placement(transformation(extent={{40,-18},{56,-2}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints 
    annotation (Placement(transformation(extent={{-54,8},{-2,40}})));
  Modelica.Blocks.Continuous.CriticalDamping filter(f=freq, n=3, 
    normalized=false) 
    annotation (Placement(transformation(extent={{-86,14},{-66,34}})));
  Utilities.ComponentsMixingUnit.MixingUnit   mixingUnit(
    c(start=c_start, fixed=true), 
    T(start=T_start, fixed=true), 
    c0= c0, 
    T0= T0, 
    a1= a1, 
    a21=a21, 
    a22=a22, 
    b = b, 
    k0= k0, 
    eps=eps) 
    annotation (Placement(transformation(extent={{70,-20},{90,0}})));
  Modelica.Blocks.Math.Feedback feedback 
    annotation (Placement(transformation(extent={{-24,-20},{-4,0}})));
  Modelica.Blocks.Sources.Step step(height=c_high_start - c_start, offset= 
        c_start) 
    annotation (Placement(transformation(extent={{-118,14},{-98,34}})));
  Modelica.Blocks.Math.Gain gain(k=20) annotation (Placement(transformation(
          extent={{4,-20},{24,0}})));
equation
  connect(step.y, filter.u)  annotation (Line(points={{-97,24},{-97,24},{
          -88,24}}, 
        color={0,0,127}));
  connect(mixingUnit.T, feedback.u2) annotation (Line(points={{92,-16},{
          98,-16},{98,-36},{-14,-36},{-14,-18}}, 
                                              color={0,0,127}));
  connect(feedback.y, gain.u) annotation (Line(points={{-5,-10},{-5,-10}, 
          {2,-10}}, 
        color={0,0,127}));
  connect(add.y, mixingUnit.T_c) annotation (Line(
      points={{56.8,-10},{68,-10}}, 
      color={0,0,127}));
  connect(gain.y, add.u2) annotation (Line(
      points={{25,-10},{32,-10},{32,-14.8},{38.4,-14.8}}, 
      color={0,0,127}));
  connect(inverseBlockConstraints.y2, invMixingUnit.T_c) annotation (Line(
      points={{-5.9,24},{-12,24}}, 
      color={0,0,127}));
  connect(inverseBlockConstraints.y1, add.u1) annotation (Line(
      points={{-0.7,24},{32,24},{32,-5.2},{38.4,-5.2}}, 
      color={0,0,127}));
  connect(filter.y, inverseBlockConstraints.u1) annotation (Line(
      points={{-65,24},{-56.6,24}}, 
      color={0,0,127}));
  connect(invMixingUnit.T, feedback.u1) annotation (Line(
      points={{-36,18},{-42,18},{-42,-10},{-22,-10}}, 
      color={0,0,127}));
  connect(invMixingUnit.c, inverseBlockConstraints.u2) annotation (Line(
      points={{-36,30},{-38,30},{-38,24},{-48.8,24}}, 
      color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-120, 
            -100},{100,100}})), 
    experiment(StopTime=500));
end MixingUnitWithContinuousControl;