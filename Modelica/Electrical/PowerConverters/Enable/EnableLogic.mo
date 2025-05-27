within Modelica.Electrical.PowerConverters.Enable;
model EnableLogic 
  "部分模型，提供使能参数和可选的使能输入"
  parameter Boolean useConstantEnable=true 
    "如果为真，则禁用布尔输入并使用 constantEnable";
  parameter Boolean constantEnable=true 
    "触发信号的恒定启用" 
    annotation (Dialog(enable=useConstantEnable));
  parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  Modelica.Blocks.Sources.BooleanConstant enableConstantSource(final k= 
        constantEnable) if useConstantEnable 
    "fire 和 notFire 的恒定启用信号" annotation (Placement(
        transformation(
        extent={{-10,10.5},{10,-10.5}}, 
        rotation=180, 
        origin={69.5,0})));
  Modelica.Blocks.Interfaces.BooleanInput enable if not useConstantEnable 
    "启用 fire 和 notFire" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={100,-120})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(final nout=m) 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput internalEnable[m] 
    "m 个复制的启用信号" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={-110,0})));
equation
  connect(internalEnable, booleanReplicator.y) annotation (Line(
      points={{-110,0},{-11,0}}, color={255,0,255}));
  connect(enable, booleanReplicator.u) annotation (Line(
      points={{100,-120},{100,-80},{40,-80},{40,-40},{40,0},{26, 
          0},{12,0}}, color={255,0,255}));
  connect(enableConstantSource.y, booleanReplicator.u) annotation (Line(
      points={{58.5,0},{12,0}}, color={255,0,255}));
  annotation (defaultComponentName="enable", 
    Documentation(info="<html>
<p>该模型提供一个内部启用信号，该信号可以根据参数或可选的信号输入进行导出。
对于 <code>useConstantEnable = true</code>，内部信号 <code>internalEnable</code> 等于参数 <code>constantEnable</code>。
对于 <code>useConstantEnable = false</code>，内部信号 <code>internalEnable</code> 等于外部信号输入 <code>enable</code>。</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}}, 
          lineColor={255,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), Text(
          extent={{-58,60},{58,-60}}, 
          textColor={255,0,255}, 
          textString="enable")}));
end EnableLogic;