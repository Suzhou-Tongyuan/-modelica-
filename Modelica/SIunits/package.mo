package SIunits 
  "Library of type and unit definitions based on SI units according to ISO 31-1992"
  extends Modelica.Icons.Package;
package UsersGuide "User's Guide of SIunits Library"
  extends Modelica.Icons.Information;

  class HowToUseSIunits "How to use SIunits"
    extends Modelica.Icons.Information;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
When implementing a Modelica model, every variable needs to
be declared. Physical variables should be declared with a unit.
The basic approach in Modelica is that the unit attribute of
a variable is the <strong>unit</strong> in which the <strong>equations</strong> are <strong>written</strong>,
for example:
</p>

<pre>   <strong>model</strong> MassOnGround
     <strong>parameter</strong> Real m(quantity=\"Mass\", unit=\"kg\") \"Mass\";
     <strong>parameter</strong> Real f(quantity=\"Force\", unit=\"N\") \"Driving force\";
     Real s(unit=\"m\") \"Position of mass\";
     Real v(unit=\"m/s\") \"Velocity of mass\";
   <strong>equation</strong>
     <strong>der</strong>(s) = v;
     m*<strong>der</strong>(v) = f;
   <strong>end</strong> MassOnGround;
</pre>

<p>
This means that the equations in the equation section are only correct
for the specified units. A different issue is the user interface, i.e.,
in which unit the variable is presented to the user in graphical
user interfaces, both for input (e.g., parameter menu), as well as
for output (e.g., in the plot window). Preferably, the Modelica tool
should provide a list of units from which the user can select, e.g.,
\"m\", \"cm\", \"km\", \"inch\" for quantity \"Length\". When storing the value in
the model as a Modelica modifier, it has to be converted to the unit defined
in the declaration. Additionally, the unit used in the graphical
user interface has to be stored. In order to have a standardized way
of doing this, Modelica provides the following three attributes
for a variable of type Real:
</p>

<ul>
<li><strong>quantity</strong> to define the physical quantity (e.g., \"Length\", or \"Energy\").</li>
<li><strong>unit</strong> to define the unit that has to be used
    in order that the equations are correct (e.g., \"N.m\").</li>
<li><strong>displayUnit</strong> to define the unit used in the graphical
    user interface as default display unit for input and/or output.</li>
</ul>

<p>
Note, a unit, such as \"N.m\", is not sufficient to define uniquely the
physical quantity, since, e.g., \"N.m\" might be either \"torque\" or
\"energy\". The \"quantity\" attribute might therefore be used by a tool
to select the corresponding menu from which the user can select
a unit for the corresponding variable.
</p>

<p>
For example, after providing a value for \"m\" and \"f\" in a parameter
menu of an instance of MassOnGround, a tool might generate the following code:
</p>

<pre>
   MassOnGround myObject(m(displayUnit=\"g\")=2, f=3);
</pre>

<p>
The meaning is that in the equations a value of \"2\" is used
and that in the graphical user interface a value of \"2000\" should be used,
together with the unit \"g\" from the unit set \"Mass\" (= the quantity name).
Note, according to the Modelica specification
a tool might ignore the \"displayUnit\" attribute.
</p>

<p>
In order to help the Modelica model developer, the Modelica.SIunits
library provides about 450 predefined type names,
together with values for the attributes <strong>quantity</strong>, <strong>unit</strong> and sometimes
<strong>displayUnit</strong> and <strong>min</strong>. The unit is always selected as SI-unit according to the
ISO standard. The type and the quantity names are the
quantity names used in the ISO standard. \"quantity\" and \"unit\" are defined
as \"<strong>final</strong>\" in order that they cannot be modified. Attributes \"displayUnit\"
and \"min\" can, however, be changed in a model via a modification. The example above,
might therefore be alternatively also defined as:
</p>

<pre>   <strong>model</strong> MassOnGround
     <strong>parameter</strong> Modelica.SIunits.Mass  m \"Mass\";
     <strong>parameter</strong> Modelica.SIunits.Force f \"Driving force\";
     ...
   <strong>end</strong> MassOnGround;
</pre>

<p>
or in a short hand notation as
</p>

<pre>
   <strong>model</strong> MassOnGround
     <strong>import</strong> SI = Modelica.SIunits;
     <strong>parameter</strong> SI.Mass  m \"Mass\";
     <strong>parameter</strong> SI.Force f \"Driving force\";
     ...
   <strong>end</strong> MassOnGround;
</pre>

<p>
For some often
used Non SI-units (like hour), some additional type definitions are
present as Modelica.SIunits.Conversions.NonSIunits. If this is not sufficient,
the user has to define its own types or use the attributes directly
in the declaration as in the example at the beginning.
</p>

<p>
<strong>Complex units</strong> are also included in Modelica.SIunits. A complex unit is declared as:
</p>
<pre>
  <strong>model</strong> QuasiStationaryMachine
    <strong>parameter</strong> Modelica.SIunits.ComplexPower SNominal = Complex(10000,4400)
       \"Nominal complex power\";
   ...
   <strong>end</strong> QuasiStationaryMachine;
</pre>
</html>"));

  end HowToUseSIunits;

  class Conventions "Conventions"
    extends Modelica.Icons.Information;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>The following conventions are used in package SIunits:</p>
<ul>
<li>Modelica quantity names are defined according to the recommendations
    of ISO 31. Some of these name are rather long, such as
    \"ThermodynamicTemperature\". Shorter alias names are defined, e.g.,
    \"type Temp_K = ThermodynamicTemperature;\".</li>
<li>Modelica units are defined according to the SI base units without
    multiples (only exception \"kg\").</li>
<li>For some quantities, more convenient units for an engineer are
    defined as \"displayUnit\", i.e., the default unit for display
    purposes (e.g., displayUnit=\"deg\" for quantity=\"Angle\").</li>
<li>The type name is identical to the quantity name, following
    the convention of type names.</li>
<li>All quantity and unit attributes are defined as final in order
    that they cannot be redefined to another value.</li>
<li>Similar quantities, such as \"Length, Breadth, Height, Thickness,
    Radius\" are defined as the same quantity (here: \"Length\").</li>
<li>The ordering of the type declarations in this package follows ISO 31:
<pre>
  Chapter  1: <strong>Space and Time</strong>
  Chapter  2: <strong>Periodic and Related Phenomena</strong>
  Chapter  3: <strong>Mechanics</strong>
  Chapter  4: <strong>Heat</strong>
  Chapter  5: <strong>Electricity and Magnetism</strong>
  Chapter  6: <strong>Light and Related Electro-Magnetic Radiations</strong>
  Chapter  7: <strong>Acoustics</strong>
  Chapter  8: <strong>Physical Chemistry</strong>
  Chapter  9: <strong>Atomic and Nuclear Physics</strong>
  Chapter 10: <strong>Nuclear Reactions and Ionizing Radiations</strong>
  Chapter 11: (not defined in ISO 31-1992)
  Chapter 12: <strong>Characteristic Numbers</strong>
  Chapter 13: <strong>Solid State Physics</strong>
</pre>
</li>
<li>Conversion functions between SI and non-SI units are available in subpackage
    <strong>Conversions</strong>.</li>
</ul>
</html>"));

  end Conventions;

  class Literature "Literature"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>
<p> This package is based on the following references
</p>

<dl>
<dt>ISO 31-1992:</dt>
<dd> <strong>General principles concerning
    quantities, units and symbols</strong>.<br>&nbsp;</dd>

<dt>ISO 1000-1992:</dt>
<dd> <strong>SI units and recommendations for the use
    of their multiples and of certain other units</strong>.<br>&nbsp;</dd>

<dt>Cardarelli F.:</dt>
<dd> <strong>Scientific Unit Conversion - A Practical
     Guide to Metrication</strong>. Springer 1997.</dd>
</dl>

</html>"));
  end Literature;

  class Contact "Contact"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<h4>Main author</h4>

<p>
<a href=\"http://www.robotic.dlr.de/Martin.Otter/\"><strong>Martin Otter</strong></a><br>
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e.V. (DLR)<br>
Institut f&uuml;r Systemdynamik und Regelungstechnik (DLR-SR)<br>
Forschungszentrum Oberpfaffenhofen<br>
D-82234 Wessling<br>
Germany<br>
email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a>
</p>

<h4>Acknowledgements</h4>

<p>
Astrid Jaschinski, Hubertus Tummescheit and Christian Schweiger
contributed to the implementation of this package.
</p>
</html>"));
  end Contact;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <strong>SIunits</strong> is a <strong>free</strong> Modelica package providing
predefined types, such as <em>Mass</em>,
<em>Length</em>, <em>Time</em>, based on the international standard
on units.</p>

</html>"));
end UsersGuide;

  package Icons "Icons for SIunits"
    extends Modelica.Icons.IconsPackage;

    partial function Conversion "Base icon for conversion functions"

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}}, 
              lineColor={191,0,0}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Line(points={{-90,0},{30,0}}, color={191,0,0}), 
            Polygon(
              points={{90,0},{30,20},{30,-20},{90,0}}, 
              lineColor={191,0,0}, 
              fillColor={191,0,0}, 
              fillPattern=FillPattern.Solid), 
            Text(
              extent={{-115,155},{115,105}}, 
              textString="%name", 
              lineColor={0,0,255})}));
    end Conversion;
    annotation();
  end Icons;

  package Conversions 
    "Conversion functions to/from non SI units and type definitions of non SI units"

    extends Modelica.Icons.Package;

    package NonSIunits "Type definitions of non SI units"

      extends Modelica.Icons.Package;

      type Temperature_degC = Real (final quantity="ThermodynamicTemperature", 
            final unit="degC") 
        "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)" annotation(absoluteValue=true);
      type Temperature_degF = Real (final quantity="ThermodynamicTemperature", 
            final unit="degF") 
        "Absolute temperature in degree Fahrenheit (for relative temperature use SIunits.TemperatureDifference)" annotation(absoluteValue=true);
      type Temperature_degRk = Real (final quantity="ThermodynamicTemperature", 
            final unit="degRk") 
        "Absolute temperature in degree Rankine (for relative temperature use SIunits.TemperatureDifference)" annotation(absoluteValue=true);
      type Angle_deg = Real (final quantity="Angle", final unit="deg") 
        "Angle in degree" annotation();
      type AngularVelocity_rpm = Real (final quantity="AngularVelocity", final unit= 
                 "rev/min") 
        "Angular velocity in revolutions per minute. Alias unit names that are outside of the SI system: rpm, r/min, rev/min" annotation();
      type Velocity_kmh = Real (final quantity="Velocity", final unit="km/h") 
        "Velocity in kilometres per hour" annotation();
      type Time_day = Real (final quantity="Time", final unit="d") 
        "Time in days" annotation();
      type Time_hour = Real (final quantity="Time", final unit="h") 
        "Time in hours" annotation();
      type Time_minute = Real (final quantity="Time", final unit="min") 
        "Time in minutes" annotation();
      type Volume_litre = Real (final quantity="Volume", final unit="l") 
        "Volume in litres" annotation();
      type ElectricCharge_Ah = 
        Real (final quantity="ElectricCharge", final unit="A.h") 
        "Electric charge in Ampere hours" annotation();
      type Energy_Wh = 
           Real (final quantity="Energy", final unit="W.h") 
        "Energy in Watt hours" annotation();
      type Energy_kWh = Real (final quantity="Energy", final unit="kW.h") 
        "Energy in kilo watt hours" annotation();
      type Pressure_bar = Real (final quantity="Pressure", final unit="bar") 
        "Absolute pressure in bar" annotation();
      type MassFlowRate_gps = Real (final quantity="MassFlowRate", final unit= 
              "g/s") "Mass flow rate in gram per second" annotation();

      type FirstOrderTemperaturCoefficient = 
                              Real (final quantity="FirstOrderTemperatureCoefficient", 
            final unit="Ohm/degC") "Obsolete type, use LinearTemperatureCoefficientResistance instead!" annotation(absoluteValue=true, 
        obsolete = "Obsolete type - use Modelica.SIunits.LinearTemperatureCoefficientResistance instead");
      type SecondOrderTemperaturCoefficient = 
                              Real (final quantity="SecondOrderTemperatureCoefficient", 
            final unit="Ohm/degC2") "Obsolete type, use QuadraticTemperatureCoefficientResistance instead!" annotation(absoluteValue=true, 
        obsolete = "Obsolete type - use Modelica.SIunits.QuadraticTemperatureCoefficientResistance instead");
      type Area_cm =   Real (final quantity="Area", final unit="cm2") 
        "Area in cm" annotation();
      type PerArea_cm =Real (final quantity="PerArea", final unit="1/cm2") 
        "Per Area in cm" annotation();
      type Area_cmPerVoltageSecond = 
                       Real (final quantity="AreaPerVoltageSecond", final unit="cm2/(V.s)") 
        "Area in cm per voltage second" annotation();

      annotation (Documentation(info="<html>
<p>
This package provides predefined types, such as <strong>Angle_deg</strong> (angle in
degree), <strong>AngularVelocity_rpm</strong> (angular velocity in revolutions per
minute) or <strong>Temperature_degF</strong> (temperature in degree Fahrenheit),
which are in common use but are not part of the international standard on
units according to ISO 31-1992 \"General principles concerning quantities,
units and symbols\" and ISO 1000-1992 \"SI units and recommendations for
the use of their multiples and of certain other units\".</p>
<p>If possible, the types in this package should not be used. Use instead
types of package Modelica.SIunits. For more information on units, see also
the book of Francois Cardarelli <strong>Scientific Unit Conversion - A
Practical Guide to Metrication</strong> (Springer 1997).</p>
<p>Some units, such as <strong>Temperature_degC/Temp_C</strong> are both defined in
Modelica.SIunits and in Modelica.Conversions.NonSIunits. The reason is that these
definitions have been placed erroneously in Modelica.SIunits although they
are not SIunits. For backward compatibility, these type definitions are
still kept in Modelica.SIunits.</p>
</html>"), Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
      Text(
        origin={15.0,51.8518}, 
        extent={{-105.0,-86.8518},{75.0,-16.8518}}, 
        textString="[km/h]")}));
    end NonSIunits;

  function to_unit1 "Change the unit of a Real number to unit=\"1\""
    extends Modelica.SIunits.Icons.Conversion;
    input Real r "Real number";
    output Real result(unit="1") "Real number r with unit=\"1\"";
  algorithm
    result := r;
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SIunits.Conversions.<strong>to_unit1</strong>(r);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Conversions.<strong>to_unit1</strong>(r)</code>\" returns r with unit=\"1\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Modelica.SIunits.Velocity v = {3,2,1};
  Real direction[3](unit=\"1\") = to_unit1(v);   // Automatically vectorized call of to_unit1
</pre></blockquote>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100, 
            100}}), graphics={Text(
          extent={{-90,86},{32,50}}, 
          textString="any", 
          horizontalAlignment=TextAlignment.Left), Text(
          extent={{-36,-52},{86,-88}}, 
          horizontalAlignment=TextAlignment.Right, 
          textString="1")}));
  end to_unit1;

    function to_degC "Convert from Kelvin to degCelsius"
      extends Modelica.SIunits.Icons.Conversion;
      input Temperature Kelvin "Kelvin value";
      output NonSIunits.Temperature_degC Celsius "Celsius value";
    algorithm
      Celsius := Kelvin + Modelica.Constants.T_zero;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}}, 
              textString="K"), Text(
              extent={{100,-20},{20,-100}}, 
              textString="degC")}));
    end to_degC;

    function from_degC "Convert from degCelsius to Kelvin"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Temperature_degC Celsius "Celsius value";
      output Temperature Kelvin "Kelvin value";
    algorithm
      Kelvin := Celsius - Modelica.Constants.T_zero;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}}, 
              textString="degC"), Text(
              extent={{100,-20},{20,-100}}, 
              textString="K")}));
    end from_degC;

    function to_degF "Convert from Kelvin to degFahrenheit"
      extends Modelica.SIunits.Icons.Conversion;
      input Temperature Kelvin "Kelvin value";
      output NonSIunits.Temperature_degF Fahrenheit "Fahrenheit value";
    algorithm
      Fahrenheit := (Kelvin + Modelica.Constants.T_zero)*(9/5) + 32;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}}, 
              textString="K"), Text(
              extent={{100,-20},{20,-100}}, 
              textString="degF")}));
    end to_degF;

    function from_degF "Convert from degFahrenheit to Kelvin"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Temperature_degF Fahrenheit "Fahrenheit value";
      output Temperature Kelvin "Kelvin value";
    algorithm
      Kelvin := (Fahrenheit - 32)*(5/9) - Modelica.Constants.T_zero;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}}, 
              textString="degF"), Text(
              extent={{100,-20},{20,-100}}, 
              textString="K"), Text(
              extent={{-20,100},{-100,20}}, 
              textString="degF")}));
    end from_degF;

    function to_degRk "Convert from Kelvin to degRankine"
      extends Modelica.SIunits.Icons.Conversion;
      input Temperature Kelvin "Kelvin value";
      output NonSIunits.Temperature_degRk Rankine "Rankine value";
    algorithm
      Rankine := (9/5)*Kelvin;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,20}}, 
              textString="K"), Text(
              extent={{100,-32},{-18,-100}}, 
              textString="degRk")}));
    end to_degRk;

    function from_degRk "Convert from degRankine to Kelvin"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Temperature_degRk Rankine "Rankine value";
      output Temperature Kelvin "Kelvin value";
    algorithm
      Kelvin := (5/9)*Rankine;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-8,100},{-100,42}}, 
              textString="degRk"), Text(
              extent={{100,-20},{20,-100}}, 
              textString="K")}));
    end from_degRk;

    function to_deg "Convert from radian to degree"
      extends Modelica.SIunits.Icons.Conversion;
      input Angle radian "radian value";
      output NonSIunits.Angle_deg degree "degree value";
    algorithm
      degree := (180.0/Modelica.Constants.pi)*radian;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{10,100},{-100,46}}, 
              textString="rad"), Text(
              extent={{100,-44},{-10,-100}}, 
              textString="deg")}));
    end to_deg;

    function from_deg "Convert from degree to radian"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Angle_deg degree "degree value";
      output Angle radian "radian value";
    algorithm
      radian := (Modelica.Constants.pi/180.0)*degree;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{4,100},{-102,46}}, 
              textString="deg"), Text(
              extent={{100,-32},{-18,-100}}, 
              textString="rad")}));
    end from_deg;

    function to_rpm "Convert from radian per second to revolutions per minute"
      extends Modelica.SIunits.Icons.Conversion;
      input AngularVelocity rs "radian per second value";
      output NonSIunits.AngularVelocity_rpm rpm "revolutions per minute value";
    algorithm
      rpm := (30/Modelica.Constants.pi)*rs;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{30,100},{-100,50}}, 
              textString="rad/s"), Text(
              extent={{100,-52},{-40,-98}}, 
              textString="rev/min")}));
    end to_rpm;

    function from_rpm 
      "Convert from revolutions per minute to radian per second"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.AngularVelocity_rpm rpm "revolutions per minute value";
      output AngularVelocity rs "radian per second value";
    algorithm
      rs := (Modelica.Constants.pi/30)*rpm;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{14,100},{-102,56}}, 
              textString="rev/min"), Text(
              extent={{100,-56},{-32,-102}}, 
              textString="rad/s")}));
    end from_rpm;

    function to_kmh "Convert from metre per second to kilometre per hour"
      extends Modelica.SIunits.Icons.Conversion;
      input Velocity ms "metre per second value";
      output NonSIunits.Velocity_kmh kmh "kilometre per hour value";
    algorithm
      kmh := 3.6*ms;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{8,100},{-100,58}}, 
              textString="m/s"), Text(
              extent={{100,-56},{-16,-100}}, 
              textString="km/h")}));
    end to_kmh;

    function from_kmh "Convert from kilometre per hour to metre per second"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Velocity_kmh kmh "kilometre per hour value";
      output Velocity ms "metre per second value";
    algorithm
      ms := kmh/3.6;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{10,100},{-100,56}}, 
              textString="km/h"), Text(
              extent={{100,-50},{-20,-100}}, 
              textString="m/s")}));
    end from_kmh;

    function to_day "Convert from second to day"
      extends Modelica.SIunits.Icons.Conversion;
      input Time s "second value";
      output NonSIunits.Time_day day "day value";
    algorithm
      day := s/86400;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-6,100},{-100,48}}, 
              textString="s"), Text(
              extent={{100,-48},{-10,-98}}, 
              textString="day")}));
    end to_day;

    function from_day "Convert from day to second"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Time_day day "day value";
      output Time s "second value";
    algorithm
      s := 86400*day;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{10,100},{-100,52}}, 
              textString="day"), Text(
              extent={{100,-54},{20,-100}}, 
              textString="s")}));
    end from_day;

    function to_hour "Convert from second to hour"
      extends Modelica.SIunits.Icons.Conversion;
      input Time s "second value";
      output NonSIunits.Time_hour hour "hour value";
    algorithm
      hour := s/3600;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{12,100},{-100,50}}, 
              textString="s"), Text(
              extent={{100,-56},{-20,-100}}, 
              textString="hour")}));
    end to_hour;

    function from_hour "Convert from hour to second"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Time_hour hour "hour value";
      output Time s "second value";
    algorithm
      s := 3600*hour;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{12,100},{-100,58}}, 
              textString="hour"), Text(
              extent={{100,-50},{16,-100}}, 
              textString="s")}));
    end from_hour;

    function to_minute "Convert from second to minute"
      extends Modelica.SIunits.Icons.Conversion;
      input Time s "second value";
      output NonSIunits.Time_minute minute "minute value";
    algorithm
      minute := s/60;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-26,100},{-100,52}}, 
              textString="s"), Text(
              extent={{100,-54},{-20,-100}}, 
              textString="min")}));
    end to_minute;

    function from_minute "Convert from minute to second"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Time_minute minute "minute value";
      output Time s "second value";
    algorithm
      s := 60*minute;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{26,100},{-100,48}}, 
              textString="min"), Text(
              extent={{100,-46},{0,-100}}, 
              textString="s")}));
    end from_minute;

    function to_litre "Convert from cubic metre to litre"
      extends Modelica.SIunits.Icons.Conversion;
      input Volume m3 "cubic metre value";
      output NonSIunits.Volume_litre litre "litre value";
    algorithm
      litre := 1000*m3;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{100,-56},{0,-100}}, 
              textString="litre"), Text(
              extent={{6,100},{-100,56}}, 
              textString="m3")}));
    end to_litre;

    function from_litre "Convert from litre to cubic metre"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Volume_litre litre "litre value";
      output Volume m3 "cubic metre value";
    algorithm
      m3 := litre/1000;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-4,100},{-100,62}}, 
              textString="litre"), Text(
              extent={{100,-56},{-6,-100}}, 
              textString="m3")}));
    end from_litre;

    function from_Ah "Convert from Ampere hours to Coulomb"
      extends Modelica.SIunits.Icons.Conversion;
      input Modelica.SIunits.Conversions.NonSIunits.ElectricCharge_Ah 
            AmpereHour "Ampere hours";
      output Modelica.SIunits.ElectricCharge Coulomb "Coulomb";
    algorithm
      Coulomb := AmpereHour * 3600;

      annotation (Icon(graphics={Text(
              extent={{-2,100},{-100,48}}, 
              textString="Ah"), Text(
              extent={{100,-46},{0,-100}}, 
              textString="C")}));
    end from_Ah;

    function to_Ah "Convert from Coulomb to Ampere hours"
      extends Modelica.SIunits.Icons.Conversion;
      input Modelica.SIunits.ElectricCharge Coulomb "Coulomb";
      output Modelica.SIunits.Conversions.NonSIunits.ElectricCharge_Ah 
                                          AmpereHour "Ampere hours";
    algorithm
      AmpereHour := Coulomb/3600;

      annotation (Icon(graphics={Text(
              extent={{-18,100},{-100,48}}, 
              textString="C"), Text(
              extent={{100,-48},{2,-100}}, 
              textString="Ah")}));
    end to_Ah;

    function from_Wh "Convert from Watt hour to Joule"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Energy_Wh WattHour "Watt hour";
      output Modelica.SIunits.Energy Joule "Joule";
    algorithm
      Joule := WattHour * 3600;

      annotation (Icon(graphics={Text(
              extent={{-20,100},{-100,54}}, 
              textString="Wh"), Text(
              extent={{100,-38},{4,-100}}, 
              textString="J")}));
    end from_Wh;

    function to_Wh "Convert from Joule to Watt hour"
      extends Modelica.SIunits.Icons.Conversion;
      input Modelica.SIunits.Energy Joule "Joule";
      output NonSIunits.Energy_Wh WattHour "Watt hour";
    algorithm
      WattHour := Joule/3600;

      annotation (Icon(graphics={Text(
              extent={{-30,100},{-100,48}}, 
              textString="J"), Text(
              extent={{100,-46},{-14,-100}}, 
              textString="Wh")}));
    end to_Wh;

    function to_kWh "Convert from Joule to kilo Watt hour"
      extends Modelica.SIunits.Icons.Conversion;
      input Energy J "Joule value";
      output NonSIunits.Energy_kWh kWh "kWh value";
    algorithm
      kWh := J/3.6e6;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,54}}, 
              textString="J"), Text(
              extent={{100,-50},{-10,-100}}, 
              textString="kWh")}));
    end to_kWh;

    function from_kWh "Convert from kilo Watt hour to Joule"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Energy_kWh kWh "kWh value";
      output Energy J "Joule value";
    algorithm
      J := 3.6e6*kWh;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{12,100},{-100,52}}, 
              textString="kWh"), Text(
              extent={{100,-44},{12,-100}}, 
              textString="J")}));
    end from_kWh;

    function to_bar "Convert from Pascal to bar"
      extends Modelica.SIunits.Icons.Conversion;
      input Pressure Pa "Pascal value";
      output NonSIunits.Pressure_bar bar "bar value";
    algorithm
      bar := Pa/1e5;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-12,100},{-100,56}}, 
              textString="Pa"), Text(
              extent={{98,-52},{-4,-100}}, 
              textString="bar")}));
    end to_bar;

    function from_bar "Convert from bar to Pascal"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Pressure_bar bar "bar value";
      output Pressure Pa "Pascal value";
    algorithm
      Pa := 1e5*bar;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{100,-56},{12,-100}}, 
              textString="Pa"), Text(
              extent={{2,100},{-100,52}}, 
              textString="bar")}));
    end from_bar;

    function to_gps "Convert from kilogram per second to gram per second"
      extends Modelica.SIunits.Icons.Conversion;
      input MassFlowRate kgps "kg/s value";
      output NonSIunits.MassFlowRate_gps gps "g/s value";
    algorithm
      gps := 1000*kgps;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-12,100},{-100,60}}, 
              textString="kg/s"), Text(
              extent={{100,-46},{-6,-100}}, 
              textString="g/s")}));
    end to_gps;

    function from_gps "Convert from gram per second to kilogram per second"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.MassFlowRate_gps gps "g/s value";
      output MassFlowRate kgps "kg/s value";
    algorithm
      kgps := gps/1000;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-8,100},{-100,54}}, 
              textString="g/s"), Text(
              extent={{100,-44},{-10,-100}}, 
              textString="kg/s")}));
    end from_gps;

    function from_Hz "Convert from Hz to rad/s"
      extends Modelica.SIunits.Icons.Conversion;
      input SIunits.Frequency f "frequency";
      output SIunits.AngularVelocity w "angular velocity";

    algorithm
      w := 2*Modelica.Constants.pi*f;
      annotation (Inline=true,Icon(graphics={
                                    Text(
              extent={{2,100},{-100,52}}, 
              textString="Hz"), Text(
              extent={{100,-56},{12,-100}}, 
              textString="1/s")}));
    end from_Hz;

    function to_Hz "Convert from rad/s to Hz"
      extends Modelica.SIunits.Icons.Conversion;
      input SIunits.AngularVelocity w "angular velocity";
      output SIunits.Frequency f "frequency";
    algorithm
      f := w/(2*Modelica.Constants.pi);
      annotation (Inline=true,Icon(graphics={
                                    Text(
              extent={{100,-52},{-2,-100}}, 
              textString="Hz"), Text(
              extent={{-12,100},{-100,56}}, 
              textString="1/s")}));
    end to_Hz;

    function to_cm2 "Convert from square metre to square centimetre"
      extends Modelica.SIunits.Icons.Conversion;
      input Area m2 "square metre value";
      output NonSIunits.Area_cm cm2 "square centimetre value";
    algorithm
      cm2 := 10000*m2;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{-20,100},{-100,58}}, 
              textString="m/s"), Text(
              extent={{100,-50},{-18,-100}}, 
              textString="cm2")}));
    end to_cm2;

    function from_cm2 "Convert from square centimetre to square metre"
      extends Modelica.SIunits.Icons.Conversion;
      input NonSIunits.Area_cm cm2 "square centimetre value";
      output Area m2 "square metre value";
    algorithm
      m2 := 0.0001*cm2;
      annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={Text(
              extent={{2,100},{-100,58}}, 
              textString="cm2"), Text(
              extent={{100,-50},{-16,-98}}, 
              textString="m/s")}));
    end from_cm2;

    partial function ConversionIcon 
      "This icon will be removed in future Modelica versions."
      extends Modelica.Icons.ObsoleteModel;

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}}, 
              lineColor={191,0,0}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid), 
            Line(points={{-90,0},{30,0}}, color={191,0,0}), 
            Polygon(
              points={{90,0},{30,20},{30,-20},{90,0}}, 
              lineColor={191,0,0}, 
              fillColor={191,0,0}, 
              fillPattern=FillPattern.Solid), 
            Text(
              extent={{-115,155},{115,105}}, 
              textString="%name", 
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
This icon of a <strong>conversion symbol</strong> will be removed in future versions of the library. Instead the icon <a href=\"modelica://Modelica.SIunits.Icons.Conversion\">Modelica.SIunits.Icons.Conversion</a> shall be used.
</p>
</html>"), 
      obsolete = "Obsolete function - use Modelica.SIunits.Icons.Conversion instead");
    end ConversionIcon;
    annotation (Documentation(info="<html>
<p>This package provides conversion functions from the non SI Units
defined in package Modelica.SIunits.Conversions.NonSIunits to the
corresponding SI Units defined in package Modelica.SIunits and vice
versa. It is recommended to use these functions in the following
way (note, that all functions have one Real input and one Real output
argument):</p>
<pre>
  <strong>import</strong> SI = Modelica.SIunits;
  <strong>import</strong> Modelica.SIunits.Conversions.*;
     ...
  <strong>parameter</strong> SI.Temperature     T   = from_degC(25);   // convert 25 degree Celsius to Kelvin
  <strong>parameter</strong> SI.Angle           phi = from_deg(180);   // convert 180 degree to radian
  <strong>parameter</strong> SI.AngularVelocity w   = from_rpm(3600);  // convert 3600 revolutions per minutes
                                                      // to radian per seconds
</pre>

</html>"));
  end Conversions;

  // Space and Time (chapter 1 of ISO 31-1992)

  type Angle = Real (
      final quantity="Angle", 
      final unit="rad", 
      displayUnit="deg") annotation();
  type SolidAngle = Real (final quantity="SolidAngle", final unit="sr") annotation();
  type Length = Real (final quantity="Length", final unit="m") annotation();
  type PathLength = Length annotation();
  type Position = Length annotation();
  type Distance = Length (min=0) annotation();
  type Breadth = Length(min=0) annotation();
  type Height = Length(min=0) annotation();
  type Thickness = Length(min=0) annotation();
  type Radius = Length(min=0) annotation();
  type Diameter = Length(min=0) annotation();
  type Area = Real (final quantity="Area", final unit="m2") annotation();
  type Volume = Real (final quantity="Volume", final unit="m3") annotation();
  type Time = Real (final quantity="Time", final unit="s") annotation();
  type Duration = Time annotation();
  type AngularVelocity = Real (
      final quantity="AngularVelocity", 
      final unit="rad/s") annotation();
  type AngularAcceleration = Real (final quantity="AngularAcceleration", final unit= 
             "rad/s2") annotation();
  type Velocity = Real (final quantity="Velocity", final unit="m/s") annotation();
  type Acceleration = Real (final quantity="Acceleration", final unit="m/s2") annotation();

  // Periodic and related phenomens (chapter 2 of ISO 31-1992)
  type Period = Real (final quantity="Time", final unit="s") annotation();
  type Frequency = Real (final quantity="Frequency", final unit="Hz") annotation();
  type AngularFrequency = Real (final quantity="AngularFrequency", final unit= 
          "rad/s") annotation();
  type Wavelength = Real (final quantity="Wavelength", final unit="m") annotation();
  type Wavelenght = Wavelength annotation();
  // For compatibility reasons only
  type WaveNumber = Real (final quantity="WaveNumber", final unit="m-1") annotation();
  type CircularWaveNumber = Real (final quantity="CircularWaveNumber", final unit= 
             "rad/m") annotation();
  type AmplitudeLevelDifference = Real (final quantity= 
          "AmplitudeLevelDifference", final unit="dB") annotation();
  type PowerLevelDifference = Real (final quantity="PowerLevelDifference", 
        final unit="dB") annotation();
  type DampingCoefficient = Real (final quantity="DampingCoefficient", final unit= 
             "s-1") annotation();
  type LogarithmicDecrement = Real (final quantity="LogarithmicDecrement", 
        final unit="1/S") annotation();
  type AttenuationCoefficient = Real (final quantity="AttenuationCoefficient", 
        final unit="m-1") annotation();
  type PhaseCoefficient = Real (final quantity="PhaseCoefficient", final unit= 
          "m-1") annotation();
  type PropagationCoefficient = Real (final quantity="PropagationCoefficient", 
        final unit="m-1") annotation();
  // added to ISO-chapter
  type Damping = DampingCoefficient annotation();

  // Mechanics (chapter 3 of ISO 31-1992)
  type Mass = Real (
      quantity="Mass", 
      final unit="kg", 
      min=0) annotation();
  type Density = Real (
      final quantity="Density", 
      final unit="kg/m3", 
      displayUnit="g/cm3", 
      min=0.0) annotation();
  type RelativeDensity = Real (
      final quantity="RelativeDensity", 
      final unit="1", 
      min=0.0) annotation();
  type SpecificVolume = Real (
      final quantity="SpecificVolume", 
      final unit="m3/kg", 
      min=0.0) annotation();
  type LinearDensity = Real (
      final quantity="LinearDensity", 
      final unit="kg/m", 
      min=0) annotation();
  type SurfaceDensity = Real (
      final quantity="SurfaceDensity", 
      final unit="kg/m2", 
      min=0) annotation();
  type Momentum = Real (final quantity="Momentum", final unit="kg.m/s") annotation();
  type Impulse = Real (final quantity="Impulse", final unit="N.s") annotation();
  type AngularMomentum = Real (final quantity="AngularMomentum", final unit= 
          "kg.m2/s") annotation();
  type AngularImpulse = Real (final quantity="AngularImpulse", final unit= 
          "N.m.s") annotation();
  type MomentOfInertia = Real (final quantity="MomentOfInertia", final unit= 
          "kg.m2") annotation();
  type Inertia = MomentOfInertia annotation();
  type Force = Real (final quantity="Force", final unit="N") annotation();
  type TranslationalSpringConstant=Real(final quantity="TranslationalSpringConstant", final unit="N/m") annotation();
  type TranslationalDampingConstant=Real(final quantity="TranslationalDampingConstant", final unit="N.s/m") annotation();
  type Weight = Force annotation();
  type Torque = Real (final quantity="Torque", final unit="N.m") annotation();
  type ElectricalTorqueConstant = Real(final quantity="ElectricalTorqueConstant", final unit= "N.m/A") annotation();
  type MomentOfForce = Torque annotation();
  type ImpulseFlowRate = Real (final quantity="ImpulseFlowRate", final unit="N") annotation();
  type AngularImpulseFlowRate = Real (final quantity="AngularImpulseFlowRate", final unit= "N.m") annotation();
  type RotationalSpringConstant=Real(final quantity="RotationalSpringConstant", final unit="N.m/rad") annotation();
  type RotationalDampingConstant=Real(final quantity="RotationalDampingConstant", final unit="N.m.s/rad") annotation();
  type Pressure = Real (
      final quantity="Pressure", 
      final unit="Pa", 
      displayUnit="bar") annotation();
  type AbsolutePressure = Pressure (min=0.0, nominal = 1e5) annotation();
  type PressureDifference = Pressure annotation();
  type BulkModulus = AbsolutePressure annotation();
  type Stress = Real (final unit="Pa") annotation();
  type NormalStress = Stress annotation();
  type ShearStress = Stress annotation();
  type Strain = Real (final quantity="Strain", final unit="1") annotation();
  type LinearStrain = Strain annotation();
  type ShearStrain = Strain annotation();
  type VolumeStrain = Real (final quantity="VolumeStrain", final unit="1") annotation();
  type PoissonNumber = Real (final quantity="PoissonNumber", final unit="1") annotation();
  type ModulusOfElasticity = Stress annotation();
  type ShearModulus = Stress annotation();
  type SecondMomentOfArea = Real (final quantity="SecondMomentOfArea", final unit= 
             "m4") annotation();
  type SecondPolarMomentOfArea = SecondMomentOfArea annotation();
  type SectionModulus = Real (final quantity="SectionModulus", final unit="m3") annotation();
  type CoefficientOfFriction = Real (final quantity="CoefficientOfFriction", 
        final unit="1") annotation();
  type DynamicViscosity = Real (
      final quantity="DynamicViscosity", 
      final unit="Pa.s", 
      min=0) annotation();
  type KinematicViscosity = Real (
      final quantity="KinematicViscosity", 
      final unit="m2/s", 
      min=0) annotation();
  type SurfaceTension = Real (final quantity="SurfaceTension", final unit="N/m") annotation();
  type Work = Real (final quantity="Work", final unit="J") annotation();
  type Energy = Real (final quantity="Energy", final unit="J") annotation();
  type EnergyDensity = Real (final quantity="EnergyDensity", final unit="J/m3") annotation();
  type PotentialEnergy = Energy annotation();
  type KineticEnergy = Energy annotation();
  type Power = Real (final quantity="Power", final unit="W") annotation();
  type EnergyFlowRate = Power annotation();
  type EnthalpyFlowRate = Real (final quantity="EnthalpyFlowRate", final unit= 
          "W") annotation();
  type Efficiency = Real (
      final quantity="Efficiency", 
      final unit="1", 
      min=0) annotation();
  type MassFlowRate = Real (quantity="MassFlowRate", final unit="kg/s") annotation();
  type VolumeFlowRate = Real (final quantity="VolumeFlowRate", final unit= 
          "m3/s") annotation();
  // added to ISO-chapter 3
  type MomentumFlux = Real (final quantity="MomentumFlux", final unit="N") annotation();
  type AngularMomentumFlux = Real (final quantity="AngularMomentumFlux", final unit= 
             "N.m") annotation();

  // Heat (chapter 4 of ISO 31-1992)
  type ThermodynamicTemperature = Real (
      final quantity="ThermodynamicTemperature", 
      final unit="K", 
      min = 0.0, 
      start = 288.15, 
      nominal = 300, 
      displayUnit="degC") 
    "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation(absoluteValue=true);
  type Temp_K = ThermodynamicTemperature annotation();
  type Temperature = ThermodynamicTemperature annotation();
  type TemperatureDifference = Real (
      final quantity="ThermodynamicTemperature", 
      final unit="K") annotation(absoluteValue=false);
  type Temp_C = SIunits.Conversions.NonSIunits.Temperature_degC annotation();
  type TemperatureSlope = Real (final quantity="TemperatureSlope", 
      final unit="K/s") annotation();
  type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit="1/K") annotation();
  type QuadraticTemperatureCoefficient = Real(final quantity = "QuadraticTemperatureCoefficient", final unit="1/K2") annotation();
  type LinearExpansionCoefficient = Real (final quantity= 
          "LinearExpansionCoefficient", final unit="1/K") annotation();
  type CubicExpansionCoefficient = Real (final quantity= 
          "CubicExpansionCoefficient", final unit="1/K") annotation();
  type RelativePressureCoefficient = Real (final quantity= 
          "RelativePressureCoefficient", final unit="1/K") annotation();
  type PressureCoefficient = Real (final quantity="PressureCoefficient", final unit= 
             "Pa/K") annotation();
  type Compressibility = Real (final quantity="Compressibility", final unit= 
          "1/Pa") annotation();
  type IsothermalCompressibility = Compressibility annotation();
  type IsentropicCompressibility = Compressibility annotation();
  type Heat = Real (final quantity="Energy", final unit="J") annotation();
  type HeatFlowRate = Real (final quantity="Power", final unit="W") annotation();
  type HeatFlux = Real (final quantity="HeatFlux", final unit="W/m2") annotation();
  type DensityOfHeatFlowRate = Real (final quantity="DensityOfHeatFlowRate", 
        final unit="W/m2") annotation();
  type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit= 
             "W/(m.K)") annotation();
  type CoefficientOfHeatTransfer = Real (final quantity= 
          "CoefficientOfHeatTransfer", final unit="W/(m2.K)") annotation();
  type SurfaceCoefficientOfHeatTransfer = CoefficientOfHeatTransfer annotation();
  type ThermalInsulance = Real (final quantity="ThermalInsulance", final unit= 
          "m2.K/W") annotation();
  type ThermalResistance = Real (final quantity="ThermalResistance", final unit= 
         "K/W") annotation();
  type ThermalConductance = Real (final quantity="ThermalConductance", final unit= 
             "W/K") annotation();
  type ThermalDiffusivity = Real (final quantity="ThermalDiffusivity", final unit= 
             "m2/s") annotation();
  type HeatCapacity = Real (final quantity="HeatCapacity", final unit="J/K") annotation();
  type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity", 
        final unit="J/(kg.K)") annotation();
  type SpecificHeatCapacityAtConstantPressure = SpecificHeatCapacity annotation();
  type SpecificHeatCapacityAtConstantVolume = SpecificHeatCapacity annotation();
  type SpecificHeatCapacityAtSaturation = SpecificHeatCapacity annotation();
  type RatioOfSpecificHeatCapacities = Real (final quantity= 
          "RatioOfSpecificHeatCapacities", final unit="1") annotation();
  type IsentropicExponent = Real (final quantity="IsentropicExponent", final unit= 
             "1") annotation();
  type Entropy = Real (final quantity="Entropy", final unit="J/K") annotation();
  type EntropyFlowRate = Real (final quantity="EntropyFlowRate", final unit="J/(K.s)") annotation();
  type SpecificEntropy = Real (final quantity="SpecificEntropy", 
                               final unit="J/(kg.K)") annotation();
  type InternalEnergy = Heat annotation();
  type Enthalpy = Heat annotation();
  type HelmholtzFreeEnergy = Heat annotation();
  type GibbsFreeEnergy = Heat annotation();
  type SpecificEnergy = Real (final quantity="SpecificEnergy", 
                              final unit="J/kg") annotation();
  type SpecificInternalEnergy = SpecificEnergy annotation();
  type SpecificEnthalpy = SpecificEnergy annotation();
  type SpecificHelmholtzFreeEnergy = SpecificEnergy annotation();
  type SpecificGibbsFreeEnergy = SpecificEnergy annotation();
  type MassieuFunction = Real (final quantity="MassieuFunction", final unit= 
          "J/K") annotation();
  type PlanckFunction = Real (final quantity="PlanckFunction", final unit="J/K") annotation();
  // added to ISO-chapter 4
  type DerDensityByEnthalpy = Real (final unit="kg.s2/m5") annotation();
  type DerDensityByPressure = Real (final unit="s2/m2") annotation();
  type DerDensityByTemperature = Real (final unit="kg/(m3.K)") annotation();
  type DerEnthalpyByPressure = Real (final unit="J.m.s2/kg2") annotation();
  type DerEnergyByDensity = Real (final unit="J.m3/kg") annotation();
  type DerEnergyByPressure = Real (final unit="J.m.s2/kg") annotation();
  type DerPressureByDensity = Real (final unit="Pa.m3/kg") annotation();
  type DerPressureByTemperature = Real (final unit="Pa/K") annotation();

  // Electricity and Magnetism (chapter 5 of ISO 31-1992)
  type ElectricCurrent = Real (final quantity="ElectricCurrent", final unit="A") annotation();
  type Current = ElectricCurrent annotation();
  type CurrentSlope = Real(final quantity="CurrentSlope", final unit="A/s") annotation();
  type ElectricCharge = Real (final quantity="ElectricCharge", final unit="C") annotation();
  type Charge = ElectricCharge annotation();
  type VolumeDensityOfCharge = Real (
      final quantity="VolumeDensityOfCharge", 
      final unit="C/m3", 
      min=0) annotation();
  type SurfaceDensityOfCharge = Real (
      final quantity="SurfaceDensityOfCharge", 
      final unit="C/m2", 
      min=0) annotation();
  type ElectricFieldStrength = Real (final quantity="ElectricFieldStrength", 
        final unit="V/m") annotation();
  type ElectricPotential = Real (final quantity="ElectricPotential", final unit= 
         "V") annotation();
  type Voltage = ElectricPotential annotation();
  type PotentialDifference = ElectricPotential annotation();
  type ElectromotiveForce = ElectricPotential annotation();
  type VoltageSecond = Real (final quantity="VoltageSecond", final unit="V.s") 
    "Voltage second" annotation();
  type VoltageSlope = Real(final quantity="VoltageSlope", final unit="V/s") annotation();
  type ElectricFluxDensity = Real (final quantity="ElectricFluxDensity", final unit= 
             "C/m2") annotation();
  type ElectricFlux = Real (final quantity="ElectricFlux", final unit="C") annotation();
  type Capacitance = Real (
      final quantity="Capacitance", 
      final unit="F", 
      min=0) annotation();
  type CapacitancePerArea = 
              Real (final quantity="CapacitancePerArea", final unit="F/m2") 
    "Capacitance per area" annotation();
  type Permittivity = Real (
      final quantity="Permittivity", 
      final unit="F/m", 
      min=0) annotation();
  type PermittivityOfVacuum = Permittivity annotation();
  type RelativePermittivity = Real (final quantity="RelativePermittivity", 
        final unit="1") annotation();
  type ElectricSusceptibility = Real (final quantity="ElectricSusceptibility", 
        final unit="1") annotation();
  type ElectricPolarization = Real (final quantity="ElectricPolarization", 
        final unit="C/m2") annotation();
  type Electrization = Real (final quantity="Electrization", final unit="V/m") annotation();
  type ElectricDipoleMoment = Real (final quantity="ElectricDipoleMoment", 
        final unit="C.m") annotation();
  type CurrentDensity = Real (final quantity="CurrentDensity", final unit= 
          "A/m2") annotation();
  type LinearCurrentDensity = Real (final quantity="LinearCurrentDensity", 
        final unit="A/m") annotation();
  type MagneticFieldStrength = Real (final quantity="MagneticFieldStrength", 
        final unit="A/m") annotation();
  type MagneticPotential = Real (final quantity="MagneticPotential", final unit="A") annotation();
  type MagneticPotentialDifference = Real (final quantity= 
          "MagneticPotential", final unit="A") annotation();
  type MagnetomotiveForce = Real (final quantity="MagnetomotiveForce", final unit= 
             "A") annotation();
  type CurrentLinkage = Real (final quantity="CurrentLinkage", final unit="A") annotation();
  type MagneticFluxDensity = Real (final quantity="MagneticFluxDensity", final unit= 
             "T") annotation();
  type MagneticFlux = Real (final quantity="MagneticFlux", final unit="Wb") annotation();
  type MagneticVectorPotential = Real (final quantity="MagneticVectorPotential", 
          final unit="Wb/m") annotation();
  type Inductance = Real (
      final quantity="Inductance", 
      final unit="H") annotation();
  type SelfInductance = Inductance(min=0) annotation();
  type MutualInductance = Inductance annotation();
  type CouplingCoefficient = Real (final quantity="CouplingCoefficient", final unit= 
             "1") annotation();
  type LeakageCoefficient = Real (final quantity="LeakageCoefficient", final unit= 
             "1") annotation();
  type Permeability = Real (final quantity="Permeability", final unit="H/m") annotation();
  type PermeabilityOfVacuum = Permeability annotation();
  type RelativePermeability = Real (final quantity="RelativePermeability", 
        final unit="1") annotation();
  type MagneticSusceptibility = Real (final quantity="MagneticSusceptibility", 
        final unit="1") annotation();
  type ElectromagneticMoment = Real (final quantity="ElectromagneticMoment", 
        final unit="A.m2") annotation();
  type MagneticDipoleMoment = Real (final quantity="MagneticDipoleMoment", 
        final unit="Wb.m") annotation();
  type Magnetization = Real (final quantity="Magnetization", final unit="A/m") annotation();
  type MagneticPolarization = Real (final quantity="MagneticPolarization", 
        final unit="T") annotation();
  type ElectromagneticEnergyDensity = Real (final quantity="EnergyDensity", 
        final unit="J/m3") annotation();
  type PoyntingVector = Real (final quantity="PoyntingVector", final unit= 
          "W/m2") annotation();
  type Resistance = Real (
      final quantity="Resistance", 
      final unit="Ohm") annotation();
  type Resistivity = Real (final quantity="Resistivity", final unit="Ohm.m") annotation();
  type Conductivity = Real (final quantity="Conductivity", final unit="S/m") annotation();
  type Reluctance = Real (final quantity="Reluctance", final unit="H-1") annotation();
  type Permeance = Real (final quantity="Permeance", final unit="H") annotation();
  type PhaseDifference = Real (
      final quantity="Angle", 
      final unit="rad", 
      displayUnit="deg") annotation();
  type Impedance = Resistance annotation();
  type ModulusOfImpedance = Resistance annotation();
  type Reactance = Resistance annotation();
  type QualityFactor = Real (final quantity="QualityFactor", final unit="1") annotation();
  type LossAngle = Real (
      final quantity="Angle", 
      final unit="rad", 
      displayUnit="deg") annotation();
  type Conductance = Real (
      final quantity="Conductance", 
      final unit="S") annotation();
  type Admittance = Conductance annotation();
  type ModulusOfAdmittance = Conductance annotation();
  type Susceptance = Conductance annotation();
  type InstantaneousPower = Real (final quantity="Power", final unit="W") annotation();
  type ActivePower = Real (final quantity="Power", final unit="W") annotation();
  type ApparentPower = Real (final quantity="Power", final unit="VA") annotation();
  type ReactivePower = Real (final quantity="Power", final unit="var") annotation();
  type PowerFactor = Real (final quantity="PowerFactor", final unit="1") annotation();
  type LinearTemperatureCoefficientResistance = Real (
    final quantity="LinearTemperatureCoefficientResistance", 
    final unit="Ohm/K") "First Order Temperature Coefficient" annotation();
  type QuadraticTemperatureCoefficientResistance = Real (
    final quantity="QuadraticTemperatureCoefficientResistance", 
    final unit="Ohm/K2") "Second Order Temperature Coefficient" annotation();

  // added to ISO-chapter 5
  type Transconductance = Real (final quantity="Transconductance", final unit= 
          "A/V2") annotation();
  type InversePotential = Real (final quantity="InversePotential", final unit= 
          "1/V") annotation();
  type ElectricalForceConstant = Real (
       final quantity="ElectricalForceConstant", 
       final unit = "N/A") annotation();

  // Light and Related Electromagnetic Radiations (chapter 6 of ISO 31-1992)
  type RadiantEnergy = Real (final quantity="Energy", final unit="J") annotation();
  type RadiantEnergyDensity = Real (final quantity="EnergyDensity", final unit= 
          "J/m3") annotation();
  type SpectralRadiantEnergyDensity = Real (final quantity= 
          "SpectralRadiantEnergyDensity", final unit="J/m4") annotation();
  type RadiantPower = Real (final quantity="Power", final unit="W") annotation();
  type RadiantEnergyFluenceRate = Real (final quantity= 
          "RadiantEnergyFluenceRate", final unit="W/m2") annotation();
  type RadiantIntensity = Real (final quantity="RadiantIntensity", final unit= 
          "W/sr") annotation();
  type Radiance = Real (final quantity="Radiance", final unit="W/(sr.m2)") annotation();
  type RadiantExtiance = Real (final quantity="RadiantExtiance", final unit= 
          "W/m2") annotation();
  type Irradiance = Real (final quantity="Irradiance", final unit="W/m2") annotation();
  type Emissivity = Real (final quantity="Emissivity", final unit="1") annotation();
  type SpectralEmissivity = Real (final quantity="SpectralEmissivity", final unit= 
             "1") annotation();
  type DirectionalSpectralEmissivity = Real (final quantity= 
          "DirectionalSpectralEmissivity", final unit="1") annotation();
  type LuminousIntensity = Real (final quantity="LuminousIntensity", final unit= 
         "cd") annotation();
  type LuminousFlux = Real (final quantity="LuminousFlux", final unit="lm") annotation();
  type QuantityOfLight = Real (final quantity="QuantityOfLight", final unit= 
          "lm.s") annotation();
  type Luminance = Real (final quantity="Luminance", final unit="cd/m2") annotation();
  type LuminousExitance = Real (final quantity="LuminousExitance", final unit= 
          "lm/m2") annotation();
  type Illuminance = Real (final quantity="Illuminance", final unit="lx") annotation();
  type LightExposure = Real (final quantity="LightExposure", final unit="lx.s") annotation();
  type LuminousEfficacy = Real (final quantity="LuminousEfficacy", final unit= 
          "lm/W") annotation();
  type SpectralLuminousEfficacy = Real (final quantity= 
          "SpectralLuminousEfficacy", final unit="lm/W") annotation();
  type LuminousEfficiency = Real (final quantity="LuminousEfficiency", final unit= 
             "1") annotation();
  type SpectralLuminousEfficiency = Real (final quantity= 
          "SpectralLuminousEfficiency", final unit="1") annotation();
  type CIESpectralTristimulusValues = Real (final quantity= 
          "CIESpectralTristimulusValues", final unit="1") annotation();
  type ChromaticityCoordinates = Real (final quantity="CromaticityCoordinates", 
          final unit="1") annotation();
  type SpectralAbsorptionFactor = Real (final quantity= 
          "SpectralAbsorptionFactor", final unit="1") annotation();
  type SpectralReflectionFactor = Real (final quantity= 
          "SpectralReflectionFactor", final unit="1") annotation();
  type SpectralTransmissionFactor = Real (final quantity= 
          "SpectralTransmissionFactor", final unit="1") annotation();
  type SpectralRadianceFactor = Real (final quantity="SpectralRadianceFactor", 
        final unit="1") annotation();
  type LinearAttenuationCoefficient = Real (final quantity= 
          "AttenuationCoefficient", final unit="m-1") annotation();
  type LinearAbsorptionCoefficient = Real (final quantity= 
          "LinearAbsorptionCoefficient", final unit="m-1") annotation();
  type MolarAbsorptionCoefficient = Real (final quantity= 
          "MolarAbsorptionCoefficient", final unit="m2/mol") annotation();
  type RefractiveIndex = Real (final quantity="RefractiveIndex", final unit="1") annotation();

  // Acoustics (chapter 7 of ISO 31-1992)
  type StaticPressure = AbsolutePressure annotation();
  type SoundPressure = StaticPressure annotation();
  type SoundParticleDisplacement = Real (final quantity="Length", final unit= 
          "m") annotation();
  type SoundParticleVelocity = Real (final quantity="Velocity", final unit= 
          "m/s") annotation();
  type SoundParticleAcceleration = Real (final quantity="Acceleration", final unit= 
             "m/s2") annotation();
  type VelocityOfSound = Real (final quantity="Velocity", final unit="m/s") annotation();
  type SoundEnergyDensity = Real (final quantity="EnergyDensity", final unit= 
          "J/m3") annotation();
  type SoundPower = Real (final quantity="Power", final unit="W") annotation();
  type SoundIntensity = Real (final quantity="SoundIntensity", final unit= 
          "W/m2") annotation();
  type AcousticImpedance = Real (final quantity="AcousticImpedance", final unit= 
         "Pa.s/m3") annotation();
  type SpecificAcousticImpedance = Real (final quantity= 
          "SpecificAcousticImpedance", final unit="Pa.s/m") annotation();
  type MechanicalImpedance = Real (final quantity="MechanicalImpedance", final unit= 
             "N.s/m") annotation();
  type SoundPressureLevel = Real (final quantity="SoundPressureLevel", final unit= 
             "dB") annotation();
  type SoundPowerLevel = Real (final quantity="SoundPowerLevel", final unit= 
          "dB") annotation();
  type DissipationCoefficient = Real (final quantity="DissipationCoefficient", 
        final unit="1") annotation();
  type ReflectionCoefficient = Real (final quantity="ReflectionCoefficient", 
        final unit="1") annotation();
  type TransmissionCoefficient = Real (final quantity="TransmissionCoefficient", 
          final unit="1") annotation();
  type AcousticAbsorptionCoefficient = Real (final quantity= 
          "AcousticAbsorptionCoefficient", final unit="1") annotation();
  type SoundReductionIndex = Real (final quantity="SoundReductionIndex", final unit= 
             "dB") annotation();
  type EquivalentAbsorptionArea = Real (final quantity="Area", final unit="m2") annotation();
  type ReverberationTime = Real (final quantity="Time", final unit="s") annotation();
  type LoudnessLevel = Real (final quantity="LoudnessLevel", final unit= 
          "phon") annotation();
  type Loudness = Real (final quantity="Loudness", final unit="sone") annotation();
  type LoundnessLevel = Real (final quantity="LoundnessLevel", final unit= 
          "phon") "Obsolete type, use LoudnessLevel instead!" annotation(
    obsolete = "Obsolete type - use Modelica.SIunits.LoudnessLevel instead");
  type Loundness = Real (final quantity="Loundness", final unit="sone") 
    "Obsolete type, use Loudness instead!" annotation(
    obsolete = "Obsolete type - use Modelica.SIunits.Loudness instead");

  // Physical chemistry and molecular physics (chapter 8 of ISO 31-1992)
  type RelativeAtomicMass = Real (final quantity="RelativeAtomicMass", final unit= 
             "1") annotation();
  type RelativeMolecularMass = Real (final quantity="RelativeMolecularMass", 
        final unit="1") annotation();
  type NumberOfMolecules = Real (final quantity="NumberOfMolecules", final unit= 
         "1") annotation();
  type AmountOfSubstance = Real (
      final quantity="AmountOfSubstance", 
      final unit="mol", 
      min=0) annotation();
  type MolarMass = Real (final quantity="MolarMass", final unit="kg/mol",min=0) annotation();
  type MolarVolume = Real (final quantity="MolarVolume", final unit="m3/mol", min=0) annotation();
  type MolarDensity = Real (final quantity="MolarDensity", unit="mol/m3") annotation();
  type MolarEnergy = Real (final quantity="MolarEnergy", final unit="J/mol", nominal=2e4) annotation();
  type MolarInternalEnergy = MolarEnergy annotation();
  type MolarHeatCapacity = Real (final quantity="MolarHeatCapacity", final unit= 
         "J/(mol.K)") annotation();
  type MolarEntropy = Real (final quantity="MolarEntropy", final unit= 
          "J/(mol.K)") annotation();
  type MolarEnthalpy = MolarEnergy annotation();
  type MolarFlowRate = Real (final quantity="MolarFlowRate", final unit= 
          "mol/s") annotation();
  type NumberDensityOfMolecules = Real (final quantity= 
          "NumberDensityOfMolecules", final unit="m-3") annotation();
  type MolecularConcentration = Real (final quantity="MolecularConcentration", 
        final unit="m-3") annotation();
  type MassConcentration = Real (final quantity="MassConcentration", final unit= 
         "kg/m3") annotation();
  type MassFraction = Real (final quantity="MassFraction", final unit="1", 
                            min=0, max=1) annotation();
  type Concentration = Real (final quantity="Concentration", final unit= 
          "mol/m3") annotation();
  type VolumeFraction = Real (final quantity="VolumeFraction", final unit="1") annotation();
  type MoleFraction = Real (final quantity="MoleFraction", final unit="1", 
                            min = 0, max = 1) annotation();
  type ChemicalPotential = Real (final quantity="ChemicalPotential", final unit= 
         "J/mol") annotation();
  type AbsoluteActivity = Real (final quantity="AbsoluteActivity", final unit= 
          "1") annotation();
  type PartialPressure = AbsolutePressure annotation();
  type Fugacity = Real (final quantity="Fugacity", final unit="Pa") annotation();
  type StandardAbsoluteActivity = Real (final quantity= 
          "StandardAbsoluteActivity", final unit="1") annotation();
  type ActivityCoefficient = Real (final quantity="ActivityCoefficient", final unit= 
             "1") annotation();
  type ActivityOfSolute = Real (final quantity="ActivityOfSolute", final unit= 
          "1") annotation();
  type ActivityCoefficientOfSolute = Real (final quantity= 
          "ActivityCoefficientOfSolute", final unit="1") annotation();
  type StandardAbsoluteActivityOfSolute = Real (final quantity= 
          "StandardAbsoluteActivityOfSolute", final unit="1") annotation();
  type ActivityOfSolvent = Real (final quantity="ActivityOfSolvent", final unit= 
         "1") annotation();
  type OsmoticCoefficientOfSolvent = Real (final quantity= 
          "OsmoticCoefficientOfSolvent", final unit="1") annotation();
  type StandardAbsoluteActivityOfSolvent = Real (final quantity= 
          "StandardAbsoluteActivityOfSolvent", final unit="1") annotation();
  type OsmoticPressure = Real (
      final quantity="Pressure", 
      final unit="Pa", 
      displayUnit="bar", 
      min=0) annotation();
  type StoichiometricNumber = Real (final quantity="StoichiometricNumber", 
        final unit="1") annotation();
  type Affinity = Real (final quantity="Affinity", final unit="J/mol") annotation();
  type MassOfMolecule = Real (final quantity="Mass", final unit="kg") annotation();
  type ElectricDipoleMomentOfMolecule = Real (final quantity= 
          "ElectricDipoleMomentOfMolecule", final unit="C.m") annotation();
  type ElectricPolarizabilityOfAMolecule = Real (final quantity= 
          "ElectricPolarizabilityOfAMolecule", final unit="C.m2/V") annotation();
  type MicrocanonicalPartitionFunction = Real (final quantity= 
          "MicrocanonicalPartitionFunction", final unit="1") annotation();
  type CanonicalPartitionFunction = Real (final quantity= 
          "CanonicalPartitionFunction", final unit="1") annotation();
  type GrandCanonicalPartitionFunction = Real (final quantity= 
          "GrandCanonicalPartitionFunction", final unit="1") annotation();
  type MolecularPartitionFunction = Real (final quantity= 
          "MolecularPartitionFunction", final unit="1") annotation();
  type StatisticalWeight = Real (final quantity="StatisticalWeight", final unit= 
         "1") annotation();
  type MeanFreePath = Length annotation();
  type DiffusionCoefficient = Real (final quantity="DiffusionCoefficient", 
        final unit="m2/s") annotation();
  type ThermalDiffusionRatio = Real (final quantity="ThermalDiffusionRatio", 
        final unit="1") annotation();
  type ThermalDiffusionFactor = Real (final quantity="ThermalDiffusionFactor", 
        final unit="1") annotation();
  type ThermalDiffusionCoefficient = Real (final quantity= 
          "ThermalDiffusionCoefficient", final unit="m2/s") annotation();
  type ElementaryCharge = Real (final quantity="ElementaryCharge", final unit= 
          "C") annotation();
  type ChargeNumberOfIon = Real (final quantity="ChargeNumberOfIon", final unit= 
         "1") annotation();
  type FaradayConstant = Real (final quantity="FaradayConstant", final unit= 
          "C/mol") annotation();
  type IonicStrength = Real (final quantity="IonicStrength", final unit= 
          "mol/kg") annotation();
  type DegreeOfDissociation = Real (final quantity="DegreeOfDissociation", 
        final unit="1") annotation();
  type ElectrolyticConductivity = Real (final quantity= 
          "ElectrolyticConductivity", final unit="S/m") annotation();
  type MolarConductivity = Real (final quantity="MolarConductivity", final unit= 
         "S.m2/mol") annotation();
  type TransportNumberOfIonic = Real (final quantity="TransportNumberOfIonic", 
        final unit="1") annotation();

  // Atomic and Nuclear Physics (chapter 9 of ISO 31-1992)
  type ProtonNumber = Real (final quantity="ProtonNumber", final unit="1") annotation();
  type NeutronNumber = Real (final quantity="NeutronNumber", final unit="1") annotation();
  type NucleonNumber = Real (final quantity="NucleonNumber", final unit="1") annotation();
  type AtomicMassConstant = Real (final quantity="Mass", final unit="kg") annotation();
  type MassOfElectron = Real (final quantity="Mass", final unit="kg") annotation();
  type MassOfProton = Real (final quantity="Mass", final unit="kg") annotation();
  type MassOfNeutron = Real (final quantity="Mass", final unit="kg") annotation();
  type HartreeEnergy = Real (final quantity="Energy", final unit="J") annotation();
  type MagneticMomentOfParticle = Real (final quantity= 
          "MagneticMomentOfParticle", final unit="A.m2") annotation();
  type BohrMagneton = MagneticMomentOfParticle annotation();
  type NuclearMagneton = MagneticMomentOfParticle annotation();
  type GyromagneticCoefficient = Real (final quantity="GyromagneticCoefficient", 
          final unit="A.m2/(J.s)") annotation();
  type GFactorOfAtom = Real (final quantity="GFactorOfAtom", final unit="1") annotation();
  type GFactorOfNucleus = Real (final quantity="GFactorOfNucleus", final unit= 
          "1") annotation();
  type LarmorAngularFrequency = Real (final quantity="AngularFrequency", final unit= 
             "s-1") annotation();
  type NuclearPrecessionAngularFrequency = Real (final quantity= 
          "AngularFrequency", final unit="s-1") annotation();
  type CyclotronAngularFrequency = Real (final quantity="AngularFrequency", 
        final unit="s-1") annotation();
  type NuclearQuadrupoleMoment = Real (final quantity="NuclearQuadrupoleMoment", 
          final unit="m2") annotation();
  type NuclearRadius = Real (final quantity="Length", final unit="m") annotation();
  type ElectronRadius = Real (final quantity="Length", final unit="m") annotation();
  type ComptonWavelength = Real (final quantity="Length", final unit="m") annotation();
  type MassExcess = Real (final quantity="Mass", final unit="kg") annotation();
  type MassDefect = Real (final quantity="Mass", final unit="kg") annotation();
  type RelativeMassExcess = Real (final quantity="RelativeMassExcess", final unit= 
             "1") annotation();
  type RelativeMassDefect = Real (final quantity="RelativeMassDefect", final unit= 
             "1") annotation();
  type PackingFraction = Real (final quantity="PackingFraction", final unit="1") annotation();
  type BindingFraction = Real (final quantity="BindingFraction", final unit="1") annotation();
  type MeanLife = Real (final quantity="Time", final unit="s") annotation();
  type LevelWidth = Real (final quantity="LevelWidth", final unit="J") annotation();
  type Activity = Real (final quantity="Activity", final unit="Bq") annotation();
  type SpecificActivity = Real (final quantity="SpecificActivity", final unit= 
          "Bq/kg") annotation();
  type DecayConstant = Real (final quantity="DecayConstant", final unit="s-1") annotation();
  type HalfLife = Real (final quantity="Time", final unit="s") annotation();
  type AlphaDisintegrationEnergy = Real (final quantity="Energy", final unit= 
          "J") annotation();
  type MaximumBetaParticleEnergy = Real (final quantity="Energy", final unit= 
          "J") annotation();
  type BetaDisintegrationEnergy = Real (final quantity="Energy", final unit="J") annotation();

  // Nuclear Reactions and Ionizing Radiations (chapter 10 of ISO 31-1992)
  type ReactionEnergy = Real (final quantity="Energy", final unit="J") annotation();
  type ResonanceEnergy = Real (final quantity="Energy", final unit="J") annotation();
  type CrossSection = Real (final quantity="Area", final unit="m2") annotation();
  type TotalCrossSection = Real (final quantity="Area", final unit="m2") annotation();
  type AngularCrossSection = Real (final quantity="AngularCrossSection", final unit= 
             "m2/sr") annotation();
  type SpectralCrossSection = Real (final quantity="SpectralCrossSection", 
        final unit="m2/J") annotation();
  type SpectralAngularCrossSection = Real (final quantity= 
          "SpectralAngularCrossSection", final unit="m2/(sr.J)") annotation();
  type MacroscopicCrossSection = Real (final quantity="MacroscopicCrossSection", 
          final unit="m-1") annotation();
  type TotalMacroscopicCrossSection = Real (final quantity= 
          "TotalMacroscopicCrossSection", final unit="m-1") annotation();
  type ParticleFluence = Real (final quantity="ParticleFluence", final unit= 
          "m-2") annotation();
  type ParticleFluenceRate = Real (final quantity="ParticleFluenceRate", final unit= 
             "s-1.m2") annotation();
  type EnergyFluence = Real (final quantity="EnergyFluence", final unit="J/m2") annotation();
  type EnergyFluenceRate = Real (final quantity="EnergyFluenceRate", final unit= 
         "W/m2") annotation();
  type CurrentDensityOfParticles = Real (final quantity= 
          "CurrentDensityOfParticles", final unit="m-2.s-1") annotation();
  type MassAttenuationCoefficient = Real (final quantity= 
          "MassAttenuationCoefficient", final unit="m2/kg") annotation();
  type MolarAttenuationCoefficient = Real (final quantity= 
          "MolarAttenuationCoefficient", final unit="m2/mol") annotation();
  type AtomicAttenuationCoefficient = Real (final quantity= 
          "AtomicAttenuationCoefficient", final unit="m2") annotation();
  type HalfThickness = Real (final quantity="Length", final unit="m") annotation();
  type TotalLinearStoppingPower = Real (final quantity= 
          "TotalLinearStoppingPower", final unit="J/m") annotation();
  type TotalAtomicStoppingPower = Real (final quantity= 
          "TotalAtomicStoppingPower", final unit="J.m2") annotation();
  type TotalMassStoppingPower = Real (final quantity="TotalMassStoppingPower", 
        final unit="J.m2/kg") annotation();
  type MeanLinearRange = Real (final quantity="Length", final unit="m") annotation();
  type MeanMassRange = Real (final quantity="MeanMassRange", final unit="kg/m2") annotation();
  type LinearIonization = Real (final quantity="LinearIonization", final unit= 
          "m-1") annotation();
  type TotalIonization = Real (final quantity="TotalIonization", final unit="1") annotation();
  type Mobility = Real (final quantity="Mobility", final unit="m2/(V.s)") annotation();
  type IonNumberDensity = Real (final quantity="IonNumberDensity", final unit= 
          "m-3") annotation();
  type RecombinationCoefficient = Real (final quantity= 
          "RecombinationCoefficient", final unit="m3/s") annotation();
  type NeutronNumberDensity = Real (final quantity="NeutronNumberDensity", 
        final unit="m-3") annotation();
  type NeutronSpeed = Real (final quantity="Velocity", final unit="m/s") annotation();
  type NeutronFluenceRate = Real (final quantity="NeutronFluenceRate", final unit= 
             "s-1.m-2") annotation();
  type TotalNeutronSourceDensity = Real (final quantity= 
          "TotalNeutronSourceDesity", final unit="s-1.m-3") annotation();
  type SlowingDownDensity = Real (final quantity="SlowingDownDensity", final unit= 
             "s-1.m-3") annotation();
  type ResonanceEscapeProbability = Real (final quantity= 
          "ResonanceEscapeProbability", final unit="1") annotation();
  type Lethargy = Real (final quantity="Lethargy", final unit="1") annotation();
  type SlowingDownArea = Real (final quantity="Area", final unit="m2") annotation();
  type DiffusionArea = Real (final quantity="Area", final unit="m2") annotation();
  type MigrationArea = Real (final quantity="Area", final unit="m2") annotation();
  type SlowingDownLength = Real (final quantity="SLength", final unit="m") annotation();
  type DiffusionLength = Length annotation();
  type MigrationLength = Length annotation();
  type NeutronYieldPerFission = Real (final quantity="NeutronYieldPerFission", 
        final unit="1") annotation();
  type NeutronYieldPerAbsorption = Real (final quantity= 
          "NeutronYieldPerAbsorption", final unit="1") annotation();
  type FastFissionFactor = Real (final quantity="FastFissionFactor", final unit= 
         "1") annotation();
  type ThermalUtilizationFactor = Real (final quantity= 
          "ThermalUtilizationFactor", final unit="1") annotation();
  type NonLeakageProbability = Real (final quantity="NonLeakageProbability", 
        final unit="1") annotation();
  type Reactivity = Real (final quantity="Reactivity", final unit="1") annotation();
  type ReactorTimeConstant = Real (final quantity="Time", final unit="s") annotation();
  type EnergyImparted = Real (final quantity="Energy", final unit="J") annotation();
  type MeanEnergyImparted = Real (final quantity="Energy", final unit="J") annotation();
  type SpecificEnergyImparted = Real (final quantity="SpecificEnergy", final unit= 
             "Gy") annotation();
  type AbsorbedDose = Real (final quantity="AbsorbedDose", final unit="Gy") annotation();
  type DoseEquivalent = Real (final quantity="DoseEquivalent", final unit="Sv") annotation();
  type AbsorbedDoseRate = Real (final quantity="AbsorbedDoseRate", final unit= 
          "Gy/s") annotation();
  type LinearEnergyTransfer = Real (final quantity="LinearEnergyTransfer", 
        final unit="J/m") annotation();
  type Kerma = Real (final quantity="Kerma", final unit="Gy") annotation();
  type KermaRate = Real (final quantity="KermaRate", final unit="Gy/s") annotation();
  type MassEnergyTransferCoefficient = Real (final quantity= 
          "MassEnergyTransferCoefficient", final unit="m2/kg") annotation();
  type Exposure = Real (final quantity="Exposure", final unit="C/kg") annotation();
  type ExposureRate = Real (final quantity="ExposureRate", final unit= 
          "C/(kg.s)") annotation();

  // chapter 11 is not defined in ISO 31-1992

  // Characteristic Numbers (chapter 12 of ISO 31-1992)
  type ReynoldsNumber = Real (final quantity="ReynoldsNumber", final unit="1") annotation();
  type EulerNumber = Real (final quantity="EulerNumber", final unit="1") annotation();
  type FroudeNumber = Real (final quantity="FroudeNumber", final unit="1") annotation();
  type GrashofNumber = Real (final quantity="GrashofNumber", final unit="1") annotation();
  type WeberNumber = Real (final quantity="WeberNumber", final unit="1") annotation();
  type MachNumber = Real (final quantity="MachNumber", final unit="1") annotation();
  type KnudsenNumber = Real (final quantity="KnudsenNumber", final unit="1") annotation();
  type StrouhalNumber = Real (final quantity="StrouhalNumber", final unit="1") annotation();
  type FourierNumber = Real (final quantity="FourierNumber", final unit="1") annotation();
  type PecletNumber = Real (final quantity="PecletNumber", final unit="1") annotation();
  type RayleighNumber = Real (final quantity="RayleighNumber", final unit="1") annotation();
  type NusseltNumber = Real (final quantity="NusseltNumber", final unit="1") annotation();
  type BiotNumber = NusseltNumber annotation();
  // The Biot number (Bi) is used when
  // the Nusselt number is reserved
  // for convective transport of heat.
  type StantonNumber = Real (final quantity="StantonNumber", final unit="1") annotation();
  type FourierNumberOfMassTransfer = Real (final quantity= 
          "FourierNumberOfMassTransfer", final unit="1") annotation();
  type PecletNumberOfMassTransfer = Real (final quantity= 
          "PecletNumberOfMassTransfer", final unit="1") annotation();
  type GrashofNumberOfMassTransfer = Real (final quantity= 
          "GrashofNumberOfMassTransfer", final unit="1") annotation();
  type NusseltNumberOfMassTransfer = Real (final quantity= 
          "NusseltNumberOfMassTransfer", final unit="1") annotation();
  type StantonNumberOfMassTransfer = Real (final quantity= 
          "StantonNumberOfMassTransfer", final unit="1") annotation();
  type PrandtlNumber = Real (final quantity="PrandtlNumber", final unit="1") annotation();
  type SchmidtNumber = Real (final quantity="SchmidtNumber", final unit="1") annotation();
  type LewisNumber = Real (final quantity="LewisNumber", final unit="1") annotation();
  type MagneticReynoldsNumber = Real (final quantity="MagneticReynoldsNumber", 
        final unit="1") annotation();
  type AlfvenNumber = Real (final quantity="AlfvenNumber", final unit="1") annotation();
  type HartmannNumber = Real (final quantity="HartmannNumber", final unit="1") annotation();
  type CowlingNumber = Real (final quantity="CowlingNumber", final unit="1") annotation();

  // Solid State Physics (chapter 13 of ISO 31-1992)
  type BraggAngle = Angle annotation();
  type OrderOfReflexion = Real (final quantity="OrderOfReflexion", final unit= 
          "1") annotation();
  type ShortRangeOrderParameter = Real (final quantity="RangeOrderParameter", 
        final unit="1") annotation();
  type LongRangeOrderParameter = Real (final quantity="RangeOrderParameter", 
        final unit="1") annotation();
  type DebyeWallerFactor = Real (final quantity="DebyeWallerFactor", final unit= 
         "1") annotation();
  type CircularWavenumber = Real (final quantity="CircularWavenumber", final unit= 
             "m-1") annotation();
  type FermiCircularWavenumber = Real (final quantity="FermiCircularWavenumber", 
          final unit="m-1") annotation();
  type DebyeCircularWavenumber = Real (final quantity="DebyeCircularWavenumber", 
          final unit="m-1") annotation();
  type DebyeCircularFrequency = Real (final quantity="AngularFrequency", final unit= 
             "s-1") annotation();
  type DebyeTemperature = ThermodynamicTemperature annotation();
  type SpectralConcentration = Real (final quantity="SpectralConcentration", 
        final unit="s/m3") annotation();
  type GrueneisenParameter = Real (final quantity="GrueneisenParameter", final unit= 
             "1") annotation();
  type MadelungConstant = Real (final quantity="MadelungConstant", final unit= 
          "1") annotation();
  type DensityOfStates = Real (final quantity="DensityOfStates", final unit= 
          "J-1/m-3") annotation();
  type ResidualResistivity = Real (final quantity="ResidualResistivity", final unit= 
             "Ohm.m") annotation();
  type LorenzCoefficient = Real (final quantity="LorenzCoefficient", final unit= 
         "V2/K2") annotation();
  type HallCoefficient = Real (final quantity="HallCoefficient", final unit= 
          "m3/C") annotation();
  type ThermoelectromotiveForce = Real (final quantity= 
          "ThermoelectromotiveForce", final unit="V") annotation();
  type SeebeckCoefficient = Real (final quantity="SeebeckCoefficient", final unit= 
             "V/K") annotation();
  type PeltierCoefficient = Real (final quantity="PeltierCoefficient", final unit= 
             "V") annotation();
  type ThomsonCoefficient = Real (final quantity="ThomsonCoefficient", final unit= 
             "V/K") annotation();
  type RichardsonConstant = Real (final quantity="RichardsonConstant", final unit= 
             "A/(m2.K2)") annotation();
  type FermiEnergy = Real (final quantity="Energy", final unit="eV") annotation();
  type GapEnergy = Real (final quantity="Energy", final unit="eV") annotation();
  type DonorIonizationEnergy = Real (final quantity="Energy", final unit="eV") annotation();
  type AcceptorIonizationEnergy = Real (final quantity="Energy", final unit= 
          "eV") annotation();
  type ActivationEnergy = Real (final quantity="Energy", final unit="eV") annotation();
  type FermiTemperature = ThermodynamicTemperature annotation();
  type ElectronNumberDensity = Real (final quantity="ElectronNumberDensity", 
        final unit="m-3") annotation();
  type HoleNumberDensity = Real (final quantity="HoleNumberDensity", final unit= 
         "m-3") annotation();
  type IntrinsicNumberDensity = Real (final quantity="IntrinsicNumberDensity", 
        final unit="m-3") annotation();
  type DonorNumberDensity = Real (final quantity="DonorNumberDensity", final unit= 
             "m-3") annotation();
  type AcceptorNumberDensity = Real (final quantity="AcceptorNumberDensity", 
        final unit="m-3") annotation();
  type EffectiveMass = Mass annotation();
  type MobilityRatio = Real (final quantity="MobilityRatio", final unit="1") annotation();
  type RelaxationTime = Time annotation();
  type CarrierLifeTime = Time annotation();
  type ExchangeIntegral = Real (final quantity="Energy", final unit="eV") annotation();
  type CurieTemperature = ThermodynamicTemperature annotation();
  type NeelTemperature = ThermodynamicTemperature annotation();
  type LondonPenetrationDepth = Length annotation();
  type CoherenceLength = Length annotation();
  type LandauGinzburgParameter = Real (final quantity="LandauGinzburgParameter", 
          final unit="1") annotation();
  type FluxiodQuantum = Real (final quantity="FluxiodQuantum", final unit="Wb") annotation();

  type TimeAging = Real (final quantity="1/Modelica.SIunits.Time",final unit="1/s") annotation();
  type ChargeAging = Real (final quantity="1/Modelica.SIunits.ElectricCharge",final unit="1/(A.s)") annotation();

 // Other types not defined in ISO 31-1992
  type PerUnit = Real(unit = "1") annotation();
  type DimensionlessRatio = Real(unit = "1") annotation();

 // Complex types for electrical systems (not defined in ISO 31-1992)
  operator record ComplexCurrent = 
    Complex(redeclare Modelica.SIunits.Current re "Real part of complex current", 
            redeclare Modelica.SIunits.Current im "Imaginary part of complex current") 
    "Complex electrical current" annotation();
  operator record ComplexCurrentSlope = 
    Complex(redeclare Modelica.SIunits.CurrentSlope re "Real part of complex current slope", 
            redeclare Modelica.SIunits.CurrentSlope im "Imaginary part of complex current slope") 
    "Complex current slope" annotation();
  operator record ComplexCurrentDensity = 
    Complex(redeclare Modelica.SIunits.CurrentDensity re "Real part of complex current density", 
            redeclare Modelica.SIunits.CurrentDensity im "Imaginary part of complex current density") 
    "Complex electrical current density" annotation();
  operator record ComplexElectricPotential = 
    Complex(redeclare Modelica.SIunits.ElectricPotential re "Imaginary part of complex electric potential", 
            redeclare Modelica.SIunits.ElectricPotential im "Real part of complex electrical potential") 
    "Complex electric potential" annotation();
  operator record ComplexPotentialDifference = 
    Complex(redeclare Modelica.SIunits.PotentialDifference re "Real part of complex potential difference", 
            redeclare Modelica.SIunits.PotentialDifference im "Imaginary part of complex potential difference") 
    "Complex electric potential difference" annotation();
  operator record ComplexVoltage = 
    Complex(redeclare Modelica.SIunits.Voltage re "Imaginary part of complex voltage", 
            redeclare Modelica.SIunits.Voltage im "Real part of complex voltage") 
    "Complex electrical voltage" annotation();
  operator record ComplexVoltageSlope = 
    Complex(redeclare Modelica.SIunits.VoltageSlope re "Real part of complex voltage slope", 
            redeclare Modelica.SIunits.VoltageSlope im "Imaginary part of complex voltage slope") 
    "Complex voltage slope" annotation();
  operator record ComplexElectricFieldStrength = 
    Complex(redeclare Modelica.SIunits.ElectricFieldStrength re "Real part of complex electric field strength", 
            redeclare Modelica.SIunits.ElectricFieldStrength im "Imaginary part of complex electric field strength") 
    "Complex electric field strength" annotation();
  operator record ComplexElectricFluxDensity = 
    Complex(redeclare Modelica.SIunits.ElectricFluxDensity re "Real part of complex electric flux density", 
            redeclare Modelica.SIunits.ElectricFluxDensity im "Imaginary part of complex electric flux density") 
    "Complex electric flux density" annotation();
  operator record ComplexElectricFlux = 
    Complex(redeclare Modelica.SIunits.ElectricFlux re "Real part of complex electric flux", 
            redeclare Modelica.SIunits.ElectricFlux im "Imaginary part of complex electric flux") 
    "Complex electric flux" annotation();
  operator record ComplexMagneticFieldStrength = 
    Complex(redeclare Modelica.SIunits.MagneticFieldStrength re "Real part of complex magnetic field strength", 
            redeclare Modelica.SIunits.MagneticFieldStrength im "Imaginary part of complex magnetic field strength") 
    "Complex magnetic field strength" annotation();
  operator record ComplexMagneticPotential = 
    Complex(redeclare Modelica.SIunits.MagneticPotential re "Real part of complex magnetic potential", 
            redeclare Modelica.SIunits.MagneticPotential im "Imaginary part of complex magnetic potential") 
    "Complex magnetic potential" annotation();
  operator record ComplexMagneticPotentialDifference = 
    Complex(redeclare Modelica.SIunits.MagneticPotentialDifference re "Real part of complex magnetic potential difference", 
            redeclare Modelica.SIunits.MagneticPotentialDifference im "Imaginary part of complex magnetic potential difference") 
    "Complex magnetic potential difference" annotation();
  operator record ComplexMagnetomotiveForce = 
    Complex(redeclare Modelica.SIunits.MagnetomotiveForce re "Real part of complex magnetomotive force", 
            redeclare Modelica.SIunits.MagnetomotiveForce im "Imaginary part of complex magnetomotive force") 
    "Complex magnetomotive force" annotation();
  operator record ComplexMagneticFluxDensity = 
    Complex(redeclare Modelica.SIunits.MagneticFluxDensity re "Real part of complex magnetic flux density", 
            redeclare Modelica.SIunits.MagneticFluxDensity im "Imaginary part of complex magnetic flux density") 
    "Complex magnetic flux density" annotation();
  operator record ComplexMagneticFlux = 
    Complex(redeclare Modelica.SIunits.MagneticFlux re "Real part of complex magnetic flux", 
            redeclare Modelica.SIunits.MagneticFlux im "Imaginary part of complex magnetic flux") 
    "Complex magnetic flux" annotation();
  operator record ComplexReluctance = 
    Complex(redeclare Modelica.SIunits.Reluctance re "Real part of complex reluctance", 
            redeclare Modelica.SIunits.Reluctance im "Imaginary part of complex reluctance") 
    "Complex reluctance" 
    annotation (Documentation(info="<html>
<p>
Since magnetic material properties like reluctance and permeance often are anisotropic resp. salient,
a special operator instead of multiplication (compare: tensor vs. vector) is required.
<a href=\"modelica://Modelica.Magnetic.FundamentalWave\">Modelica.Magnetic.FundamentalWave</a> uses a
special record <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>
which is only valid in the rotor-fixed coordinate system.
</p>
<p>
<strong>Note:</strong> To avoid confusion, no magnetic material properties should be defined as Complex units.
</p>
</html>"));
  operator record ComplexImpedance = 
    Complex(redeclare Resistance re "Real part of complex impedance (resistance)", 
            redeclare Reactance im "Imaginary part of complex impedance (reactance)") 
    "Complex electrical impedance" annotation();
  operator record ComplexAdmittance = 
    Complex(redeclare Conductance re "Real part of complex admittance (conductance)", 
            redeclare Susceptance im "Imaginary part of complex admittance (susceptance)") 
    "Complex electrical admittance" annotation();
  operator record ComplexPower = 
    Complex(redeclare ActivePower re "Real part of complex power (active power)", 
            redeclare ReactivePower im "Imaginary part of complex power (reactive power)") 
    "Complex electrical power" annotation();
  operator record ComplexPerUnit = 
    Complex(redeclare PerUnit re "Real part of complex per unit quantity", 
            redeclare PerUnit im "Imaginary part of complex per unit quantity") 
    "Complex per unit" annotation();
  annotation (Protection(hideFromBrowser=true),Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
      Polygon(
        fillColor = {128,128,128}, 
        pattern = LinePattern.None, 
        fillPattern = FillPattern.Solid, 
        points = {{-80,-40},{-80,-40},{-55,50},{-52.5,62.5},{-65,60},{-65,65},{-35,77.5},{-32.5,60},{-50,0},{-50,0},{-30,15},{-20,27.5},{-32.5,27.5},{-32.5,27.5},{-32.5,32.5},{-32.5,32.5},{2.5,32.5},{2.5,32.5},{2.5,27.5},{2.5,27.5},{-7.5,27.5},{-30,7.5},{-30,7.5},{-25,-25},{-17.5,-28.75},{-10,-25},{-5,-26.25},{-5,-32.5},{-16.25,-41.25},{-31.25,-43.75},{-40,-33.75},{-45,-5},{-45,-5},{-52.5,-10},{-52.5,-10},{-60,-40},{-60,-40}}, 
        smooth = Smooth.Bezier), 
      Polygon(
        fillColor = {128,128,128}, 
        pattern = LinePattern.None, 
        fillPattern = FillPattern.Solid, 
        points = {{87.5,30},{62.5,30},{62.5,30},{55,33.75},{36.25,35},{16.25,25},{7.5,6.25},{11.25,-7.5},{22.5,-12.5},{22.5,-12.5},{6.25,-22.5},{6.25,-35},{16.25,-38.75},{16.25,-38.75},{21.25,-41.25},{21.25,-41.25},{45,-48.75},{47.5,-61.25},{32.5,-70},{12.5,-65},{7.5,-51.25},{21.25,-41.25},{21.25,-41.25},{16.25,-38.75},{16.25,-38.75},{6.25,-41.25},{-6.25,-50},{-3.75,-68.75},{30,-76.25},{65,-62.5},{63.75,-35},{27.5,-26.25},{22.5,-20},{27.5,-15},{27.5,-15},{30,-7.5},{30,-7.5},{27.5,-2.5},{28.75,11.25},{36.25,27.5},{47.5,30},{53.75,22.5},{51.25,8.75},{45,-6.25},{35,-11.25},{30,-7.5},{30,-7.5},{27.5,-15},{27.5,-15},{43.75,-16.25},{65,-6.25},{72.5,10},{70,20},{70,20},{80,20}}, 
        smooth = Smooth.Bezier)}), Documentation(info="<html>
<p>This package provides predefined types, such as <em>Mass</em>,
<em>Angle</em>, <em>Time</em>, based on the international standard
on units, e.g.,
</p>

<pre>   <strong>type</strong> Angle = Real(<strong>final</strong> quantity = \"Angle\",
                     <strong>final</strong> unit     = \"rad\",
                     displayUnit    = \"deg\");
</pre>

<p>
Some of the types are derived SI units that are utilized in package Modelica
(such as ComplexCurrent, which is a complex number where both the real and imaginary
part have the SI unit Ampere).
</p>

<p>
Furthermore, conversion functions from non SI-units to SI-units and vice versa
are provided in subpackage
<a href=\"modelica://Modelica.SIunits.Conversions\">Conversions</a>.
</p>

<p>
For an introduction how units are used in the Modelica standard library
with package SIunits, have a look at:
<a href=\"modelica://Modelica.SIunits.UsersGuide.HowToUseSIunits\">How to use SIunits</a>.
</p>

<p>
Copyright &copy; 1998-2019, Modelica Association and contributors
</p>
</html>", revisions="<html>
<ul>
<li><em>May 25, 2011</em> by Stefan Wischhusen:<br/>Added molar units for energy and enthalpy.</li>
<li><em>Jan. 27, 2010</em> by Christian Kral:<br/>Added complex units.</li>
<li><em>Dec. 14, 2005</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Add User&#39;s Guide and removed &quot;min&quot; values for Resistance and Conductance.</li>
<li><em>October 21, 2002</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Christian Schweiger:<br/>Added new package <strong>Conversions</strong>. Corrected typo <em>Wavelenght</em>.</li>
<li><em>June 6, 2000</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Introduced the following new types<br/>type Temperature = ThermodynamicTemperature;<br/>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure<br/>Attribute &quot;final&quot; removed from min and max values in order that these values can still be changed to narrow the allowed range of values.<br/>Quantity=&quot;Stress&quot; removed from type &quot;Stress&quot;, in order that a type &quot;Stress&quot; can be connected to a type &quot;Pressure&quot;.</li>
<li><em>Oct. 27, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>New types due to electrical library: Transconductance, InversePotential, Damping.</li>
<li><em>Sept. 18, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.</li>
<li><em>Aug 12, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Type &quot;Pressure&quot; renamed to &quot;AbsolutePressure&quot; and introduced a new type &quot;Pressure&quot; which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.</li>
<li><em>June 29, 1999</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Bug-fix: Double definition of &quot;Compressibility&quot; removed and appropriate &quot;extends Heat&quot; clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
<li><em>April 8, 1998</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br/>Complete ISO 31 chapters realized.</li>
<li><em>Nov. 15, 1997</em> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Hubertus Tummescheit:<br/>Some chapters realized.</li>
</ul>
</html>"));
end SIunits;