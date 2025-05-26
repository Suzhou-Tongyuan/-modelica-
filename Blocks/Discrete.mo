within Modelica.Blocks;
package Discrete 
  "Library of discrete input/output blocks with fixed sample period"

  extends Modelica.Icons.Package;

  block Sampler "Ideal sampling of continuous signals"
    extends Interfaces.DiscreteSISO;

  equation
    when {sampleTrigger, initial()} then
      y = u;
    end when;
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true, 
          extent={{-100.0,-100.0},{100.0,100.0}}), 
          graphics={
        Ellipse(lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{25.0,-10.0},{45.0,10.0}}), 
        Line(points={{-100.0,0.0},{-45.0,0.0}}, 
          color={0,0,127}), 
        Line(points={{45.0,0.0},{100.0,0.0}}, 
          color={0,0,127}), 
        Line(points={{-35.0,0.0},{30.0,35.0}}, 
          color={0,0,127}), 
        Ellipse(lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{-45.0,-10.0},{-25.0,10.0}})}), 
      Documentation(info="<html>
<p>
Samples the continues input signal with a sampling rate defined
via parameter <strong>samplePeriod</strong>.
</p>
</html>"));
  end Sampler;

  block ZeroOrderHold "Zero order hold of a sampled-data system"
    extends Interfaces.DiscreteSISO;
    output Real ySample(start=0, fixed=true);

  equation
    when {sampleTrigger, initial()} then
      ySample = u;
    end when;
    /* Define y=ySample with an infinitesimal delay to break potential
       algebraic loops if both the continuous and the discrete part have
       direct feedthrough
    */
    y = pre(ySample);
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true, 
          extent={{-100.0,-100.0},{100.0,100.0}}), 
          graphics={
        Line(points={{-78.0,-42.0},{-52.0,-42.0},{-52.0,0.0},{-26.0,0.0},{-26.0,24.0},{-6.0,24.0},{-6.0,64.0},{18.0,64.0},{18.0,20.0},{38.0,20.0},{38.0,0.0},{44.0,0.0},{44.0,0.0},{62.0,0.0}}, 
          color={0,0,127})}), 
      Documentation(info="<html>
<p>
The output is identical to the sampled input signal at sample
time instants and holds the output at the value of the last
sample instant during the sample points.
</p>
</html>"));
  end ZeroOrderHold;

  block FirstOrderHold "First order hold of a sampled-data system"
    extends Modelica.Blocks.Interfaces.DiscreteSISO;
  protected
    SI.Time tSample;
    Real uSample;
    Real pre_uSample;
    Real c;
  initial equation
    pre(tSample) = time;
    pre(uSample) = u;
    pre(pre_uSample) = u;
    pre(c) = 0.0;
  equation
    when sampleTrigger then
      tSample = time;
      uSample = u;
      pre_uSample = pre(uSample);
      c = if firstTrigger then 0 else (uSample - pre_uSample)/samplePeriod;
    end when;
    /* Use pre_uSample and pre(c) to break potential algebraic loops by an
       infinitesimal delay if both the continuous and the discrete part
       have direct feedthrough.
    */
    y = pre_uSample + pre(c)*(time - tSample);
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true, 
          extent={{-100.0,-100.0},{100.0,100.0}}), 
          graphics={
        Line(points={{-79.0,-41.0},{-59.0,-33.0},{-40.0,1.0},{-20.0,9.0},{0.0,63.0},{21.0,20.0},{41.0,10.0},{60.0,20.0}}, 
          color={0,0,127}), 
        Line(points={{60.0,20.0},{81.0,10.0}}, 
          color={0,0,127})}), 
      Documentation(info="<html>
<p>
The output signal is the extrapolation through the
values of the last two sampled input signals.
</p>
</html>"));
  end FirstOrderHold;

  block UnitDelay "Unit Delay Block"
    parameter Real y_start=0 "Initial value of output signal";
    extends Interfaces.DiscreteSISO;

  equation
    when sampleTrigger then
      y = pre(u);
    end when;

  initial equation
      y = y_start;
    annotation (
      Documentation(info="<html>
<p>
This block describes a unit delay:
</p>
<blockquote><pre>
     1
y = --- * u
     z
</pre></blockquote>
<p>
that is, the output signal y is the input signal u of the
previous sample instant. Before the second sample instant,
the output y is identical to parameter yStart.
</p>

</html>"), Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100.0,-100.0},{100.0,100.0}}), 
        graphics={
      Line(points={{-30.0,0.0},{30.0,0.0}}, 
        color={0,0,127}), 
      Text(textColor={0,0,127}, 
        extent={{-90.0,10.0},{90.0,90.0}}, 
        textString="1"), 
      Text(textColor={0,0,127}, 
        extent={{-90.0,-90.0},{90.0,-10.0}}, 
        textString="z")}));
  end UnitDelay;
  block UnitDelayImproved "Unit Delay Block improved version"

  extends Modelica.Blocks.Interfaces.DiscreteBlock;
    parameter Integer N = 1 "The number of delay cycles";
    parameter Real y_start=0 "Initial value of output signal";
    output Real x[N](start = 0, fixed=true);

    Modelica.Blocks.Interfaces.RealInput u 
      annotation (Placement(transformation(origin={-120,0}, 
  extent={{-20,-20},{20,20}})));
    Modelica.Blocks.Interfaces.RealOutput y 
      annotation (Placement(transformation(origin={110,2.220446049250313e-16}, 
  extent={{-10,-10},{10,10}})));
  protected
    Real xext[N+1](each start=0, each fixed=true);

  equation
    when sampleTrigger then
      xext = vector([u; pre(x)]);
      x = xext[1:N];
      y = xext[N+1];
    end when;

  initial equation
      y = y_start;
    annotation (
      Documentation(info="<html>
<p>
This block describes a unit delay:
</p>
<blockquote><pre>
   1
y = --- * u
   z
</pre></blockquote>
<p>
that is, the output signal y is the input signal u of the
previous sample instant. Before the second sample instant,
the output y is identical to parameter yStart.
</p>

</html>"  ), Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100.0,-100.0},{100.0,100.0}}), 
        graphics={
      Line(points={{-30.0,0.0},{30.0,0.0}}, 
        color={0,0,127}), 
      Text(textColor={0,0,127}, 
        extent={{-90.0,10.0},{90.0,90.0}}, 
        textString="1"), 
      Text(textColor={0,0,127}, 
        extent={{-90.0,-90.0},{90.0,-10.0}}, 
        textString="z")}));
  end UnitDelayImproved;
  block BooleanUnitDelay "Unit Delay Block of Boolean interface"
    parameter Boolean y_start=false "Initial value of output signal";
    extends Modelica.Blocks.Interfaces.DiscreteBlock;

    Modelica.Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    when sampleTrigger then
      y = pre(u);
    end when;

  initial equation
      y = y_start;
    annotation (
      Documentation(info="<html>
<p>
This block describes a unit delay:
</p>
<blockquote><pre>
1
y = --- * u
z
</pre></blockquote>
<p>
that is, the output signal y is the input signal u of the
previous sample instant. Before the second sample instant,
the output y is identical to parameter yStart.
</p>

</html>"      ), Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
preserveAspectRatio=true, 
grid={2,2}),graphics = {Line(origin={0,0}, 
points={{-30,0},{30,0}}, 
color={255,0,255}), Text(origin={0,50}, 
lineColor={255,0,255}, 
extent={{-90,-40},{90,40}}, 
textString="1", 
textStyle={TextStyle.None}, 
textColor={255,0,255}), Text(origin={0,-50}, 
lineColor={255,0,255}, 
extent={{-90,-40},{90,40}}, 
textString="z", 
textStyle={TextStyle.None}, 
textColor={255,0,255})}));
  end BooleanUnitDelay;
  block IntergerUnitDelay "Unit Delay Block of Integer interface"
    parameter Integer y_start=0 "Initial value of output signal";
    extends Modelica.Blocks.Interfaces.DiscreteBlock;

    Modelica.Blocks.Interfaces.IntegerInput u "Connector of Integer input signal" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.IntegerOutput y "Connector of Integer output signal" 
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    when sampleTrigger then
      y = pre(u);
    end when;

  initial equation
      y = y_start;
    annotation (
      Documentation(info="<html>
<p>
This block describes a unit delay:
</p>
<blockquote><pre>
 1
y = --- * u
 z
</pre></blockquote>
<p>
that is, the output signal y is the input signal u of the
previous sample instant. Before the second sample instant,
the output y is identical to parameter yStart.
</p>

</html>"    ), Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
preserveAspectRatio=true, 
grid={2,2}),graphics = {Line(origin={0,0}, 
points={{-30,0},{30,0}}, 
color={255,127,0}), Text(origin={0,50}, 
lineColor={255,127,0}, 
extent={{-90,-40},{90,40}}, 
textString="1", 
textStyle={TextStyle.None}, 
textColor={255,127,0}), Text(origin={0,-50}, 
lineColor={255,127,0}, 
extent={{-90,-40},{90,40}}, 
textString="z", 
textStyle={TextStyle.None}, 
textColor={255,127,0})}));
  end IntergerUnitDelay;

  block TransferFunction "Discrete Transfer Function block"
    parameter Real b[:]={1} "Numerator coefficients of transfer function.";
    parameter Real a[:]={1} "Denominator coefficients of transfer function.";
    extends Interfaces.DiscreteSISO;
    output Real x[size(a, 1) - 1](each start=0, each fixed=true) 
      "State of transfer function from controller canonical form";
  protected
    parameter Integer nb=size(b, 1) "Size of Numerator of transfer function";
    parameter Integer na=size(a, 1) "Size of Denominator of transfer function";
    Real x1(start=0,fixed=true);
    Real xext[size(a, 1)](each start=0, each fixed=true);

  equation
    when sampleTrigger then
      /* State variables x are defined according to
       controller canonical form. */
      x1 = (u - a[2:size(a, 1)]*pre(x))/a[1];
      xext = vector([x1; pre(x)]);
      x = xext[1:size(x, 1)];
      y = vector([zeros(na - nb, 1); b])*xext;
    end when;
    /* This is a non-sampled equation and above there are two separate
       when-clauses. This breaks feedback loops without direct terms,
       since in that case y will be independent of x1 (and only dependent
       on pre(x)).
    */
    /* Corresponding (simpler) version using when-semantics of Modelica 1.3:
   equation
     when sampleTrigger then
      [x; xn] = [x1; pre(x)];
      [u] = transpose([a])*[x1; pre(x)];
      [y] = transpose([zeros(na - nb, 1); b])*[x1; pre(x)];
     end when;
*/
    annotation (
      Documentation(info="<html>
<p>The <strong>discrete transfer function</strong> block defines the
transfer function between the input signal u and the output
signal y. The numerator has the order nb-1, the denominator
has the order na-1.</p>
<blockquote><pre>
       b(1)*z^(nb-1) + b(2)*z^(nb-2) + ... + b(nb)
y(z) = -------------------------------------------- * u(z)
       a(1)*z^(na-1) + a(2)*z^(na-2) + ... + a(na)
</pre></blockquote>
<p>State variables <strong>x</strong> are defined according to
<strong>controller canonical</strong> form. Initial values of the
states can be set as start values of <strong>x</strong>.</p>
<p>Example:</p>
<blockquote><pre>
Blocks.Discrete.TransferFunction g(b = {2,4}, a = {1,3});
</pre></blockquote>
<p>results in the following transfer function:</p>
<blockquote><pre>
     2*z + 4
y = --------- * u
      z + 3
</pre></blockquote>

</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>November 15, 2000</em>
    by <a href=\"http://www.dynasim.se\">Hans Olsson</a>:<br>
    Converted to when-semantics of Modelica 1.4 with special
    care to avoid unnecessary algebraic loops.</li>
<li><em>June 18, 2000</em>
    by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
    Realized based on a corresponding model of Dieter Moormann
    and Hilding Elmqvist.</li>
</ul>
</html>"), 
      Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100.0,-100.0},{100.0,100.0}}), 
        graphics={
      Line(points={{82.0,0.0},{-84.0,0.0}}, 
        color={0,0,127}), 
      Text(textColor={0,0,127}, 
        extent={{-92.0,12.0},{86.0,92.0}}, 
        textString="b(z)"), 
      Text(textColor={0,0,127}, 
        extent={{-90.0,-90.0},{90.0,-12.0}}, 
        textString="a(z)")}));
  end TransferFunction;
  block TransferFunctionDia "Discrete Transfer Function block，Dynamic icon display"
    parameter Real b[:]={1} "Numerator coefficients of transfer function.";
    parameter Real a[:]={1} "Denominator coefficients of transfer function.";
    extends Interfaces.DiscreteSISO;
    output Real x[size(a, 1) - 1](each start=0, each fixed=true) 
      "State of transfer function from controller canonical form";
  protected
    parameter Integer nb=size(b, 1) "Size of Numerator of transfer function";
    parameter Integer na=size(a, 1) "Size of Denominator of transfer function";
    Real x1(start=0,fixed=true);
    Real xext[size(a, 1)](each start=0, each fixed=true);

  equation
    when sampleTrigger then
      /* State variables x are defined according to
       controller canonical form. */
      x1 = (u - a[2:size(a, 1)]*pre(x))/a[1];
      xext = vector([x1; pre(x)]);
      x = xext[1:size(x, 1)];
      y = vector([zeros(na - nb, 1); b])*xext;
    end when;
    /* This is a non-sampled equation and above there are two separate
       when-clauses. This breaks feedback loops without direct terms,
       since in that case y will be independent of x1 (and only dependent
       on pre(x)).
    */
    /* Corresponding (simpler) version using when-semantics of Modelica 1.3:
   equation
     when sampleTrigger then
      [x; xn] = [x1; pre(x)];
      [u] = transpose([a])*[x1; pre(x)];
      [y] = transpose([zeros(na - nb, 1); b])*[x1; pre(x)];
     end when;
  */
    annotation (
      Documentation(info="<html>
<p>The <strong>discrete transfer function</strong> block defines the
transfer function between the input signal u and the output
signal y. The numerator has the order nb-1, the denominator
has the order na-1.</p>
<blockquote><pre>
       b(1)*z^(nb-1) + b(2)*z^(nb-2) + ... + b(nb)
y(z) = -------------------------------------------- * u(z)
       a(1)*z^(na-1) + a(2)*z^(na-2) + ... + a(na)
</pre></blockquote>
<p>State variables <strong>x</strong> are defined according to
<strong>controller canonical</strong> form. Initial values of the
states can be set as start values of <strong>x</strong>.</p>
<p>Example:</p>
<blockquote><pre>
Blocks.Discrete.TransferFunction g(b = {2,4}, a = {1,3});
</pre></blockquote>
<p>results in the following transfer function:</p>
<blockquote><pre>
     2*z + 4
y = --------- * u
      z + 3
</pre></blockquote>

</html>"    , revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>November 15, 2000</em>
    by <a href=\"http://www.dynasim.se\">Hans Olsson</a>:<br>
    Converted to when-semantics of Modelica 1.4 with special
    care to avoid unnecessary algebraic loops.</li>
<li><em>June 18, 2000</em>
    by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
    Realized based on a corresponding model of Dieter Moormann
    and Hilding Elmqvist.</li>
</ul>
</html>"    ), 
      Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100.0,-100.0},{100.0,100.0}}), 
        graphics={
      Line(points={{82.0,0.0},{-84.0,0.0}}, 
        color={0,0,127}), 
      Text(textColor={0,0,127}, 
        extent={{-92.0,12.0},{86.0,92.0}}, 
        textString="%{b(polynomial_z)}"), 
      Text(textColor={0,0,127}, 
        extent={{-90.0,-90.0},{90.0,-12.0}}, 
        textString="%{a(polynomial_z)}")}));
  end TransferFunctionDia;

  block StateSpace "Discrete State Space block"
    parameter Real A[:, size(A, 1)]=[1, 0; 0, 1] 
      "Matrix A of state space model";
    parameter Real B[size(A, 1), :]=[1; 1] "Matrix B of state space model";
    parameter Real C[:, size(A, 1)]=[1, 1] "Matrix C of state space model";
    parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2)) 
      "Matrix D of state space model";

    extends Interfaces.DiscreteMIMO(final nin=size(B, 2), final nout=size(C, 1));
    output Real x[size(A, 1)] "State vector";

  equation
    when sampleTrigger then
      x = A*pre(x) + B*u;
      y = C*pre(x) + D*u;
    end when;
    annotation (
      Documentation(info="<html>
<p>
The <strong>discrete state space</strong> block defines the relation
between the input u and the output y in state space form:
</p>
<blockquote><pre>
x = A * pre(x) + B * u
y = C * pre(x) + D * u
</pre></blockquote>
<p>
where pre(x) is the value of the discrete state x at
the previous sample time instant.
The input is a vector of length nu, the output is a vector
of length ny and nx is the number of states. Accordingly
</p>
<blockquote><pre>
A has the dimension: A(nx,nx),
B has the dimension: B(nx,nu),
C has the dimension: C(ny,nx),
D has the dimension: D(ny,nu)
</pre></blockquote>
<p>
Example:
</p>
<blockquote><pre>
parameter: A = [0.12, 2;3, 1.5]
parameter: B = [2, 7;3, 1]
parameter: C = [0.1, 2]
parameter: D = zeros(ny,nu)

results in the following equations:
  [x[1]]   [0.12  2.00] [pre(x[1])]   [2.0  7.0] [u[1]]
  [    ] = [          ]*[         ] + [        ]*[    ]
  [x[2]]   [3.00  1.50] [pre(x[2])]   [0.1  2.0] [u[2]]
                             [pre(x[1])]            [u[1]]
       y[1]   = [0.1  2.0] * [         ] + [0  0] * [    ]
                             [pre(x[2])]            [u[2]]
</pre></blockquote>
</html>"), Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-90,15},{-15,90}}, 
            textString="A", 
            textColor={0,0,127}), 
          Text(
            extent={{15,15},{90,90}}, 
            textString="B", 
            textColor={0,0,127}), 
          Text(
            extent={{-52,28},{54,-20}}, 
            textString="z", 
            textColor={0,0,127}), 
          Text(
            extent={{-90,-15},{-15,-90}}, 
            textString="C", 
            textColor={0,0,127}), 
          Text(
            extent={{15,-15},{90,-90}}, 
            textString="D", 
            textColor={0,0,127})}));
  end StateSpace;

  block TriggeredSampler "Triggered sampling of continuous signals"
    extends Modelica.Blocks.Icons.DiscreteBlock;
    parameter Real y_start=0 "Initial value of output signal";

    Modelica.Blocks.Interfaces.RealInput u "Connector with a Real input signal" 
                                                          annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y 
      "Connector with a Real output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanInput trigger "Trigger input" annotation (Placement(
          transformation(
          origin={0,-118}, 
          extent={{-20,-20},{20,20}}, 
          rotation=90)));
  equation
    when trigger then
      y = u;
    end when;
  initial equation
    y = y_start;
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true, 
          extent={{-100.0,-100.0},{100.0,100.0}}), 
          graphics={
        Ellipse(lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{25.0,-10.0},{45.0,10.0}}), 
        Line(points={{-100.0,0.0},{-45.0,0.0}}, 
          color={0,0,127}), 
        Line(points={{45.0,0.0},{100.0,0.0}}, 
          color={0,0,127}), 
        Line(points={{0.0,-100.0},{0.0,-26.0}}, 
          color={255,0,255}), 
        Line(points={{-35.0,0.0},{28.0,-48.0}}, 
          color={0,0,127}), 
        Ellipse(lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{-45.0,-10.0},{-25.0,10.0}})}), 
      Documentation(info="<html>
<p>
Samples the continuous input signal whenever the trigger input
signal is rising (i.e., trigger changes from <strong>false</strong> to
<strong>true</strong>) and provides the sampled input signal as output.
Before the first sampling, the output signal is equal to
the initial value defined via parameter <strong>y0</strong>.
</p>
</html>"));
  end TriggeredSampler;

  block TriggeredMax 
    "Compute maximum, absolute value of continuous signal at trigger instants"

    extends Modelica.Blocks.Icons.DiscreteBlock;
    Modelica.Blocks.Interfaces.RealInput u "Connector with a Real input signal" 
                                           annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y 
      "Connector with a Real output signal" annotation (Placement(
          transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanInput trigger annotation (Placement(
          transformation(
          origin={0,-118}, 
          extent={{-20,-20},{20,20}}, 
          rotation=90)));
  equation
    when trigger then
       y = max(pre(y), abs(u));
    end when;
  initial equation
    y = 0;
    annotation (
      Icon(
        coordinateSystem(preserveAspectRatio=true, 
          extent={{-100.0,-100.0},{100.0,100.0}}), 
          graphics={
        Ellipse(lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{25.0,-10.0},{45.0,10.0}}), 
        Line(points={{-100.0,0.0},{-45.0,0.0}}, 
          color={0,0,127}), 
        Line(points={{45.0,0.0},{100.0,0.0}}, 
          color={0,0,127}), 
        Line(points={{0.0,-100.0},{0.0,-26.0}}, 
          color={255,0,255}), 
        Line(points={{-35.0,0.0},{28.0,-48.0}}, 
          color={0,0,127}), 
        Text(extent={{-86.0,24.0},{82.0,82.0}}, 
          color={0,0,127}, 
          textString="max"), 
        Ellipse(lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{-45.0,-10.0},{-25.0,10.0}})}), 
      Documentation(info="<html>
<p>
Samples the continuous input signal whenever the trigger input
signal is rising (i.e., trigger changes from <strong>false</strong> to
<strong>true</strong>). The maximum, absolute value of the input signal
at the sampling point is provided as output signal.
</p>
</html>"));
  end TriggeredMax;
  annotation (Documentation(info="<html>
<p>
This package contains <strong>discrete control blocks</strong>
with <strong>fixed sample period</strong>.
Every component of this package is structured in the following way:
</p>
<ol>
<li> A component has <strong>continuous real</strong> input and output signals.</li>
<li> The <strong>input</strong> signals are <strong>sampled</strong> by the given sample period
     defined via parameter <strong>samplePeriod</strong>.
     The first sample instant is defined by parameter <strong>startTime</strong>.</li>
<li> The <strong>output</strong> signals are computed from the sampled input signals.</li>
</ol>
<p>
A <strong>sampled data system</strong> may consist of components of package <strong>Discrete</strong>
and of every other purely <strong>algebraic</strong> input/output block, such
as the components of packages <strong>Modelica.Blocks.Math</strong>,
<strong>Modelica.Blocks.Nonlinear</strong> or <strong>Modelica.Blocks.Sources</strong>.
</p>

</html>", revisions="<html>
<ul>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New components TriggeredSampler and TriggeredMax added.</li>
<li><em>June 18, 2000</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized based on a corresponding library of Dieter Moormann and
       Hilding Elmqvist.</li>
</ul>
</html>"), Icon(graphics={
        Line(points={{-88,0},{-45,0}}, color={95,95,95}), 
        Ellipse(
          lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{-45,-10},{-25,10}}), 
        Line(points={{-35,0},{24,52}}, color={95,95,95}), 
        Ellipse(
          lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{25,-10},{45,10}}), 
        Line(points={{45,0},{82,0}}, color={95,95,95})}));
  model SlidingModeController "Hysteresis-based sliding mode control"

  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Real lambda(start = 1 , unit = 1) "Sliding factor that affects the convergence speed of the error to zero.";
  parameter Real band(start = 0.2, unit = 1) "Total hysteresis bandwidth, distributed symmetrically about the set point.";
  parameter Real uplim(start = 10, unit = 1) "Upper limit for the control output signal.";
  parameter Real lowlim(start = -10, unit = 1) "Lower limit for the control output signal.";
  parameter Real Ts(start = 0.02, unit = 1) "Block sample time, in s, between consecutive block executions. During execution, the block produces outputs and, if appropriate, updates its internal state. ";

    Modelica.Blocks.Interfaces.RealInput r "Plant system reference signal." 
      annotation (Placement(transformation(origin={-120.131,39.5511}, 
  extent={{-20,-20},{20,20}})));
    Modelica.Blocks.Interfaces.RealInput y "Plant system output signal." 
      annotation (Placement(transformation(origin={-120.132,-40.6601}, 
  extent={{-20,-20},{20,20}})));
    Modelica.Blocks.Interfaces.RealOutput u "Control system output signal." 
      annotation (Placement(transformation(origin={110.152,5.41254e-5}, 
  extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Math.Feedback feedback 
      annotation (Placement(transformation(origin={-68.0132,39.5512}, 
  extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Discrete.TransferFunction transferFunction(samplePeriod=Ts,b={1, -1},a=Ts * {1, 0}) 
      annotation (Placement(transformation(origin={-30.605,2.13064}, 
  extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Math.Add add 
      annotation (Placement(transformation(origin={8.13199,33.637}, 
  extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Nonlinear.Relay relay(ov=uplim,cv=lowlim,op=band/2,cp=-band/2) 
      annotation (Placement(transformation(origin={51.0099,33.6369}, 
  extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Math.Gain gain(k=lambda) 
      annotation (Placement(transformation(origin={-26.7131,39.7914}, 
  extent={{-10,-10},{10,10}})));
    annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  grid={2,2}),graphics = {Text(origin={-77,39.5511}, 
  lineColor={0,0,127}, 
  extent={{-39,36.6633},{39,-36.6633}}, 
  textString="r", 
  textStyle={TextStyle.None}, 
  textColor={0,0,127}), Text(origin={-77,-28.9901}, 
  lineColor={0,0,127}, 
  extent={{-39,31.67},{39,-31.67}}, 
  textString="y", 
  textStyle={TextStyle.None}, 
  textColor={0,0,127}), Text(origin={74.5,5.41254e-5}, 
  lineColor={0,0,127}, 
  extent={{-32.5,36.663325},{32.5,-36.6633}}, 
  textString="u", 
  textStyle={TextStyle.None}, 
  textColor={0,0,127})}),Documentation(info="<html><p style=\"text-align: start;\">The Sliding Mode Controller block implements hysteresis-based sliding mode control (SMC).
</p>
<p style=\"text-align: start;\">The sliding mode controller has this structure:
</p>
<p style=\"text-align: start;\"><img src=\"data:image/png;base64,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\" alt=\"image.png\" data-href=\"\" style=\"\">
</p>
<p style=\"text-align: start;\">In this controller, lambda is the value of the Sliding factor parameter. To change the convergence speed of the error to zero, specify a value greater than 0 for the Sliding factor parameter.
</p>
<p style=\"text-align: start;\">The Discrete Transferfunction in thiss controller has such form:
</p>
<pre><code >Y(s)    K(z-1)
---- = --------
U(s)     Ts z</code></pre><p>
Note:
</p>
<p style=\"text-align: start;\">The Sliding Mode Controller block is a Discrete Block.
</p>
</html>"    ));
    equation
    connect(r, feedback.u1) 
    annotation(Line(origin={-118.525,39.6568}, 
  points={{-1.60666,-0.105663},{42.5116,-0.105663},{42.5116,-0.1056}}, 
  color={0,0,127}));
    connect(feedback.u2, y) 
    annotation(Line(origin={-114.525,-0.343234}, 
  points={{46.5116,31.8944},{46.5116,-40.3168},{-5.60702,-40.3168}}, 
  color={0,0,127}));
    connect(transferFunction.u, feedback.y) 
    annotation(Line(origin={-41.5248,8.65677}, 
  points={{-1.08023,-6.52613},{-7.5082,-6.52613},{-7.5082,30.89443},{-17.4884,30.89443}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
    connect(transferFunction.y, add.u2) 
    annotation(Line(origin={16.4752,2.65677}, 
  points={{-36.0802,-0.526126},{-25.8878,-0.526126},{-25.8878,24.98023},{-20.34321,24.98023}}, 
  color={0,0,127}));
    connect(add.y, relay.u) 
    annotation(Line(origin={54.4752,35.6568}, 
  points={{-35.3433,-2.01981},{-15.4786,-2.01981},{-15.4786,-2.09378}}, 
  color={0,0,127}));
    connect(relay.y, u) 
    annotation(Line(origin={133.475,34.6568}, 
  points={{-71.4132,-1.01985},{-53.6334,-1.01985},{-53.6334,-34.6567},{-23.3232,-34.6567}}, 
  color={0,0,127}));
    connect(gain.y, add.u1) 
    annotation(Line(origin={-10,39}, 
  points={{-5.71306,0.791352},{6.13199,0.791352},{6.13199,0.637}}, 
  color={0,0,127}));
    connect(gain.u, feedback.y) 
    annotation(Line(origin={-49,39}, 
  points={{10.2869,0.791352},{-10.0132,0.791352},{-10.0132,0.5512}}, 
  color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
    end SlidingModeController;
end Discrete;