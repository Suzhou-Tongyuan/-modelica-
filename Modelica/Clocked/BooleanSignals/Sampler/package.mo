within Modelica.Clocked.BooleanSignals;
package Sampler "布尔信号采样器和保持模块库"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
这个包含有标记时钟分区边界并将 <strong>Boolean</strong> 信号从一个分区转换到下一个分区的模块。
具体来说，提供了以下模块：
<br>&nbsp;
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\">
<tr><th align=\"left\"><strong>Boundary Type</strong></th>
    <th align=\"left\"><strong>Block Name</strong></th>
    <th align=\"left\"><strong>Description</strong></th></tr>

<tr><td valign=\"top\" rowspan=\"3\">continuous-time &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.Sample\">Sample</a></td>
      <td>Sample a continuous-time signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SampleClocked\">SampleClocked</a></td>
      <td>Sample and associate a clock to the sampled <strong>scalar</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SampleVectorizedAndClocked\">SampleVectorizedAndClocked</a></td>
      <td>Sample an input vector and associate a clock to the sampled <strong>vector</strong> signal.</td>
    </tr>

<tr><td valign=\"top\">clocked &rarr; continuous-time</td>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.Hold\">Hold</a></td>
      <td>Hold a clocked signal with zero-order hold.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"4\">clocked &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SubSample\">SubSample</a></td>
      <td>Sub-sample a signal (output clock is slower as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.SuperSample\">SuperSample</a></td>
      <td>Super-sample a signal (output clock is faster as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.ShiftSample\">ShiftSample</a></td>
      <td>Shift a signal (output clock is delayed with respect to input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.BackSample\">BackSample</a></td>
      <td>Shift a signal and start the output clock before the input clock with a start value.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"2\">within clocked partition</td>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.AssignClock\">AssignClock</a></td>
      <td>Assign a clock to a clocked <strong>scalar</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.AssignClockVectorized\">AssignClockVectorized</a></td>
      <td>Assign a clock to a clocked <strong>vector</strong> signal.</td>
    </tr>
</table>

<p>
Additionally, package
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.Utilities\">Utilities</a>
contains utility blocks that are used as building blocks for user-relevant blocks.
</p>
</html>"));
end Sampler;