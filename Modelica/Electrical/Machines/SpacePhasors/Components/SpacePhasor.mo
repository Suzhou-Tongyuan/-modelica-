within Modelica.Electrical.Machines.SpacePhasors.Components;
model SpacePhasor 
  "物理转换：三相<->空间矢量"
  import Modelica.Constants.pi;
  constant Integer m=3 "相数";
  parameter Real turnsRatio=1 "变比";
  SI.Voltage v[m] "瞬时相电压";
  SI.Current i[m] "瞬时相电流";
protected
  parameter Real TransformationMatrix[2, m]=2/m*{{cos(+(k - 1)/m*2*pi) 
      for k in 1:m},{+sin(+(k - 1)/m*2*pi) for k in 1:m}};
  parameter Real InverseTransformation[m, 2]={{cos(-(k - 1)/m*2*pi),-sin(
      -(k - 1)/m*2*pi)} for k in 1:m};
public
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(final m=m) 
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin zero annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin ground annotation (
      Placement(transformation(extent={{90,-110},{110,-90}})));
  Machines.Interfaces.SpacePhasor spacePhasor 
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
equation
  v/turnsRatio = plug_p.pin.v - plug_n.pin.v;
  i*turnsRatio = +plug_p.pin.i;
  i*turnsRatio = -plug_n.pin.i;
  m*zero.v = sum(v);
  spacePhasor.v_ = TransformationMatrix*v;
  //v  = fill(zero.v,m) + InverseTransformation*spacePhasor.v_;
  -m*zero.i = sum(i);
  -spacePhasor.i_ = TransformationMatrix*i;
  //-i  = fill(zero.i,m) + InverseTransformation*spacePhasor.i_;
  ground.v = 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{0,0},{80,80},{60,72},{72,60},{80,80}}, color={0,0,255}), 
        Line(points={{0,0},{80,-80},{72,-60},{60,-72},{80,-80}}, color={0,0,255}), 
        Line(
          points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33, 
              17.32},{-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20, 
              -20},{-13.33,-17.32},{-6.67,-10},{0,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33, 
              17.32},{-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30, 
              -20},{-23.33,-17.32},{-16.67,-10},{-10,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33, 
              17.32},{-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10, 
              -20},{-3.33,-17.32},{3.33,-10},{10,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Text(
          extent={{-150,-120},{150,-160}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Text(
          extent={{40,10},{90,-10}}, 
          textColor={0,0,255}, 
          textString="zero"), 
        Line(points={{90,-100},{60,-100}}, color={0,0,255}), 
        Line(points={{60,-84},{60,-116}}, color={0,0,255}), 
        Line(points={{50,-90},{50,-110}}, color={0,0,255}), 
        Line(points={{40,-96},{40,-104}}, color={0,0,255})}), 
      Documentation(info="<html>
电压和电流的物理转换：三相&lt;-&gt;空间矢量：<br>
x[k]=X0+{cos(-(k-1)/m*2*pi),-sin(-(k-1)/m*2*pi)}*X[Re,Im]<br>
反之亦然：<br>
X0 = sum(x[k])/m<br>
X[Re,Im] = sum(2/m*{cos((k-1)/m*2*pi),sin((k-1)/m*2*pi)}*x[k])<br>
这里，x表示三相值，X[Re,Im]表示空间矢量，X0表示零序系统。<br>
<em>物理转换</em> 表示电压和电流在两个方向上都进行了转换。<br>
零序电压和电流存在于零点引脚。可以在零点引脚和地引脚之间连接额外的零序阻抗。
</html>"));
end SpacePhasor;