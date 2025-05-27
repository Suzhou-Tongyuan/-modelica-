within Modelica.Electrical.PowerConverters.Interfaces.Enable;
partial model Enable 
  "提供启用参数和可选的启用输入的部分模型"
  parameter Boolean useConstantEnable=true 
    "如果为true，则禁用布尔输入并使用constantEnable" 
    annotation (Dialog(tab="Enable"));
  parameter Boolean constantEnable=true 
    "常量启用发射信号" 
    annotation (Dialog(tab="Enable", enable=useConstantEnable));
  parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  PowerConverters.Enable.EnableLogic enableLogic(
    final useConstantEnable=useConstantEnable, 
    final constantEnable=constantEnable, 
    final m=m) "启用逻辑" 
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
  Modelica.Blocks.Interfaces.BooleanInput enable if not useConstantEnable 
    "启用fire和notFire" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={100,-120})));
equation
  connect(enableLogic.enable, enable) annotation (Line(
      points={{100,-92},{100,-120}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>
这个部分模型为启用模型提供了参数和条件输入信号：</p>
<ul>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable1\">Enable1</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable2\">Enable2</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable1m\">Enable1m</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable2m\">Enable2m</a></li>
</ul>
</html>"));
end Enable;