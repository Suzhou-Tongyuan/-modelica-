within Modelica.Mechanics.MultiBody.Interfaces;
connector Frame_b 
  "固定于组件的坐标系，同时带有一个局部力和局部力矩(图标为非填充矩形)"
  extends Frame;

  annotation (defaultComponentName="frame_b", 
   Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.16), graphics={Rectangle(
          extent={{-10,10},{10,-10}}, 
          lineColor={95,95,95}, 
          lineThickness=0.5), Rectangle(
          extent={{-30,100},{30,-100}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
   Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.16), graphics={Text(
          extent={{-140,-50},{140,-90}}, 
          textString="%name"), Rectangle(
          extent={{-12,40},{12,-40}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
固定在机械部件上的坐标系的基本定义。
在坐标系的原点，作用着局部力和局部力矩。该组件有一个未填充的矩形图标。
</p>
</html>"));
end Frame_b;