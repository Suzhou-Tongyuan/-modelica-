within Modelica.Electrical.Polyphase.Basic;
model MultiStar 
  "多个基础系统组成的多相系统的星形连接"
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  final parameter Integer mSystems=numberOfSymmetricBaseSystems(m) "基础系统数量";
  final parameter Integer mBasic=integer(m/mSystems) "每个基础系统的相数";
  Polyphase.Interfaces.PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Polyphase.Interfaces.NegativePlug starpoints(final m=mSystems) 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  for k in 1:mSystems loop
    for j in 1:mBasic loop
      connect(plug_p.pin[(k - 1)*mBasic + j], starpoints.pin[k]);
    end for;
  end for;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(
          points={{74,-4},{-6,-4}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Line(
          points={{-6,-4},{-45,64}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Line(
          points={{-6,-4},{-44,-73}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Line(points={{-90,0},{-40,0}}, color={0,0,255}), 
        Line(points={{80,0},{90,0}}, color={0,0,255}), 
        Line(
          points={{6,4},{-33,72}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Line(
          points={{86,4},{6,4}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Line(
          points={{6,4},{-32,-65}}, 
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
将多相电路的星形(wye)连接连接到由多个基础系统组成的电路中(请参阅<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">多相指南</a>)。星点处的电势都是相等的。
</p>
<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiDelta\">MultiDelta</a>
</p></html>"));
end MultiStar;