within Modelica.Clocked.IntegerSignals;
package Sampler "整数信号采样器和hold模块库"
  extends Modelica.Icons.Package;

  annotation(Documentation(info = "<html><p>
该软件包包含标记时钟分区边界和将 <strong>整型</strong>信号从一个分区转换到下一个分区的模块。特别是提供了以下模块： <br> 
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"3\">
<tr><th align=\"left\"><strong>Boundary Type</strong></th>
    <th align=\"left\"><strong>Block Name</strong></th>
    <th align=\"left\"><strong>Description</strong></th></tr>

<tr><td valign=\"top\" rowspan=\"3\">continuous-time &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.Sample\">Sample</a></td>
      <td>Sample a continuous-time signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.SampleClocked\">SampleClocked</a></td>
      <td>Sample and associate a clock to the sampled <strong>scalar</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.SampleVectorizedAndClocked\">SampleVectorizedAndClocked</a></td>
      <td>Sample an input vector and associate a clock to the sampled <strong>vector</strong> signal.</td>
    </tr>

<tr><td valign=\"top\">clocked &rarr; continuous-time</td>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.Hold\">Hold</a></td>
      <td>Hold a clocked signal with zero-order hold.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"4\">clocked &rarr; clocked</td>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.SubSample\">SubSample</a></td>
      <td>Sub-sample a signal (output clock is slower as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.SuperSample\">SuperSample</a></td>
      <td>Super-sample a signal (output clock is faster as input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.ShiftSample\">ShiftSample</a></td>
      <td>Shift a signal (output clock is delayed with respect to input clock).</td>
    </tr>

    <tr>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.BackSample\">BackSample</a></td>
      <td>Shift a signal and start the output clock before the input clock with a start value.</td>
    </tr>

<tr><td valign=\"top\" rowspan=\"2\">within clocked partition</td>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.AssignClock\">AssignClock</a></td>
      <td>Assign a clock to a clocked <strong>scalar</strong> signal.</td>
    </tr>
    <tr>
      <td><a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.AssignClockVectorized\">AssignClockVectorized</a></td>
      <td>Assign a clock to a clocked <strong>vector</strong> signal.</td>
    </tr>
</table>
<p>
此外，包<a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.Utilities\" target=\"\">Utilities</a>&nbsp;包含了一些工具模块，这些模块作为构建用户相关模块的基础构建块。
</p>
<p>
<br>
</p>
</html>"));
end Sampler;