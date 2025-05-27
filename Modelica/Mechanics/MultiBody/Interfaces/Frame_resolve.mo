within Modelica.Mechanics.MultiBody.Interfaces;
connector Frame_resolve 
  "固定于组件的坐标系，用于表示矢量在哪个坐标系中解析(图标为非填充矩形)"
  extends Frame;

  annotation (defaultComponentName="frame_resolve", 
    Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}, 
          initialScale=0.16), graphics={Rectangle(
            extent={{-10,10},{10,-10}}, 
            lineColor={95,95,95}, 
            pattern=LinePattern.Dot), Rectangle(
            extent={{-30,100},{30,-100}}, 
            lineColor={95,95,95}, 
            pattern=LinePattern.Dot, 
            fillColor={255,255,255}, 
            fillPattern=FillPattern.Solid)}), 
    Diagram(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}, 
          initialScale=0.16), graphics={Text(
            extent={{-140,-50},{140,-90}}, 
            textString="%name"), Rectangle(
            extent={{-12,40},{12,-40}}, 
            lineColor={95,95,95}, 
            pattern=LinePattern.Dot, 
            fillColor={255,255,255}, 
            fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
固定在机械部件上的坐标系的基本定义。
在坐标系的原点，作用着局部力和局部力矩。
该坐标系用于表示矢量在哪个坐标系中解析。
使用Frame_resolve连接器的组件必须将该坐标系的局部力和局部力矩设置为零。
当从一个Frame_resolve连接器连接到另一个坐标系连接器时，默认情况下连接线的线型为\"虚线\"。
该组件有一个未填充的矩形图标。
</p>
</html>"));
end Frame_resolve;