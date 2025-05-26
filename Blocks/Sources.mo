within Modelica.Blocks;
package Sources 
  "Library of signal source blocks generating Real, Integer and Boolean signals"
  import Modelica.Blocks.Interfaces;

  extends Modelica.Icons.SourcesPackage;

  block RealExpression "Set output signal to a time varying Real expression"

    Modelica.Blocks.Interfaces.RealOutput y=0.0 "Value of Real output" 
      annotation (Dialog(group="Time varying output signal"), Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, 
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,40},{100,-40}}, 
            fillColor={235,235,235}, 
            fillPattern=FillPattern.Solid, 
            borderPattern=BorderPattern.Raised), 
          Text(
            extent={{-96,15},{96,-15}}, 
            textString="%y"), 
          Text(
            extent={{-150,90},{150,50}}, 
            textString="%name", 
            textColor={0,0,255})}), Documentation(info="<html>
<p>
The (time varying) Real output signal of this block can be defined in its
parameter menu via variable <strong>y</strong>. The purpose is to support the
easy definition of Real expressions in a block diagram. For example,
in the y-menu the definition \"if time &lt; 1 then 0 else 1\" can be given in order
to define that the output signal is one, if time &ge; 1 and otherwise
it is zero. Note, that \"time\" is a built-in variable that is always
accessible and represents the \"model time\" and that
variable <strong>y</strong> is both a variable and a connector.
</p>
</html>"));

  end RealExpression;

  block IntegerExpression 
    "Set output signal to a time varying Integer expression"

    Modelica.Blocks.Interfaces.IntegerOutput y=0 "Value of Integer output" 
      annotation (Dialog(group="Time varying output signal"), Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, 
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,40},{100,-40}}, 
            fillColor={235,235,235}, 
            fillPattern=FillPattern.Solid, 
            borderPattern=BorderPattern.Raised), 
          Text(
            extent={{-96,15},{96,-15}}, 
            textString="%y"), 
          Text(
            extent={{-150,90},{150,50}}, 
            textString="%name", 
            textColor={0,0,255})}), Documentation(info="<html>
<p>
The (time varying) Integer output signal of this block can be defined in its
parameter menu via variable <strong>y</strong>. The purpose is to support the
easy definition of Integer expressions in a block diagram. For example,
in the y-menu the definition \"if time &lt; 1 then 0 else 1\" can be given in order
to define that the output signal is one, if time &ge; 1 and otherwise
it is zero. Note, that \"time\" is a built-in variable that is always
accessible and represents the \"model time\" and that
variable <strong>y</strong> is both a variable and a connector.
</p>
</html>"));

  end IntegerExpression;

  block BooleanExpression 
    "Set output signal to a time varying Boolean expression"

    Modelica.Blocks.Interfaces.BooleanOutput y=false "Value of Boolean output" 
      annotation (Dialog(group="Time varying output signal"), Placement(
          transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, 
          extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,40},{100,-40}}, 
            fillColor={235,235,235}, 
            fillPattern=FillPattern.Solid, 
            borderPattern=BorderPattern.Raised), 
          Text(
            extent={{-96,15},{96,-15}}, 
            textString="%y"), 
          Text(
            extent={{-150,90},{150,50}}, 
            textString="%name", 
            textColor={0,0,255}), 
          Polygon(
            points={{100,10},{120,0},{100,-10},{100,10}}, 
            lineColor=DynamicSelect({255,0,255}, if y then {0,255,0} else {255,0,255}), 
            fillColor=DynamicSelect({255,255,255}, if y then {0,255,0} else {255,255,255}), 
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
The (time varying) Boolean output signal of this block can be defined in its
parameter menu via variable <strong>y</strong>. The purpose is to support the
easy definition of Boolean expressions in a block diagram. For example,
in the y-menu the definition \"time &gt;= 1 and time &lt;= 2\" can be given in order
to define that the output signal is <strong>true</strong> in the time interval
1 &le; time &le; 2 and otherwise it is <strong>false</strong>.
Note, that \"time\" is a built-in variable that is always
accessible and represents the \"model time\" and that
variable <strong>y</strong> is both a variable and a connector.
</p>
</html>"));

  end BooleanExpression;
  block Clock "Generate actual time signal"
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else time - startTime);
    annotation (Protection(hideFromBrowser=true), 
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164}), 
          Line(points={{0,80},{0,60}}, color={160,160,164}), 
          Line(points={{80,0},{60,0}}, color={160,160,164}), 
          Line(points={{0,-80},{0,-60}}, color={160,160,164}), 
          Line(points={{-80,0},{-60,0}}, color={160,160,164}), 
          Line(points={{37,70},{26,50}}, color={160,160,164}), 
          Line(points={{70,38},{49,26}}, color={160,160,164}), 
          Line(points={{71,-37},{52,-27}}, color={160,160,164}), 
          Line(points={{39,-70},{29,-51}}, color={160,160,164}), 
          Line(points={{-39,-70},{-29,-52}}, color={160,160,164}), 
          Line(points={{-71,-37},{-50,-26}}, color={160,160,164}), 
          Line(points={{-71,37},{-54,28}}, color={160,160,164}), 
          Line(points={{-38,70},{-28,51}}, color={160,160,164}), 
          Line(
            points={{0,0},{-50,50}}, 
            thickness=0.5), 
          Line(
            points={{0,0},{40,0}}, 
            thickness=0.5), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="startTime=%startTime")}), 
      Diagram(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{-80,90},{-85,68},{-75,68},{-80,90}}, 
            lineColor={95,95,95}, 
            fillColor={95,95,95}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,68},{-80,-80}}, color={95,95,95}), 
          Line(
            points={{-80,0},{-10,0},{60,70}}, 
            color={0,0,255}, 
            thickness=0.5), 
          Line(points={{-90,-70},{82,-70}}, color={95,95,95}), 
          Polygon(
            points={{90,-70},{68,-64},{68,-76},{90,-70}}, 
            lineColor={95,95,95}, 
            fillColor={95,95,95}, 
            fillPattern=FillPattern.Solid), 
          Polygon(
            points={{-34,0},{-37,-13},{-31,-13},{-34,0}}, 
            lineColor={95,95,95}, 
            fillColor={95,95,95}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-34,0},{-34,-70}}, color={95,95,95}), 
          Polygon(
            points={{-34,-70},{-37,-57},{-31,-57},{-34,-70},{-34,-70}}, 
            lineColor={95,95,95}, 
            fillColor={95,95,95}, 
            fillPattern=FillPattern.Solid), 
          Text(
            extent={{-77,-28},{-35,-40}}, 
            textString="offset"), 
          Text(
            extent={{-30,-73},{18,-86}}, 
            textString="startTime"), 
          Text(
            extent={{-81,91},{-40,71}}, 
            textString="y"), 
          Text(
            extent={{63,-79},{94,-89}}, 
            textString="time"), 
          Line(points={{-10,0},{-10,-70}}, color={95,95,95}), 
          Line(points={{-10,0},{50,0}}, color={95,95,95}), 
          Line(points={{50,0},{50,60}}, color={95,95,95}), 
          Text(
            extent={{35,33},{50,23}}, 
            textString="1"), 
          Text(
            extent={{14,13},{32,1}}, 
            textString="1")}), 
      Documentation(info="<html>
<p>
The Real output y is a clock signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Clock.png\"
 alt=\"Clock.png\">
</p>
</html>"    ));
  end Clock;

  block ContinuousClock "Generate current time signal"
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else time - startTime);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164}), 
          Line(points={{0,80},{0,60}}, color={160,160,164}), 
          Line(points={{80,0},{60,0}}, color={160,160,164}), 
          Line(points={{0,-80},{0,-60}}, color={160,160,164}), 
          Line(points={{-80,0},{-60,0}}, color={160,160,164}), 
          Line(points={{37,70},{26,50}}, color={160,160,164}), 
          Line(points={{70,38},{49,26}}, color={160,160,164}), 
          Line(points={{71,-37},{52,-27}}, color={160,160,164}), 
          Line(points={{39,-70},{29,-51}}, color={160,160,164}), 
          Line(points={{-39,-70},{-29,-52}}, color={160,160,164}), 
          Line(points={{-71,-37},{-50,-26}}, color={160,160,164}), 
          Line(points={{-71,37},{-54,28}}, color={160,160,164}), 
          Line(points={{-38,70},{-28,51}}, color={160,160,164}), 
          Line(
            points={{0,0},{-50,50}}, 
            thickness=0.5), 
          Line(
            points={{0,0},{40,0}}, 
            thickness=0.5), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="startTime=%startTime")}), 
      Documentation(info="<html>
<p>
The Real output y is a clock signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/ContinuousClock.png\"
     alt=\"ContinuousClock.png\">
</div>
</html>"));
  end ContinuousClock;

  block Constant "Generate constant signal of type Real"
    parameter Real k(start=1) "Constant output value" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png"));
    extends Interfaces.SO;

  equation
    y = k;
    annotation (
      defaultComponentName="const", 
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,0},{80,0}}), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="k=%k")}), 
      Documentation(info="<html>
<p>
The Real output y is a constant signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png\"
     alt=\"Constant.png\">
</div>
</html>"));
  end Constant;

  block Step "Generate step signal of type Real"
    parameter Real height=1 "Height of step" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Step.png"));
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else height);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,-70},{0,-70},{0,50},{80,50}}), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="startTime=%startTime")}), 
      Documentation(info="<html>
<p>
The Real output y is a step signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\"
     alt=\"Step.png\">
</div>

</html>"));
  end Step;

  block Ramp "Generate ramp signal"
    parameter Real height=1 "Height of ramps" 
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png"));
    parameter SI.Time duration(min=0.0, start=2) 
      "Duration of ramp (= 0.0 gives a Step)";
    extends Interfaces.SignalSource;

  equation
    y = offset + (if time < startTime then 0 else if time < (startTime + 
      duration) then (time - startTime)*height/duration else height);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,-70},{-40,-70},{31,38}}), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="duration=%duration"), 
          Line(points={{31,38},{86,38}})}), 
      Documentation(info="<html>
<p>
The Real output y is a ramp signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png\"
     alt=\"Ramp.png\">
</div>

<p>
If parameter duration is set to 0.0, the limiting case of a Step signal is achieved.
</p>
</html>"));
  end Ramp;

  block Sine "Generate sine signal"
    import Modelica.Constants.pi;
    parameter Real amplitude=1 "Amplitude of sine wave" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Sine.png"));
    parameter SI.Frequency f(start=1) "Frequency of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    extends Interfaces.SignalSource;
  equation
    y = offset + (if time < startTime then 0 else amplitude*Modelica.Math.sin(2 
      *pi*f*(time - startTime) + phase));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,0},{68,0}}, color={192,192,192}), 
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4, 
                74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3, 
                59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7, 
                -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5}, 
                {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, smooth = Smooth.Bezier), 
          Text(
            extent={{-147,-152},{153,-112}}, 
            textString="f=%f")}), 
      Documentation(info="<html>
<p>
The Real output y is a sine signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Sine.png\"
     alt=\"Sine.png\">
</div>
</html>"));
  end Sine;

  block Cosine "Generate cosine signal"
    import Modelica.Constants.pi;
    parameter Real amplitude=1 "Amplitude of cosine wave" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Cosine.png"));
    parameter SI.Frequency f(start=1) "Frequency of cosine wave";
    parameter SI.Angle phase=0 "Phase of cosine wave";
    extends Interfaces.SignalSource;
  equation
    y = offset + (if time < startTime then 0 else amplitude*Modelica.Math.cos(2 
      *pi*f*(time - startTime) + phase));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,0},{68,0}}, color={192,192,192}), 
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,80},{-76.2,79.8},{-70.6,76.6},{-64.9,69.7},{-59.3, 
                59.4},{-52.9,44.1},{-44.83,21.2},{-27.9,-30.8},{-20.7,-50.2},{-14.3, 
                -64.2},{-8.7,-73.1},{-3,-78.4},{2.6,-80},{8.2,-77.6},{13.9,-71.5}, 
                {19.5,-61.9},{25.9,-47.2},{34,-24.8},{42,0}}, smooth=Smooth.Bezier), 
          Text(
            extent={{-147,-152},{153,-112}}, 
            textString="f=%f"), 
          Line(points={{42,1},{53.3,35.2},{60.5,54.1},{66.9,67.4},{72.6,75.6},{
                78.2,80.1},{83.8,80.8}})}), 
      Documentation(info="<html>
<p>
The Real output y is a cosine signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Cosine.png\"
     alt=\"Cosine.png\">
</div>
</html>"));
  end Cosine;

  block SineVariableFrequencyAndAmplitude 
    "Generate sine signal with variable frequency and amplitude"
    extends Interfaces.SO;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
    parameter Real constantAmplitude=1 "Constant amplitude" 
      annotation(Dialog(enable=useConstantAmplitude));
    parameter Boolean useConstantFrequency=false "Enable constant frequency";
    parameter SI.Frequency constantFrequency=1 "Constant frequency" 
      annotation(Dialog(enable=useConstantFrequency));
    parameter Real offset=0 "Offset of the sine wave" 
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/SineVariableFrequencyAndAmplitude.png"));
    SI.Angle phi(start=0) "Phase of the sine wave";
    Blocks.Interfaces.RealInput amplitude if not useConstantAmplitude "Amplitude" 
                  annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}}, 
          origin={-120,60})));
    Blocks.Interfaces.RealInput f(unit="Hz") if not useConstantFrequency 
      "Frequency" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}}, 
          origin={-120,-60})));
  protected
    Blocks.Interfaces.RealInput amplitude_internal "Amplitude" annotation (Placement(
          transformation(
          extent={{-2,-2},{2,2}}, 
          origin={-80,60})));
    Blocks.Interfaces.RealInput f_internal(unit="Hz") "Frequency" annotation (Placement(
          transformation(
          extent={{-2,-2},{2,2}}, 
          origin={-80,-60})));
    Blocks.Sources.Constant amplitude_constant(final k=constantAmplitude) if 
      useConstantAmplitude 
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
          rotation=90, 
          origin={-80,30})));
    Blocks.Sources.Constant f_constant(final k=constantFrequency) if 
      useConstantFrequency 
      annotation (Placement(transformation(extent={{10,-10},{-10,10}}, 
          rotation=90, 
          origin={-80,-30})));
  equation
    der(phi) = 2*pi*f_internal;
    y = offset + amplitude_internal*sin(phi);
    connect(f, f_internal) 
      annotation (Line(points={{-120,-60},{-80,-60}}, color={0,0,127}));
    connect(amplitude, amplitude_internal) 
      annotation (Line(points={{-120,60},{-80,60}}, color={0,0,127}));
    connect(amplitude_constant.y, amplitude_internal) 
      annotation (Line(points={{-80,41},{-80,60}}, color={0,0,127}));
    connect(f_constant.y, f_internal) 
      annotation (Line(points={{-80,-41},{-80,-60}}, color={0,0,127}));
    annotation (defaultComponentName="sine", 
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,0},{68,0}}, color={192,192,192}), 
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={
  {-80,0},{-78.4,0},{-76.8,0},{-75.2,0},{-73.6,0.1}, 
  {-72,0.1},{-70.4,0.2},{-68.8,0.3},{-67.2,0.4},{-65.6,0.6}, 
  {-64,0.8},{-62.4,1.1},{-60.8,1.4},{-59.2,1.8},{-57.6,2.2}, 
  {-56,2.7},{-54.4,3.3},{-52.8,3.9},{-51.2,4.6},{-49.6,5.4}, 
  {-48,6.2},{-46.4,7.2},{-44.8,8.2},{-43.2,9.2},{-41.6,10.4}, 
  {-40,11.6},{-38.4,12.9},{-36.8,14.2},{-35.2,15.6},{-33.6,17.1}, 
  {-32,18.6},{-30.4,20.1},{-28.8,21.6},{-27.2,23.1},{-25.6,24.6}, 
  {-24,26.1},{-22.4,27.5},{-20.8,28.8},{-19.2,30},{-17.6,31.1}, 
  {-16,32},{-14.4,32.7},{-12.8,33.2},{-11.2,33.5},{-9.6,33.5}, 
  {-8,33.2},{-6.4,32.5},{-4.8,31.5},{-3.2,30.1},{-1.6,28.4}, 
  {0,26.2},{1.6,23.6},{3.2,20.6},{4.8,17.2},{6.4,13.3}, 
  {8,9.1},{9.6,4.6},{11.2,-0.3},{12.8,-5.4},{14.4,-10.7}, 
  {16,-16.1},{17.6,-21.6},{19.2,-27.1},{20.8,-32.3},{22.4,-37.4}, 
  {24,-42.1},{25.6,-46.3},{27.2,-49.9},{28.8,-52.8},{30.4,-54.8}, 
  {32,-56},{33.6,-56.1},{35.2,-55.2},{36.8,-53.1},{38.4,-49.8}, 
  {40,-45.3},{41.6,-39.7},{43.2,-33},{44.8,-25.3},{46.4,-16.6}, 
  {48,-7.3},{49.6,2.6},{51.2,12.8},{52.8,23},{54.4,33}, 
  {56,42.5},{57.6,51.2},{59.2,58.8},{60.8,64.9},{62.4,69.3}, 
  {64,71.9},{65.6,72.3},{67.2,70.5},{68.8,66.4},{70.4,60}, 
  {72,51.4},{73.6,40.8},{75.2,28.4},{76.8,14.7},{78.4,0}, 
  {80,-15.1}},     smooth = Smooth.Bezier)}), 
      Documentation(info="<html>
<p>
This signal source provides a sinusoidal signal with variable frequency <code>f</code> and variable <code>amplitude</code>,
i.e. the phase angle of the sine wave is integrated from 2*&pi;*f.
</p>
<p>
Note that the initial value of the phase angle <code>phi</code> defines the initial phase shift,
and that the parameter <code>startTime</code> is omitted since the voltage can be kept equal to offset with setting the input <code>amplitude</code> to zero.
</p>
</html>"));
  end SineVariableFrequencyAndAmplitude;

  block CosineVariableFrequencyAndAmplitude 
    "Generate cosine signal with variable frequency and amplitude"
    extends Interfaces.SO;
    import Modelica.Constants.pi;
    parameter Boolean useConstantAmplitude=false "Enable constant amplitude";
    parameter Real constantAmplitude=1 "Constant amplitude" 
      annotation(Dialog(enable=useConstantAmplitude));
    parameter Boolean useConstantFrequency=false "Enable constant frequency";
    parameter SI.Frequency constantFrequency=1 "Constant frequency" 
      annotation(Dialog(enable=useConstantFrequency));
    parameter Real offset=0 "Offset of the sine wave" 
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/CosineVariableFrequencyAndAmplitude.png"));
    SI.Angle phi(start=0) "Phase of the sine wave";
    Blocks.Interfaces.RealInput amplitude if not useConstantAmplitude "Amplitude" 
                  annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}}, 
          origin={-120,60})));
    Blocks.Interfaces.RealInput f(unit="Hz") if not useConstantFrequency 
      "Frequency" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}}, 
          origin={-120,-60})));
  protected
    Blocks.Interfaces.RealInput amplitude_internal "Amplitude" annotation (Placement(
          transformation(
          extent={{-2,-2},{2,2}}, 
          origin={-80,60})));
    Blocks.Interfaces.RealInput f_internal(unit="Hz") "Frequency" annotation (Placement(
          transformation(
          extent={{-2,-2},{2,2}}, 
          origin={-80,-60})));
    Blocks.Sources.Constant amplitude_constant(final k=constantAmplitude) if 
      useConstantAmplitude 
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
          rotation=90, 
          origin={-80,30})));
    Blocks.Sources.Constant f_constant(final k=constantFrequency) if 
      useConstantFrequency 
      annotation (Placement(transformation(extent={{10,-10},{-10,10}}, 
          rotation=90, 
          origin={-80,-30})));
  equation
    der(phi) = 2*pi*f_internal;
    y = offset + amplitude_internal*cos(phi);
    connect(f, f_internal) 
      annotation (Line(points={{-120,-60},{-80,-60}}, color={0,0,127}));
    connect(amplitude, amplitude_internal) 
      annotation (Line(points={{-120,60},{-80,60}}, color={0,0,127}));
    connect(amplitude_constant.y, amplitude_internal) 
      annotation (Line(points={{-80,41},{-80,60}}, color={0,0,127}));
    connect(f_constant.y, f_internal) 
      annotation (Line(points={{-80,-41},{-80,-60}}, color={0,0,127}));
    annotation (defaultComponentName="cosine", 
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,0},{68,0}}, color={192,192,192}), 
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={
  {-80,80},{-78.4,79.6},{-76.8,79.2},{-75.2,78.8},{-73.6,78.4},{-72,78}, 
  {-70.4,77.5},{-68.8,77.1},{-67.2,76.6},{-65.6,76.1},{-64,75.6}, 
  {-62.4,75},{-60.8,74.4},{-59.2,73.7},{-57.6,73},{-56,72.2}, 
  {-54.4,71.3},{-52.8,70.3},{-51.2,69.2},{-49.6,68},{-48,66.6}, 
  {-46.4,65.2},{-44.8,63.6},{-43.2,61.8},{-41.6,59.9},{-40,57.7}, 
  {-38.4,55.5},{-36.8,53},{-35.2,50.3},{-33.6,47.5},{-32,44.4}, 
  {-30.4,41.1},{-28.8,37.7},{-27.2,34},{-25.6,30.1},{-24,26.1}, 
  {-22.4,21.9},{-20.8,17.5},{-19.2,13},{-17.6,8.3},{-16,3.5}, 
  {-14.4,-1.3},{-12.8,-6.2},{-11.2,-11.1},{-9.6,-16},{-8,-20.8}, 
  {-6.4,-25.5},{-4.8,-30.1},{-3.2,-34.5},{-1.6,-38.6},{0,-42.4}, 
  {1.6,-45.9},{3.2,-49},{4.8,-51.7},{6.4,-53.9},{8,-55.5}, 
  {9.6,-56.5},{11.2,-57},{12.8,-56.8},{14.4,-55.9},{16,-54.4}, 
  {17.6,-52.2},{19.2,-49.3},{20.8,-45.7},{22.4,-41.5},{24,-36.7}, 
  {25.6,-31.4},{27.2,-25.6},{28.8,-19.4},{30.4,-12.9},{32,-6.2}, 
  {33.6,0.6},{35.2,7.4},{36.8,14},{38.4,20.4},{40,26.3}, 
  {41.6,31.8},{43.2,36.5},{44.8,40.6},{46.4,43.7},{48,45.9}, 
  {49.6,47.1},{51.2,47.2},{52.8,46.2},{54.4,44.1},{56,41}, 
  {57.6,36.8},{59.2,31.8},{60.8,25.9},{62.4,19.4},{64,12.4}, 
  {65.6,5.1},{67.2,-2.2},{68.8,-9.5},{70.4,-16.4},{72,-22.8}, 
  {73.6,-28.4},{75.2,-33},{76.8,-36.6},{78.4,-38.9},{80,-39.8}}, 
      smooth = Smooth.Bezier)}), 
      Documentation(info="<html>
<p>
This signal source provides a cosine signal with variable frequency <code>f</code> and variable <code>amplitude</code>,
i.e. the phase angle of the cosine wave is integrated from 2*&pi;*f.
</p>
<p>
Note that the initial value of the phase angle <code>phi</code> defines the initial phase shift,
and that the parameter <code>startTime</code> is omitted since the voltage can be kept equal to offset with setting the input <code>amplitude</code> to zero.
</p>
</html>"));
  end CosineVariableFrequencyAndAmplitude;

  block Sinc "Generate sinc signal"
    import Modelica.Constants.pi;
    import Modelica.Constants.eps;
    parameter Real amplitude=1 "Amplitude of sine wave" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Sinc.png"));
    parameter SI.Frequency f(start=1) "Frequency of sine wave";
    extends Interfaces.SignalSource;
  protected
    SI.Angle x=2*pi*f*(time - startTime);
  equation
    y = offset + (if time < startTime then 0 else amplitude* 
      (if noEvent(time - startTime < eps) then 1 else (sin(x))/x));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,0},{68,0}}, color={192,192,192}), 
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Text(
            extent={{-147,-152},{153,-112}}, 
            textString="f=%f", 
            textColor={0,0,0}), 
      Line(points={
        {-80, 80.0},{-76, 78.7},{-72, 74.8},{-68, 68.7},{-64, 60.5}, 
        {-60, 50.9},{-56, 40.4},{-52, 29.4},{-48, 18.7},{-44,  8.7}, 
        {-40,  0.0},{-36, -7.2},{-32,-12.5},{-28,-15.8},{-24,-17.3}, 
        {-20,-17.0},{-16,-15.1},{-12,-12.1},{ -8, -8.3},{ -4, -4.1}, 
        {  0,  0.0},{  4,  3.7},{  8,  6.8},{ 12,  9.0},{ 16, 10.1}, 
        { 20, 10.2},{ 24,  9.3},{ 28,  7.6},{ 32,  5.3},{ 36,  2.7}, 
        { 40,  0.0},{ 44, -2.5},{ 48, -4.7},{ 52, -6.2},{ 56, -7.1}, 
        { 60, -7.3},{ 64, -6.7},{ 68, -5.6},{ 72, -3.9},{ 76, -2.0}, 
        { 80,  0.0}}, smooth = Smooth.Bezier)}), 
      Documentation(info="<html>
<p>
The Real output y is a sinc signal: <code> amplitude*(sin(2*&pi;*f*t))/((2*&pi;*f*t))</code>
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Sinc.png\"
     alt=\"Sinc.png\">
</div>
</html>"));
  end Sinc;

  block ExpSine "Generate exponentially damped sine signal"
    import Modelica.Constants.pi;
    parameter Real amplitude=1 "Amplitude of sine wave" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/ExpSine.png"));
    parameter SI.Frequency f(start=2) "Frequency of sine wave";
    parameter SI.Angle phase=0 "Phase of sine wave";
    parameter SI.Damping damping(start=1) 
      "Damping coefficient of sine wave";
    extends Interfaces.SignalSource;
  equation
    y = offset + (if time < startTime then 0 else amplitude*Modelica.Math.exp(-
      (time - startTime)*damping)*Modelica.Math.sin(2*pi*f*(time - 
      startTime) + phase));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,0},{68,0}}, color={192,192,192}), 
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,0},{-75.2,32.3},{-72,50.3},{-68.7,64.5},{-65.5,74.2}, 
                {-62.3,79.3},{-59.1,79.6},{-55.9,75.3},{-52.7,67.1},{-48.6,52.2}, 
                {-43,25.8},{-35,-13.9},{-30.2,-33.7},{-26.1,-45.9},{-22.1,-53.2}, 
                {-18.1,-55.3},{-14.1,-52.5},{-10.1,-45.3},{-5.23,-32.1},{8.44, 
                13.7},{13.3,26.4},{18.1,34.8},{22.1,38},{26.9,37.2},{31.8,31.8}, 
                {38.2,19.4},{51.1,-10.5},{57.5,-21.2},{63.1,-25.9},{68.7,-25.9}, 
                {75.2,-20.5},{80,-13.8}}, smooth = Smooth.Bezier), 
          Text(
            extent={{-147,-152},{153,-112}}, 
            textString="f=%f")}), 
      Documentation(info="<html>
<p>
The Real output y is a sine signal with exponentially changing amplitude:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/ExpSine.png\"
     alt=\"ExpSine.png\">
</div>
</html>"));
  end ExpSine;

  block Exponentials "Generate a rising and falling exponential signal"

    parameter Real outMax=1 "Height of output for infinite riseTime" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Exponentials.png"));
    parameter SI.Time riseTime(min=0,start=0.5) "Rise time";
    parameter SI.Time riseTimeConst(min=Modelica.Constants.small) = 0.1 
      "Rise time constant; rising is defined as outMax*(1-exp(-riseTime/riseTimeConst))";
    parameter SI.Time fallTimeConst(min=Modelica.Constants.small)= 
      riseTimeConst "Fall time constant";
    extends Interfaces.SignalSource;
  protected
    Real y_riseTime;

  equation
    y_riseTime = outMax*(1 - Modelica.Math.exp(-riseTime/riseTimeConst));
    y = offset + (if (time < startTime) then 0 else if (time < (startTime + 
      riseTime)) then outMax*(1 - Modelica.Math.exp(-(time - startTime)/ 
      riseTimeConst)) else y_riseTime*Modelica.Math.exp(-(time - startTime - 
      riseTime)/fallTimeConst));

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,-70},{68,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,-70},{-77.2,-55.3},{-74.3,-42.1},{-70.8,-27.6},{-67.3, 
                -15},{-63.7,-4.08},{-59.5,7.18},{-55.3,16.7},{-50.3,26},{-44.6, 
                34.5},{-38.3,42.1},{-31.2,48.6},{-22.7,54.3},{-12.1,59.2},{-10, 
                60},{-7.88,47.5},{-5.05,32.7},{-2.22,19.8},{0.606,8.45},{4.14,-3.7}, 
                {7.68,-14},{11.9,-24.2},{16.2,-32.6},{21.1,-40.5},{26.8,-47.4}, 
                {33.1,-53.3},{40.9,-58.5},{50.8,-62.8},{60,-65.4}}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="riseTime=%riseTime")}), 
      Documentation(info="<html>
<p>
The Real output y is a rising exponential followed
by a falling exponential signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Exponentials.png\"
     alt=\"Exponentials.png\">
</div>
</html>"));
  end Exponentials;

  block Pulse "Generate pulse signal of type Real"
    parameter Real amplitude=1 "Amplitude of pulse" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png"));
    parameter Real width(
      final min=Modelica.Constants.small, 
      final max=100) = 50 "Width of pulse in % of period";
    parameter SI.Time period(final min=Modelica.Constants.small, 
        start=1) "Time for one period";
    parameter Integer nperiod=-1 
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.SignalSource;
  protected
    SI.Time T_width=period*width/100;
    SI.Time T_start "Start time of current period";
    Integer count "Period count";
  initial algorithm
    count := integer((time - startTime)/period);
    T_start := startTime + count*period;
  equation
    when integer((time - startTime)/period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and 
      count >= nperiod)) then 0 else if time < T_start + T_width then amplitude 
       else 0);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,-70},{-40,-70},{-40,44},{0,44},{0,-70},{40,-70},{40, 
                44},{79,44}}), 
          Text(
            extent={{-147,-152},{153,-112}}, 
            textString="period=%period")}), 
      Documentation(info="<html>
<p>
The Real output y is a pulse signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png\"
     alt=\"Pulse.png\">
</div>
</html>"));
  end Pulse;

  block SawTooth "Generate saw tooth signal"
    parameter Real amplitude=1 "Amplitude of saw tooth" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/SawTooth.png"));
    parameter SI.Time period(final min=Modelica.Constants.small,start=1) 
      "Time for one period";
    parameter Integer nperiod=-1 
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.SignalSource;
  protected
    SI.Time T_start(final start=startTime) "Start time of current period";
    Integer count "Period count";
  initial algorithm
    count := integer((time - startTime)/period);
    T_start := startTime + count*period;
  equation
    when integer((time - startTime)/period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and 
      count >= nperiod)) then 0 else amplitude*(time - T_start)/period);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,-70},{-60,-70},{0,40},{0,-70},{60,41},{60,-70}}), 
          Text(
            extent={{-147,-152},{153,-112}}, 
            textString="period=%period")}), 
      Documentation(info="<html>
<p>
The Real output y is a saw tooth signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/SawTooth.png\"
     alt=\"SawTooth.png\">
</div>
</html>"));
  end SawTooth;
  model TriangleWave "Generate a triangle wave signal"
    import SI=Modelica.Units.SI;
    parameter Real amplitude=1 "Amplitude of triangle wave" ;
    final parameter SI.Time rising(final min=0) = 0.5*period;
    final parameter SI.Time width(final min=0) = 0;
    final parameter SI.Time falling(final min=0) = 0.5*period;
    parameter SI.Time period(final min=Modelica.Constants.small, start=1) "Time for one period";
    final parameter Integer nperiod=-1 ;
    extends Modelica.Blocks.Interfaces.SignalSource;
  protected
    final parameter SI.Time T_rising=rising ;
    final parameter SI.Time T_width=T_rising + width;
    final parameter SI.Time T_falling=T_width + falling;
    SI.Time T_start "Start time of current period";
    Integer count "Period count";
  initial algorithm
    count := integer((time - startTime)/period);
    T_start := startTime + count*period;
  equation
    when integer((time - startTime)/period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and 
      count >= nperiod)) then 0 else if (time < T_start + T_rising) then 
      amplitude*(time - T_start)/rising else if (time < T_start + T_width) 
       then amplitude else if (time < T_start + T_falling) then amplitude*(
      T_start + T_falling - time)/falling else 0);
    annotation (
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  preserveAspectRatio=true, 
  grid={2,2}),graphics = {Line(origin={-80,-6}, 
  points={{0,74},{0,-74}}, 
  color={192,192,192}), Polygon(origin={-80,79}, 
  lineColor={192,192,192}, 
  fillColor={192,192,192}, 
  fillPattern=FillPattern.Solid, 
  points={{0,11},{-8,-11},{8,-11},{0,11}}), Line(origin={-4,-70}, 
  points={{-86,0},{86,0}}, 
  color={192,192,192}), Polygon(origin={79,-70}, 
  lineColor={192,192,192}, 
  fillColor={192,192,192}, 
  fillPattern=FillPattern.Solid, 
  points={{11,0},{-11,8},{-11,-8},{11,0}}), Text(origin={3,-132}, 
  extent={{-150,-20},{150,20}}, 
  textString="period=%period"), Line(origin={-8,-15}, 
  points={{-72,-55},{-32,-55},{-6,55},{-6,55},{22,-55},{48,55},{72,-55}})}),__MWORKS(VisibleVariable={"y"
  }),Documentation(info="<html><p>
The Real output y is a triangular wave signal:
</p>
<p>
<img src=\"data:image/png;base64,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\" alt=\"image.png\" data-href=\"\" style=\"width: 303.19px;height: 285.11px;\"/>
</p>
</html>"  ));

  end TriangleWave;

  block Trapezoid "Generate trapezoidal signal of type Real"
    parameter Real amplitude=1 "Amplitude of trapezoid" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Trapezoid.png"));
    parameter SI.Time rising(final min=0) = 0 
      "Rising duration of trapezoid";
    parameter SI.Time width(final min=0) = 0.5 
      "Width duration of trapezoid";
    parameter SI.Time falling(final min=0) = 0 
      "Falling duration of trapezoid";
    parameter SI.Time period(final min=Modelica.Constants.small, start=1) 
      "Time for one period";
    parameter Integer nperiod=-1 
      "Number of periods (< 0 means infinite number of periods)";
    extends Interfaces.SignalSource;
  protected
    parameter SI.Time T_rising=rising 
      "End time of rising phase within one period";
    parameter SI.Time T_width=T_rising + width 
      "End time of width phase within one period";
    parameter SI.Time T_falling=T_width + falling 
      "End time of falling phase within one period";
    SI.Time T_start "Start time of current period";
    Integer count "Period count";
  initial algorithm
    count := integer((time - startTime)/period);
    T_start := startTime + count*period;
  equation
    when integer((time - startTime)/period) > pre(count) then
      count = pre(count) + 1;
      T_start = time;
    end when;
    y = offset + (if (time < startTime or nperiod == 0 or (nperiod > 0 and 
      count >= nperiod)) then 0 else if (time < T_start + T_rising) then 
      amplitude*(time - T_start)/rising else if (time < T_start + T_width) 
       then amplitude else if (time < T_start + T_falling) then amplitude*(
      T_start + T_falling - time)/falling else 0);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Text(
            extent={{-147,-152},{153,-112}}, 
            textString="period=%period"), 
          Line(points={{-81,-70},{-60,-70},{-30,40},{9,40},{39,-70},{61,-70},{
                90,40}})}), 
      Documentation(info="<html>
<p>
The Real output y is a trapezoid signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Trapezoid.png\"
     alt=\"Trapezoid\">
</div>
</html>"));
  end Trapezoid;

  block LogFrequencySweep "Logarithmic frequency sweep"
    extends Modelica.Blocks.Interfaces.SO;
    import Modelica.Constants.eps;
    parameter Real wMin(final min=eps) "Start frequency" 
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png"));
    parameter Real wMax(final min=eps) "End frequency";
    parameter SI.Time startTime=0 "Start time of frequency sweep";
    parameter SI.Time duration(min=0.0, start=1) "Duration of ramp (= 0.0 gives a Step)";
  equation
    y = if time < startTime then wMin else 
      if time < (startTime + max(duration,eps)) then 
        10^(log10(wMin) + (log10(wMax) - log10(wMin))*min(1, (time-startTime)/max(duration,eps))) 
      else 
        wMax;
     annotation (defaultComponentName="logSweep", 
       Documentation(info="<html>
<p>The output <code>y</code> performs a logarithmic frequency sweep.
The logarithm of frequency <code>w</code> performs a linear ramp from <code>log10(wMin)</code> to <code>log10(wMax)</code>.
The output is the decimal power of this logarithmic ramp.
</p>
<p>For <code>time &lt; startTime</code> the output is equal to <code>wMin</code>.</p>
<p>For <code>time &gt; startTime+duration</code> the output is equal to <code>wMax</code>.</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/LogFrequencySweep.png\"
     alt=\"LogFrequencySweep.png\">
</div>

</html>"), 
      Icon(graphics={
          Line(points={{-78,44},{80,44}}, color={192,192,192}), 
          Line(points={{-78,34},{80,34}}, color={192,192,192}), 
          Line(points={{-78,20},{80,20}}, color={192,192,192}), 
          Line(points={{-78,-2},{80,-2}}, color={192,192,192}), 
          Line(points={{-78,-48},{80,-48}}, color={192,192,192}), 
          Line(
            points={{-70,-48},{-50,-48},{50,44},{70,44}}, 
            color={0,0,127}, 
            thickness=0.5), 
          Line(points={{-50,-48},{-50,44}}, color={192,192,192}), 
          Line(points={{50,-48},{50,44}}, color={192,192,192}), 
          Line(points={{-78,40},{80,40}}, color={192,192,192}), 
                                 Polygon(
                points={{90,-48},{68,-40},{68,-56},{90,-48}}, 
                lineColor={192,192,192}, 
                fillColor={192,192,192}, 
                fillPattern=FillPattern.Solid), 
                          Polygon(
                points={{-70,90},{-78,68},{-62,68},{-70,90}}, 
                lineColor={192,192,192}, 
                fillColor={192,192,192}, 
                fillPattern=FillPattern.Solid), 
          Line(points={{-70,-56},{-70,68}}, color={192,192,192})}));
  end LogFrequencySweep;

  block KinematicPTP 
    "Move as fast as possible along a distance within given kinematic constraints"

    parameter Real deltaq[:]={1} "Distance to move" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP.png"));
    parameter Real qd_max[:](each final min=Modelica.Constants.small) = {1} 
      "Maximum velocities der(q)";
    parameter Real qdd_max[:](each final min=Modelica.Constants.small) = {1} 
      "Maximum accelerations der(qd)";
    parameter SI.Time startTime=0 "Time instant at which movement starts";

    extends Interfaces.MO(final nout=max([size(deltaq, 1); size(qd_max, 1); size(qdd_max, 1)]));

  protected
    parameter Real p_deltaq[nout]=(if size(deltaq, 1) == 1 then ones(nout)* 
        deltaq[1] else deltaq);
    parameter Real p_qd_max[nout]=(if size(qd_max, 1) == 1 then ones(nout)* 
        qd_max[1] else qd_max);
    parameter Real p_qdd_max[nout]=(if size(qdd_max, 1) == 1 then ones(nout)* 
        qdd_max[1] else qdd_max);
    Real sd_max;
    Real sdd_max;
    Real sdd;
    Real aux1[nout];
    Real aux2[nout];
    SI.Time Ta1;
    SI.Time Ta2;
    SI.Time Tv;
    SI.Time Te;
    Boolean noWphase;

  equation
    for i in 1:nout loop
      aux1[i] = p_deltaq[i]/p_qd_max[i];
      aux2[i] = p_deltaq[i]/p_qdd_max[i];
    end for;
    sd_max = 1/max(abs(aux1));
    sdd_max = 1/max(abs(aux2));

    Ta1 = sqrt(1/sdd_max);
    Ta2 = sd_max/sdd_max;
    noWphase = Ta2 >= Ta1;
    Tv = if noWphase then Ta1 else 1/sd_max;
    Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;

    // path-acceleration
    sdd = if time < startTime then 0 else ((if noWphase then (if time < Ta1 + 
      startTime then sdd_max else (if time < Te + startTime then -sdd_max else 
      0)) else (if time < Ta2 + startTime then sdd_max else (if time < Tv + 
      startTime then 0 else (if time < Te + startTime then -sdd_max else 0)))));

    // acceleration
    y = p_deltaq*sdd;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,78},{-80,-82}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,0},{82,0}}, color={192,192,192}), 
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(
            points={{-80,0},{-70,0},{-70,70},{-30,70},{-30,0},{20,0},{20,-70},{
                60,-70},{60,0},{68,0}}), 
          Text(
            extent={{2,80},{80,20}}, 
            textColor={192,192,192}, 
            textString="acc"), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="deltaq=%deltaq")}), 
          Documentation(info="<html>
<p>
The goal is to move as <strong>fast</strong> as possible along a distance
<strong>deltaq</strong>
under given <strong>kinematical constraints</strong>. The distance can be a positional or
angular range. In robotics such a movement is called <strong>PTP</strong> (Point-To-Point).
This source block generates the <strong>acceleration</strong> qdd of this signal
as output:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP.png\"
     alt=\"KinematicPTP.png\">
</div>

<p>
After integrating the output two times, the position q is
obtained. The signal is constructed in such a way that it is not possible
to move faster, given the <strong>maximally</strong> allowed <strong>velocity</strong> qd_max and
the <strong>maximally</strong> allowed <strong>acceleration</strong> qdd_max.
</p>
<p>
If several distances are given (vector deltaq has more than 1 element),
an acceleration output vector is constructed such that all signals
are in the same periods in the acceleration, constant velocity
and deceleration phase. This means that only one of the signals
is at its limits whereas the others are synchronized in such a way
that the end point is reached at the same time instant.
</p>

<p>
This element is useful to generate a reference signal for a controller
which controls a drive train or in combination with model
Modelica.Mechanics.Rotational.<strong>Accelerate</strong> to drive
a flange according to a given acceleration.
</p>

</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>June 27, 2001</em>
       by Bernhard Bachmann.<br>
       Bug fixed that element is also correct if startTime is not zero.</li>
<li><em>Nov. 3, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><em>June 29, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>
</html>"));
  end KinematicPTP;

  block KinematicPTP2 
    "Move as fast as possible from start to end position within given kinematic constraints with output signals q, qd=der(q), qdd=der(qd)"

    parameter Real q_begin[:]={0} "Start position" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP2.png"));
    parameter Real q_end[:]={1} "End position";
    parameter Real qd_max[:](each final min=Modelica.Constants.small) = {1} 
      "Maximum velocities der(q)";
    parameter Real qdd_max[:](each final min=Modelica.Constants.small) = {1} 
      "Maximum accelerations der(qd)";
    parameter SI.Time startTime=0 
      "Time instant at which movement starts";

    extends Modelica.Blocks.Icons.Block;
    final parameter Integer nout=max([size(q_begin, 1); size(q_end, 1); size(qd_max, 1); size(qdd_max, 1)]) 
      "Number of output signals (= dimension of q, qd, qdd, moving)";
    output SI.Time endTime "Time instant at which movement stops";

    Modelica.Blocks.Interfaces.RealOutput q[nout] 
      "Reference position of path planning" annotation (Placement(
          transformation(extent={{100,70},{120,90}})));
    Modelica.Blocks.Interfaces.RealOutput qd[nout] 
      "Reference speed of path planning" annotation (Placement(transformation(
            extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealOutput qdd[nout] 
      "Reference acceleration of path planning" annotation (Placement(
          transformation(extent={{100,-40},{120,-20}})));
    Modelica.Blocks.Interfaces.BooleanOutput moving[nout] 
      "= true, if end position not yet reached; = false, if end position reached or axis is completely at rest" 
      annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

  protected
    parameter Real p_q_begin[nout]=(if size(q_begin, 1) == 1 then ones(nout)* 
        q_begin[1] else q_begin);
    parameter Real p_q_end[nout]=(if size(q_end, 1) == 1 then ones(nout)*q_end[
        1] else q_end);
    parameter Real p_qd_max[nout]=(if size(qd_max, 1) == 1 then ones(nout)* 
        qd_max[1] else qd_max);
    parameter Real p_qdd_max[nout]=(if size(qdd_max, 1) == 1 then ones(nout)* 
        qdd_max[1] else qdd_max);
    parameter Real p_deltaq[nout]=p_q_end - p_q_begin;
    constant Real eps=10*Modelica.Constants.eps;
    Boolean motion_ref;
    Real sd_max_inv;
    Real sdd_max_inv;
    Real sd_max;
    Real sdd_max;
    Real sdd;
    Real aux1[nout];
    Real aux2[nout];
    SI.Time Ta1;
    SI.Time Ta2;
    SI.Time Tv;
    SI.Time Te;
    Boolean noWphase;
    SI.Time Ta1s;
    SI.Time Ta2s;
    SI.Time Tvs;
    SI.Time Tes;
    Real sd_max2;
    Real s1;
    Real s2;
    Real s3;
    Real s;
    Real sd;

  equation
    for i in 1:nout loop
      aux1[i] = p_deltaq[i]/p_qd_max[i];
      aux2[i] = p_deltaq[i]/p_qdd_max[i];
    end for;

    sd_max_inv = max(abs(aux1));
    sdd_max_inv = max(abs(aux2));

    if sd_max_inv <= eps or sdd_max_inv <= eps then
      sd_max = 0;
      sdd_max = 0;
      Ta1 = 0;
      Ta2 = 0;
      noWphase = false;
      Tv = 0;
      Te = 0;
      Ta1s = 0;
      Ta2s = 0;
      Tvs = 0;
      Tes = 0;
      sd_max2 = 0;
      s1 = 0;
      s2 = 0;
      s3 = 0;
      s = 0;
    else
      sd_max = 1/max(abs(aux1));
      sdd_max = 1/max(abs(aux2));
      Ta1 = sqrt(1/sdd_max);
      Ta2 = sd_max/sdd_max;
      noWphase = Ta2 >= Ta1;
      Tv = if noWphase then Ta1 else 1/sd_max;
      Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;
      Ta1s = Ta1 + startTime;
      Ta2s = Ta2 + startTime;
      Tvs = Tv + startTime;
      Tes = Te + startTime;
      sd_max2 = sdd_max*Ta1;
      s1 = sdd_max*(if noWphase then Ta1*Ta1 else Ta2*Ta2)/2;
      s2 = s1 + (if noWphase then sd_max2*(Te - Ta1) - (sdd_max/2)*(Te - Ta1)^2 
         else sd_max*(Tv - Ta2));
      s3 = s2 + sd_max*(Te - Tv) - (sdd_max/2)*(Te - Tv)*(Te - Tv);

      if time < startTime then
        s = 0;
      elseif noWphase then
        if time < Ta1s then
          s = (sdd_max/2)*(time - startTime)*(time - startTime);
        elseif time < Tes then
          s = s1 + sd_max2*(time - Ta1s) - (sdd_max/2)*(time - Ta1s)*(time - 
            Ta1s);
        else
          s = s2;
        end if;
      elseif time < Ta2s then
        s = (sdd_max/2)*(time - startTime)*(time - startTime);
      elseif time < Tvs then
        s = s1 + sd_max*(time - Ta2s);
      elseif time < Tes then
        s = s2 + sd_max*(time - Tvs) - (sdd_max/2)*(time - Tvs)*(time - Tvs);
      else
        s = s3;
      end if;

    end if;

    sd = der(s);
    sdd = der(sd);

    qdd = p_deltaq*sdd;
    qd = p_deltaq*sd;
    q = p_q_begin + p_deltaq*s;
    endTime = Tes;

    // report when axis is moving
    motion_ref = time < endTime;
    for i in 1:nout loop
      moving[i] = if abs(q_begin[i] - q_end[i]) > eps then motion_ref else 
        false;
    end for;

    annotation (
      defaultComponentName="kinematicPTP", 
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,78},{-80,-82}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,88},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,0},{17,0}}, color={192,192,192}), 
          Line(
            points={{-80,0},{-70,0},{-70,70},{-50,70},{-50,0},{-15,0},{-15,-70}, 
                {5,-70},{5,0},{18,0}}), 
          Text(
            extent={{34,96},{94,66}}, 
            textString="q"), 
          Text(
            extent={{40,44},{96,14}}, 
            textString="qd"), 
          Text(
            extent={{32,-18},{99,-44}}, 
            textString="qdd"), 
          Text(
            extent={{-32,-74},{97,-96}}, 
            textString="moving")}), 
      Documentation(info="<html>
<p>
The goal is to move as <strong>fast</strong> as possible from start position <strong>q_begin</strong>
to end position <strong>q_end</strong>
under given <strong>kinematical constraints</strong>. The positions can be translational or
rotational definitions (i.e., q_begin/q_end is given). In robotics such a movement is called <strong>PTP</strong> (Point-To-Point).
This source block generates the <strong>position</strong> q(t), the
<strong>speed</strong> qd(t) = der(q), and the <strong>acceleration</strong> qdd = der(qd)
as output. The signals are constructed in such a way that it is not possible
to move faster, given the <strong>maximally</strong> allowed <strong>velocity</strong> qd_max and
the <strong>maximally</strong> allowed <strong>acceleration</strong> qdd_max:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/KinematicPTP2.png\"
     alt=\"KinematicPTP2.png\">
</div>

<p>
If vectors q_begin/q_end have more than 1 element,
the output vectors are constructed such that all signals
are in the same periods in the acceleration, constant velocity
and deceleration phase. This means that only one of the signals
is at its limits whereas the others are synchronized in such a way
that the end point is reached at the same time instant.
</p>

<p>
This element is useful to generate a reference signal for a controller
which controls, e.g., a drive train, or to drive
a flange according to a given acceleration.
</p>

</html>", revisions="<html>
<ul>
<li><em>March 24, 2007</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Non-standard Modelica function \"constrain(..)\" replaced by standard
       Modelica implementation (via internal function position()).<br>
       New output signal \"moving\" added.</li>
<li><em>June 27, 2001</em>
       by Bernhard Bachmann.<br>
       Bug fixed that element is also correct if startTime is not zero.</li>
<li><em>Nov. 3, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Vectorized and moved from Rotational to Blocks.Sources.</li>
<li><em>June 29, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       realized.</li>
</ul>
</html>"));
  end KinematicPTP2;

  block TimeTable 
    "Generate a (possibly discontinuous) signal by linear interpolation in a table"

    parameter Real table[:, 2] = fill(0.0, 0, 2) 
      "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])" 
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png"));
    parameter SI.Time timeScale(
      min=Modelica.Constants.eps)=1 "Time scale of first table column" 
      annotation (Evaluate=true);
    extends Interfaces.SignalSource;
    parameter SI.Time shiftTime=startTime 
      "Shift time of first table column";
  protected
    discrete Real a "Interpolation coefficient a of actual interval (y=a*x+b)";
    discrete Real b "Interpolation coefficient b of actual interval (y=a*x+b)";
    Integer last(start=1) "Last used lower grid index";
    discrete SI.Time nextEvent(start=0, fixed=true) "Next event instant";
    discrete Real nextEventScaled(start=0, fixed=true) 
      "Next scaled event instant";
    Real timeScaled "Scaled time";

    function getInterpolationCoefficients 
      "Determine interpolation coefficients and next time event"
      extends Modelica.Icons.Function;
      input Real table[:, 2] "Table for interpolation";
      input Real offset "y-offset";
      input Real startTimeScaled "Scaled time-offset";
      input Real timeScaled "Actual scaled time instant";
      input Integer last "Last used lower grid index";
      input Real TimeEps "Relative epsilon to check for identical time instants";
      input Real shiftTimeScaled "Time shift";
      output Real a "Interpolation coefficient a (y=a*x + b)";
      output Real b "Interpolation coefficient b (y=a*x + b)";
      output Real nextEventScaled "Next scaled event instant";
      output Integer next "New lower grid index";
    protected
      Integer columns=2 "Column to be interpolated";
      Integer ncol=2 "Number of columns to be interpolated";
      Integer nrow=size(table, 1) "Number of table rows";
      Integer next0;
      Real tp;
      Real dt;
    algorithm
      next := last;
      nextEventScaled := timeScaled - TimeEps*abs(timeScaled);
      // in case there are no more time events
      tp := timeScaled + TimeEps*abs(timeScaled);

      if tp < startTimeScaled then
        // First event not yet reached
        nextEventScaled := startTimeScaled;
        a := 0;
        b := offset;
      elseif nrow < 2 then
        // Special action if table has only one row
        a := 0;
        b := offset + table[1, columns];
      else
        tp := tp - shiftTimeScaled;
        // Find next time event instant. Note, that two consecutive time instants
        // in the table may be identical due to a discontinuous point.
        while next < nrow and tp >= table[next, 1] loop
          next := next + 1;
        end while;

        // Define next time event, if last table entry not reached
        if next < nrow then
          nextEventScaled := shiftTimeScaled + table[next, 1];
        end if;

        // Determine interpolation coefficients
        if next == 1 then
          next := 2;
        end if;
        next0 := next - 1;
        dt := table[next, 1] - table[next0, 1];
        if dt <= TimeEps*abs(table[next, 1]) then
          // Interpolation interval is not big enough, use "next" value
          a := 0;
          b := offset + table[next, columns];
        else
          a := (table[next, columns] - table[next0, columns])/dt;
          b := offset + table[next0, columns] - a*table[next0, 1];
        end if;
      end if;
      // Take into account shiftTimeScaled "a*(time - shiftTime) + b"
      b := b - a*shiftTimeScaled;
    end getInterpolationCoefficients;
  algorithm
    if noEvent(size(table, 1) > 1) then
      assert(not (table[1, 1] > 0.0 or table[1, 1] < 0.0), "The first point in time has to be set to 0, but is table[1,1] = " + String(table[1, 1]));
    end if;
    when {time >= pre(nextEvent),initial()} then
      (a,b,nextEventScaled,last) := getInterpolationCoefficients(
          table, 
          offset, 
          startTime/timeScale, 
          timeScaled, 
          last, 
          100*Modelica.Constants.eps, 
          shiftTime/timeScale);
      nextEvent := nextEventScaled*timeScale;
    end when;
  equation
    assert(size(table, 1) > 0, "No table values defined.");
    timeScaled = time/timeScale;
    y = a*timeScaled + b;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Rectangle(
            extent={{-48,70},{2,-50}}, 
            lineColor={255,255,255}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-48,-50},{-48,70},{52,70},{52,-50},{-48,-50},{-48,-20}, 
                {52,-20},{52,10},{-48,10},{-48,40},{52,40},{52,70},{2,70},{2,-51}}), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="offset=%offset")}), 
          Documentation(info="<html>
<p>
This block generates an output signal by <strong>linear interpolation</strong> in
a table. The time points and function values are stored in a matrix
<strong>table[i,j]</strong>, where the first column table[:,1] contains the
time points and the second column contains the data to be interpolated.
The table interpolation has the following properties:
</p>
<ul>
<li>The interpolation interval is found by a linear search where the interval used in the
    last call is used as start interval.</li>
<li>The time points need to be <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed, by providing the same
    time point twice in the table.</li>
<li>Values <strong>outside</strong> of the table range, are computed by
    <strong>extrapolation</strong> through the last or first two points of the
    table.</li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and
    the function value is just returned independently of the actual time instant.</li>
<li>Via parameters <strong>shiftTime</strong> and <strong>offset</strong> the curve defined
    by the table can be shifted both in time and in the ordinate value.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and the offset
    is used as ordinate value for the output.</li>
<li>If the table has more than one row, the first point in time <strong>always</strong> has to be set to <strong>0</strong>, e.g.,
    <strong>table=[1,1;2,2]</strong> is <strong>illegal</strong>. If you want to
    shift the time table in time use the <strong>shiftTime</strong> parameter instead.</li>
<li>The table is implemented in a numerically sound way by
    generating <strong>time events</strong> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
<li>Via parameter <strong>timeScale</strong> the first column of the table array can
    be scaled, e.g., if the table array is given in hours (instead of seconds)
    <strong>timeScale</strong> shall be set to 3600.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
   table = [0, 0;
            1, 0;
            1, 1;
            2, 4;
            3, 9;
            4, 16];
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation).
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png\"
     alt=\"TimeTable.png\">
