within Modelica.Electrical.PowerConverters.ACAC.Control;
block SoftStartControl
  extends Modelica.Blocks.Icons.Block;
  import ModeOfOperation = 
    Modelica.Electrical.PowerConverters.Types.SoftStarterModeOfOperation;
  parameter SI.Time tRampUp "启动斜坡持续时间";
  parameter Real vStart=0 "启动电压 / 额定电压";
  parameter Real iMax "最大电流 / 额定电流";
  parameter Real iMin=0.9*iMax "电流控制下限";
  parameter SI.Current INominal "额定电流";
parameter SI.Time tRampDown "停止斜坡持续时间";
  Modelica.Blocks.Interfaces.RealInput iRMS(unit="A") "测量的有效值电流" 
    annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput vRef(min=0, max=1, start=0) "参考电压" 
    annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanInput start annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
protected
  PowerConverters.Types.SoftStarterModeOfOperation modeOfOperation;
  Real i=iRMS/INominal "测量电流";
  Boolean limit "指示电流限制";
initial equation
  if start then
    if vRef<1 then
      modeOfOperation=ModeOfOperation.Up;
    else
      modeOfOperation=ModeOfOperation.On;
    end if;
  else
    if vRef>0 then
      modeOfOperation=ModeOfOperation.Down;
    else
      modeOfOperation=ModeOfOperation.Off;
    end if;
  end if;
  limit = i>=iMax;
equation
  assert(iMax>iMin, "iMax 必须大于 iMin");
  when start then
    modeOfOperation = ModeOfOperation.Up;
  elsewhen vRef>=1 then
    modeOfOperation = ModeOfOperation.On;
  elsewhen not start then
    modeOfOperation = ModeOfOperation.Down;
  elsewhen vRef<=0 then
    modeOfOperation = ModeOfOperation.Off;
  end when;
  when start and vRef<vStart then
    reinit(vRef, vStart);
  end when;
  when i>=iMax then
    limit=true;
  elsewhen i<=iMin then
    limit=false;
  end when;
  if modeOfOperation==ModeOfOperation.Up and not limit then
    der(vRef) = (1 - vStart)/tRampUp;
  elseif modeOfOperation==ModeOfOperation.Down  and not limit then
    der(vRef) = -1/tRampDown;
  else
    der(vRef) = 0;
  end if;
  annotation (Documentation(info="<html>
<p>
该模块模拟了软启动控制器的功能，根据额定电压控制输出 <code>vRef</code> 在 [0,1] 范围内。
</p>
<p>
布尔输入 <code>start = true</code> 导致输出 <code>vRef</code> 根据斜坡升高： <code>vRef = vStart + (1 - vStart)*(time - t0)/tRampUp</code>。
</p>
<p>
在启动斜坡期间，如果电流超过指定的最大电流 <code>iMax</code>，则斜坡停止。
当电流低于电流控制下限 <code>iMin &lt; iMax</code> 时，斜坡继续。
</p>
<p>
注意：建议过滤测量电流，例如使用 <a href=\"modelica://Modelica.Blocks.Continuous.Filter\">Modelica.Blocks.Continuous.Filter</a>。
</p>
<p>
布尔输入 <code>start = false</code> 导致输出 <code>vRef</code> 根据斜坡降低： <code>vRef = -(time - t0)/tRampDown</code>。
</p>
</html>"), Icon(graphics={
        Polygon(
          points={{-12,20},{-12,-4},{12,8},{-12,20}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-12,20},{-12,-20}}, color={0,0,255}), 
        Line(points={{12,20},{12,-20}}, color={0,0,255}), 
        Polygon(
          points={{-12,12},{-12,-12},{12,0},{-12,12}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          origin={0,-8}, 
          rotation=180), 
        Line(points={{-40,0},{-12,0}}, color={0,0,255}), 
        Line(points={{12,0},{40,0}}, color={0,0,255}), 
        Polygon(
          points={{-12,80},{-12,56},{12,68},{-12,80}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-12,80},{-12,40}}, color={0,0,255}), 
        Line(points={{12,80},{12,40}}, color={0,0,255}), 
        Polygon(
          points={{-12,12},{-12,-12},{12,0},{-12,12}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          origin={0,52}, 
          rotation=180), 
        Line(points={{-40,60},{-12,60}}, color={0,0,255}), 
        Line(points={{12,60},{40,60}}, color={0,0,255}), 
        Polygon(
          points={{-12,-40},{-12,-64},{12,-52},{-12,-40}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-12,-40},{-12,-80}}, color={0,0,255}), 
        Line(points={{12,-40},{12,-80}}, color={0,0,255}), 
        Polygon(
          points={{-12,12},{-12,-12},{12,0},{-12,12}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          origin={0,-68}, 
          rotation=180), 
        Line(points={{-40,-60},{-12,-60}}, color={0,0,255}), 
        Line(points={{12,-60},{40,-60}}, color={0,0,255})}));
end SoftStartControl;