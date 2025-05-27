within Modelica.Electrical.PowerConverters.Interfaces.Enable;
partial model Enable1m 
  "提供m个触发信号的启用参数和可选启用输入的部分模型"
  parameter Boolean useConstantEnable=true 
    "如果为true，则禁用布尔输入并使用constantEnable" 
    annotation (Dialog(tab="Enable"));
  parameter Boolean constantEnable=true 
    "启用触发信号的常数" 
    annotation (Dialog(tab="Enable", enable=useConstantEnable));
  parameter Integer m(final min=3) = 3 "相位数" annotation(Evaluate=true);
  Modelica.Blocks.Logical.And andCondition_p[m] 
    "m个正电位晶体管的And条件" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=270, 
        origin={-60,-80})));
  Modelica.Blocks.Interfaces.BooleanInput fire_p[m] 
    "正电位晶体管的m个触发信号" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={-60,-120})));
  PowerConverters.Enable.EnableLogic enableLogic(
    final useConstantEnable=useConstantEnable, 
    final constantEnable=constantEnable, 
    final m=m) "启用逻辑" 
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
  Modelica.Blocks.Interfaces.BooleanInput enable if not useConstantEnable 
    "启用触发信号" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={100,-120})));
equation
  connect(andCondition_p.u1, fire_p) annotation (Line(
      points={{-60,-92},{-60,-120}}, color={255,0,255}));
  connect(enableLogic.enable, enable) annotation (Line(
      points={{100,-92},{100,-120}}, color={255,0,255}));
  connect(enableLogic.internalEnable, andCondition_p.u2) annotation (Line(
      points={{79,-80},{76,-80},{76,-96},{40,-96},{40,-76},{-40,-76},{-40,-100}, 
          {-52,-100},{-52,-92}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>这个部分模型为 <code>m</code> 个触发信号提供了启用逻辑。</p>
</html>"));
end Enable1m;