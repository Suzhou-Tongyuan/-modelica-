within Modelica.Electrical.Machines.UsersGuide;
class Discrimination "机器模型的区分"
  extends Modelica.Icons.Information;
  annotation (
    preferredView="info", 
    Documentation(info="<html>
  <table>
  <thead>
  <tr>
  <th align=\"left\">机器类型</th>
  <th align=\"left\">瞬态模型</th>
  <th align=\"left\">准静态模型</th>
  </tr>
  </thead>
  <tbody>
  <tr>
  <td>变压器</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.Transformers\">Modelica.Electrical.Machines.BasicMachines.Transformers</a></td>
  <td><a href=\"modelica://Modelica.Electrical.QuasiStatic.Machines.BasicMachines.Transformers\">Modelica.Electrical.QuasiStatic.Machines.BasicMachines.Transformers</a></td>
  </tr>
  <tr>
  <td>直流电机</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines\">Modelica.Electrical.Machines.BasicMachines.DCMachines</a></td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines\">Modelica.Electrical.Machines.BasicMachines.QuasiStaticDCMachines</a></td>
  </tr>
  <tr>
  <td>三相感应电机（限制为三相）</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines\">Modelica.Electrical.Machines.BasicMachines.InductionMachines</a></td>
  <td>n/a</td>
  </tr>
  <tr>
  <td>三相同步电机（限制为三相）</td>
  <td><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines\">Modelica.Electrical.Machines.BasicMachines.SynchronousMachines</a></td>
  <td>n/a</td>
  </tr>
  <tr>
  <td>感应电机（任意相数）</td>
  <td><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines\">Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines</a></td>
  <td><a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines\">Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines</a></td>
  </tr>
  <tr>
  <td>同步电机（任意相数）</td>
  <td><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines\">Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines</a></td>
  <td><a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines\">Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines</a></td>
  </tr>
   </tbody>
  </table>

  <h4>注意</h4>
  <ul>
  <li>瞬态模型和准静态模型是参数兼容的。</li>
  <li>三相感应电机模型和任意相数的感应电机模型是参数兼容的。</li>
  <li>三相同步电机模型和任意相数的同步电机模型是参数兼容的。</li>
  </ul>
  </html>"));
end Discrimination;