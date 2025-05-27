within Modelica.Fluid;
model System 
  "系统属性和默认值(环境、流向、初始化)"

  package Medium = Modelica.Media.Interfaces.PartialMedium "默认介质" 
      annotation (choicesAllMatching = true);
  parameter SI.AbsolutePressure p_ambient=101325 "默认环境压力" 
    annotation(Dialog(group="环境"));
  parameter SI.Temperature T_ambient=293.15 "默认环境温度" 
    annotation(Dialog(group="环境"));
  parameter SI.Acceleration g=Modelica.Constants.g_n "重力加速度" 
    annotation(Dialog(group="环境"));

  // 假设
  parameter Boolean allowFlowReversal = true "false:限制设计流向（接口a -> 接口b）" 
    annotation(Dialog(tab="假设"), Evaluate=true);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics= Modelica.Fluid.Types.Dynamics.DynamicFreeInitial "能量平衡的默认公式" 
    annotation(Evaluate=true, Dialog(tab = "假设", group="动力学"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics= energyDynamics "质量平衡的默认公式" 
    annotation(Evaluate=true, Dialog(tab = "假设", group="动力学"));
  final parameter Modelica.Fluid.Types.Dynamics substanceDynamics= massDynamics "物质平衡的默认公式" 
    annotation(Evaluate=true, Dialog(tab = "假设", group="动力学"));
  final parameter Modelica.Fluid.Types.Dynamics traceDynamics= massDynamics "微量物质平衡的默认公式" 
    annotation(Evaluate=true, Dialog(tab = "假设", group="动力学"));
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics= Modelica.Fluid.Types.Dynamics.SteadyState "若选项可用，则为动量平衡的默认公式" 
    annotation(Evaluate=true, Dialog(tab = "假设", group="动力学"));

  // 初始化
  parameter SI.MassFlowRate m_flow_start = 0 "质量流量的默认起始值" 
    annotation(Dialog(tab = "初始化"));
  parameter SI.AbsolutePressure p_start = p_ambient "默认压力起始值" 
    annotation(Dialog(tab = "初始化"));
  parameter SI.Temperature T_start = T_ambient "温度的默认起始值" 
    annotation(Dialog(tab = "初始化"));
  // 高级
  parameter Boolean use_eps_Re = false "true:使用雷诺数自动确定湍流区域" 
    annotation(Evaluate=true, Dialog(tab = "高级"));
  parameter SI.MassFlowRate m_flow_nominal = if use_eps_Re then 1 else 1e2*m_flow_small "默认额定质量流量" 
    annotation(Dialog(tab="高级", enable = use_eps_Re));
  parameter Real eps_m_flow(min=0) = 1e-4 "对 |m_flow| < eps_m_flow*m_flow_nominal 时的零流量进行正则化处理" 
    annotation(Dialog(tab = "高级", enable = use_eps_Re));
  parameter SI.AbsolutePressure dp_small(min=0) = 1 "层流和零流量正则化的默认小压降" 
    annotation(Dialog(tab="高级", group="经典", enable = not use_eps_Re));
  parameter SI.MassFlowRate m_flow_small(min=0) = 1e-2 "层流和零流量正则化的默认小质量流量" 
    annotation(Dialog(tab = "高级", group="经典", enable = not use_eps_Re));
initial equation
  //assert(use_eps_Re, "*** Using classic system.m_flow_small and system.dp_small."
  //       + " They do not distinguish between laminar flow and regularization of zero flow."
  //       + " Absolute small values are error prone for models with local nominal values."
  //       + " Moreover dp_small can generally be obtained automatically."
  //       + " Please update the model to new system.use_eps_Re = true  (see system, Advanced tab). ***",
  //       level=AssertionLevel.warning);
  annotation (
    defaultComponentName="system", 
    defaultComponentPrefixes="inner", 
    missingInnerMessage="
您的模型使用了外部的 system 组件，但没有定义内部的 system 组件。
为了进行模拟，请将 Modelica.Fluid.System 拖入您的模型以指定系统属性。", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100, 
            100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,150},{150,110}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Line(points={{-86,-30},{82,-30}}), 
        Line(points={{-82,-68},{-52,-30}}), 
        Line(points={{-48,-68},{-18,-30}}), 
        Line(points={{-14,-68},{16,-30}}), 
        Line(points={{22,-68},{52,-30}}), 
        Line(points={{74,84},{74,14}}), 
        Polygon(
          points={{60,14},{88,14},{74,-18},{60,14}}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{16,20},{60,-18}}, 
          textString="g"), 
        Text(
          extent={{-90,82},{74,50}}, 
          textString="defaults"), 
        Line(
          points={{-82,14},{-42,-20},{2,30}}, 
          thickness=0.5), 
        Ellipse(
          extent={{-10,40},{12,18}}, 
          pattern=LinePattern.None, 
          fillColor={255,0,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html><p>
每个流体模型都需要一个系统组件来提供全系统设置，如环境条件和总体建模假设。 系统设置通过 “inner/outer”机制传递到流体模型中。
</p>
<p>
模型不应直接使用系统参数， 而应声明一个本地参量，默认使用全局设置。 唯一的例外情况是：
</p>
<ul><li>
重力系统.g，</li>
<li>
global_system.eps_m_flow 用于定义局部的 m_flow_small，它是基于局部的 m_flow_nominal：</li>
</ul><p>
全局 system.m_flow_small 和 system.dp_small 是经典参数。 他们没有区分层流和零流的正则化（regularization of zero flow）。 对于具有本地名义值的模型来说，绝对小值容易出错。 此外，dp_small 通常可以自动获取。 考虑使用新的 system.use_eps_Re = true（请参阅 \"Advanced \"选项卡）。
</p>
</html>"));
end System;