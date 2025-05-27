within Modelica.Electrical.PowerConverters.Interfaces.Enable;
partial model Enable1 
  "提供一个触发信号的启用参数和可选启用输入的部分模型"
  extends PowerConverters.Interfaces.Enable.Enable(final m=1);
  Modelica.Blocks.Logical.And andCondition_p 
    "正电位晶体管的And条件" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=270, 
        origin={-60,-80})));
  Modelica.Blocks.Interfaces.BooleanInput fire_p 
    "正电位晶体管的触发信号" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={-60,-120})));
equation
  connect(andCondition_p.u1, fire_p) annotation (Line(
      points={{-60,-92},{-60,-120}}, color={255,0,255}));
  connect(enableLogic.enable, enable) annotation (Line(
      points={{100,-92},{100,-120}}, color={255,0,255}));
  connect(enableLogic.internalEnable[1], andCondition_p.u2) annotation (
      Line(
      points={{79,-80},{76,-80},{76,-96},{40,-96},{40,-76},{-40,-76},{-40,-100}, 
          {-52,-100},{-52,-92}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>这个部分模型为一个触发信号提供了启用逻辑。</p>
</html>"));
end Enable1;