</div>

</html>", revisions="<html>
<h4>Release Notes</h4>
<ul>
<li><em>Oct. 21, 2002</em>
       by Christian Schweiger:<br>
       Corrected interface from
<blockquote><pre>
parameter Real table[:, :]=[0, 0; 1, 1; 2, 4];
</pre></blockquote>
       to
<blockquote><pre>
parameter Real table[:, <strong>2</strong>]=[0, 0; 1, 1; 2, 4];
</pre></blockquote>
       </li>
<li><em>Nov. 7, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"));
  end TimeTable;

  block CombiTimeTable 
    "Table look-up with respect to time and linear/periodic extrapolation methods (data from matrix/file)"
    import Modelica.Blocks.Tables.Internal;
    extends Modelica.Blocks.Interfaces.MO(final nout=max([size(columns, 1); size(offset, 1)]));
    parameter Boolean tableOnFile=false 
      "= true, if table is defined on file or in function usertab" 
      annotation (Dialog(group="Table data definition"));
    parameter Real table[:, :] = fill(0.0, 0, 2) 
      "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])" 
      annotation (Dialog(group="Table data definition",enable=not tableOnFile));
    parameter String tableName="NoName" 
      "Table name on file or in function usertab (see docu)" 
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter String fileName="NoName" "File where matrix is stored" 
      annotation (Dialog(
        group="Table data definition", 
        enable=tableOnFile, 
        loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat);;csv files (*.csv)", 
            caption="Open file in which table is present")));
    parameter Boolean verboseRead=true 
      "= true, if info message that file is loading is to be printed" 
      annotation (Dialog(group="Table data definition",enable=tableOnFile));
    parameter Integer columns[:]=2:size(table, 2) 
      "Columns of table to be interpolated" 
      annotation (Dialog(group="Table data interpretation", 
      groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/CombiTimeTable.png"));
    parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments 
      "Smoothness of table interpolation" 
      annotation (Dialog(group="Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints 
      "Extrapolation of data outside the definition range" 
      annotation (Dialog(group="Table data interpretation"));
    parameter SI.Time timeScale(
      min=Modelica.Constants.eps)=1 "Time scale of first table column" 
      annotation (Dialog(group="Table data interpretation"), Evaluate=true);
    parameter Real offset[:]={0} "Offsets of output signals" 
      annotation (Dialog(group="Table data interpretation"));
    parameter SI.Time startTime=0 
      "Output = offset for time < startTime" 
      annotation (Dialog(group="Table data interpretation"));
    parameter SI.Time shiftTime=startTime 
      "Shift time of first table column" 
      annotation (Dialog(group="Table data interpretation"));
    parameter Modelica.Blocks.Types.TimeEvents timeEvents=Modelica.Blocks.Types.TimeEvents.Always 
      "Time event handling of table interpolation" 
      annotation (Dialog(group="Table data interpretation", enable=smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments));
    parameter Boolean verboseExtrapolation=false 
      "= true, if warning messages are to be printed if time is outside the table definition range" 
      annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter SI.Time t_min=t_minScaled*timeScale 
      "Minimum abscissa value defined in table";
    final parameter SI.Time t_max=t_maxScaled*timeScale 
      "Maximum abscissa value defined in table";
    final parameter Real t_minScaled=Internal.getTimeTableTmin(tableID) 
      "Minimum (scaled) abscissa value defined in table";
    final parameter Real t_maxScaled=Internal.getTimeTableTmax(tableID) 
      "Maximum (scaled) abscissa value defined in table";
  protected
    final parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*offset[1] else offset) 
      "Offsets of output signals";
    parameter Modelica.Blocks.Types.ExternalCombiTimeTable tableID= 
        Modelica.Blocks.Types.ExternalCombiTimeTable(
          if tableOnFile then tableName else "NoName", 
          if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName", 
          table, 
          startTime/timeScale, 
          columns, 
          smoothness, 
          extrapolation, 
          shiftTime/timeScale, 
          if smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then timeEvents elseif smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then Modelica.Blocks.Types.TimeEvents.Always else Modelica.Blocks.Types.TimeEvents.NoTimeEvents, 
          if tableOnFile then verboseRead else false) "External table object";
    discrete SI.Time nextTimeEvent(start=0, fixed=true) 
      "Next time event instant";
    discrete Real nextTimeEventScaled(start=0, fixed=true) 
      "Next scaled time event instant";
    Real timeScaled "Scaled time";
  equation
    if tableOnFile then
      assert(tableName <> "NoName", 
        "tableOnFile = true and no table name given");
    else
      assert(size(table, 1) > 0 and size(table, 2) > 0, 
        "tableOnFile = false and parameter table is an empty matrix");
    end if;

    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(time >= t_min), "
Extrapolation warning: Time (="     + String(time) + ") must be greater or equal
than the minimum abscissa value t_min (="     + String(t_min) + ") defined in the table.
"    , level=AssertionLevel.warning);
      assert(noEvent(time <= t_max), "
Extrapolation warning: Time (="     + String(time) + ") must be less or equal
than the maximum abscissa value t_max (="     + String(t_max) + ") defined in the table.
"    , level=AssertionLevel.warning);
    end if;

    timeScaled = time/timeScale;
    when {time >= pre(nextTimeEvent), initial()} then
      nextTimeEventScaled = Internal.getNextTimeEvent(tableID, timeScaled);
      nextTimeEvent = if nextTimeEventScaled < Modelica.Constants.inf then nextTimeEventScaled*timeScale else Modelica.Constants.inf;
    end when;
    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:nout loop
        y[i] = p_offset[i] + Internal.getTimeTableValueNoDer(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled));
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:nout loop
        y[i] = p_offset[i] + Internal.getTimeTableValueNoDer2(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled));
      end for;
    else
      for i in 1:nout loop
        y[i] = p_offset[i] + Internal.getTimeTableValue(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled));
      end for;
    end if;
    annotation (
      Documentation(info="<html>
<p>
This block generates an output signal y[:] by <strong>constant</strong>,
<strong>linear</strong> or <strong>cubic Hermite spline interpolation</strong>
in a table. The time points and function values are stored in a matrix
<strong>table[i,j]</strong>, where the first column table[:,1] contains the
time points and the other columns contain the data to be interpolated.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTimeTable.png\"
     alt=\"CombiTimeTable.png\">
</div>

<p>
Via parameter <strong>columns</strong> it can be defined which columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output is computed
by interpolation of column 2 and the second output is computed
by interpolation of column 4 of the table matrix.
The table interpolation has the following properties:
</p>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>The time points need to be <strong>strictly increasing</strong> for cubic Hermite
    spline interpolation, otherwise <strong>monotonically increasing</strong>.</li>
<li><strong>Discontinuities</strong> are allowed for (constant or) linear interpolation,
    by providing the same time point twice in the table.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Linear interpolation
           = 2: Akima interpolation: Smooth interpolation by cubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Smooth interpolation by cubic
                Hermite splines such that y preserves the monotonicity and
                der(y) is continuous, also if extrapolated.
           = 5: Steffen interpolation: Smooth interpolation by cubic Hermite
                splines such that y preserves the monotonicity and der(y)
                is continuous, also if extrapolated.
           = 6: Modified Akima interpolation: Smooth interpolation by cubic
                Hermite splines such that der(y) is continuous, also if
                extrapolated. Additionally, overshoots and edge cases of the
                original Akima interpolation method are avoided.
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.<br>There is a design inconsistency, that it is possible
to model a signal consisting of constant segments using linear interpolation and duplicated sample points.
In contrast to interpolation by constant segments, the first derivative is provided as zero.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and
    the table values of this row are just returned.</li>
<li>Via parameters <strong>shiftTime</strong> and <strong>offset</strong> the curve defined
    by the table can be shifted both in time and in the ordinate value.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and the offset
    is used as ordinate value for all outputs.</li>
<li>The table is implemented in a numerically sound way by
    generating <strong>time events</strong> at interval boundaries, in case of
    interpolation by linear segments.
    This generates continuously differentiable values for the integrator.
    Via parameter <strong>timeEvents</strong> it is defined how the time events are generated:
<blockquote><pre>
timeEvents = 1: Always generate time events at interval boundaries
           = 2: Generate time events at discontinuities (defined by duplicated sample points)
           = 3: No time events at interval boundaries
</pre></blockquote>
    For interpolation by constant segments time events are always generated at interval boundaries.
    For smooth interpolation by cubic Hermite splines no time events are generated at interval boundaries.</li>
<li>Via parameter <strong>timeScale</strong> the first column of the table array can
    be scaled, e.g., if the table array is given in hours (instead of seconds)
    <strong>timeScale</strong> shall be set to 3600.</li>
<li>For special applications it is sometimes needed to know the minimum
    and maximum time instant defined in the table as a parameter. For this
    reason parameters <strong>t_min</strong>/<strong>t_minScaled</strong> and
    <strong>t_max</strong>/<strong>t_maxScaled</strong> are provided and can be
    accessed from the outside of the table object. Whereas <strong>t_min</strong> and
    <strong>t_max</strong> define the scaled abscissa values (using parameter
    <strong>timeScale</strong>) in SI.Time, <strong>t_minScaled</strong> and
    <strong>t_maxScaled</strong> define the unitless original abscissa values of
    the table.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
table = [0, 0;
         1, 0;
         1, 1;
         2, 4;
         3, 9;
         4, 16];
extrapolation = 2 (default), timeEvents = 2
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation via last 2 points).
</pre></blockquote>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li>Explicitly supplied as <strong>parameter matrix</strong> \"table\",
    and the other parameters have the following values:
<blockquote><pre>
tableName is \"NoName\" or has only blanks,
fileName  is \"NoName\" or has only blanks.
</pre></blockquote></li>
<li><strong>Read</strong> from a <strong>file</strong> \"fileName\" where the matrix is stored as
    \"tableName\". Both text and MATLAB MAT-file format is possible.
    (The text format is described below).
    The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
    The library supports at least v4, v6 and v7 whereas v7.3 is optional.
    It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
    by command
<blockquote><pre>
save tables.mat tab1 tab2 tab3
</pre></blockquote>
    or Scilab by command
<blockquote><pre>
savematfile tables.mat tab1 tab2 tab3
</pre></blockquote>
    when the three tables tab1, tab2, tab3 should be used from the model.<br>
    Note, a fileName can be defined as URI by using the helper function
    <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>Statically stored in function \"usertab\" in file \"usertab.c\".
    The matrix is identified by \"tableName\". Parameter
    fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
    preferred as otherwise the table is reallocated and transposed.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from a text file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(6,2)   # comment line
  0   0
  1   0
  1   1
  2   4
  3   9
  4  16
double tab2(6,2)   # another comment line
  0   0
  2   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double tab1(5,2)
0,0
1,1
2,4
3,9
4,16
double tab2(5,2)
0,0
2,2
4,8
6,18
8,32
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTimeTable2.png\"
     alt=\"CombiTimeTable2.png\">
</div>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Text files should either be ASCII or UTF-8 encoded, where UTF-8 encoded strings are only allowed in line comments and an optional UTF-8 BOM at the start of the text file is ignored.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"    , revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>April 09, 2013</em>
       by Thomas Beutlich:<br>
       Implemented as external object.</li>
<li><em>March 31, 2001</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Used CombiTableTime as a basis and added the
       arguments <strong>extrapolation, columns, startTime</strong>.
       This allows periodic function definitions.</li>
</ul>
</html>"    ), 
      Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100.0,-100.0},{100.0,100.0}}), 
        graphics={
      Polygon(lineColor={192,192,192}, 
        fillColor={192,192,192}, 
        fillPattern=FillPattern.Solid, 
        points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}), 
      Line(points={{-80.0,68.0},{-80.0,-80.0}}, 
        color={192,192,192}), 
      Line(points={{-90.0,-70.0},{82.0,-70.0}}, 
        color={192,192,192}), 
      Polygon(lineColor={192,192,192}, 
        fillColor={192,192,192}, 
        fillPattern=FillPattern.Solid, 
        points={{90.0,-70.0},{68.0,-62.0},{68.0,-78.0},{90.0,-70.0}}), 
      Rectangle(lineColor={255,255,255}, 
        fillColor={255,215,136}, 
        fillPattern=FillPattern.Solid, 
        extent={{-48.0,-50.0},{2.0,70.0}}), 
      Line(points={{-48.0,-50.0},{-48.0,70.0},{52.0,70.0},{52.0,-50.0},{-48.0,-50.0},{-48.0,-20.0},{52.0,-20.0},{52.0,10.0},{-48.0,10.0},{-48.0,40.0},{52.0,40.0},{52.0,70.0},{2.0,70.0},{2.0,-51.0}})}));
  end CombiTimeTable;

  block BooleanConstant "Generate constant signal of type Boolean"
    parameter Boolean k=true "Constant output value" 
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanConstant.png"));
    extends Interfaces.partialBooleanSource;

  equation
    y = k;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={Line(points={{-80,0},{80,0}}), 
            Text(
            extent={{-150,-140},{150,-110}}, 
            textString="%k")}), 
        Documentation(info="<html>
<p>
The Boolean output y is a constant signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanConstant.png\"
     alt=\"BooleanConstant.png\">
</div>
</html>"));
  end BooleanConstant;

  block BooleanStep "Generate step signal of type Boolean"
    parameter SI.Time startTime=0 "Time instant of step start" 
     annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png"));
    parameter Boolean startValue=false "Output before startTime";

    extends Interfaces.partialBooleanSource;
  equation
    y = if time >= startTime then not startValue else startValue;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
              100}}), graphics={
          Line(
            visible=not startValue, 
            points={{-80,-70},{0,-70},{0,50},{80,50}}), 
          Line(
            visible=startValue, 
            points={{-80,50},{0,50},{0,-70},{68,-70}}), 
          Text(
            extent={{-150,-140},{150,-110}}, 
            textString="%startTime")}), 
      Documentation(info="<html>
<p>
The Boolean output y is a step signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png\"
     alt=\"BooleanStep.png\">
</div>
</html>"));
  end BooleanStep;

  block BooleanPulse "Generate pulse signal of type Boolean"

    parameter Real width(
      final min=Modelica.Constants.small, 
      final max=100) = 50 "Width of pulse in % of period" 
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanPulse.png"));
    parameter SI.Time period(final min=Modelica.Constants.small, 
        start=1) "Time for one period";
    parameter SI.Time startTime=0 "Time instant of first pulse";
    extends Modelica.Blocks.Interfaces.partialBooleanSource;

  protected
    parameter SI.Time Twidth=period*width/100 
      "Width of one pulse" annotation (HideResult=true);
    discrete SI.Time pulseStart "Start time of pulse" 
      annotation (HideResult=true);
  initial equation
    pulseStart = startTime;
  equation
    when sample(startTime, period) then
      pulseStart = time;
    end when;
    y = time >= pulseStart and time < pulseStart + Twidth;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={Text(
            extent={{-150,-140},{150,-110}}, 
            textString="%period"), Line(points={{-80,-70},{-40,-70},{-40,44},{0, 
                44},{0,-70},{40,-70},{40,44},{79,44}})}), 
        Documentation(info="<html>
<p>
The Boolean output y is a pulse signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Pulse.png\"
     alt=\"Pulse.png\">
</div>
</html>"));
  end BooleanPulse;

  block SampleTrigger "Generate sample trigger signal"
    parameter SI.Time period(final min=Modelica.Constants.small, 
        start=0.01) "Sample period" 
      annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/SampleTrigger.png"));
    parameter SI.Time startTime=0 
      "Time instant of first sample trigger";
    extends Interfaces.partialBooleanSource;

  equation
    y = sample(startTime, period);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-60,-70},{-60,70}}), 
          Line(points={{-20,-70},{-20,70}}), 
          Line(points={{20,-70},{20,70}}), 
          Line(points={{60,-70},{60,70}}), 
          Text(
            extent={{-150,-140},{150,-110}}, 
            textString="%period")}), 
        Documentation(info="<html>
<p>
The Boolean output y is a trigger signal where the output y is only <strong>true</strong>
at sample times (defined by parameter <strong>period</strong>) and is otherwise
<strong>false</strong>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/SampleTrigger.png\"
     alt=\"SampleTrigger.png\">
</div>
</html>"));
  end SampleTrigger;

  block BooleanTable 
    "Generate a Boolean output signal based on a vector of time instants"

    parameter SI.Time table[:]={0,1} 
      "Vector of time points. At every time point, the output y gets its opposite value (e.g., table={0,1})" annotation(Dialog(group="Table data definition"));
    parameter Boolean startValue=false 
      "Start value of y. At time = table[1], y changes to 'not startValue'" annotation(Dialog(group="Table data interpretation", 
      groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanTable.png"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint 
      "Extrapolation of data outside the definition range" annotation(Dialog(group="Table data interpretation"));
    parameter SI.Time startTime=-Modelica.Constants.inf 
      "Output = false for time < startTime" annotation(Dialog(group="Table data interpretation"));
    parameter SI.Time shiftTime=0 
      "Shift time of table" annotation(Dialog(group="Table data interpretation"));

    extends Interfaces.partialBooleanSO;

    CombiTimeTable combiTimeTable(
      final table=if n > 0 then if startValue then [table[1], 1.0; table, {mod(i + 1, 2.0) for i in 1:n}] else [table[1], 0.0; table, {mod(i, 2.0) for i in 1:n}] else if startValue then [0.0, 1.0] else [0.0, 0.0], 
      final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, 
      final columns={2}, 
      final extrapolation=extrapolation, 
      final startTime=startTime, 
      final shiftTime=shiftTime) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
    Modelica.Blocks.Math.RealToBoolean realToBoolean annotation(Placement(transformation(extent={{10,-10},{30,10}})));

  protected
      function isValidTable "Check if table is valid"
        extends Modelica.Icons.Function;
        input Real table[:] "Vector of time instants";
    protected
        constant Integer n=size(table, 1) "Number of table points";
      algorithm
        if n > 0 then
          // Check whether time values are strict monotonically increasing
          for i in 2:n loop
            assert(table[i] > table[i-1], 
              "Time values of table not strict monotonically increasing: table[" 
               + String(i - 1) + "] = " + String(table[i - 1]) + ", table[" + 
              String(i) + "] = " + String(table[i]));
          end for;
        end if;
      end isValidTable;

      /*parameter*/constant Integer n=size(table, 1) "Number of table points";
  initial algorithm
      isValidTable(table);
  equation
      assert(extrapolation <> Modelica.Blocks.Types.Extrapolation.LastTwoPoints, "Unsuitable extrapolation setting.");
      connect(combiTimeTable.y[1], realToBoolean.u) annotation(Line(points={{-9,0},{8,0}}, color={0,0,127}));
      connect(realToBoolean.y, y) annotation(Line(points={{31,0},{110,0},{110,0}}, color={255,127,0}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
              100}}), graphics={Polygon(
            points={{-80,88},{-88,66},{-72,66},{-80,88}}, 
            lineColor={255,0,255}, 
            fillColor={255,0,255}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,66},{-80,-82}}, color={255,0,255}), 
          Line(points={{-90,-70},{72,-70}}, color={255,0,255}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={255,0,255}, 
            fillColor={255,0,255}, 
            fillPattern=FillPattern.Solid), 
          Rectangle(
            extent={{-18,70},{32,-50}}, 
            lineColor={255,255,255}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), Line(points={{-18,-50},{-18,70},{32, 
                70},{32,-50},{-18,-50},{-18,-20},{32,-20},{32,10},{-18,10},{-18, 
                40},{32,40},{32,70},{32,70},{32,-51}})}), 
      Documentation(info="<html>
<p>
The Boolean output y is a signal defined by parameter vector <strong>table</strong>.
In the vector time points are stored.
The table interpolation has the following properties:
</p>

<ul>
<li>At every time point, the output y
    changes its value to the negated value of the previous one.</li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the <strong>startValue</strong> or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (This setting is not suitable and triggers an assert.)
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>Via parameter <strong>shiftTime</strong> the curve defined by the table can be shifted
    in time.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and <strong>false</strong>
    is used as ordinate value for the output.</li>
</ul>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanTable.png\"
     alt=\"BooleanTable.png\">
</div>

<p>
The precise semantics is:
</p>

<blockquote><pre>
<strong>if</strong> size(table,1) == 0 <strong>then</strong>
   y = startValue;
<strong>else</strong>
   //            time &lt; table[1]: y = startValue
   // table[1] &le; time &lt; table[2]: y = not startValue
   // table[2] &le; time &lt; table[3]: y = startValue
   // table[3] &le; time &lt; table[4]: y = not startValue
   // ...
<strong>end if</strong>;
</pre></blockquote>
</html>"));
  end BooleanTable;

  block RadioButtonSource "Boolean signal source that mimics a radio button"

    parameter SI.Time buttonTimeTable[:]={0,1} 
      "Time instants where button is pressed";
    input Boolean reset[:]={false} 
      "Reset button to false, if an element of reset becomes true" 
      annotation (Dialog(group="Time varying expressions"));

    Modelica.Blocks.Interfaces.BooleanOutput on(start=false,fixed=true) 
      annotation (Placement(transformation(extent={{100,-15},{130,15}})));
  protected
    Modelica.Blocks.Sources.BooleanTable table(table=buttonTimeTable, y(start=false, fixed=true));
    parameter Integer nReset=size(reset, 1);
    Boolean pre_reset[nReset];
  initial equation
    pre(pre_reset) = fill(false, nReset);
    pre(reset) = fill(false, nReset);
  algorithm
    pre_reset := pre(reset);
    when pre_reset then
      on := false;
    end when;

    when change(table.y) then
      on := true;
    end when;

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, 
          extent={{-100,-100},{100,100}}, 
          initialScale=0.06), graphics={Rectangle(
            extent={{-100,-100},{100,100}}, 
            borderPattern=BorderPattern.Raised, 
            fillColor=DynamicSelect({192,192,192}, if on then {0,255,0} else {192,192,192}), 
            fillPattern=FillPattern.Solid, 
            lineColor={128,128,128}), Text(
            extent={{-300,110},{300,175}}, 
            textColor={0,0,255}, 
            textString="%name")}, 
          interaction={OnMouseDownSetBoolean(on, true)}), Documentation(info="<html>
<p>
Boolean signal source that mimics a radio button:
Via a table, a radio button is pressed (i.e., the output 'on' is set to true) and is reset when an element of the Boolean vector
'reset' becomes true. If both appear at the same time instant, setting
the button according to the table has a higher priority as resetting
the button. Example:
</p>

<blockquote><pre>
RadioButtonSource start(buttonTimeTable={1,3}, reset={stop.on});
RadioButtonSource stop (buttonTimeTable={2,4}, reset={start.on});
</pre></blockquote>

<p>
The \"start\" button is pressed at time=1 s and time=3 s,
whereas the \"stop\" button is pressed at time=2 s and time=4 s.
This gives the following result:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/RadioButtonSource.png\"
     alt=\"RadioButtonSource.png\">
</blockquote>

<p>
This example is also available in
<a href=\"modelica://Modelica.Blocks.Examples.Interaction1\">Modelica.Blocks.Examples.Interaction1</a>
</p>

</html>"));
  end RadioButtonSource;

  block IntegerConstant "Generate constant signal of type Integer"
    parameter Integer k(start=1) "Constant output value";
    extends Interfaces.IntegerSO;

  equation
    y = k;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
              100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,0},{80,0}}), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="k=%k")}), 
      Documentation(info="<html>
<p>
The Integer output y is a constant signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerConstant.png\"
     alt=\"IntegerConstant.png\">
</div>
</html>"));
  end IntegerConstant;

  block IntegerStep "Generate step signal of type Integer"
    parameter Integer height=1 "Height of step";
    extends Interfaces.IntegerSignalSource;
  equation
    y = offset + (if time < startTime then 0 else height);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
              100}}), graphics={
          Line(points={{-80,68},{-80,-80}}, color={192,192,192}), 
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-70},{82,-70}}, color={192,192,192}), 
          Polygon(
            points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-80,-70},{0,-70},{0,50},{80,50}}), 
          Text(
            extent={{-150,-150},{150,-110}}, 
            textString="startTime=%startTime")}), 
      Documentation(info="<html>
<p>
The Integer output y is a step signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerStep.png\"
     alt=\"IntegerStep.png\">
</div>
</html>"));
  end IntegerStep;

  block IntegerTable 
    "Generate an Integer output signal based on a table matrix with [time, yi] values"

    parameter Real table[:, 2]=fill(0,0,2) "Table matrix (first column: time; second column: y)" annotation(Dialog(group="Table data definition"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint 
      "Extrapolation of data outside the definition range" annotation(Dialog(group="Table data interpretation"));
    parameter SI.Time startTime=-Modelica.Constants.inf 
      "Output = 0 for time < startTime" annotation(Dialog(group="Table data interpretation"));
    parameter SI.Time shiftTime=0 
      "Shift time of first table column" annotation(Dialog(group="Table data interpretation"));

    extends Interfaces.IntegerSO;

    CombiTimeTable combiTimeTable(
      final table=table, 
      final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, 
      final columns={2}, 
      final extrapolation=extrapolation, 
      final startTime=startTime, 
      final shiftTime=shiftTime) annotation(Placement(transformation(extent={{-30,-10},{-10,10}})));
    Modelica.Blocks.Math.RealToInteger realToInteger annotation(Placement(transformation(extent={{10,-10},{30,10}})));

  protected
      function isValidTable "Check if table is valid"
        extends Modelica.Icons.Function;
        input Real table[:, 2] "Table matrix";
    protected
        SI.Time t_last;
        Integer n=size(table, 1) "Number of table points";
      algorithm
        if n > 0 then
          // Check whether time values are strict monotonically increasing
          t_last := table[1, 1];
          for i in 2:n loop
            assert(table[i, 1] > t_last, 
              "Time values of table not strict monotonically increasing: table[" 
               + String(i - 1) + ",1] = " + String(table[i - 1, 1]) + "table[" + 
              String(i) + ",1] = " + String(table[i, 1]));
          end for;

          // Check that all values in the second column are Integer values
          for i in 1:n loop
            assert(rem(table[i, 2], 1) == 0.0, 
              "Table value is not an Integer: table[" + String(i) + ",2] = " + 
              String(table[i, 2]));
          end for;
        end if;
      end isValidTable;

      parameter Integer n=size(table, 1) "Number of table points";
  initial algorithm
      isValidTable(table);
  equation
      assert(n > 0, "No table values defined.");
      assert(extrapolation <> Modelica.Blocks.Types.Extrapolation.LastTwoPoints, "Unsuitable extrapolation setting.");
      connect(combiTimeTable.y[1], realToInteger.u) annotation(Line(points={{-9,0},{8,0}}, color={0,0,127}));
      connect(realToInteger.y, y) annotation(Line(points={{31,0},{110,0},{110,0}}, color={255,127,0}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
        graphics={
          Line(points={{-80,64},{-80,-84}}, color={192,192,192}), 
          Polygon(
            points={{-80,86},{-88,64},{-72,64},{-80,86}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-90,-74},{82,-74}}, color={192,192,192}), 
          Polygon(
            points={{90,-74},{68,-66},{68,-82},{90,-74}}, 
            lineColor={192,192,192}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Rectangle(
            extent={{-46,68},{4,-52}}, 
            lineColor={255,255,255}, 
            fillColor={192,192,192}, 
            fillPattern=FillPattern.Solid), 
          Line(points={{-46,-52},{-46,68},{54,68},{54,-52},{-46,-52},{-46,-22}, 
                {54,-22},{54,8},{-46,8},{-46,38},{54,38},{54,68},{4,68},{4,-53}})}), 
      Documentation(info="<html>

<p>
This block generates an Integer output signal by using a table.
The time points and y-values are stored in a matrix
<strong>table[i,j]</strong>, where the first column table[:,1] contains the
Real time points and the second column contains the Integer value of the
output y at this time point.
The table interpolation has the following properties:
</p>

<ul>
<li>An assert is triggered, if no table values are provided, if the
    time points are not strict monotonically increasing, or if
    the second column of the table matrix does not contain Integer values.</li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last value of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (This setting is not suitable and triggers an assert.)
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one row</strong>, no interpolation is performed and
    the table values of this row are just returned.</li>
<li>Via parameter <strong>shiftTime</strong> the curve defined by the table can be shifted
    in time.
    The time instants stored in the table are therefore <strong>relative</strong>
    to <strong>shiftTime</strong>.</li>
<li>If time &lt; startTime, no interpolation is performed and zero
    is used as ordinate value for the output.</li>
</ul>

<p>
Example:
</p>
<blockquote><pre>
table = [  0, 1;
           1, 4;
         1.5, 5;
           2, 6];
</pre></blockquote>
<p>
results in the following output:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/IntegerTable.png\"
     alt=\"IntegerTable.png\">
</div>

</html>"));
  end IntegerTable;
  annotation (Documentation(info="<html>
<p>
This package contains <strong>source</strong> components, i.e., blocks which
have only output signals. These blocks are used as signal generators
for Real, Integer and Boolean signals.
</p>

<p>
All Real source signals (with the exception of the Constant source)
have at least the following two parameters:
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>offset</strong></td>
      <td>Value which is added to the signal</td>
  </tr>
  <tr><td><strong>startTime</strong></td>
      <td>Start time of signal. For time &lt; startTime,
                the output y is set to offset.</td>
  </tr>
</table>

<p>
The <strong>offset</strong> parameter is especially useful in order to shift
the corresponding source, such that at initial time the system
is stationary. To determine the corresponding value of offset,
usually requires a trimming calculation.
</p>
</html>", revisions="<html>
<ul>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed.</li>
<li><em>Nov. 8, 1999</em>
       by <a href=\"mailto:christoph@clauss-it.com\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>
<li><em>Oct. 31, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       <a href=\"mailto:christoph@clauss-it.com\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>
<li><em>June 29, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
end Sources;