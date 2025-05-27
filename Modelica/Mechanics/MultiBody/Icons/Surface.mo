within Modelica.Mechanics.MultiBody.Icons;
model Surface "表面图标"
  annotation (Icon(graphics={Polygon(
          points={{-102,40},{-98,92},{28,-8},{96,146},{104,-118},{-18,-34},{-52, 
              -130},{-102,40}}, 
          lineColor={0,0,255}, 
          smooth=Smooth.Bezier, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,140},{150,100}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(info="<html>
<p>
该图标设计用于<strong>参数化表面</strong>模型。
</p>
</html>"));
end Surface;