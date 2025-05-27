within Modelica.Electrical.QuasiStatic;
package Machines "准静态机器模型"
  extends Modelica.Icons.Package;
  annotation (Icon(graphics={
        Rectangle(
          origin={0,14.817}, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-54.179,-59.817},{65.821,60.183}}), 
        Rectangle(
          origin={5.821,15}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-80,-60},{-60,60}}), 
        Rectangle(
          origin={5.821,15}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{60,-10},{80,10}}), 
        Rectangle(
          origin={5.821,15}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          extent={{-60,50},{20,70}}), 
        Polygon(
          origin={5.821,15}, 
          fillPattern=FillPattern.Solid, 
          points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{60, 
              -100},{-70,-100},{-70,-90}})}), preferredView="info", Documentation(info="<html>
<p><strong>要区分各种机器模型，请参见<a href=\"modelica://Modelica.Electrical.Machines.UsersGuide.Discrimination\">区分</a></strong>。</p>
<p>
版权 &copy; 1998-2020，Modelica Association 和贡献者
</p>
<p>此包包含准静态感应机和变压器模型。</p>
<h4>注意</h4>
<p>
准静态直流机仍使用直流电压和电流进行操作，而准静态感应机和变压器
使用由时间相量表示的正弦电压和电流进行操作。 准静态理论可以在
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">参考文献</a> 中找到。
因此，准静态直流机模型是
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines\">机器库</a>
的一部分。
</p>
</html>"));
end Machines;