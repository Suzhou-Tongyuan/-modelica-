within Modelica.Mechanics.Rotational.Components;
model IdealGear "无惯性的理想齿轮"
  extends Modelica.Mechanics.Rotational.Icons.Gear;
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
  parameter Real ratio(start=1) 
    "传动比（flange_a.phi/flange_b.phi）";
  SI.Angle phi_a 
     "左轴一维转动接口与支撑之间的角度";
  SI.Angle phi_b 
    "右轴一维转动接口与支撑之间的角度";

equation
  phi_a = flange_a.phi - phi_support;
  phi_b = flange_b.phi - phi_support;
  phi_a = ratio*phi_b;
  0 = ratio*flange_a.tau + flange_b.tau;
  annotation (
    Documentation(info="<html>
<p>
该元件描述了任何类型的固定在地面上的齿轮箱，该箱具有一个驱动轴和一个被驱动轴。
齿轮是<strong>理想的</strong>，即它没有惯性、弹性、阻尼或齿隙。如果需要考虑这些效应，则必须以适当的方式将齿轮连接到其他元素。
</p>
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100,-100},{100,100}}), 
    graphics={
      Text(extent={{-153,145},{147,105}}, 
        textColor={0,0,255}, 
        textString="%name"), 
      Text(extent={{-146,-49},{154,-79}}, 
        textString="ratio=%ratio")}));
end IdealGear;