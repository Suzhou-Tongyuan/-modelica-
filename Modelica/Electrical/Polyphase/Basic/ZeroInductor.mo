within Modelica.Electrical.Polyphase.Basic;
model ZeroInductor "线性零序电感"
  extends Polyphase.Interfaces.OnePort;
  parameter SI.Inductance Lzero "零序电感";
  SI.Current i0;
  SI.Voltage v0;
equation
  m*i0 = sum(i);
  v0 = Lzero*der(i0);
  v = fill(v0, m);
  annotation (defaultComponentName="inductor", Documentation(info="<html>
<p>
模型表示多相零序电感器。
</p>
<h4>实现</h4>
<blockquote><pre>
v = Lzero*sum(der(i)) = Lzero*der(sum(i))
</pre></blockquote>

</html>"), 
       Icon(graphics={
        Line(points={{-90,0},{-50,0}}, color={0,0,255}), 
        Line(points={{52,0},{90,0}}, color={0,0,255}), 
        Ellipse(extent={{-50,30},{-8,-32}}, lineColor={0,0,255}), 
        Ellipse(extent={{-20,30},{22,-32}}, lineColor={0,0,255}), 
        Ellipse(extent={{10,30},{52,-32}}, lineColor={0,0,255}), 
        Text(
          extent={{-150,50},{150,90}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-80},{150,-40}}, 
          textString="m=%m")}));
end ZeroInductor;