within Modelica.Electrical.Polyphase.Interfaces;
connector PositivePlug "具有m个引脚的正极电气多相插头"
  extends Plug;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid)}), 
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={Ellipse(
          extent={{-40,40},{40,-40}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
连接器PositivePlug和NegativePlug几乎相同。
唯一的区别在于，图标不同，以便更容易识别组件的插头。
通常情况下，连接器PositivePlug用于电气组件的正极，连接器NegativePlug用于负极。<br>
连接器Plug是一个复合连接器，包含m个引脚(Modelica.Electrical.Analog.Interfaces.Pin)。
</p>
</html>"));
end PositivePlug;