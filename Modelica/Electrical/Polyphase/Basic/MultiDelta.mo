within Modelica.Electrical.Polyphase.Basic;
model MultiDelta 
  "由多个基础系统组成的多相系统的三角形连接"
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter Integer m(final min=2) = 3 "相数" annotation(Evaluate=true);
  parameter Integer kPolygon(final min=1)=1 "多边形的替代方案";
  final parameter Integer mSystems=numberOfSymmetricBaseSystems(m) "基础系统数量";
  final parameter Integer mBasic=integer(m/mSystems) "每个基础系统的相数";
  Polyphase.Interfaces.PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Polyphase.Interfaces.NegativePlug plug_n(final m=m) 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
protected
  parameter Integer kP=if (mBasic<=2 or kPolygon<1 or kPolygon>integer(mBasic - 1)/2) then 1 else kPolygon;
equation
  for k in 1:mSystems loop
    for j in 1:(mBasic -kP) loop
      connect(plug_n.pin[(k - 1)*mBasic + j], plug_p.pin[(k - 1)*mBasic + j + kP]);
    end for;
    for j in (mBasic - kP + 1):mBasic loop
      connect(plug_n.pin[(k - 1)*mBasic + j], plug_p.pin[(k - 2)*mBasic + j + kP]);
    end for;
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{-46,0}}, color={0,0,255}), 
        Line(
          points={{-44,62},{-44,-76},{75,-6},{-44,62},{-44,61}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Line(points={{80,0},{90,0}}, color={0,0,255}), 
        Line(
          points={{-36,74},{-36,-64},{83,6},{-36,74},{-36,73}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Text(
          extent={{-150,-110},{150,-70}}, 
          textString="m=%m"), 
        Text(
          extent={{-150,70},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
                              Documentation(info="<html>
<p>
多个基础系统组成的多相电路的三角(多边形)连接(参见<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">多相指南</a>)。
</p>
<h4>注意</h4>
<p>
如果kPolygon&lt;1或kPolygon&gt;(mBasic-1)/2，则将kPolygon替换为值1，而不发出进一步警告。<br>
在m=2的情况下，kPolygon=1是唯一有效的选择。
</p>
<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStar\">MultiStar</a>
</p>
</html>"));
end MultiDelta;