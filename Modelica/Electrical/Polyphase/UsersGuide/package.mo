within Modelica.Electrical.Polyphase;
package UsersGuide "用户指南"
  extends Modelica.Icons.Information;

  annotation (preferredView="info", 
    DocumentationClass=true, 
    Documentation(info="<html>
<p>
该库包含用于建模多相电路的组件。
相数m不限于三个。
连接器(称为插头)包含m个单相<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.Pin\">引脚</a>的数组。
大多数组件使用来自<a href=\"modelica://Modelica.Electrical.Analog\">Modelica.Electrical.Analog</a>的单相组件数组。
</p>
<h4>注意</h4>
<p>
对于任意相数m&gt;3的方向，请参阅<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">相位定向概念</a>。
</p>
</html>"));
end UsersGuide;