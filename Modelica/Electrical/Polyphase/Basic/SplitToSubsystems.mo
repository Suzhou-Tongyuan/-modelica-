within Modelica.Electrical.Polyphase.Basic;
model SplitToSubsystems "将多相分成子系统"
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  final parameter Integer mSystems=numberOfSymmetricBaseSystems(m) 
    "基础系统数量";
  final parameter Integer mBasic=integer(m/mSystems) 
    "每个基础系统的相数";
  Interfaces.PositivePlug plug_p(final m=m) 
    "带有m个引脚的正多相电插头" annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plugs_n[mSystems](each final m=mBasic) 
    "带有每个mBasic引脚的mSystems负多相电插头" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  for k in 1:mSystems loop
    for j in 1:mBasic loop
      connect(plug_p.pin[(k - 1)*mBasic + j], plugs_n[k].pin[j]);
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
将插头plug_p中的m相分割成子系统，即，根据用户指南中描述的相方向，形成mSystems个带有mBasic个引脚的插头。
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-150,60},{150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-110},{150,-70}}, 
          textString="m=%m"), 
        Line(points={{-90,0},{-20,0}}, color={0,0,255}), 
        Line(points={{-90,2},{-20,2}}, color={0,0,255}), 
        Line(points={{-90,-2},{-20,-2}}, 
                                       color={0,0,255}), 
        Line(points={{-20,0},{90,0}},  color={0,0,255}, 
          pattern=LinePattern.Dot), 
        Line(points={{-20,2},{-0.78125,10},{100,10}}, 
                                       color={0,0,255}), 
        Line(points={{-20,-2},{-0.7812,-10},{100,-10}}, 
                                       color={0,0,255})}));
end SplitToSubsystems;