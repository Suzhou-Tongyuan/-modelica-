within Modelica.Thermal.FluidHeatFlow.Components;
model Cylinder "气缸中活塞的简单模型"
  import Modelica.Constants.small;
  extends FluidHeatFlow.BaseClasses.SinglePortLeft(final Exchange=true);

  parameter SI.Area A "气缸/活塞的截面";
  parameter SI.Length L "气缸长度";
  extends 
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2
    (s(start=small));
  SI.Force f=flange.f "活塞受力";
protected
  SI.Mass m "介质质量";
  SI.Enthalpy H "介质的焓";
equation
  assert(s>=small, getInstanceName()+": 活塞碰到气缸底部!");
  assert(s<=L, getInstanceName()+":活塞碰到汽缸顶部!");
  flowPort.p*A = -f;
  m = medium.rho*A*s;
  der(m) = flowPort.m_flow;
  H = m*h;
  der(H)=flowPort.H_flow;
  annotation (Documentation(info="<html><p>
这是气缸中活塞的简单模型:
</p>
<p>
平移法兰与活塞连接，气缸底部有一个流体接口。
</p>
<p>
活塞在气缸内的位置从底部的0到气缸顶部的L(气缸长度)。 如果活塞离开气缸，则触发一个断言。
</p>
<li>
活塞的运动与通过流体接口的体积流量相耦合。</li>
<li>
活塞上的力等于流体的压力乘以A(活塞的横截面)。</li>
<p>
活塞被认为没有质量。
</p>
<p>
注释: 注意初始条件。活塞的位置(相对于支架)应在(0,L)范围内。 法兰的位置(以及支架的位置，if useSupport=true)受到连接部件的影响。
</p>
</html>"), 
     Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={       Text(
          extent={{-150,140},{150,100}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Polygon(
          points={{-90,10},{-70,10},{-70,60},{70,60},{70,-60},{-70,-60},{-70,-10}, 
              {-90,-10},{-90,10}}, 
          lineColor={255,0,0}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          lineThickness=0.5), 
        Rectangle(
          extent={{-14,58},{68,-58}}, 
          lineColor={28,108,200}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-24,58},{-14,-58}}, 
          lineThickness=0.5, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.HorizontalCylinder), 
        Rectangle(
          extent={{-14,10},{90,-10}}, 
          lineThickness=0.5, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.HorizontalCylinder), 
        Line(points={{-10,-72},{70,-72}}), 
        Polygon(
          points={{-40,-72},{-10,-62},{-10,-82},{-40,-72}}, 
          lineColor={128,128,128}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.Solid)}));
end Cylinder;