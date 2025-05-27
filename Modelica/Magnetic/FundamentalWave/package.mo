within Modelica.Magnetic;
package FundamentalWave "电机磁基波效应库"
  extends Modelica.Icons.Package;
  annotation (preferredView="info", Documentation(revisions="<html>

<p><a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.ReleaseNotes\">release notes</a>中汇总了更改的详细列表。.</p>

</html>", info="<html>
  <p><strong>有关各种机器模型的判别，请参阅 <a href=\"modelica://Modelica.Electrical.Machines.UsersGuide.Discrimination\">discrimination</a></strong>.</p>
<p>
Copyright &copy; 2009-2020, Modelica Association and contributors
</p>
</html>"), 
    Icon(graphics={
        Rectangle(
          extent={{-40,60},{-60,-60}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={128,128,128}), 
        Rectangle(
          extent={{-40,70},{40,50}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-40,60},{80,-60}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={255,128,0}), 
        Rectangle(
          extent={{80,10},{100,-10}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={95,95,95}), 
        Polygon(
          points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90}, 
              {80,-100},{-50,-100},{-50,-90}}, 
          fillPattern=FillPattern.Solid)}));
end FundamentalWave;