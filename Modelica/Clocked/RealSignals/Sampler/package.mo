within Modelica.Clocked.RealSignals;
package Sampler "用于实数信号的采样器和保持模块库"
  extends Modelica.Icons.Package;

  annotation(Documentation(info = "<html><p>
<span style=\"color: rgb(51, 51, 51);\">该包包含标记时钟化分区边界的模块，并将实数信号从一个分区转换到下一个分区的块。特别提供了以下块：</span><br>
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\">
<tr><th align=\"left\"><strong>Boundary Type</strong></th>
    <th align=\"left\"><strong>Block Name</strong></th>
    <th align=\"left\"><strong>Description</strong></th></tr>

<tr><td valign=\"top\" rowspan=\"4\">continuous-time &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">Sample</a></td>
      <td>Sample a continuous-time signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleClocked\">SampleClocked</a></td>
      <td>Sample and associate a clock to the sampled <strong>scalar</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked\">SampleVectorizedAndClocked</a></td>
      <td>Sample an input vector and associate a clock to the sampled <strong>vector</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleWithADeffects\">SampleWithADeffects</a></td>
      <td>Sample with (simulated) Analog-Digital converter effects including noise.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"2\">clocked &rarr; continuous-time</td>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Hold\">Hold</a></td>
      <td>Hold a clocked signal with zero-order hold.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects\">HoldWithDAeffects</a></td>
      <td>Hold with (simulated) Digital-Analog converter effects and computational delay.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"5\">clocked &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SubSample\">SubSample</a></td>
      <td>Sub-sample a signal (output clock is slower as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSample\">SuperSample</a></td>
      <td>Super-sample a signal (output clock is faster as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated\">SuperSampleInterpolated</a></td>
      <td>Super-sample a signal with linear interpolation (output clock is faster as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.ShiftSample\">ShiftSample</a></td>
      <td>Shift a signal (output clock is delayed with respect to input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.BackSample\">BackSample</a></td>
      <td>Shift a signal and start the output clock before the input clock with a start value.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"2\">within clocked partition</td>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.AssignClock\">AssignClock</a></td>
      <td>Assign a clock to a clocked <strong>scalar</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.AssignClockVectorized\">AssignClockVectorized</a></td>
      <td>Assign a clock to a clocked <strong>vector</strong> signal.</td>
    </tr>
</table>
<p>

此外，<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities\" target=\"\">Utilities</a>&nbsp;软件包包含一些实用模块，这些模块用作用户相关模块的构建模块。 特别地，<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample\" target=\"\">UpSample</a>&nbsp;模块可以与<a href=\"modelica://Modelica.Clocked.RealSignals.Periodic.FIRbyCoefficients\" target=\"\">FIR filter</a>&nbsp;滤波器模块结合使用，用于模拟带插值和滤波的超采样。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end Sampler;