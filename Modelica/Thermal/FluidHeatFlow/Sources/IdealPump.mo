within Modelica.Thermal.FluidHeatFlow.Sources;
model IdealPump "理想泵的模型"

  extends FluidHeatFlow.BaseClasses.TwoPort(final tapT=1);
  parameter SI.AngularVelocity wNominal(start=1, displayUnit="rev/min") 
    "额定转速" 
      annotation(Dialog(group="Pump characteristic"));
  parameter SI.Pressure dp0(start=2) 
    "最大压力增幅 @ V_flow=0" 
      annotation(Dialog(group="Pump characteristic"));
  parameter SI.VolumeFlowRate V_flow0(start=2) 
    "最大体积流量 @ dp=0" 
      annotation(Dialog(group="Pump characteristic"));
  SI.AngularVelocity w=der(flange_a.phi) "流速";
protected
  SI.Pressure dp1;
  SI.VolumeFlowRate V_flow1;
public
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
equation
  // 泵特性
  dp1 = dp0*sign(w/wNominal)*(w/wNominal)^2;
  V_flow1 = V_flow0*(w/wNominal);
  if noEvent(abs(w)<Modelica.Constants.small) then
    dp = 0;
    flange_a.tau = 0;
  else
    dp = -dp1*(1 - V_flow/V_flow1);
    flange_a.tau*w = -dp*V_flow;
  end if;
  // 不与介质进行能量交换
  Q_flow = 0;
annotation (Documentation(info="<html><p>
简单的风扇或泵，其特性依赖于轴的转速。<br> torque * speed = pressure increase * volume flow (无损失)<br> 压力增加与体积流量的关系由线性函数定义， from dp0(V_flow=0) to V_flow0(dp=0)。<br>轴交点随转速变化如下：
</p>
<li>
dp prop. speed^2</li>
<li>
V_flow prop.speed</li>
<p>
冷却剂的温度和焓流不受影响。<br> 将参数 m（风扇/泵内介质的质量）设为零，可忽略温度瞬态项 cv*m*der(T)。<br> 热力学方程由 BaseClasses.TwoPort 定义。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Ellipse(
          extent={{-90,90},{90,-90}}, 
          lineColor={255,0,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,150},{150,90}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Rectangle(
          extent={{-10,-40},{10,-100}}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={175,175,175}), 
        Polygon(
          points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={0,0,255})}));
end IdealPump;