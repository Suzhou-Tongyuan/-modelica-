within Modelica.Electrical.PowerConverters.Interfaces.Enable;
partial model Enable2m 
  "提供2*m个触发信号的启用参数和可选启用输入的部分模型"
  extends Interfaces.Enable.Enable1m;
  Modelica.Blocks.Logical.And andCondition_n[m] 
    "m 个负电位晶体管的 And 条件" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={60,-80})));
  Modelica.Blocks.Interfaces.BooleanInput fire_n[m] 
    "负电位晶体管的触发信号" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={60,-120})));
equation
  connect(fire_n, andCondition_n.u1) annotation (Line(
      points={{60,-120},{60,-92}}, color={255,0,255}));
  connect(enableLogic.internalEnable, andCondition_n.u2) annotation (Line(
      points={{79,-80},{76,-80},{76,-96},{52,-96},{52,-92}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>这个部分模型为 <code>2*m</code> 个触发信号提供了启用逻辑。</p>
</html>"));
end Enable2m;