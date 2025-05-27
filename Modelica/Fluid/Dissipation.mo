within Modelica.Fluid;
package Dissipation 
  "对流换热与压降特性关联函数"
    extends Modelica.Icons.BasesPackage;
  import PI = Modelica.Constants.pi;
  import REC = Modelica.Fluid.Dissipation.Utilities.Records;
  import TYP = Modelica.Fluid.Dissipation.Utilities.Types;

  package UsersGuide "用户指南"
    extends Modelica.Icons.Information;
    class GettingStarted "入门指南"
      extends Modelica.Icons.Information;

      annotation(Documentation(info = "<html><p>
</strong>
</p>
<strong>Fluid.Dissipation</strong> 库<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">为构建热液压能源系统提供了适用于多种能源设备的对流换热和压力损失（HTPL）关联式</span>。
</p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">本部分阐述如何将Fluid.Dissipation库提供的HTPL（换热与压降）函数集成至用户自定义应用模型</span>。
此外，您可在 Modelica.Fluid 中的热液压框架<a href=\"modelica://Modelica.Fluid.Fittings\" target=\"\">(参见 package Fittings)</a>&nbsp; &nbsp;<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">
中找到已集成完毕、可直接使用的应用模型</span> 。<br><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> &nbsp; &nbsp; </span><span style=\"font-size: 16px;\"> 下文以直管为例，
分五个步骤阐述该实现方法。此方法通常可通用于本库中所有HTPL（换热与压降）关联式的集成应用</span>。
</p>
<h4>步骤 1：使用/创建缺少压降关联的模型</h4><p>
对于<strong>不可压缩工况</strong>下使用压降计算的所有热水力系统，其模型均可建立。此时，压降 (DP) 将根据已知质量流量 (m_flow) 进行计算
</p>
<pre><code >DP = f(m_flow,...)
</code></pre><p>
或者<strong>可压缩情况</strong>，此时质量流量 (M_FLOW) 将根据已知压降 (dp) 进行计算
</p>
<pre><code >M_FLOW = f(dp,...).
</code></pre><p>
 无论何种工况，目标变量（<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">可压缩工况下的DP或不可压缩工况下的M_FLOW</span>）
 均作为对应输入变量（分别为 m_flow 或 dp）的函数进行计算。针对这两种工况的函数可以在库中找到， <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">具体路径为对应压降装置的子库，
 函数名通过下划线后缀标明其用途</span>（<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">可压缩计算使用functionname_MFLOW，
 不可压缩计算使用functionname_DP</span>）。
</p>
<p>
 <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">要构建简化的热液压模型，需将压降（dp）与质量流量（M_FLOW）定义为未知变量，
 此时二者间的函数关联式尚未定义。下文将以可压缩流动模型为例，阐述其具体实现方法</span>。
</p>
<pre><code >model straightPipe
//可压缩情况 M_FLOW = f(dp)
SI.Pressure dp \"输入压降\";
SI.MassFlowRate M_FLOW \"输出质量流量\";
end straightPipe

equation
end straightPipe
</code></pre><h4>步骤 2：选择所需的压降<strong>函数</strong></h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> &nbsp; &nbsp; &nbsp;HTPL（换热与压降）关联式以函数形式为多种设备建模。要获取直管的压降模型， 
可浏览</span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"><strong>Fluid.Dissipation</strong></span><span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">库并查找目标函数，此处路径为</span>：
</p>
<pre><code >Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW
</code></pre><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\"> &nbsp; &nbsp; &nbsp;此直管可压缩工况的HTPL（换热与压降）关联式需拖放至步骤1中模型方程层的方程部分</span>。
</p>
<pre><code >model straightPipe
//可压缩情况 M_FLOW = f(dp)
SI.Pressure dp \"输入压降\";
SI.MassFlowRate M_FLOW \"输出质量流量\";

equation
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW
end straightPipe
</code></pre><h4>步骤 3：选择对应的压降<strong>记录</strong></h4><p>
 &nbsp;步骤 2 中所选择的函数仍需通过记录表提供其对应的输入值。这些输入记录表分为两类：一类用于输入参数（如几何形状），另一类用于输入变量（如流体物性）。这些输入记录表的名称与对应的函数名相同，
 但通过后缀区分用途<strong>IN_con</strong> 用于参数输入记录，<strong>_IN_var</strong> 用于变量输入记录。<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">将所选函数对应的输入记录拖放至步骤1模型的图表层即可完成关联</span>。
</p>
<pre><code >输入参数记录表：
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con IN_con
输入变量记录表：
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var IN_var
</code></pre><p>
 &nbsp;此时，步骤 1 中模型的方程层应该如下形式（不含注释和注释标记）：
</p>
<pre><code >model straightPipe
...
//记录表
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con IN_con;
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var IN_var;

equation
Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW
end straightPipe
</code></pre><h4>步骤 4：建立函数-记录结构</h4><p>
 &nbsp;<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">此时需将输入记录分配至方程层中选定的函数。针对可压缩工况，最终构建的函数-记录结构如下所示</span>：
</p>
<pre><code >model straightPipe
...
equation
//可压缩情况
M_FLOW = Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW(IN_con,IN_var,dp);
end straightPipe
</code></pre><p>
 &nbsp;<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在此，可压缩工况下的未知质量流量（M_FLOW）通过热液压框架接口输出的已知压差（dp）计算得出，而输入记录（IN_con、IN_var）则提供诸如几何参数、流体物性等数据</span>。
</p>
<h4>步骤 5：分配记录变量</h4><p>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">最后一步需为函数的输入记录变量赋值。记录变量的赋值既可在图表层的记录中直接完成，亦可在方程层中进行。在方程层中对输入记录进行赋值后，模型将呈现如下形式</span>：
</p>
<pre><code >model straightPipe
...
//可压缩流体流动
//输入记录表

Fluid.Dissipation.Examples.Applications.PressureLoss.BaseClasses.StraightPipe.Overall.Pres
sureLossInput_con
IN_con(
d_hyd=d_hyd,
L=L,
roughness=roughness,
K=K);

Fluid.Dissipation.Examples.Applications.PressureLoss.BaseClasses.StraightPipe.Overall.Pres
sureLossInput_var
IN_var(
eta=eta,
rho=rho);
...
end straight Pipe;
</code></pre><p>
 &nbsp;<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">若在现有应用模型中实现HTPL（换热与压降）关联式， 需将步骤1中的未知变量（可压缩工况下的M_FLOW与dp，或不可压缩工况下的DP与m_flow）调整为模型变量（通常为接口变量）</span>。
 HTPL 关联式在<strong>Modelica.Fluid</strong> 中的实现可参考<a href=\"modelica://Modelica.Fluid.Fittings\" target=\"\">多个设备的流动模型</a>&nbsp;。
</p>
</html>"    ));
    end GettingStarted;

    class ReleaseNotes "发布说明"
      extends Modelica.Icons.ReleaseNotes;

      annotation(Documentation(info = "<html><h4>版本 1.0 Beta 4-6, 2010-01-12</h4><p>
Fluid.Dissipation <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在本次版本中进行了如下优化</span>：
</p>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">优化传热与压降函数的输入记录结构：</span></li>
<li>
减少了可压缩和不可压缩函数及其组合函数的输入记录表数量，以提高库的易用性。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">将单一函数的输入记录拆分为参数记录（如几何参数）与变量记录（如流体物性），以降低集成开发环境（IDE）求解器的计算负担</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">优化现有传热与压降函数在Modelica.Fluid中的应用模型</span>：</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">采用单一基础流动模型实现所有能源设备继承结构的扁平化</span>。</li>
<li>
<span style=\"font-size: 16px;\">已实现流体密度与动态黏度在逆流工况下的平滑状态处理</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">因结构变更，需对完整库进行适配调整</span>。</li>
<h4>版本 1.0 Beta 3, 2009-07-03</h4><p>
Fluid.Dissipation <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在本次版本中进行了如下优化</span>：
</p>
<li>
更改了流动模型结构：<br> &nbsp; &nbsp; &nbsp; <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">当前，
若集成开发环境（IDE）支持实现，未来版本将新增自动选择计算方式的功能：根据工况自动调用质量流量（可压缩工况）或压降（不可压缩工况）函数进行计算。
因此，Modelica.Fluid流动模型中不再支持手动选择可压缩或不可压缩计算模式。若未来该功能未实现，且流体端口已知量为质量流量而非压降，则Modelica.Fluid流动模型将生成非线性方程</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">因流动模型结构变更，已调整函数调用输入记录的结构与数量</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">因流动模型结构变更，已调整函数调用的结构</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">已完成所有可用传热与压降函数的验证工作</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">已包含用于验证所有可用传热与压降函数的脚本</span>。</li>
<h4>版本 1.0 Beta 2, 2009-04-22</h4><p>
Fluid.Dissipation <span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在本次版本中进行了如下优化</span>：
</p>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">在传热与压降函数的逆运算中支持解析雅克比矩阵（</span> Jacobian）。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">已集成适用于现有传热与压降函数的Modelica.Fluid应用模型</span>。</li>
<li>
<span style=\"color: rgba(0, 0, 0, 0.9); font-size: 16px;\">依据Modelica标准命名规范，对完整库进行适应性调整</span>。</li>
<h4>版本 1.0 Beta 1, 2008-10-08<br><br>Fluid.Dissipation 初次发布。<br><br></h4></html>"    ));
    end ReleaseNotes;

    class Contact "联系方式"
      extends Modelica.Icons.Contact;
      annotation(Documentation(info = "<html><h4>图书管理员和共同作者</h4><p>
<strong>斯特凡·维斯克胡森</strong><br> XRG Simulation GmbH<br> 德国汉堡<br> 电子邮箱: <a href=\"mailto:wischhusen@xrg-simulation.de\" target=\"\">wischhusen@xrg-simulation.de</a>&nbsp;
</p>
<h4>致谢</h4><p>
 以下人员为Modelica.Fluid.Dissipation库做出了贡献（按字母顺序排列）： Jörg Eiden, Ole Engel, Nina Peci, Sven Rutkowski, Thorben Vahlenkamp, Stefan Wischhusen。
</p>
<p>
 Modelica.Fluid.Dissipation库的开发由德国联邦教育和研究部（资助编号：01IS07022B）通过ITEA研究项目EuroSysLib-D资助。该项目始于2007年10月，并于2010年6月结束。
</p>
</html>"    ));
    end Contact;
    annotation (DocumentationClass=true, Documentation(info="<html><p>
用户指南包含以下子章节：
</p>
<li>
<a href=\"modelica://Modelica.Fluid.Dissipation.UsersGuide.GettingStarted\" target=\"\">Getting Started</a>&nbsp; </li>
<li>
<a href=\"modelica://Modelica.Fluid.Dissipation.UsersGuide.ReleaseNotes\" target=\"\">Release notes</a>&nbsp; </li>
<li>
<a href=\"modelica://Modelica.Fluid.Dissipation.UsersGuide.Contact\" target=\"\">Contact information</a>&nbsp; </li>
</html>"));
  end UsersGuide;

  package HeatTransfer "传热计算库"
  extends Modelica.Icons.VariantsPackage;
    package Channel
    extends Modelica.Icons.VariantsPackage;

      function kc_evenGapLaminar 
        "均匀间隙 | 层流状态 | 考虑边界层发展 | 单侧或双侧传热 | 相同且恒定的壁面温度 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con 
          IN_con "函数 kc_evenGapLaminar 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var 
          IN_var "函数 kc_evenGapLaminar 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap annotation();

        Real MIN = Modelica.Constants.eps;

        Real laminar = 2200 "层流区的最大雷诺数";

        SI.Area A_cross = IN_con.s * IN_con.h "间隙横截面积";
        SI.Diameter d_hyd = 2 * IN_con.s "水力直径";

        Real prandtlMax = if IN_con.target == TYP.UndevOne then 10 else if IN_con.target 
          == TYP.UndevBoth then 1000 else 0 "最大普朗特数";
        Real prandtlMin = if IN_con.target == TYP.UndevOne or IN_con.target == TYP.UndevBoth then 
          0.1 else 0 "最小普朗特数";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "间隙中的平均速度";

        //故障状态
        Real fstatus[2] "检查预期边界条件";

        //说明
      algorithm
        Pr := abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));
        Re := max(1, abs(IN_var.rho * velocity * d_hyd / max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(IN_con, 
          IN_var);
        Nu := kc * d_hyd / max(MIN, IN_var.lambda);

        //故障状态
        fstatus[1] := if Re > laminar then 1 else 0;
        fstatus[2] := if IN_con.target == TYP.UndevOne or IN_con.target == TYP.UndevBoth then 
          if Pr > prandtlMax or Pr < prandtlMin then 1 else 0 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation(Inline = false, Documentation(info = "<html>
<p>
在不同的流动和传热情况下，计算层流流体流经均匀间隙时的平均对流传热系数 <strong>kc</strong>。
需要注意的是，在该函数中还会观察故障状态，以检查是否满足预期的边界条件。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapLaminar\">查看更多信息</a>。
</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_evenGapLaminar;

      function kc_evenGapLaminar_KC 
        "均匀间隙 | 层流状态 | 考虑边界层发展 | 单侧或双侧传热 | 相同且恒定的壁面温度 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_con 
          IN_con "函数 kc_evenGapLaminar_KC 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_IN_var 
          IN_var "函数 kc_evenGapLaminar_KC 的输入记录表" 
          annotation(Dialog(group = "变量输入"));
        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_evenGapLaminar_KC";

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap annotation();

        Real MIN = Modelica.Constants.eps;

        SI.Area A_cross = max(MIN, IN_con.s * IN_con.h) 
          "间隙横截面积";
        SI.Diameter d_hyd = 2 * IN_con.s "水力直径";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "间隙中的平均速度";
        SI.ReynoldsNumber Re = (IN_var.rho * velocity * d_hyd / max(MIN, IN_var.eta));
        SI.PrandtlNumber Pr = abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));

        //平均努塞尔数变量
        //资料来源: p.Gb 7, eq. 36/37
        SI.NusseltNumber Nu_1 = if IN_con.target == TYP.DevOne or IN_con.target == TYP.UndevOne then 
          4.861 else if IN_con.target == TYP.DevBoth or IN_con.target == TYP.UndevBoth then 
          7.541 else 0 "第一努塞尔数";
        //资料来源: p.Gb 7, eq. 38
        SI.NusseltNumber Nu_2 = 1.841 * (Re * Pr * d_hyd / (max(IN_con.L, MIN))) ^ (1 / 3) 
          "第二努塞尔数";
        //资料来源: p.Gb 7, eq. 42
        SI.NusseltNumber Nu_3 = if IN_con.target == TYP.UndevOne or IN_con.target == 
          TYP.UndevBoth then (2 / (1 + 22 * Pr)) ^ (1 / 6) * (Re * Pr * d_hyd / (max(IN_con.L, MIN))) 
          ^ (0.5) else 0 "第三平均努塞尔数";
        SI.NusseltNumber Nu = ((Nu_1) ^ 3 + (Nu_2) ^ 3 + (Nu_3) ^ 3) ^ (1 / 3);

        //说明
      algorithm
        kc := Nu * ((IN_var.lambda / max(MIN, d_hyd)));
        annotation(Inline = false, Documentation(info = "<html>
<p>
在不同的流动和传热情况下，计算层流流体流经均匀间隙时的平均对流传热系数 <strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapLaminar\">查看更多信息</a>。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_evenGapLaminar_KC;

      record kc_evenGapLaminar_IN_con 
        "函数 kc_evenGapLaminar 和 kc_evenGapLaminar_KC 的输入记录表"
        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con;
        annotation(Documentation(info = "<html>
<p>
该记录用作传热函数
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar\"> kc_evenGapLaminar</a> 和
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC\"> kc_evenGapLaminar_KC</a>
的<strong>输入记录</strong>。
</p>
</html>"      ));
      end kc_evenGapLaminar_IN_con;

      record kc_evenGapLaminar_IN_var 
        "函数 kc_evenGapLaminar 和 kc_evenGapLaminar_KC 的输入记录表"

        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var;

        annotation (Documentation(info="<html>
<p>
该记录用作传热函数 
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar\"> kc_evenGapLaminar</a> 和 
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC\"> kc_evenGapLaminar_KC</a> 
的<strong>输入记录</strong>。
</p>
</html>"                        ));
      end kc_evenGapLaminar_IN_var;

      function kc_evenGapOverall 
        "均匀间隙 | 整体流动 | 考虑边界层发展 | 单侧或双侧传热 | 相同且恒定的壁面温度 | 表面粗糙度 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

        import MIN = Modelica.Constants.eps;
        // 引入 SMOOTH = Modelica.Fluid.Dissipation.Utilities.Functions.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con 
          IN_con "函数 kc_evenGapOverall 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var 
          IN_var "函数 kc_evenGapOverall 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap annotation();

        Real MIN = Modelica.Constants.eps;

        Real laminar = 2200 "层流区的最大雷诺数";
        Real turbulent = 1e4 "湍流区的最小雷诺数";

        SI.Area A_cross = IN_con.s * IN_con.h "间隙横截面积";
        SI.Diameter d_hyd = 2 * IN_con.s "水力直径";

        Real prandtlMax = if IN_con.target == TYP.UndevOne then 10 else if IN_con.target 
          == TYP.UndevBoth then 1000 else 0 "最大普朗特数";
        Real prandtlMin = if IN_con.target == TYP.UndevOne or IN_con.target == TYP.UndevBoth then 
          0.1 else 0 "最小普朗特数";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "间隙中的平均速度";

        //故障状态
        Real fstatus[2] "检查预期边界条件";

        //说明
      algorithm
        Pr := abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));
        Re := max(1e-3, abs(IN_var.rho * velocity * d_hyd / max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC(IN_con, IN_var);
        Nu := kc * d_hyd / max(MIN, IN_var.lambda);

        //故障状态
        fstatus[1] := if IN_con.target == TYP.UndevOne or IN_con.target == TYP.UndevBoth then 
          if Pr > prandtlMax or Pr < prandtlMin then 1 else 0 else 0;
        fstatus[2] := if d_hyd / IN_con.L > 1.0 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;

        annotation(Inline = false, smoothOrder(normallyConstant = IN_con) = 2, 
          Documentation(info = "<html>
<p>
在不同的流体流动和传热情况下，计算流体流经均匀间隙时的平均对流传热系数 <strong>kc</strong>。需要注意的是，在该功能中还会观察故障状态，以检查是否满足预期的边界条件。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapOverall\">查看更多信息</a>。
</p>
</html>"      ));
      end kc_evenGapOverall;

      function kc_evenGapOverall_KC 
        "均匀间隙 | 整体流动 | 考虑边界层发展 | 单侧或双侧传热 | 相同且恒定的壁面温度 | 表面粗糙度 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 6-10

        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con 
          IN_con "函数 kc_evenGapOverall_KC 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var 
          IN_var "函数 kc_evenGapOverall_KC 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_evenGapOverall_KC";

      protected
        Real MIN = Modelica.Constants.eps;

        Real laminar = 2200 "层流区的最大雷诺数";
        Real turbulent = 1e4 "湍流区的最小雷诺数";

        SI.Area A_cross = max(MIN, IN_con.s * IN_con.h) 
          "间隙横截面积";
        SI.Diameter d_hyd = 2 * IN_con.s "水力直径";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "间隙中的平均速度";
        SI.ReynoldsNumber Re = (IN_var.rho * velocity * d_hyd / max(MIN, IN_var.eta));
        SI.PrandtlNumber Pr = abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));

        kc_evenGapTurbulent_IN_con IN_con_turb(h = IN_con.h, s = IN_con.s, L = IN_con.L);
      algorithm
        kc := SMOOTH(
          laminar, 
          turbulent, 
          Re) * Dissipation.HeatTransfer.Channel.kc_evenGapLaminar_KC(
          IN_con, IN_var) + SMOOTH(
          turbulent, 
          laminar, 
          Re) * Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC(IN_con_turb, 
          IN_var);
        annotation(Inline = false, Documentation(info = "<html>
<p>
在不同的流体流动和传热情况下，计算流体流经均匀间隙时的平均对流传热系数 <strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapOverall\">查看更多信息</a>。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_evenGapOverall_KC;

      record kc_evenGapOverall_IN_con 
        "函数 kc_evenGapOverall 和 kc_evenGapOverall_KC 的输入记录表"
        //均匀间隙变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.EvenGap;
        annotation(Documentation(info = "<html>
<p>
该记录用作传热函数 
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall\"> kc_evenGapOverall</a> 和
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC\"> kc_evenGapOverall_KC</a> 
的<strong>输入记录</strong>。
</p>
</html>"      ));
      end kc_evenGapOverall_IN_con;

      record kc_evenGapOverall_IN_var 
        "函数 kc_evenGapOverall 和 kc_evenGapOverall_KC 的输入记录表"

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //输入变量（质量流量）
        SI.MassFlowRate m_flow annotation (Dialog(group="输入"));

        annotation (Documentation(info="<html>
<p>
该记录用作传热函数 
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall\"> kc_evenGapOverall</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_KC\"> kc_evenGapOverall_KC</a> 
的<strong>输入记录</strong>。
</p>
</html>"                              ));
      end kc_evenGapOverall_IN_var;

      function kc_evenGapTurbulent 
        "均匀间隙 | 湍流状态 | 湍流流动 | 两侧的传热 | 相同且恒定的壁面温度 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 7

        import MIN = Modelica.Constants.eps;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_con 
          IN_con "函数 kc_evenGapTurbulent 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_var 
          IN_var "函数 kc_evenGapTurbulent 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        Real MIN = Modelica.Constants.eps;

        Real prandtlMax = 100 "最大普朗特数";
        Real prandtlMin = 0.6 "最小普朗特数";
        Real turbulentMax = 1e6 
          "湍流区的最大雷诺数";
        Real turbulentMin = 3e4 
          "湍流区的最小雷诺数";

        SI.Area A_cross = max(MIN, IN_con.s * IN_con.h) 
          "间隙横截面积";
        SI.Diameter d_hyd = 2 * IN_con.s "水力直径";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "间隙中的平均速度";

        //故障状态
        Real fstatus[3] "检查预期边界条件";

        //说明
      algorithm
        Pr := abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));
        Re := max(1, abs(IN_var.rho * velocity * d_hyd / max(MIN, IN_var.eta)));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC(IN_con, 
          IN_var);
        Nu := kc * d_hyd / max(MIN, IN_var.lambda);

        //failure status
        fstatus[1] := if Re > turbulentMax or Re < turbulentMin then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;
        fstatus[3] := if d_hyd / max(MIN, IN_con.L) > 1.0 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation(Inline = false, Documentation(info = "<html>
<p>
在热量从两侧传递的情况下，计算通过均匀间隙的发达湍流流体的平均对流传热系数 <strong>kc</strong>。请注意，在此函数中还会观察到故障状态，以检查是否满足预期的边界条件。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapTurbulent\">查看更多信息</a>。
</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_evenGapTurbulent;

      function kc_evenGapTurbulent_KC 
        "均匀间隙 | 湍流状态 | 湍流流动 | 两侧的传热 | 相同且恒定的壁面温度 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Gb 7

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_con 
          IN_con "函数 kc_evenGapTurbulent_KC 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_IN_var 
          IN_var "函数 kc_evenGapTurbulent_KC 的输入记录表" 
          annotation (Dialog(group="变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_evenGapTurbulent_KC";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, IN_con.s*IN_con.h) 
          "间隙横截面积";
        SI.Diameter d_hyd=2*IN_con.s "水力直径";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross) 
          "间隙中的平均速度";
        SI.ReynoldsNumber Re=max(MIN,(IN_var.rho*velocity*d_hyd/max(MIN, IN_var.eta)));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        //资料来源: p.Ga 5, eq. 27
        Real zeta=1/max(MIN, 1.8*Modelica.Math.log10(abs(Re)) - 1.5)^2 
          "压力损失系数";

        //资料来源: p.Gb 5, eq. 26
        //根据 Gb 7, sec. 2.4 节的假设
        SI.NusseltNumber Nu=abs((zeta/8)*Re*Pr/(1 + 12.7*(zeta/8)^0.5*(Pr^(2/3) - 1)) 
            *(1 + (d_hyd/max(MIN, IN_con.L))^(2/3)));

        //说明
      algorithm
        kc := Nu*(IN_var.lambda/max(MIN, d_hyd));

      annotation (Inline=false, Documentation(info="<html>
<p>
计算通过均匀间隙的发展后的湍流流体在两侧传热时的平均对流传热系数 <strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapTurbulent\">查看更多信息</a>。
</p>
</html>"                                                ,       revisions="<html>
<p>2016-04-12 Stefan Wischhusen: Limited Re to very small value (Modelica.Constant.eps).</p>
</html>"                                                ), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_evenGapTurbulent_KC;

      record kc_evenGapTurbulent_IN_con 
        "函数 kc_evenGapTurbulent 和 kc_evenGapTurbulent_KC 的输入记录表"

        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_con(
          final target = Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevBoth);

        annotation(Documentation(info = "<html>
<p>
该记录用作传热函数 
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent\"> kc_evenGapTurbulent</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC\"> kc_evenGapTurbulent_KC</a> 
的<strong>输入记录</strong>。
</p>
</html>"      ));
      end kc_evenGapTurbulent_IN_con;

      record kc_evenGapTurbulent_IN_var 
        "函数 kc_evenGapTurbulent 和 kc_evenGapTurbulent_KC 的输入记录表"

        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapOverall_IN_var;

        annotation(Documentation(info = "<html>
<p>
该记录用作传热函数 
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent\"> kc_evenGapTurbulent</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent_KC\"> kc_evenGapTurbulent_KC</a> 
的<strong>输入记录</strong>。
</p>
</html>"      ));
      end kc_evenGapTurbulent_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>均匀间隙</h4>
<h5>层流</h5>
<p>
在不同的流动和传热情况下，计算层流流体流经均匀间隙时的平均对流传热系数 <strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapLaminar\">查看更多信息</a>。
</p>

<h5>湍流</h5>
<p>
在不同的流动和传热情况下，计算层流流体流经均匀间隙时的平均对流传热系数 <strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapLaminar\">查看更多信息</a>。
</p>

<h5>整体流</h5>
<p>
在不同的流动和传热情况下，计算层流流体流经均匀间隙时的平均对流传热系数 <strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Channel.kc_evenGapLaminar\">查看更多信息</a>。
</p>
</html>"            ));
    end Channel;

    package General
    extends Modelica.Icons.VariantsPackage;
      function kc_approxForcedConvection 
        "强制对流 | 近似值 | 湍流状态 | 流体力学发展流体流动 的平均对流传热系数"
        extends Modelica.Icons.Function;
        //资料来源: A Bejan and A.D. Kraus. Heat Transfer handbook.John Wiley & Sons, 2nd edition, 2003. (p.424 ff)
        //根据来源对方程进行注释

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con 
          IN_con "函数 kc_approxForcedConvection 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var 
          IN_var "函数 kc_approxForcedConvection 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_general annotation();

        Real MIN = Modelica.Constants.eps;

        Real prandtlMax[3] = {120, 16700, 500} "最大普朗特数";
        Real prandtlMin[3] = {0.7, 0.7, 1.5} "最小普朗特数";
        Real reynoldsMax[3] = {1.24e5, 1e6, 1e6} "最大雷诺数";
        Real reynoldsMin[3] = {2500, 1e4, 3e3} "最小雷诺数";

        SI.Diameter d_hyd = max(MIN, 4 * IN_con.A_cross / max(MIN, IN_con.perimeter)) 
          "水力直径";

        //故障状态
        Real fstatus[2] "检查预期边界条件";

      algorithm
        Pr := Modelica.Fluid.Dissipation.Utilities.Functions.General.PrandtlNumber(
          IN_var.cp, 
          IN_var.eta, 
          IN_var.lambda);
        Re := max(1, Modelica.Fluid.Dissipation.Utilities.Functions.General.ReynoldsNumber(
          IN_con.A_cross, 
          IN_con.perimeter, 
          IN_var.rho, 
          IN_var.eta, 
          abs(IN_var.m_flow))) "Reynolds number";
        kc := Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC(
          IN_con, IN_var);
        Nu := kc * d_hyd / max(MIN, IN_var.lambda);

        //故障状态
        fstatus[1] := if IN_con.target == TYP.Rough then if Pr > prandtlMax[1] or Pr 
          < prandtlMin[1] then 1 else 0 else if IN_con.target == TYP.Middle then if 
          Pr > prandtlMax[2] or Pr < prandtlMin[2] then 1 else 0 else if IN_con.target 
          == TYP.Finest then if Pr > prandtlMax[3] or Pr < prandtlMin[3] then 1 else 
          0 else 0;
        fstatus[2] := if IN_con.target == TYP.Rough then if Re > reynoldsMax[1] or Re 
          < reynoldsMin[1] then 1 else 0 else if IN_con.target == TYP.Middle then 
          if Re > reynoldsMax[2] or Re < reynoldsMin[2] then 1 else 0 else if IN_con.target 
          == TYP.Finest then if Re > reynoldsMax[3] or Re < reynoldsMin[3] then 1 else 
          0 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;

        annotation(Inline = false, Documentation(info = "<html><p>
强制对流的平均对流传热系数 <strong>kc</strong> 的近似计算，流体在湍流状态下充分流动。
</p>
<p>
对流换热计算的详细说明可在其基础函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC\" target=\"\">kc_approxForcedConvection_KC</a> 中找到。请注意，在该函数中还会观察到一个故障状态，以检查是否满足了预期的边界条件。 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.General.kc_approxForcedConvection\" target=\"\">查看更多信息</a> 。
</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_approxForcedConvection;

      function kc_approxForcedConvection_KC 
        "强制对流 | 近似值 | 湍流状态 | 流体力学发展流体流动 的平均对流传热系数"
        extends Modelica.Icons.Function;
        //资料来源: A Bejan and A.D. Kraus. Heat Transfer handbook.John Wiley & Sons, 2nd edition, 2003. (p.424 ff)
        //根据来源对方程进行注释

        //type =
        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_con 
          IN_con "函数 kc_approxForcedConvection_KC 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_IN_var 
          IN_var "函数 kc_approxForcedConvection_KC 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_approxForcedConvection_KC";

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.kc_general annotation();

        Real MIN = Modelica.Constants.eps;

        SI.Diameter d_hyd = max(MIN, 4 * IN_con.A_cross / max(MIN, IN_con.perimeter)) 
          "水力直径";

        SI.PrandtlNumber Pr = max(MIN, abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda))) 
          "普朗特数";
        SI.ReynoldsNumber Re = (4 * abs(IN_var.m_flow) / max(MIN, IN_con.perimeter * 
          IN_var.eta)) "雷诺数";

      algorithm
        kc := IN_var.lambda / d_hyd * (if IN_con.target == TYP.Rough then 0.023 * Re ^ (4 / 5) * 
          Pr ^ IN_con.exp_Pr else if IN_con.target == TYP.Middle then 0.023 * Re ^ (4 / 5) * Pr 
          ^ (1 / 3) * (IN_var.eta / IN_var.eta_wall) ^ 0.14 else if IN_con.target == TYP.Finest and Pr 
          <= 1.5 then 0.0214 * max(1, abs(Re ^ 0.8 - 100)) * Pr ^ 0.4 else if IN_con.target 
          == TYP.Finest then 0.012 * max(1, abs(Re ^ 0.87 - 280)) * Pr ^ 0.4 else 0);

        //说明

        annotation(Inline = false, Documentation(info = "<html><p>
强制对流的平均对流传热系数 <strong>kc</strong> 的近似计算，流体在湍流状态下充分流动。 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.General.kc_approxForcedConvection\" target=\"\">查看更多信息</a> 。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: Removed singularity for Re at zero mass flow rate.</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_approxForcedConvection_KC;

      record kc_approxForcedConvection_IN_con 
        "函数 kc_approxForcedConvection 和 kc_approxForcedConvection_KC 的输入记录表"
        //通用变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.General;
        parameter Real exp_Pr=0.4 
      "与 Dittus/Boelter有关的普朗特尔指数 | 0.4（加热） | 0.3（冷却）" 
      annotation (Dialog(group="Generic variables",enable=target == Modelica.Fluid.Dissipation.Utilities.Types.kc_general.Rough));

      annotation (Documentation(info="<html><p>
<br>该记录用作传热函数 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection\" target=\"\">kc_approxForcedConvection</a> &nbsp;和<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC\" target=\"\"> kc_approxForcedConvection_KC</a>. 的<strong>输入记录</strong>。<br>
</p>
</html>"  ,revisions="<html>
2016-06-06 Stefan Wischhusen: Corrected enable in dialog.
</html>"  ));
      end kc_approxForcedConvection_IN_con;

      record kc_approxForcedConvection_IN_var 
        "函数 kc_approxForcedConvection 和 kc_approxForcedConvection_KC 的输入记录表"
        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;
        SI.DynamicViscosity eta_wall 
          "壁温下的流体动力黏度" annotation(Dialog(group = 
          "流体性质", enable = target == 2));

        //输入变量（质量流量）
        SI.MassFlowRate m_flow annotation(Dialog(group = "输入"));

        annotation(Documentation(info = "<html><p>
<br>该记录用作传热函数 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection\" target=\"\">kc_approxForcedConvection</a> 和<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.General.kc_approxForcedConvection_KC\" target=\"\"> kc_approxForcedConvection_KC</a>.的<strong>输入记录</strong>。
</p>
</html>"      ));
      end kc_approxForcedConvection_IN_var;
    annotation (preferredView="info", Documentation(info="<html><h4>一般传热</h4><h5>近似强制对流</h5>
<p>
强制对流的平均对流传热系数 <strong>kc</strong> 的近似计算，流体在湍流状态下充分流动。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.General.kc_approxForcedConvection\" target=\"\">查看更多信息</a>。
</p>
</html>"      ));
    end General;

    package HeatExchanger
      extends Modelica.Icons.VariantsPackage;
      function kc_flatTube
        extends Modelica.Icons.Function;
        //资料来源: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

        //图标

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con 
          IN_con "函数 kc_flatTube 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var 
          IN_var "函数 kc_flatTube 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        type TYP = 
          Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_flatTubes annotation();

        SI.Area A_c = if IN_con.geometry == TYP.LouverFin then IN_con.A_fr * ((IN_con.F_l 
          - IN_con.delta_f) * (IN_con.F_p - IN_con.delta_f) / ((IN_con.F_l + IN_con.D_m) 
          * IN_con.F_p)) else if IN_con.geometry == TYP.RectangularFin then IN_con.A_fr 
          * (h * s / ((h + t + IN_con.D_m) * (s + t))) else 0 
          "最小流动横截面积";
        SI.Length h = if IN_con.geometry == TYP.RectangularFin then IN_con.D_h * (1 + 
          IN_con.alpha) / (2 * IN_con.alpha) else 0 "自由流高度";
        SI.Length l = if IN_con.geometry == TYP.RectangularFin then t / IN_con.delta else 
          0 "鳍片长度";
        SI.Length s = if IN_con.geometry == TYP.RectangularFin then h * IN_con.alpha else 
          0 "侧鳍间距（自由流动宽度）";
        SI.Length t = if IN_con.geometry == TYP.RectangularFin then s * IN_con.gamma else 
          0 "鳍片厚度";
      algorithm
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC(IN_con, 
          IN_var);
        Pr := abs(IN_var.eta * IN_var.cp / IN_var.lambda);

        if IN_con.geometry == TYP.LouverFin then
          Re := abs(IN_var.m_flow) * IN_con.L_p / (IN_var.eta * A_c);
          Nu := max(1e-3, kc * IN_con.L_p / IN_var.lambda);
        elseif IN_con.geometry == TYP.RectangularFin then
          Re := abs(IN_var.m_flow) * IN_con.D_h / (IN_var.eta * A_c);
          Nu := max(1e-3, kc * IN_con.D_h / IN_var.lambda);
        end if;

        failureStatus := if IN_con.geometry == TYP.LouverFin then if Re < 100 or Re 
          > 3000 then 1 else 0 else if IN_con.geometry == TYP.RectangularFin then 
          if Re < 300 or Re > 5000 then 1 else 0 else 0;

        annotation(Inline = false, Documentation(info = "<html>
<p>
计算具有平管和多种几何形状鳍片的换热器空气侧传热的平均对流传热系数<strong>kc</strong>。请注意，该函数中还观察到一个故障状态，以检查预期的边界条件是否满足。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_flatTube\">查看更多信息</a>。
</p>

</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 删除了零质量流量时 Re 的奇异性。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);

      end kc_flatTube;

      function kc_flatTube_KC
        extends Modelica.Icons.Function;
        //资料来源: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_con 
          IN_con "函数 kc_flatTube_KC 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_IN_var 
          IN_var "函数 kc_flatTube_KC 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_flatTubePlateFin_KC";

      protected
        type TYP = 
          Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_flatTubes annotation();

        Real MIN = Modelica.Constants.eps;
        Real Phi = IN_con.Phi * 180 / PI "散热孔角度";

        SI.ReynoldsNumber Re_Dh = max(MIN, (abs(IN_var.m_flow) * IN_con.D_h / (IN_var.eta * 
          A_c))) "基于水力直径的雷诺数";
        SI.ReynoldsNumber Re_Lp = max(MIN, (abs(IN_var.m_flow) * IN_con.L_p / (IN_var.eta * 
          A_c))) "基于散热孔距的雷诺数";
        SI.PrandtlNumber Pr = IN_var.eta * IN_var.cp / IN_var.lambda "普朗特数";
        Real j "Colburn j 系数";

        SI.Area A_c = if IN_con.geometry == TYP.LouverFin then IN_con.A_fr * ((IN_con.F_l 
          - IN_con.delta_f) * (IN_con.F_p - IN_con.delta_f) / ((IN_con.F_l + IN_con.D_m) 
          * IN_con.F_p)) else if IN_con.geometry == TYP.RectangularFin then IN_con.A_fr 
          * (h * s / ((h + t + IN_con.D_m) * (s + t))) else 0 
          "最小流动横截面积";
        SI.Length h = if IN_con.geometry == TYP.RectangularFin then IN_con.D_h * (1 + 
          IN_con.alpha) / (2 * IN_con.alpha) else 0 "自由流高度";
        SI.Length l = if IN_con.geometry == TYP.RectangularFin then t / IN_con.delta else 
          0 "鳍片长度";
        SI.Length s = if IN_con.geometry == TYP.RectangularFin then h * IN_con.alpha else 
          0 "侧鳍间距（自由流动宽度）";
        SI.Length t = if IN_con.geometry == TYP.RectangularFin then s * IN_con.gamma else 
          0 "鳍片厚度";

      algorithm
        if IN_con.geometry == TYP.LouverFin then
          j := Re_Lp ^ (-0.49) * (Phi / 90) ^ 0.27 * (IN_con.F_p / IN_con.L_p) ^ (-0.14) * (IN_con.F_l 
            / IN_con.L_p) ^ (-0.29) * (IN_con.T_d / IN_con.L_p) ^ (-0.23) * (IN_con.L_l / IN_con.L_p) 
            ^ 0.68 * (IN_con.T_p / IN_con.L_p) ^ (-0.28) * (IN_con.delta_f / IN_con.L_p) ^ (-0.05);
          kc := j * (Re_Lp * Pr ^ (1 / 3) * IN_var.lambda / IN_con.L_p);

        elseif IN_con.geometry == TYP.RectangularFin then
          j := 0.6522 * Re_Dh ^ (-0.5403) * (s / h) ^ (-0.1541) * (t / l) ^ 0.1499 * (t / s) ^ (-0.0678) * (1 
            + 5.269e-5 * Re_Dh ^ 1.340 * (s / h) ^ 0.504 * (t / l) ^ 0.456 * (t / s) ^ (-1.055)) ^ 0.1;
          kc := j * (Re_Dh * Pr ^ (1 / 3) * IN_var.lambda / IN_con.D_h);
        end if;
        annotation(Inline = false, Documentation(info = "<html>
<p>
计算具有平管和多种几何形状鳍片的换热器空气侧传热的平均对流传热系数<strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_flatTube\">查看更多信息</a>。
</p>
</html>"      , revisions = "<html>
<p>2016-04-12 Stefan Wischhusen: 将 Re_Dh 和 Re_Lp 限制在非常小的值（Modelica.Constant.eps）。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_flatTube_KC;

      record kc_flatTube_IN_con 
        "函数 kc_flatTube 和 kc_flatTube_KC 的输入记录表"
        extends Modelica.Icons.Record;

        Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_flatTubes 
          geometry = Dissipation.Utilities.Types.HTXGeometry_flatTubes.LouverFin 
          "鳍片几何形状的选择" annotation(Dialog(group = "换热"));

        SI.Area A_fr = 0 "正面区域" annotation(Dialog(group = "换热"));
        SI.Length D_h = 0 "水力直径" annotation(Dialog(group = "换热", 
          enable = geometry == 2));
        SI.Length D_m = 0 "扁管的主要管径" 
          annotation(Dialog(group = "换热"));
        SI.Length F_l = 0 "鳍片长度" annotation(Dialog(group = "换热", enable = 
          geometry == 1));
        SI.Length F_p = 0 "鳍片距，鳍片间距 + 鳍片厚度" annotation(Dialog(
          group = "换热", enable = geometry == 1));
        SI.Length L_l = 0 "散热孔长度" annotation(Dialog(group = "换热", 
          enable = geometry == 1));
        SI.Length L_p = 0 "散热孔距" annotation(Dialog(group = "换热", 
          enable = geometry == 1));
        SI.Length T_d = 0 "管道深度" annotation(Dialog(group = "换热", enable = 
          geometry == 1));
        SI.Length T_p = 0 "管间距" annotation(Dialog(group = "换热", enable = 
          geometry == 1));

        Real alpha = 0 "侧鳍间距 (s) / 自由流高度 (h)" annotation(
          Dialog(group = "Heat exchanger", enable = geometry == 2));
        Real gamma = 0 "鳍片厚度 (t) / 侧鳍片间距 (s)" annotation(Dialog(
          group = "换热", enable = geometry == 2));
        Real delta = 0 "鳍片厚度 (t) / 鳍片长度 (l)" annotation(Dialog(group = 
          "换热", enable = geometry == 2));
        SI.Length delta_f = 0 "鳍片厚度" annotation(Dialog(group = "换热", 
          enable = geometry == 1));
        SI.Angle Phi = 0 "散热孔角度" annotation(Dialog(group = "换热", 
          enable = geometry == 1));

      annotation(Documentation(info = "<html>
这个记录表用作平面管在对流换热中的函数 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube\"> kc_flatTube</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC\"> kc_flatTube_KC</a> 的<strong>输入记录</strong>。
</html>"                ));

      end kc_flatTube_IN_con;

      record kc_flatTube_IN_var 
        "函数 kc_flatTube 和 kc_flatTube_KC 的输入记录表"
        extends Modelica.Icons.Record;

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //输入变量（质量流量）
        SI.MassFlowRate m_flow annotation(Dialog(group = "输入"));

        annotation(Documentation(info = "<html>
这个记录表用作平面管在对流换热中的函数 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube\"> kc_flatTube</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_flatTube_KC\"> kc_flatTube_KC</a> 的<strong>输入记录</strong>。
</html>"      ));
      end kc_flatTube_IN_var;

      function kc_roundTube
        extends Modelica.Icons.Function;
        //资料来源: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con 
          IN_con "函数 kc_roundTube 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var 
          IN_var "函数 kc_roundTube 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        type TYP = 
          Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_roundTubes annotation();

        SI.Area A_c = IN_con.A_fr * ((IN_con.F_p * IN_con.P_t - IN_con.F_p * IN_con.D_c - (
          IN_con.P_t - IN_con.D_c) * IN_con.delta_f) / (IN_con.F_p * IN_con.P_t)) 
          "最小流动横截面积";
        SI.Area A_tot = if IN_con.geometry == TYP.LouverFin then IN_con.A_fr * ((IN_con.N 
          * PI * IN_con.D_c * (IN_con.F_p - IN_con.delta_f) + 2 * (IN_con.P_t * IN_con.L - 
          IN_con.N * PI * IN_con.D_c ^ 2 / 4)) / (IN_con.P_t * IN_con.F_p)) else 0 
          "总传热面积";
        SI.Length D_h = if IN_con.geometry == TYP.LouverFin then 4 * A_c * IN_con.L / A_tot else 
          0 "水力直径";

      /*SI.Length D_h=
      if IN_con.geometry==2 then
      4*A_c/(IN_con.A_fr*(2*(IN_con.P_t-IN_con.D_c+IN_con.F_p)/(IN_con.F_p*(IN_con.P_t-IN_con.D_c)))) else
      0 "水力直径";*/

      algorithm
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC(IN_con, 
          IN_var);
        Pr := abs(IN_var.eta * IN_var.cp / IN_var.lambda);

        if IN_con.geometry == TYP.PlainFin or IN_con.geometry == TYP.LouverFin or 
          IN_con.geometry == TYP.SlitFin or IN_con.geometry == TYP.WavyFin then
          Re := abs(IN_var.m_flow) * IN_con.D_c / (IN_var.eta * A_c);
          Nu := max(1e-3, kc * IN_con.D_c / IN_var.lambda);
        end if;

        failureStatus := if IN_con.geometry == TYP.PlainFin then if Re < 300 or Re > 
          8000 then 1 else 0 else if IN_con.geometry == TYP.LouverFin then if Re < 
          300 or Re > 7000 then 1 else 0 else if IN_con.geometry == TYP.SlitFin then 
          if Re < 400 or Re > 7000 then 1 else 0 else if IN_con.geometry == TYP.WavyFin then 
          if Re < 350 or Re > 7000 then 1 else 0 else 0;

      annotation(Inline = false, Documentation(info="<html><p>
计算具有圆管和多种几何形状鳍片的换热器空气侧传热的平均对流传热系数<strong>kc</strong>。请注意，在此函数中还会观察到故障状态，以检查预期的边界条件是否得到满足。 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_roundTube\" target=\"\">查看更多信息</a>。
</p>
</html>"            ,revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 消除零质量流量时 Re 的奇点。</p>
</html>"            ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_roundTube;

      function kc_roundTube_KC
        extends Modelica.Icons.Function;
        //资料来源: A.M. Jacobi, Y. Park, D. Tafti, X. Zhang. AN ASSESSMENT OF THE STATE OF THE ART, AND POTENTIAL DESIGN IMPROVEMENTS, FOR FLAT-TUBE HEAT EXCHANGERS IN AIR CONDITIONING AND REFRIGERATION APPLICATIONS - PHASE I

        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_con 
          IN_con "函数 kc_roundTube_KC 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_IN_var 
          IN_var "函数 kc_roundTube_KC 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_roundTube_KC";

      protected
        type TYP = 
          Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_roundTubes annotation();

        Real MIN = Modelica.Constants.eps;

        SI.ReynoldsNumber Re_Dc = max(MIN, (abs(IN_var.m_flow) * IN_con.D_c / (IN_var.eta * 
          A_c))) "基于鳍环直径的雷诺数";

        SI.ReynoldsNumber Re_i "波状鳍片过渡到线性化计算时的雷诺数";

        SI.PrandtlNumber Pr = IN_var.eta * IN_var.cp / IN_var.lambda "普朗特数";
        Real j "Colburn j 系数";

        SI.Area A_c = IN_con.A_fr * ((IN_con.F_p * IN_con.P_t - IN_con.F_p * IN_con.D_c - (
          IN_con.P_t - IN_con.D_c) * IN_con.delta_f) / (IN_con.F_p * IN_con.P_t)) 
          "最小流动横截面积";
        SI.Area A_tot = if IN_con.geometry == TYP.LouverFin then IN_con.A_fr * ((IN_con.N 
          * PI * IN_con.D_c * (IN_con.F_p - IN_con.delta_f) + 2 * (IN_con.P_t * IN_con.L - 
          IN_con.N * PI * IN_con.D_c ^ 2 / 4)) / (IN_con.P_t * IN_con.F_p)) else 0 
          "总换热面积";
        SI.Length D_h = if IN_con.geometry == TYP.LouverFin then 4 * A_c * IN_con.L / A_tot else 
          0 "水力直径";

        /*SI.Length D_h=
        if IN_con.geometry==2 then
        4*A_c/(IN_con.A_fr*(2*(IN_con.P_t-IN_con.D_c+IN_con.F_p-IN_con.delta_f)/(IN_con.F_p*IN_con.P_t))) else
        0 "水力直径";*/

        Real J1 = 0 "用于计算 Colburn j 系数指数";
        Real J2 = 0 "用于计算 Colburn j 系数指数";
        Real J3 = 0 "用于计算 Colburn j 系数指数";
        Real J4 = 0 "用于计算 Colburn j 系数指数";
        Real J5 = 0 "用于计算 Colburn j 系数指数";
        Real J6 = 0 "用于计算 Colburn j 系数指数";
        Real J7 = 0 "用于计算 Colburn j 系数指数";
        Real J8 = 0 "用于计算 Colburn j 系数指数";

      algorithm
        if IN_con.geometry == TYP.PlainFin then
          j := 0.991 * (2.24 * Re_Dc ^ (-0.092) * (IN_con.N / 4) ^ (-0.031)) ^ (0.607 * (4 - IN_con.N)) 
            * (0.14 * Re_Dc ^ (-0.328) * (IN_con.P_t / IN_con.P_l) ^ (-0.502) * (IN_con.F_p / IN_con.D_c) 
            ^ (0.0312)) * (2.55 * (IN_con.P_l / IN_con.D_c) ^ (-1.28));
          kc := j * (Re_Dc * Pr ^ (1 / 3) * IN_var.lambda / IN_con.D_c);

        elseif IN_con.geometry == TYP.LouverFin then
          if Re_Dc < 900 then
            J1 := -0.991 - 0.1055 * (IN_con.P_l / IN_con.P_t) ^ 3.1 * log(IN_con.L_h / IN_con.L_p);
            J2 := -0.7344 + 2.1059 * IN_con.N ^ 0.55 / (log(Re_Dc) - 3.2);
            J3 := 0.08485 * (IN_con.P_l / IN_con.P_t) ^ (-4.4) * IN_con.N ^ (-0.68);
            J4 := -0.1741 * log(IN_con.N);
            j := 14.3117 * Re_Dc ^ J1 * (IN_con.F_p / IN_con.D_c) ^ J2 * (IN_con.L_h / IN_con.L_p) ^ 
              J3 * (IN_con.F_p / IN_con.P_l) ^ J4 * (IN_con.P_l / IN_con.P_t) ^ (-1.724);
          elseif Re_Dc > 1100 then
            J5 := -0.6027 + 0.02593 * (IN_con.P_l / D_h) ^ 0.52 * IN_con.N ^ (-0.5) * log(IN_con.L_h 
              / IN_con.L_p);
            J6 := -0.4776 + 0.40774 * IN_con.N ^ 0.7 / (log(Re_Dc) - 4.4);
            J7 := -0.58655 * (IN_con.F_p / D_h) ^ 2.3 * (IN_con.P_l / IN_con.P_t) ^ (-1.6) * IN_con.N 
              ^ (-0.65);
            J8 := 0.0814 * (log(Re_Dc) - 3);
            j := 1.1373 * Re_Dc ^ J5 * (IN_con.F_p / IN_con.P_l) ^ J6 * (IN_con.L_h / IN_con.L_p) ^ 
              J7 * (IN_con.P_l / IN_con.P_t) ^ J8 * IN_con.N ^ 0.3545;
          else
            J1 := -0.991 - 0.1055 * (IN_con.P_l / IN_con.P_t) ^ 3.1 * log(IN_con.L_h / IN_con.L_p);
            J2 := -0.7344 + 2.1059 * IN_con.N ^ 0.55 / (log(Re_Dc) - 3.2);
            J3 := 0.08485 * (IN_con.P_l / IN_con.P_t) ^ (-4.4) * IN_con.N ^ (-0.68);
            J4 := -0.1741 * log(IN_con.N);
            J5 := -0.6027 + 0.02593 * (IN_con.P_l / D_h) ^ 0.52 * IN_con.N ^ (-0.5) * log(IN_con.L_h 
              / IN_con.L_p);
            J6 := -0.4776 + 0.40774 * IN_con.N ^ 0.7 / (log(Re_Dc) - 4.4);
            J7 := -0.58655 * (IN_con.F_p / D_h) ^ 2.3 * (IN_con.P_l / IN_con.P_t) ^ (-1.6) * IN_con.N 
              ^ (-0.65);
            J8 := 0.0814 * (log(Re_Dc) - 3);
            j := SMOOTH(
              900, 
              1100, 
              Re_Dc) * (14.3117 * Re_Dc ^ J1 * (IN_con.F_p / IN_con.D_c) ^ J2 * (IN_con.L_h / IN_con.L_p) 
              ^ J3 * (IN_con.F_p / IN_con.P_l) ^ J4 * (IN_con.P_l / IN_con.P_t) ^ (-1.724)) + 
              SMOOTH(
              1100, 
              900, 
              Re_Dc) * (1.1373 * Re_Dc ^ J5 * (IN_con.F_p / IN_con.P_l) ^ J6 * (IN_con.L_h / IN_con.L_p) 
              ^ J7 * (IN_con.P_l / IN_con.P_t) ^ J8 * IN_con.N ^ 0.3545);
          end if;
          kc := SMOOTH(
            100, 
            0, 
            Re_Dc) * j * (Re_Dc * Pr ^ (1 / 3) * IN_var.lambda / IN_con.D_c);

        elseif IN_con.geometry == TYP.SlitFin then
          J1 := -0.674 + 0.1316 * IN_con.N / log(Re_Dc) - 0.3769 * IN_con.F_p / IN_con.D_c - 
            1.8857 * IN_con.N / Re_Dc;
          J2 := -0.0178 + 0.996 * IN_con.N / log(Re_Dc) + 26.7 * IN_con.N / Re_Dc;
          J3 := 1.865 + 1244.03 * IN_con.F_p / (Re_Dc * IN_con.D_c) - 14.37 / log(Re_Dc);
          j := 1.6409 * Re_Dc ^ J1 * (IN_con.S_p / IN_con.S_h) ^ 1.16 * (IN_con.P_t / IN_con.P_l) ^ 
            1.37 * (IN_con.F_p / IN_con.D_c) ^ J2 * IN_con.N ^ J3;
          kc := j * (Re_Dc * Pr ^ (1 / 3) * IN_var.lambda / IN_con.D_c);

        elseif IN_con.geometry == TYP.WavyFin then
          Re_i := 2 * exp(2.921) ^ (1 / (A_c / IN_con.A_fr));  // 2 * turning point of the not linearized kc calculation
          if Re_Dc > Re_i then
            // 原始计算
            j := 1.201 / ((Modelica.Math.log(Re_Dc ^ (A_c / IN_con.A_fr))) ^ 2.921);
          else
            // 线性化计算，以避免在低雷诺数时 kc 增加，以及在 Re = 1 时除以零
            j := (Re_Dc - Re_i) * (-1.201 * 2.921 * (A_c / IN_con.A_fr) / ((Modelica.Math.log(Re_i ^ (A_c / IN_con.A_fr))) ^ 3.921 * Re_i)) + 1.201 / ((Modelica.Math.log(Re_i ^ (A_c / IN_con.A_fr))) ^ 2.921);
          end if;
          kc := j * (Re_Dc * Pr ^ (1 / 3) * IN_var.lambda / IN_con.D_c);



        end if;

      annotation(Inline = false, Documentation(info = "<html>
<p>
计算具有圆管和多种几何形状鳍片的换热器空气侧传热的平均对流传热系数<strong>kc</strong>。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_roundTube\">查看更多信息</a>。
</p>
</html>"                , revisions = "<html>
<p>2016-04-11 Sven Rutkowski: 通过波纹鳍片相关性中的线性化函数消除了零质量流量时 Re 的奇点。</p>
</html>"                ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_roundTube_KC;

      record kc_roundTube_IN_con 
        "函数 kc_roundTube 和 kc_roundTube_KC 的输入记录表"
        extends Modelica.Icons.Record;

        Modelica.Fluid.Dissipation.Utilities.Types.HTXGeometry_roundTubes 
          geometry = Dissipation.Utilities.Types.HTXGeometry_roundTubes.PlainFin 
          "鳍片几何形状的选择" annotation(Dialog(group = "换热"));

        SI.Area A_fr = 0 "正面区域" annotation(Dialog(group = "换热"));
        SI.Length D_c = 0 "鳍环直径" 
          annotation(Dialog(group = "换热"));
        SI.Length F_p = 0 "鳍片距，鳍片间距 + 鳍片厚度" 
          annotation(Dialog(group = "换热"));
        SI.Length L = 0 "换热长度" annotation(Dialog(group = 
          "换热", enable = geometry == 2));
        SI.Length L_h = 0 "散热孔高度" annotation(Dialog(group = "换热", 
          enable = geometry == 2));
        SI.Length L_p = 0 "散热孔距" annotation(Dialog(group = "换热", 
          enable = geometry == 2));
        Integer N = 0 "管道排数" annotation(Dialog(group = "换热", 
          enable = (geometry == 1 or geometry == 2 or geometry == 3)));
        SI.Length P_d = 0 "波状鳍的深度、波高" annotation(Dialog(
          group = "换热", enable = geometry == 4));
        SI.Length P_l = 0 "纵向管间距" annotation(Dialog(group = 
          "换热", enable = (geometry == 1 or geometry == 2 or geometry == 3)));
        SI.Length P_t = 0 "横向管间距" 
          annotation(Dialog(group = "换热"));
        SI.Length S_h = 0 "狭缝高度" annotation(Dialog(group = "换热", 
          enable = geometry == 3));
        SI.Length S_p = 0 "狭缝间距" annotation(Dialog(group = "换热", enable = 
          geometry == 3));
        SI.Length X_f = 0 "波状鳍的半波长" annotation(Dialog(group = 
          "换热", enable = geometry == 4));

        SI.Length delta_f = 0 "鳍片厚度" annotation(Dialog(group = "换热"));

        annotation(Documentation(info = "<html>
这个记录表用作圆管在对流换热中的函数 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube\"> kc_roundTube</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC\"> kc_roundTube_KC</a> 的<strong>输入记录</strong>。
</html>"      ));

      end kc_roundTube_IN_con;

      record kc_roundTube_IN_var 
        "函数 kc_roundTube 和 kc_roundTube_KC 的输入记录表"
        extends Modelica.Icons.Record;

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //输入变量（质量流量）
        SI.MassFlowRate m_flow annotation(Dialog(group = "输入"));

      annotation(Documentation(info = "<html>
这个记录表用作圆管在对流换热中的函数 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube\"> kc_roundTube</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HeatExchanger.kc_roundTube_KC\"> kc_roundTube_KC</a> 的<strong>输入记录</strong>。
</html>"                ));

      end kc_roundTube_IN_var;
    annotation(preferredView = "info", Documentation(info="<html><h4>热交换器</h4><h5>平管热交换器</h5><p>
计算具有平管和多种鳍片几何形状的热交换器空气侧传热的平均对流传热系数<strong>kc</strong>。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_flatTube\" target=\"\">查看更多信息</a>。
</p>
<h5>圆管热交换器</h5><p>
计算具有圆管和多种鳍片几何形状的热交换器空气侧传热的平均对流传热系数<strong>kc</strong>。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HeatExchanger.kc_roundTube\" target=\"\">查看更多信息</a>。
</p>
</html>"      ));
    end HeatExchanger;

    package HelicalPipe
    extends Modelica.Icons.VariantsPackage;
      function kc_laminar 
        "螺旋管 | 层流状态 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //根据资料来源的方程式符号

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con 
          IN_con "函数 kc_laminar 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var 
          IN_var "函数 kc_laminar 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        Real MIN = Modelica.Constants.eps;

        SI.Diameter d_hyd = IN_con.d_hyd "水力直径";
        SI.Area A_cross = PI * IN_con.d_hyd ^ 2 / 4 "圆形横截面积";
        SI.Diameter d_s = IN_con.L / (IN_con.n_nt * PI) "线圈平均直径";
        SI.Diameter d_w = sqrt(max(MIN, (d_s ^ 2 - (IN_con.h / PI) ^ 2))) 
          "螺旋管平均直径";
        SI.Diameter d_coil = max(d_w, d_w * (1 + (IN_con.h / (PI * d_w)) ^ 2)) 
          "螺旋管的平均曲率直径";
        SI.ReynoldsNumber Re_crit = 2300 * (1 + 8.6 * (IN_con.d_hyd / d_coil) ^ 0.45) 
          "临界雷诺数";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "平均速度";

        //故障状态
        Real fstatus[1] "检查预期边界条件";

        //说明
      algorithm
        Pr := abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));
        Re := abs(IN_var.rho * velocity * IN_con.d_hyd / max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC(IN_con, IN_var);
        Nu := kc * IN_con.d_hyd / max(MIN, IN_var.lambda);

        //故障状态
        fstatus[1] := if Re > Re_crit then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation(Inline = false, Documentation(info = "<html>
<p>
计算层流区中螺旋管的平均对流传热系数<strong>kc</strong>。注意，此函数还观察故障状态，以检查是否满足预期的边界条件。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_laminar\">查看更多信息</a>。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 通过波纹鳍片相关性中的线性化函数消除了零质量流量时 Re 的奇点。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_laminar;

      function kc_laminar_KC 
        "螺旋管 | 流体力学发展的层流区 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //根据资料来源的方程式符号

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_con 
          IN_con "函数 kc_laminar_KC 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_IN_var 
          IN_var "函数 kc_laminar_KC 的输入记录表" 
          annotation (Dialog(group="变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_laminar_KC";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=IN_con.d_hyd "水力直径";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "圆形横截面积";
        SI.Diameter d_s=IN_con.L/(IN_con.n_nt*PI) "线圈平均直径";
        SI.Diameter d_w=sqrt(max(MIN, (d_s^2 - (IN_con.h/PI)^2))) 
          "螺旋管平均直径";
        SI.Diameter d_coil=max(d_w, d_w*(1 + (IN_con.h/(PI*d_w))^2)) 
          "螺旋管的平均曲率直径";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross) 
          "平均速度";
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        Real m=0.5 + 0.2903*(IN_con.d_hyd/d_coil)^0.194 
          "实际雷诺数的指数";

        //说明
      algorithm
        kc := (IN_var.lambda/IN_con.d_hyd)*(3.66 + 0.08*(1 + 0.8*(IN_con.d_hyd/d_coil) 
          ^0.9)*Re^(m)*Pr^(1/3));
      annotation(Inline=false, Documentation(info="<html>
<p>
计算层流区中螺旋管的平均对流传热系数<strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_laminar\">查看更多信息</a>。
</p>
</html>"           , revisions="<html>
<blockquote><pre>2016-04-12 Stefan Wischhusen: 消除了零质量流量时 Re 的奇点。 </pre></blockquote>
</html>"          ), smoothOrder(normallyConstant= IN_con) = 2);
      end kc_laminar_KC;

      record kc_laminar_IN_con 
        "函数 kc_laminar 和 kc_laminar_KC 的输入记录表"

        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con;

      annotation (Documentation(info="<html>
此记录表被用作<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\">kc_laminar</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC\">kc_laminar_KC</a> 传热函数的<strong>输入记录表</strong>。
</html>"           ));
      end kc_laminar_IN_con;

      record kc_laminar_IN_var 
        "函数 kc_laminar 和 kc_laminar_KC 的输入记录表"

        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var;

      annotation (Documentation(info="<html>
此记录表被用作 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\">kc_laminar</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC\">kc_laminar_KC</a> 传热函数的<strong>输入记录表</strong>。
</html>"           ));

      end kc_laminar_IN_var;

      function kc_overall 
        "螺旋管 | 整体流 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //根据资料来源的方程式符号

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con 
          IN_con "函数 kc_overall 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var 
          IN_var "函数 kc_overall 的输入记录表" 
          annotation (Dialog(group="变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation (Dialog(group="输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation (Dialog(group="输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation (Dialog(group="输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation (Dialog(group="输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation (Dialog(group="输出"));

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "横截面积";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross) 
          "平均速度";

        //说明
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := (IN_var.rho*velocity*IN_con.d_hyd/max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC(IN_con, IN_var);
        Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

        failureStatus := 0;
      annotation(Inline=false, Documentation(info="<html>
<p>
计算在流体动力学上发展起来的层流区和湍流区中的螺旋管的平均对流传热系数<strong>kc</strong>。此外，还在此函数中观察了故障状态，以检查预期的边界条件是否得到满足。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_overall\">查看更多信息</a>。
</p>
</html>"                 , revisions="<html>
<p>2016-04-11 Stefan Wischhusen: 消除了零质量流量时 Re 的奇点。</p>
</html>"                ), smoothOrder(normallyConstant= IN_con) = 2);
      end kc_overall;

      function kc_overall_KC 
        "螺旋管 | 整体流 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //根据资料来源的方程式符号

        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con 
          IN_con "函数 kc_overall_KC 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var 
          IN_var "函数 kc_overall_KC 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_overall_KC";

      protected
        Real MIN=Modelica.Constants.eps;
        Real laminar=2e3 "层流区的最大雷诺数";
        Real turbulent=2.2e4 "湍流区的最小雷诺数";

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "Cross sectional area";
        SI.Diameter d_s=max(1e-6, IN_con.L/(IN_con.n_nt*PI)) 
          "线圈平均直径";
        SI.Diameter d_w=sqrt(max(MIN, abs(d_s^2 - (IN_con.h/PI)^2))) 
          "螺旋管平均直径";
        SI.Diameter d_coil=d_w*(1 + (IN_con.h/(PI*d_w))^2) 
          "螺旋管的平均曲率直径";
        SI.ReynoldsNumber Re_crit=min(4e3, 2300*(1 + 8.6*(IN_con.d_hyd/d_coil)^0.45)) 
          "临界雷诺数";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross) 
          "平均速度";
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*IN_con.d_hyd/max(MIN, 
            IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        //说明
      algorithm
        kc := SMOOTH(
                Re_crit, 
                turbulent, 
                Re)*Dissipation.HeatTransfer.HelicalPipe.kc_laminar_KC(IN_con, 
          IN_var) + SMOOTH(
                turbulent, 
                Re_crit, 
                Re)*Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC(IN_con, 
          IN_var);
      annotation (Inline=false, Documentation(info="<html>
<p>
计算在流体动力学上发展起来的层流区和湍流区中的螺旋管的平均对流传热系数<strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_overall\">查看更多信息</a>。
</p>
</html>"           , revisions="<html>
<p>2016-04-11 Stefan Wischhusen: 消除了零质量流量时 Re 的奇点。</p>
</html>"          ), smoothOrder(normallyConstant= IN_con) = 2);

      end kc_overall_KC;

      record kc_overall_IN_con 
        "函数 kc_overall 和 kc_overall_KC 的输入记录表"

        //螺旋管变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.HelicalPipe;

      annotation (Documentation(info="<html><p>
<br>此记录表被用作 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall\" target=\"\">kc_overall</a> 和<br><a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC\" target=\"\">kc_overall_KC</a> 传热函数的<strong>输入记录表</strong>。<br>
</p>
</html>"          ));
      end kc_overall_IN_con;

      record kc_overall_IN_var 
        "函数 kc_overall 和 kc_overall_KC 的输入记录表"

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //输入变量（质量流量）
        SI.MassFlowRate m_flow annotation (Dialog(group="输入"));

      annotation (Documentation(info="<html>
此记录表用作传热函数 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall\"> kc_overall</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_KC\"> kc_overall_KC</a> 的<strong>输入记录表</strong>。
</html>"                    ));
      end kc_overall_IN_var;

      function kc_turbulent 
        "螺旋管| 流体力学发展的湍流区 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //根据资料来源的方程式符号

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con 
          IN_con "函数 kc_turbulent 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var 
          IN_var "函数 kc_turbulent 的输入记录表" 
          annotation (Dialog(group="变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation (Dialog(group="输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation (Dialog(group="输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation (Dialog(group="输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation (Dialog(group="输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation (Dialog(group="输出"));

      protected
        Real MIN=Modelica.Constants.eps;

        Real turbulent=2.2e4 "湍流区的最小雷诺数";

        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "横截面积";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross) 
          "平均速度";

        //故障状态
        Real fstatus[1] "检查预期边界条件";

        //说明
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/IN_var.lambda);
        Re := abs(IN_var.rho*velocity*IN_con.d_hyd/IN_var.eta);
        kc := Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC(IN_con, IN_var);
        Nu := kc*IN_con.d_hyd/max(MIN, IN_var.lambda);

        //故障状态
        fstatus[1] := if Re < turbulent then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
      annotation (Inline=false, Documentation(info="<html>
<p>
计算螺旋管在湍流区中的平均对流换热系数 <strong>kc</strong>。此外，还观察此函数中的故障状态，以检查是否满足预期的边界条件。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_turbulent\">查看更多信息</a> .
</p>
</html>"                                , revisions="<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"                                ), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent;

      function kc_turbulent_KC 
        "螺旋管 | 流体力学发展的湍流区 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, section Gc1 - Gc2
        //根据资料来源的方程式符号

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_con 
          IN_con "函数 kc_turbulent_KC 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_IN_var 
          IN_var "函数 kc_turbulent_KC 的输入记录表" 
          annotation (Dialog(group="变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_turbulent_KC";

      protected
        Real MIN=Modelica.Constants.eps;
        Real turbulent=2.2e4 "湍流区的最小雷诺数";

        SI.Diameter d_hyd=IN_con.d_hyd "水力直径";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "圆形横截面积";
        SI.Diameter d_s=IN_con.L/(IN_con.n_nt*PI) "Mean coil diameter";
        SI.Diameter d_w=sqrt(max(MIN, (d_s^2 - (IN_con.h/PI)^2))) 
          "螺旋管平均直径";
        SI.Diameter d_coil=max(d_w, d_w*(1 + (IN_con.h/(PI*d_w))^2)) 
          "螺旋管的平均曲率直径";

        SI.Velocity velocity=abs(IN_var.m_flow)/max(MIN, IN_var.rho*A_cross) 
          "平均速度";
        SI.ReynoldsNumber Re=(IN_var.rho*velocity*IN_con.d_hyd/max(MIN, 
            IN_var.eta));
        SI.PrandtlNumber Pr=abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));

        Real zeta_TOT=0.3164*max(turbulent, Re)^(-0.25) + 0.03*sqrt(IN_con.d_hyd/ 
            d_coil) "压力损失系数";

        //说明
      algorithm
        kc := (IN_var.lambda/IN_con.d_hyd)*(zeta_TOT/8)*Re*Pr/(1 + 12.7*sqrt(zeta_TOT 
          /8)*(Pr^(2/3) - 1));
      annotation (Inline=false, Documentation(info="<html>
<p>
计算螺旋管在湍流区中的平均对流换热系数 <strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_turbulent\">查看更多信息</a> .
</p>
</html>"                                , revisions="<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"                                ), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent_KC;

      record kc_turbulent_IN_con 
        "函数 kc_turbulent 和 kc_turbulent_KC 的输入记录表"

        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_con;

      annotation (Documentation(info="<html>
这个记录用作螺旋管在湍流区中的对流换热函数 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">  kc_turbulent</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC\">  kc_turbulent_KC</a> 的<strong>输入记录</strong>。
</html>"                    ));
      end kc_turbulent_IN_con;

      record kc_turbulent_IN_var 
        "函数 kc_turbulent 和 kc_turbulent_KC 的输入记录表"

        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_overall_IN_var;

      annotation (Documentation(info="<html>
这个记录用作螺旋管在湍流流动 regime 中的对流换热函数 <a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">  kc_turbulent</a> 和
<a href=\"Modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent_KC\">  kc_turbulent_KC</a> 的<strong>输入记录</strong>。
</html>"                    ));
      end kc_turbulent_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>螺旋管</h4>
<h5>层流区</h5>
<p>计算层流区螺旋管的平均对流传热系数<strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_laminar\">查看更多信息</a>。</p>

<h5>湍流区</h5>
<p>计算湍流区螺旋管的平均对流传热系数<strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_turbulent\">查看更多信息</a>。</p>

<h5>整体流动</h5>
<p>计算螺旋管在水动力学上发展出的层流和湍流区的平均对流传热系数<strong>kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.HelicalPipe.kc_overall\">查看更多信息</a>。</p>
</html>"        ));
    end HelicalPipe;

    package Plate
    extends Modelica.Icons.VariantsPackage;

      function kc_laminar 
        "板 | 层流状态 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //根据资料来源的方程式符号

        //输入记录表
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_con 
          IN_con "函数 kc_laminar 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_var 
          IN_var "函数 kc_laminar 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        Real MIN = Modelica.Constants.eps;

        Real laminar = 1e5 "层流区的最大雷诺数";
        Real prandtlMax = 2000 "最大普朗特数";
        Real prandtlMin = 0.6 "最小普朗特数";

        //故障状态
        Real fstatus[2] "检查预期边界条件";

        //说明
      algorithm
        Pr := IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda);
        Re := abs(IN_var.rho * IN_var.velocity * IN_con.L / max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC(IN_con, IN_var);
        Nu := kc * IN_con.L / max(MIN, IN_var.lambda);

        //故障状态
        fstatus[1] := if Re > laminar then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation(Inline = false, Documentation(info = "<html><p>
计算均匀表面上层流流体流动的平均对流传热系数 <strong>kc</strong>。此外，还观察此函数中的故障状态，以检查是否满足预期的边界条件。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_laminar\" target=\"\">查看更多信息</a> 。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_laminar;

      function kc_laminar_KC 
        "板 | 层流状态 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //根据资料来源的方程式符号

        //输入记录表
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_con 
          IN_con "函数 kc_laminar_KC 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_IN_var 
          IN_var "函数 kc_laminar_KC 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_laminar_KC";

      protected
        Real MIN = Modelica.Constants.eps;

        SI.Length L = max(MIN, IN_con.L);

        SI.SpecificHeatCapacityAtConstantPressure cp = IN_var.cp;
        SI.DynamicViscosity eta = max(MIN, IN_var.eta);
        SI.ThermalConductivity lambda = max(MIN, IN_var.lambda);
        SI.Density rho = IN_var.rho;

        SI.Velocity velocity = abs(IN_var.velocity) "平均速度";
        SI.ReynoldsNumber Re = (rho * velocity * L / eta);
        SI.PrandtlNumber Pr = eta * cp / lambda;

        //说明
      algorithm
        kc := (lambda / L) * (0.664 * abs(Re) ^ 0.5 * Pr ^ (1 / 3));
        annotation(Inline = true, Documentation(info = "<html><p>
计算均匀表面上层流流体流动的平均对流传热系数<strong> kc</strong>。一般来说，在已知流体速度的情况下，该函数是计算平均对流传热系数<strong> kc</strong> 的最佳数值函数。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_laminar\" target=\"\">查看更多信息</a> 。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_laminar_KC;

      record kc_laminar_IN_con 
        "函数 kc_laminar 和 kc_laminar_KC 的输入记录表"
        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con;

      annotation (Documentation(info="<html><p>
该记录用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar\" target=\"\">kc_laminar </a>和 
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC\" target=\"\">kc_laminar_KC </a>的输入记录表。
</p>
</html>"              ));
      end kc_laminar_IN_con;

      record kc_laminar_IN_var 
        "函数 kc_laminar 和 kc_laminar_KC 的输入记录表"
        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var;

      annotation (Documentation(info="<html><p>
该记录用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar\" target=\"\">kc_laminar </a>和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC\" target=\"\">kc_laminar_KC </a>的输入记录表。
</p>
</html>"        ));
      end kc_laminar_IN_var;

      function kc_overall 
        "均热板 | 整体区域 | 恒定壁温 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //根据资料来源的方程式符号

        //输入记录表
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con 
          IN_con "函数 kc_overall 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var 
          IN_var "函数 kc_overall 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation (Dialog(group="输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation (Dialog(group="输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation (Dialog(group="输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation (Dialog(group="输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation (Dialog(group="输出"));

      protected
        Real MIN=Modelica.Constants.eps;

        Real prandtlMax=2000 "最大普朗特数";
        Real prandtlMin=0.6 "最小普朗特数";
        Real reynoldsMax=1e7 "最大雷诺数";
        Real reynoldsMin=1e1 "最小雷诺数";

        //故障状态
        Real fstatus[2] "检查预期边界条件";

        //说明
      algorithm
        Pr := IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda);
        Re := abs(IN_var.rho*IN_var.velocity*IN_con.L/max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC(IN_con, IN_var);
        Nu := kc*IN_con.L/max(MIN, IN_var.lambda);

        //故障状态
        fstatus[1] := if Re > reynoldsMax or Re < reynoldsMin then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
      annotation (Inline=false, Documentation(info="<html><p>
计算均匀表面上层流或湍流流体的平均对流传热系数 kc。此外，还观察此函数中的故障状态，以检查是否满足预期的边界条件。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_overall\" target=\"\">查看更多信息</a> .
</p>
</html>"        ,revisions="<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"        ), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_overall;

      function kc_overall_KC 
        "均热板 | 整体区域 | 恒定壁温 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //根据资料来源的方程式符号

        //输入记录表
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con 
          IN_con "函数 kc_overall_KC 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var 
          IN_var "函数 kc_overall_KC 的输入记录表" 
          annotation (Dialog(group="变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_overall_KC";

      protected
        SI.CoefficientOfHeatTransfer kc_lam= 
            Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar_KC(     IN_con, IN_var);
        SI.CoefficientOfHeatTransfer kc_turb= 
            Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC(     IN_con, IN_var);

        //说明
      algorithm
        kc := sqrt((kc_lam)^2 + (kc_turb)^2);
      annotation (Inline=true, Documentation(info="<html><p>
计算均匀表面上层流或湍流流体的平均对流传热系数 <strong>kc</strong>。一般来说，在已知流体速度的情况下，该函数是计算平均对流传热系数 <strong>kc</strong> 的最佳数值函数。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_overall\" target=\"\">查看更多信息</a> .
</p>
</html>"        ,revisions="<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"        ), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_overall_KC;

      record kc_overall_IN_con 
        "函数 kc_overall 和函数 kc_overall_KC 的输入记录表"
        //板变量
        extends Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.Plate;

      annotation (Documentation(info="<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall\" target=\"\">kc_overall</a> 和

<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC\" target=\"\">kc_overall_KC</a>的<strong>输入记录</strong>。
</p>
</html>"              ));
      end kc_overall_IN_con;

      record kc_overall_IN_var 
        "函数 kc_overall 和函数 kc_overall_KC 的输入记录表"
        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //输入变量（流体流速）
        SI.Velocity velocity annotation (Dialog(group="输入"));

      annotation (Documentation(info="<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall\" target=\"\">kc_overall</a> 和

<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_KC\" target=\"\">kc_overall_KC</a>的<strong>输入记录</strong>。
</p>
</html>"              ));
      end kc_overall_IN_var;

      function kc_turbulent 
        "均热板 | 湍流状态 | 恒定壁温 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //根据资料来源的方程式符号

        //输入记录表
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_con 
          IN_con "函数 kc_turbulent 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_var 
          IN_var "函数 kc_turbulent 的输入记录表" 
          annotation (Dialog(group="变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation (Dialog(group="输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation (Dialog(group="输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation (Dialog(group="输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation (Dialog(group="输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义s" 
          annotation (Dialog(group="输出"));

      protected
        Real MIN=Modelica.Constants.eps;

        Real prandtlMax=2000 "最大普朗特数";
        Real prandtlMin=0.6 "最小普朗特数";
        Real reynoldsMax=1e7 "最大雷诺数";
        Real reynoldsMin=5e5 "最小雷诺数";

        //故障状态
        Real fstatus[2] "检查预期边界条件";

        //说明
      algorithm
        Pr := abs(IN_var.eta*IN_var.cp/max(MIN, IN_var.lambda));
        Re := abs(IN_var.rho*IN_var.velocity*IN_con.L/max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC(IN_con, IN_var);
        Nu := kc*IN_con.L/max(MIN, IN_var.lambda);

        //故障状态
        fstatus[1] := if Re > reynoldsMax or Re < reynoldsMin then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
      annotation (Inline=false, Documentation(info="<html><p>
计算均匀表面上的流体力学发展的湍流的平均对流传热系数 kc。此外，还观察此函数中的故障状态，以检查是否满足预期的边界条件。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_turbulent\" target=\"\">查看更多信息</a> .
</p>
</html>"        ,revisions="<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"        ), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent;

      function kc_turbulent_KC 
        "均热板 | 湍流状态 | 恒定壁温 的平均传热系数"
        extends Modelica.Icons.Function;
        //资料来源: VDI-Waermeatlas, Aufl. 9, Springer-Verlag, 2002, Section Gd 1
        //根据资料来源的方程式符号

        //输入记录表
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_con 
          IN_con "函数 kc_turbulent_KC 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_IN_var 
          IN_var "函数 kc_turbulent_KC 的输入记录表" 
          annotation (Dialog(group="变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数  kc_turbulent_KC";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Length L=max(MIN, IN_con.L);

        SI.SpecificHeatCapacityAtConstantPressure cp=IN_var.cp;
        SI.DynamicViscosity eta=IN_var.eta;
        SI.ThermalConductivity lambda=max(MIN, IN_var.lambda);
        SI.Density rho=IN_var.rho;

        SI.Velocity velocity=abs(IN_var.velocity) "平均速度";
        SI.ReynoldsNumber Re=abs(rho*velocity*L/eta);
        SI.PrandtlNumber Pr=abs(eta*cp/lambda);

        //说明
      algorithm
        kc := abs((lambda/L))*(0.037*Re^0.8*Pr)/(1 + 2.443/(max(Re^0.1, 1e-6))*(Pr^(2 
          /3) - 1));
      annotation (Inline=true, Documentation(info="<html><p>
计算均匀表面上的流体力学发展的湍流的平均对流传热系数 <strong>kc</strong>。一般来说，在已知流体速度的情况下，该函数是计算平均对流传热系数 <strong>kc</strong> 的最佳数值函数。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_turbulent\" target=\"\">查看更多信息</a> .
</p>
</html>"              ,revisions="<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"              ), smoothOrder(normallyConstant=IN_con) = 2);
      end kc_turbulent_KC;

      record kc_turbulent_IN_con 
        "函数 kc_turbulent 和 kc_turbulent_KC 的输入记录表"
        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_con;

      annotation (Documentation(info="<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent\" target=\"\">kc_turbulent</a> 和

&nbsp;<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC\" target=\"\">kc_turbulent_KC</a>的输入记录。<br>
</p>
</html>"              ));
      end kc_turbulent_IN_con;

      record kc_turbulent_IN_var 
        "函数 kc_turbulent 和 kc_turbulent_KC 的输入记录表"
        extends Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_overall_IN_var;

      annotation (Documentation(info="<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent\" target=\"\">kc_turbulent</a> 和

&nbsp;<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent_KC\" target=\"\">kc_turbulent_KC</a>的输入记录。<br>
</p>
</html>"              ));
      end kc_turbulent_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>均匀板</h4>
<h5>层流区</h5>
<p>计算均匀表面上层流流体流动的平均对流传热系数<strong>kc</strong>。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_laminar\">查看更多信息</a>。</p>

<h5>湍流区</h5>
<p>计算均匀表面上水动力学发展出的湍流流体流动的平均对流传热系数<strong>kc</strong>。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_turbulent\">查看更多信息</a>。</p>

<h5>整体流动</h5>
<p>计算均匀表面上层流和湍流流体流动的平均对流传热系数<strong>kc</strong>。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_overall\">查看更多信息</a>。</p>
</html>"                ));

    end Plate;

    package StraightPipe
    extends Modelica.Icons.VariantsPackage;

      function kc_laminar 
        "直管 | 均匀的管壁温度或均匀的热通量 | 流体动力学发达或不发达的层流状态 的平均传热系数"
        extends Modelica.Icons.Function;
        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con 
          IN_con "函数 kc_laminar 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var 
          IN_var "函数 kc_laminar 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        Real MIN = Modelica.Constants.eps;

        Real laminar = 2e3 "层流区的最大雷诺数";
        Real prandtlMax = 1000 "最大普朗特数";
        Real prandtlMin = 0.6 "最小普朗特数";

        SI.Area A_cross = PI * IN_con.d_hyd ^ 2 / 4 "横截面积";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "平均速度";

        //故障状态
        Real fstatus[2] "检查预期边界条件";

        //说明
      algorithm
        Pr := abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));
        Re := (IN_var.rho * velocity * IN_con.d_hyd / max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC(IN_con, IN_var);
        Nu := kc * IN_con.d_hyd / max(MIN, IN_var.lambda);

        //故障状态
        fstatus[1] := if Re > laminar then 1 else 0;
        fstatus[2] := if Pr > prandtlMax or Pr < prandtlMin then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation(Inline = false, Documentation(info = "<html><p>
计算在均匀壁温或均匀热通量条件下，流体力学发达或不发达层流情况下直管的平均对流传热系数 kc。此外，还观察此函数中的故障状态，以检查是否满足预期的边界条件。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_laminar\" target=\"\">查看更多信息</a> 。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_laminar;

      function kc_laminar_KC 
        "直管 | 均匀的管壁温度或均匀的热通量 | 流体动力学发达或不发达的层流状态 的平均传热系数"
        extends Modelica.Icons.Function;
        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_con 
          IN_con "函数 kc_laminar_KC 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_IN_var 
          IN_var "函数 kc_laminar_KC 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_laminar_KC";

      protected
        type TYP = 
          Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary annotation();

        Real MIN = Modelica.Constants.eps;

        SI.Area A_cross = PI * IN_con.d_hyd ^ 2 / 4 "圆形横截面积";

        Real Nu0 = if IN_con.target == TYP.UWTuDFF or IN_con.target == TYP.UWTuUFF then 
          0.7 else if IN_con.target == TYP.UHFuDFF or IN_con.target == TYP.UHFuUFF then 
          0.6 else 0 "平均努塞数的帮助变量";
        Real Nu1 = if IN_con.target == TYP.UWTuDFF or IN_con.target == TYP.UWTuUFF then 
          3.66 else if IN_con.target == TYP.UHFuDFF or IN_con.target == TYP.UHFuUFF then 
          4.364 else 0 "平均努塞数的帮助变量";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "平均速度";
        SI.ReynoldsNumber Re = (IN_var.rho * velocity * IN_con.d_hyd / max(MIN, 
          IN_var.eta));
        SI.PrandtlNumber Pr = abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));

        SI.NusseltNumber Nu2 = if IN_con.target == TYP.UWTuDFF or IN_con.target == TYP.UWTuUFF then 
          1.615 * (Re * Pr * IN_con.d_hyd / IN_con.L) ^ (1 / 3) else if IN_con.target == 
          TYP.UHFuDFF or IN_con.target == TYP.UHFuUFF then 1.953 * (Re * Pr * IN_con.d_hyd 
          / IN_con.L) ^ (1 / 3) else 0 "平均努塞数的帮助变量";
        SI.NusseltNumber Nu3 = if IN_con.target == TYP.UWTuUFF then (2 / (1 + 22 * Pr)) ^ (1 / 
          6) * (Re * Pr * IN_con.d_hyd / IN_con.L) ^ 0.5 else if IN_con.target == TYP.UHFuUFF then 
          0.924 * (Pr ^ (1 / 3)) * (Re * IN_con.d_hyd / IN_con.L) ^ (1 / 2) else 0 
          "平均努塞数的帮助变量";

        SI.NusseltNumber Nu = (Nu1 ^ 3 + Nu0 ^ 3 + (Nu2 - Nu0) ^ 3 + Nu3 ^ 3) ^ (1 / 3) 
          "平均努塞数";

        //说明
      algorithm
        kc := Nu * IN_var.lambda / max(MIN, IN_con.d_hyd);
        annotation(Inline = false, Documentation(info = "<html><p>
计算在均匀壁温<strong>或</strong>均匀热通量条件下，流体力学发达<strong>或</strong>不发达层流情况下直管的平均对流传热系数<strong> kc</strong>。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_laminar\" target=\"\">查看更多信息</a> 。
</p>
</html>"      , revisions = "<html>
<p>2014-08-05 Stefan Wischhusen: 发展的流体流动中均匀热通量的修正项 (Nu3)。</p>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_laminar_KC;

      record kc_laminar_IN_con 
        "函数 kc_laminar 和 kc_laminar_KC 的输入记录表"
        extends Utilities.Records.HeatTransfer.StraightPipe;

          //选择
        Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary target=Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF 
          "传热边界条件的选择" 
          annotation (Dialog(group="选择"));

      annotation (Documentation(info="<html><p>
该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar\" target=\"\">kc_laminar</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC\" target=\"\">kc_laminar_KC </a>的<strong>输入记录</strong>。
</p>
</html>"        ));
      end kc_laminar_IN_con;

      record kc_laminar_IN_var 
        "函数 kc_laminar 和 kc_laminar_KC 的输入记录表"
        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var;

      annotation (Documentation(info="<html><p>
该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar\" target=\"\">kc_laminar</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC\" target=\"\">kc_laminar_KC </a>的<strong>输入记录</strong>。
</p>
</html>"        ));
      end kc_laminar_IN_var;

      function kc_overall 
        "直管 | 均匀的管壁温度或均匀的热通量 | 流体动力学发达或不发达的总体流动状态 | 压力损失相关性 的平均传热系数"
        extends Modelica.Icons.Function;
        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con 
          IN_con "函数 kc_overall 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var 
          IN_var "函数 kc_overall 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.Roughness annotation();

        Real MIN = Modelica.Constants.eps;

        SI.Area A_cross = PI * IN_con.d_hyd ^ 2 / 4 "横截面积";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "平均速度";

        //故障状态
        Real fstatus[3] "检查预期边界条件";

      algorithm
        Pr := abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));
        Re := (IN_var.rho * velocity * IN_con.d_hyd / max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC(IN_con, IN_var);
        Nu := kc * IN_con.d_hyd / max(MIN, IN_var.lambda);

        //故障状态
        if IN_con.roughness == TYP.Neglected then
          if Re < 2e4 or Re > 1e6 then
            fstatus[1] := 1;
          else
            fstatus[1] := 0;
          end if;
        elseif IN_con.roughness == TYP.Considered then
          if Re < 1e4 or Re > 1e6 then
            fstatus[1] := 1;
          else
            fstatus[1] := 0;
          end if;
        else
          assert(false, "未选择粗糙度");
        end if;
        fstatus[2] := if Pr < 0.6 or Pr > 1e3 then 1 else 0;
        fstatus[3] := if IN_con.d_hyd / max(MIN, IN_con.L) > 1 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation(Inline = false, Documentation(info = "<html><p>
在均匀壁温或均匀热通量条件下，计算直管的平均对流传热系数 kc，并忽略或考虑压力损失的影响。此外，还观察此函数中的故障状态，以检查是否满足预期的边界条件。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_overall\" target=\"\">查看更多信息</a> 。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_overall;

      function kc_overall_KC 
        "直管 | 均匀的管壁温度或均匀的热通量 | 流体动力学发达或不发达的总体流动状态 | 压力损失相关性 的平均传热系数"
        extends Modelica.Icons.Function;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_con 
          IN_con "函数 kc_overall_KC 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var 
          IN_var "函数 kc_overall_KC 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_overall_KC";

      protected
        Real MIN = Modelica.Constants.eps;
        Real laminar = 2200 "层流区的最大雷诺数";
        Real turbulent = 1e4 "湍流区的最小雷诺数";

        SI.Area A_cross = PI * IN_con.d_hyd ^ 2 / 4 "横截面积";

        SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho * A_cross) 
          "平均速度";
        SI.ReynoldsNumber Re = (IN_var.rho * velocity * IN_con.d_hyd / max(MIN, 
          IN_var.eta));
        SI.PrandtlNumber Pr = abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));

        kc_turbulent_IN_con IN_con_turb(d_hyd = IN_con.d_hyd, L = IN_con.L, roughness = IN_con.roughness, K = IN_con.K);
        kc_laminar_IN_con IN_con_lam(d_hyd = IN_con.d_hyd, L = IN_con.L, target = IN_con.target);

      algorithm
        kc := SMOOTH(
          laminar, 
          turbulent, 
          Re) * Dissipation.HeatTransfer.StraightPipe.kc_laminar_KC(IN_con_lam, 
          IN_var) + SMOOTH(
          turbulent, 
          laminar, 
          Re) * Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC(IN_con_turb, 
          IN_var);

        annotation(Inline = false, Documentation(info = "<html><p>
在均匀壁温或均匀热通量条件下，计算直管的平均对流传热系数<strong> kc</strong>，并忽略或考虑压力损失的影响。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_overall\" target=\"\">查看更多信息</a> 。
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_overall_KC;

      record kc_overall_IN_con 
        "函数 kc_overall 和 kc_overall_KC 的输入记录表"

          //选择
        Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary target=Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF 
          "传热边界条件的选择" 
          annotation (Dialog(group="选择"));

        extends kc_turbulent_IN_con;

      annotation (Documentation(info="<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall\" target=\"\">kc_overall</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC\" target=\"\">kc_overall_KC </a>的<strong>输入记录</strong>。<br>
</p>
</html>"));
      end kc_overall_IN_con;

      record kc_overall_IN_var 
        "函数 kc_overall 和 kc_overall_KC 的输入记录表"
        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.FluidProperties;

        //输入变量（质量流量）
        SI.MassFlowRate m_flow annotation (Dialog(group="输入"));

      annotation (Documentation(info="<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall\" target=\"\">kc_overall</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_KC\" target=\"\">kc_overall_KC </a>的<strong>输入记录</strong>。
</p>
</html>"        ));
      end kc_overall_IN_var;

      function kc_turbulent 
        "直管 | 流体力学发展的湍流状态 | 压力损失相关性 的平均传热系数"
        extends Modelica.Icons.Function;
        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_con 
          IN_con "函数 kc_turbulent 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_var 
          IN_var "函数 kc_turbulent 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "对流传热系数" 
          annotation(Dialog(group = "输出"));
        output SI.PrandtlNumber Pr "普朗特数" annotation(Dialog(group = "输出"));
        output SI.ReynoldsNumber Re "雷诺数" 
          annotation(Dialog(group = "输出"));
        output SI.NusseltNumber Nu "努塞尔数" 
          annotation(Dialog(group = "输出"));
        output Real failureStatus 
          "0== 边界条件满足 | 1== 失败 >> 检查结果是否仍有意义" 
          annotation(Dialog(group = "输出"));

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.Roughness annotation();

        Real MIN = Modelica.Constants.eps;

        SI.Area A_cross = PI * IN_con.d_hyd ^ 2 / 4 "横截面积";

        SI.Velocity velocity = abs(IN_var.m_flow) / (IN_var.rho * A_cross) 
          "平均速度";

        //故障状态
        Real fstatus[3] "检查预期边界条件";

        //说明
      algorithm
        Pr := abs(IN_var.eta * IN_var.cp / max(MIN, IN_var.lambda));
        Re := (IN_var.rho * velocity * IN_con.d_hyd / max(MIN, IN_var.eta));
        kc := Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC(IN_con, IN_var);
        Nu := kc * IN_con.d_hyd / max(MIN, IN_var.lambda);

        //故障状态
        if IN_con.roughness == TYP.Neglected then
          if Re < 2e4 or Re > 1e6 then
            fstatus[1] := 1;
          else
            fstatus[1] := 0;
          end if;
        elseif IN_con.roughness == TYP.Considered then
          if Re < 1e4 or Re > 1e6 then
            fstatus[1] := 1;
          else
            fstatus[1] := 0;
          end if;
        else
          assert(false, "未选择粗糙度");
        end if;
        fstatus[2] := if Pr <= 0.6 or Pr >= 1e3 then 1 else 0;
        fstatus[3] := if IN_con.d_hyd / max(MIN, IN_con.L) > 1 then 1 else 0;

        failureStatus := 0;
        for i in 1:size(fstatus, 1) loop
          if fstatus[i] == 1 then
            failureStatus := 1;
          end if;
        end for;
        annotation(Inline = false, Documentation(info = "<html><p>
在均匀壁温或均匀热通量条件下，计算直管的平均对流传热系数 kc，忽略或考虑压力损失的影响。此外，还观察此函数中的故障状态，以检查是否满足预期的边界条件。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_turbulent\" target=\"\">查看更多信息</a> 。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_turbulent;

      function kc_turbulent_KC 
        "直管 | 流体力学发展的湍流状态 | 压力损失相关性 的平均传热系数"
        extends Modelica.Icons.Function;
        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_con 
          IN_con "函数 kc_turbulent_KC 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_IN_var 
          IN_var "函数 kc_turbulent_KC 的输入记录表" 
          annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "输出函数 kc_turbulent_KC";

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.Roughness annotation();

        Real MIN = Modelica.Constants.eps;

        SI.Area A_cross = PI * IN_con.d_hyd ^ 2 / 4 "圆形截面积";

        SI.Velocity velocity = abs(IN_var.m_flow) / (IN_var.rho * A_cross) 
          "平均速度";
        SI.ReynoldsNumber Re = max(MIN, (IN_var.rho * velocity * IN_con.d_hyd / IN_var.eta));
        SI.PrandtlNumber Pr = abs(IN_var.eta * IN_var.cp / IN_var.lambda);

        Real zeta = abs(1 / max(MIN, 1.8 * Modelica.Math.log10(abs(Re)) - 1.5) ^ 2) 
          "压力损失系数";

        //说明
      algorithm
        kc := if IN_con.roughness == TYP.Neglected then abs(IN_var.lambda / IN_con.d_hyd) 
          * 0.023 * Re ^ 0.8 * Pr ^ (1 / 3) else if IN_con.roughness == TYP.Considered then abs(
          IN_var.lambda / IN_con.d_hyd) * (abs(zeta) / 8) * abs(Re) * abs(Pr) / (1 + 12.7 * (abs(
          zeta) / 8) ^ 0.5 * (abs(Pr) ^ (2 / 3) - 1)) * (1 + (IN_con.d_hyd / IN_con.L) ^ (2 / 3)) else 
          0;
        annotation(Inline = false, Documentation(info = "<html><p>
在均匀壁温或均匀热通量条件下，在忽略或考虑压力损失影响的情况下，计算流体力学发展湍流流的直管平均对流传热系数 kc。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_turbulent\" target=\"\">查看更多信息</a> 。
</p>
</html>"      , revisions = "<html>
<p>2016-04-12 Stefan Wischhusen: 限制 Re 为极小值（Modelica.Constant.eps）。</p>
</html>"      ), smoothOrder(normallyConstant = IN_con) = 2);
      end kc_turbulent_KC;

      record kc_turbulent_IN_con 
        "函数 kc_turbulent 和 kc_turbulent_KC 的输入记录表"
        extends Utilities.Records.HeatTransfer.StraightPipe;

        Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness = Dissipation.Utilities.Types.Roughness.Considered 
          "考虑表面粗糙度的选择" 
          annotation(Dialog(group = "选择"));

        SI.Length K = 0 "粗糙度（表面凸起的平均高度）" annotation(
          Dialog(group = "直管", enable = roughness == Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered));

        annotation(Documentation(info = "<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent\" target=\"\">kc_turbulent</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC\" target=\"\">kc_turbulent_KC </a>的<strong>输入记录</strong>。
</p>
</html>"      ));
      end kc_turbulent_IN_con;

      record kc_turbulent_IN_var 
        "函数 kc_turbulent 和 kc_turbulent_KC 的输入记录表"
        extends 
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_overall_IN_var;

      annotation (Documentation(info="<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent\" target=\"\">kc_turbulent</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC\" target=\"\">kc_turbulent_KC </a>的<strong>输入记录</strong>。
</p>
</html>"        ));
      end kc_turbulent_IN_var;

      function kc_twoPhaseOverall_KC 
        "直管 | 水平或垂直沸腾 | 水平冷凝 的局部两相传热系数"
        extends Modelica.Icons.Function;
        //资料来源_1: Bejan,A.: HEAT TRANSFER HANDBOOK, Wiley, 2003.
        //资料来源_2: Gungor, K.E. and R.H.S. Winterton: A general correlation for flow boiling in tubes and annuli, Int.J. Heat Mass Transfer, Vol.29, p.351-358, 1986.

        //输入记录表
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_con 
          IN_con annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC_IN_var 
          IN_var annotation(Dialog(group = "变量输入"));

        //输出变量
        output SI.CoefficientOfHeatTransfer kc 
          "局部两相传热系数";

      protected
        Real MIN = Modelica.Constants.eps;

        //说明
      algorithm
        kc := if IN_con.target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor then 
          Modelica.Fluid.Dissipation.Utilities.Functions.HeatTransfer.TwoPhase.kc_twoPhase_boilingHorizontal_KC(
          IN_con, IN_var) else if IN_con.target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then 
          Modelica.Fluid.Dissipation.Utilities.Functions.HeatTransfer.TwoPhase.kc_twoPhase_boilingVertical_KC(
          IN_con, IN_var) else if IN_con.target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.CondHor then 
          Modelica.Fluid.Dissipation.Utilities.Functions.HeatTransfer.TwoPhase.kc_twoPhase_condensationHorizontal_KC(
          IN_con, IN_var) else MIN;
        annotation(Inline = false, smoothOrder(normallyConstant = IN_con) = 2, 
          Documentation(info = "<html><p>
计算整体流动状态下（水平/垂直）<strong>沸腾</strong>或（水平）<strong>冷凝</strong>的局部<strong>两相</strong>传热系数 kc_2ph。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_twoPhaseOverall\" target=\"\">查看更多信息</a> 。
</p>
</html>"      , revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 移除了在质量流量为零时的 Re 奇异性。</p>
</html>"      ));
      end kc_twoPhaseOverall_KC;

      record kc_twoPhaseOverall_KC_IN_con 
        "函数 kc_twoPhaseOverall_KC 的输入记录表"
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_con;

      annotation (Documentation(info="<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC\" target=\"\">kc_twoPhaseOverall_KC</a><a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_turbulent_KC\" target=\"\"> </a>的<strong>输入记录</strong>。
</p>
</html>"));
      end kc_twoPhaseOverall_KC_IN_con;

      record kc_twoPhaseOverall_KC_IN_var 
        "函数 kc_twoPhaseOverall_KC 的输入记录表"
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_var;

      annotation (Documentation(info="<html><p>
<br>该记录表用作传热函数 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.StraightPipe.kc_twoPhaseOverall_KC\" target=\"\">kc_twoPhaseOverall_KC </a>的<strong>输入记录</strong>。
</p>
</html>"        ));
      end kc_twoPhaseOverall_KC_IN_var;
      annotation (preferredView="info", Documentation(info="<html><h4>直管</h4><h5>层流</h5><p>
计算在均匀壁温<strong>或</strong>均匀热通量条件下，流体力学发达<strong>或</strong>不发达层流情况下直管的平均对流传热系数<strong> kc</strong>。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_laminar\" target=\"\">查看更多信息</a>.
</p>
<h5>湍流</h5><p>
计算壁温均匀的流体力学湍流直管的平均对流传热系数 <strong>kc</strong>。 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.StraightPipe.kc_twoPhaseOverall\" target=\"\">查看更多信息</a>.
</p>
</html>"        ));
    end StraightPipe;
  annotation(preferredView="info");
  end HeatTransfer;

  package PressureLoss "用于计算压力损失的库"
  extends Modelica.Icons.VariantsPackage;

    package Bend "用于计算弯头压力损失的库"
    extends Modelica.Icons.VariantsPackage;

      function dp_curvedOverall_DP 
        "弯头 | 计算压力损失 | 整体流态 | 表面粗糙度 的压力损失"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //资料来源_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //资料来源_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //根据来源对方程进行注释

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_con 
          IN_con "函数 dp_curvedOverall_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var 
          IN_var "函数 dp_curvedOverall_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_curvedOverall_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "水力直径";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "圆形横截面积";
        Real frac_RD=max(MIN, IN_con.R_0/d_hyd) "相对曲率半径";
        Real k=max(MIN, abs(IN_con.K)/d_hyd) "相对粗糙度";
        Real delta=IN_con.delta*180/PI "转弯角度";
        SI.Length L=IN_con.delta*IN_con.R_0 "流道长度";

        //资料来源_1: p.336, sec.15: definition of flow regime boundaries
        SI.ReynoldsNumber Re_min=1 "最小雷诺数";
        SI.ReynoldsNumber Re_lam_max=6.5e3 
          "层流区的最大雷诺数 (6.5e3)";
        SI.ReynoldsNumber Re_turb_min=4e4 
          "湍流区的最小雷诺数 (4e4)";
        SI.ReynoldsNumber Re_turb_max=3e5 
          "湍流区的最大雷诺数 (3e5)";
        SI.ReynoldsNumber Re_turb_const=1e6 
          "独立于压力损失系数的雷诺数 (1e6)";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(1e2, 754*Modelica.Math.exp(
            if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        //资料来源_1: p.357, diag. 6-1: coefficients for local resistance coefficient [zeta_LOC]:
        //IN_con.R_0/IN_con.d_hyd <= 3
        Real A1=if delta <= 70 then 0.9*sin(delta*PI/180) else if delta >= 100 then 
            0.7 + 0.35*delta/90 else 1.0 
          "考虑转角对zeta_LOC影响的系数";
        Real A2=if frac_RD > 2.0 then 6e2 else if frac_RD <= 2.0 and frac_RD > 0.55 then 
                  (if frac_RD > 1.0 then 1e3 else if frac_RD <= 1.0 and frac_RD > 0.7 then 
                  3e3 else 6e3) else 4e3 
          "在zeta_LOC上考虑层流区的系数";
        Real B1=if frac_RD >= 1.0 then 0.21*(frac_RD)^(-0.5) else 0.21*(frac_RD)^(-2.5) 
          "考虑zeta_LOC相对曲率半径(R_0/d_hyd)的系数";
        Real C1=1.0 
          "考虑到横截面积对 zeta_LOC（此处：圆形横截面积）的相对伸长率";
        TYP.LocalResistanceCoefficient zeta_LOC_sharp_turb=max(MIN, A1*B1*C1) 
          "湍流区的局部阻力系数（Re > Re_turb_max）";

        SI.ReynoldsNumber Re=max(Re_min, 4*abs(m_flow)/(PI*IN_con.d_hyd*IN_var.eta)) 
          "雷诺数";

        //流动状态下的质量流量边界
        SI.MassFlowRate m_flow_smooth=Re_min*PI*IN_con.d_hyd*IN_var.eta/4;

        //资料来源_1: p.357, diag. 6-1, sec. 2 / p.336, sec. 15 (turbulent regime + hydraulically rough):
        //IN_con.R_0/IN_con.d_hyd < 3
        Real C_Re=if frac_RD > 0.7 then 11.5/Re^0.19 else if frac_RD <= 0.7 and 
            frac_RD >= 0.55 then 5.45/Re^0.131 else 1 + 4400/Re 
          "水力完全湍流区的修正系数（Re_turb_min < Re < Re_turb_max）";

        //资料来源_1: p.357, diag. 6-1
        //IN_con.R_0/IN_con.d_hyd < 3
        TYP.LocalResistanceCoefficient zeta_LOC_sharp=if Re < Re_lam_leave then A2/Re 
             + zeta_LOC_sharp_turb else if Re < Re_turb_min then SMOOTH(
            Re_lam_leave, 
            Re_turb_min, 
            Re)*(A2/max(Re_lam_leave, Re) + zeta_LOC_sharp_turb) + SMOOTH(
            Re_turb_min, 
            Re_lam_leave, 
            Re)*(C_Re*zeta_LOC_sharp_turb) else if Re < Re_turb_max then SMOOTH(
            Re_turb_min, 
            Re_turb_max, 
            Re)*(C_Re*zeta_LOC_sharp_turb) + SMOOTH(
            Re_turb_max, 
            Re_turb_min, 
            Re)*zeta_LOC_sharp_turb else zeta_LOC_sharp_turb 
          "R_0/d_hyd < 3 时的局部阻力系数";

        TYP.LocalResistanceCoefficient zeta_LOC=zeta_LOC_sharp 
          "局部阻力系数";

        //资料来源_2: p.191, eq. 8.4: 考虑到表面粗糙度
        //限制最大雷诺数 Re=1e6 时的 lambda_FRI (资料来源_2: p.207, sec. 9.2.4)
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7* 
            IN_con.d_hyd) + 5.74/min(1e6, max(Re_lam_leave, Re))^0.9))^2 
          "考虑表面粗糙度的 Darcy 摩擦系数";

        //资料来源_2: p.207, sec. 9.2.4: 表面粗糙度修正系数 CF
        Real CF_fri=1+SMOOTH(
            Re_lam_max, 
            Re_lam_leave, 
            Re)*min(1.4, (lambda_FRI_rough*L/d_hyd/zeta_LOC)) + SMOOTH(
            Re_lam_leave, 
            Re_lam_max, 
            Re) "考虑表面粗糙度的修正速度";

        TYP.PressureLossCoefficient zeta_TOT=max(1, CF_fri)*zeta_LOC 
          "压力损失系数";

        //说明

      algorithm
        DP := zeta_TOT*(IN_var.rho/2)* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
          m_flow, 
          m_flow_smooth, 
          2)/max(MIN, (IN_var.rho*A_cross)^2);
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
          inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW(
                IN_con, 
                IN_var, 
                DP)), 
          Documentation(info="<html>
<p>考虑表面粗糙度，计算层流区内不可压缩和单相流体通过圆形横截面的弯管的压力损失。</p>

<p>一般来说，这个函数在<strong>不可压缩情况下</strong>使用最佳，其中质量流量（m_flow）在所用模型中已知（作为状态变量），需要计算相应的压力损失（DP）。另一方面，如果压力损失（dp）已知（作为压力的状态变量），需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW\">dp_curvedOverall_MFLOW</a>在<strong>可压缩情况下</strong>使用最佳。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">查看更多信息</a>。</p>
</html>"                                                                                              , revisions="<html>
2014-12-12 Stefan Wischhusen：对于R/D > 0.55-0.7，修正了因子A2。现在，该因子为6e3，而不是4e3。<br>
</html>"         ));
      end dp_curvedOverall_DP;

      function dp_curvedOverall_MFLOW 
        "弯头 | 计算压力损失 | 整体流态 | 表面粗糙度 的压力损失"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //资料来源_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //资料来源_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //根据来源对方程进行注释

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_con 
          IN_con "函数 dp_curvedOverall_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_IN_var 
          IN_var "函数 dp_curvedOverall_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "Pressure loss" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW 
          "输出函数 dp_curvedOverall_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "水力直径";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "圆形横截面积";
        Real frac_RD=max(MIN, IN_con.R_0/d_hyd) "相对曲率半径";
        Real k=max(MIN, abs(IN_con.K)/d_hyd) "相对粗糙度";
        Real delta=IN_con.delta*180/PI "转弯角度";
        SI.Length L=IN_con.delta*IN_con.R_0 "流道长度";

        //资料来源_1: p.336, sec.15: definition of flow regime boundaries
        SI.ReynoldsNumber Re_min=1 "最小雷诺数";
        SI.ReynoldsNumber Re_lam_max=6.5e3 
          "层流区的最大雷诺数 (6.5e3)";
        SI.ReynoldsNumber Re_turb_min=4e4 
          "湍流区的最小雷诺数 (4e4)";
        SI.ReynoldsNumber Re_turb_max=3e5 
          "湍流区的最大雷诺数 (3e5)";
        SI.ReynoldsNumber Re_turb_const=1e6 
          "独立于压力损失系数的雷诺数 (1e6)";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(1e2, 754*Modelica.Math.exp(
            if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        //资料来源_1: p.357, diag. 6-1: coefficients for local resistance coefficient [zeta_LOC]:
        //IN_con.R_0/IN_con.d_hyd <= 3
        Real A1=if delta <= 70 then 0.9*sin(delta/180*PI) else if delta >= 100 then 
            0.7 + 0.35*delta/90 else 1.0 
          "考虑转角对zeta_LOC影响的系数";
        Real A2=if frac_RD > 2.0 then 6e2 else if frac_RD <= 2.0 and frac_RD > 0.55 then 
                  (if frac_RD > 1.0 then 1e3 else if frac_RD <= 1.0 and frac_RD > 0.7 then 
                  3e3 else 6e3) else 4e3 
          "在zeta_LOC上考虑层流区的系数";
        Real B1=if frac_RD >= 1.0 then 0.21*(frac_RD)^(-0.5) else 0.21*(frac_RD)^(-2.5) 
          "考虑zeta_LOC相对曲率半径(R_0/d_hyd)的系数";
        Real C1=1.0 
          "考虑到横截面积对 zeta_LOC（此处：圆形横截面积）的相对伸长率";
        TYP.LocalResistanceCoefficient zeta_LOC_sharp_turb=max(MIN, A1*B1*C1) 
          "湍流区的局部阻力系数（Re > Re_turb_max）";

        //资料来源_1: p.357, diag. 6-1: pressure loss boundaries for w.r.t. flow regimes
        //IN_con.R_0/d_hyd <=3
        SI.AbsolutePressure dp_lam_max=(zeta_LOC_sharp_turb + A2/Re_lam_leave)*IN_var.rho 
            /2*(Re_lam_leave*IN_var.eta/(IN_var.rho*d_hyd))^2 
          "层流区的最大压力损失";
        SI.AbsolutePressure dp_turb_min=zeta_LOC_sharp_turb*(if frac_RD > 0.7 then 
            11.5/Re_turb_min^0.19 else if frac_RD <= 0.7 and frac_RD >= 0.55 then 
            5.45/Re_turb_min^0.131 else 1 + 4400/Re_turb_min)*IN_var.rho/2*(
            Re_turb_min*IN_var.eta/(IN_var.rho*d_hyd))^2 
          "湍流区的最小压力损失";
        SI.AbsolutePressure dp_turb_max=zeta_LOC_sharp_turb*(if frac_RD > 0.7 then 
            11.5/Re_turb_max^0.19 else if frac_RD <= 0.7 and frac_RD >= 0.55 then 
            5.45/Re_turb_max^0.131 else 1 + 4400/Re_turb_max)*IN_var.rho/2*(
            Re_turb_max*IN_var.eta/(IN_var.rho*d_hyd))^2 
          "湍流区的最大压力损失";
        SI.AbsolutePressure dp_turb_const=zeta_LOC_sharp_turb*IN_var.rho/2*(
            Re_turb_const*IN_var.eta/(IN_var.rho*d_hyd))^2 
          "雷诺数与压力损失系数无关时的压力损失";

        //资料来源_1: p.357, diag. 6-1: mean velocities for assumed flow regime
        //IN_con.R_0/d_hyd <=3
        SI.Velocity v_lam=if 1e7*sqrt(abs(zeta_LOC_sharp_turb*abs(dp)*IN_var.rho* 
            d_hyd^2)) < abs(A2*IN_var.eta) then 2*abs(dp)*d_hyd/A2/IN_var.eta else (-
            A2/2*IN_var.eta + 0.5*sqrt(max(MIN, (A2*IN_var.eta)^2 + 8* 
            zeta_LOC_sharp_turb*abs(dp)*IN_var.rho*d_hyd^2)))/zeta_LOC_sharp_turb/ 
            IN_var.rho/d_hyd 
          "层流区的平均速度 (Re < Re_lam_leave)";
        SI.Velocity v_tra=if 1e7*sqrt(abs(zeta_LOC_sharp_turb*abs(dp_lam_max)*IN_var.rho 
            *d_hyd^2)) < abs(A2*IN_var.eta) then 2*abs(dp_lam_max)*d_hyd/A2/IN_var.eta 
             else (-A2/2*IN_var.eta + 0.5*sqrt(max(MIN, (A2*IN_var.eta)^2 + 8* 
            zeta_LOC_sharp_turb*abs(dp_lam_max)*IN_var.rho*d_hyd^2)))/ 
            zeta_LOC_sharp_turb/IN_var.rho/d_hyd 
          "过渡区的平均速度 (Re_lam_leave < Re_turb_min)";
        SI.Velocity v_turb=if frac_RD > 0.7 then (max(MIN, abs(dp))/(IN_var.rho/2* 
            11.5*zeta_LOC_sharp_turb)*(IN_var.rho*IN_con.d_hyd/max(MIN, IN_var.eta))^ 
            0.19)^(1/(2 - 0.19)) else if frac_RD > 0.55 and frac_RD < 0.7 then (max(
            MIN, abs(dp))/(IN_var.rho/2*5.45*zeta_LOC_sharp_turb)*(IN_var.rho*IN_con.d_hyd 
            /max(MIN, IN_var.eta))^0.131)^(1/(2 - 0.131)) else -2200/(IN_var.rho* 
            IN_con.d_hyd/IN_var.eta) + ((-2200/(IN_var.rho*IN_con.d_hyd/max(MIN, 
            IN_var.eta)))^2 + 2*abs(max(MIN, dp))/max(MIN, IN_var.rho))^0.5 
          "湍流区的平均速度与压力损失系数的关系 (Re_turb_min < Re < Re_turb_max)";
        SI.Velocity v_turb_const=sqrt(max(MIN, 2*abs(dp)/(IN_var.rho* 
            zeta_LOC_sharp_turb))) 
          "湍流状态下的平均速度与压力损失系数无关 (Re > Re_turb_max)";

        //平滑条件下的平均流速与流态的关系
        SI.Velocity v_smooth=if dp < dp_lam_max then v_lam else if dp < dp_turb_min then 
                  SMOOTH(
            dp_lam_max, 
            dp_turb_min, 
            dp)*v_lam + SMOOTH(
            dp_turb_min, 
            dp_lam_max, 
            dp)*v_turb else if dp < dp_turb_max then v_turb else SMOOTH(
            dp_turb_max, 
            dp_turb_const, 
            dp)*v_turb + SMOOTH(
            dp_turb_const, 
            dp_turb_max, 
            dp)*v_turb_const 
          "R_0/d_hyd < 3 时平滑条件下的平均速度";

        SI.ReynoldsNumber Re_smooth=max(Re_min, IN_var.rho*v_smooth*d_hyd/IN_var.eta) 
          "平滑条件下的雷诺数";

        //资料来源_2: p.191, eq. 8.4: considering surface roughness
        //限制最大雷诺数 Re=1e6 时的 lambda_FRI (资料来源_2: p.207, sec. 9.2.4)
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7* 
            IN_con.d_hyd) + 5.74/min(1e6, max(Re_lam_leave, Re_smooth))^0.9))^2 
          "考虑表面粗糙度的 Darcy 摩擦系数";
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.25/(Modelica.Math.log10(5.74/max(
            Re_lam_leave, Re_smooth)^0.9))^2 
          "忽略表面粗糙度的 Darcy 摩擦系数";

        //资料来源_2: p.207, sec. 9.2.4: correction factors CF w.r.t.surface roughness
        Real CF_3=1+SMOOTH(
            6e3, 
            1e3, 
            Re_smooth)*min(1.4, (lambda_FRI_rough*L/d_hyd/zeta_LOC_sharp_turb)) + SMOOTH(
            1e3, 
            6e3, 
            Re_smooth) "考虑表面粗糙度的修正速度";

        SI.Velocity velocity=v_smooth/max(1, CF_3)^(0.5) 
          "考虑表面粗糙度的修正速度";

        //说明

      algorithm
        M_FLOW := sign(dp)*IN_var.rho*A_cross*abs(velocity);

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
          inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), 
          Documentation(info="<html>
<p>
考虑表面粗糙度，计算层流区内不可压缩和单相流体通过圆形横截面的弯管的压力损失。
</p>

<p>
一般来说，如果压力损失（dp）已知（作为压力的状态变量），需要计算质量流量（M_FLOW），则这个函数在<strong>可压缩情况下</strong>使用最佳。另一方面，如果质量流量（m_flow）在所用模型中已知（作为状态变量），需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP\">dp_curvedOverall_DP</a>在<strong>不可压缩情况下</strong>使用最佳。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">查看更多信息</a>。</p>
</html>"                                                                                  , revisions="<html>
2014-12-01 Stefan Wischhusen: 引入变量v_lam和v_tra的扩展，以改善接近零流量时的数值。<br>
2014-12-12 Stefan Wischhusen: 对于R/D > 0.55-0.7，修正了因子A2。现在，该因子为6e3，而不是4e3。<br>
</html>"          ));

      end dp_curvedOverall_MFLOW;

      record dp_curvedOverall_IN_con 
        "函数 dp_curvedOverall_DP 和 dp_curvedOverall_MFLOW 的输入记录表"

        //弯头变量
        extends Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Bend;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP\" target=\"\">dp_curvedOverall_DP </a>和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW\" target=\"\">dp_curvedOverall_MFLOW </a>的<strong>输入记录</strong>。
</p>
</html>"  ));
      end dp_curvedOverall_IN_con;

      record dp_curvedOverall_IN_var 
        "函数 dp_curvedOverall_DP 和 dp_curvedOverall_MFLOW 的输入记录表"

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_DP\" target=\"\">dp_curvedOverall_DP </a>和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_curvedOverall_MFLOW\" target=\"\">dp_curvedOverall_MFLOW </a>的<strong>输入记录</strong>。<br>
</p>
</html>"  ));
      end dp_curvedOverall_IN_var;

      function dp_edgedOverall_DP 
        "直角弯头 | 计算压力损失 | 整体流态 | 表面粗糙度 的压力损失"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //资料来源_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //资料来源_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //根据来源对方程进行注释

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con 
          IN_con "函数 dp_edgedOverall_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var 
          IN_var "函数 dp_edgedOverall_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_edgedOverall_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "水力直径";
        SI.Area A_cross=PI*d_hyd^2/4 "圆形横截面积";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "相对粗糙度";
        Real delta=IN_con.delta*180/PI "转弯角度";

        //流动边界的定义
        //资料来源_2: p.207, sec. 9.2.4
        //资料来源_3: p.Lac 6, fig. 16
        SI.ReynoldsNumber Re_min=1 "最小雷诺数";
        SI.ReynoldsNumber Re_lam_min=5e2 
          "粗糙度促成的过渡区开始";
        SI.ReynoldsNumber Re_lam_max=1e4 
          "粗糙度促成的过渡区结束";
        SI.ReynoldsNumber Re_turb_min=1e5 
          "取决于雷诺数的过渡区最小雷诺数";
        SI.ReynoldsNumber Re_turb_max=2e5 
          "取决于雷诺数的过渡区最大雷诺数（k_Re=1）";
        SI.ReynoldsNumber Re_turb_const=1e6 
          "独立于压力损失系数的雷诺数 (1e6)";

        //资料来源_1: p. 81, sec. 2-2-21: start of transition regime
        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754* 
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        //资料来源_1: p.366, diag. 6-7
        Real A=0.95 + 33.5/max(MIN, delta) 
          "考虑转角对 zeta_LOC 影响的系数";
        Real C1=1 
          "考虑到横截面积对 zeta_LOC（此处：圆形横截面积）的相对伸长率";

        //资料来源_1: p.366, diag. 6-7
        TYP.LocalResistanceCoefficient zeta_LOC=max(MIN, 0.95*sin(PI/180*delta/2)^2 
             + 2.05*sin(PI/180*delta/2)^4) "局部阻力系数";

        //资料来源_1: p.365: Correction w.r.t. effect of Reynolds number in laminar regime
        Real B=24.8 
          "考虑雷诺数对 zeta_TOT 影响的系数";
        Real exp=0.263 
          "层流区雷诺数修正指数";

        Real v_min=Re_min*IN_var.eta/(IN_var.rho*d_hyd) 
          "线性插值的最小平均速度";

        SI.Velocity velocity=m_flow/(IN_var.rho*A_cross) "平均速度";
        SI.ReynoldsNumber Re=max(Re_min, IN_var.rho*abs(velocity)*d_hyd/IN_var.eta) 
          "雷诺数";

        //资料来源_2: p.191, eq. 8.4: considering surface roughness
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7* 
            IN_con.d_hyd) + 5.74/max(Re_lam_min, Re)^0.9)) 
            ^2 "考虑表面粗糙度的 Darcy 摩擦系数";
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.25/(Modelica.Math.log10(5.74/max(Re_lam_min, Re)^0.9))^2 
          "忽略表面粗糙度的 Darcy 摩擦系数";

        //资料来源_3: Lac 6, Figure 18
        Real CF_fri= SMOOTH(Re_lam_leave, Re_lam_min, Re)*max(1, min(1.4, (lambda_FRI_rough/ 
            lambda_FRI_smooth))) + SMOOTH(Re_lam_min, Re_lam_leave, Re) 
          "考虑表面粗糙度的修正速度";

        //资料来源_2: p.208, diag. 9.3: Correction w.r.t. effect of Reynolds number
        Real CF_Re=SMOOTH(
            Re_turb_min, 
            Re_turb_max, 
            Re)*B/Re^exp + SMOOTH(
            Re_turb_max, 
            Re_turb_min, 
            Re) "雷诺数修正系数";

        TYP.PressureLossCoefficient zeta_TOT=A*C1*zeta_LOC*CF_Re*CF_fri 
          "压力损失系数";

      algorithm
        DP := zeta_TOT*(IN_var.rho/2)* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                velocity, 
                v_min, 
                2);
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
考虑表面粗糙度，计算通过带有尖角的直角弯头的弯管的压力损失，属于整体流动，适用于不可压缩和单相流体通过圆形横截面。
</p>

<p>
相比于相同条件下的弯头，直角弯头的压力损失更大。直角弯头中尖角的影响远远大于表面粗糙度的影响。
</p>

<p>
一般来说，这个函数在<strong>不可压缩情况下</strong>使用最佳，其中质量流量（m_flow）在所用模型中已知（作为状态变量），需要计算相应的压力损失（DP）。另一方面，如果压力损失（dp）已知（作为压力的状态变量），需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW\">dp_edgedOverall_MFLOW</a>在<strong>可压缩情况下</strong>使用最佳。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">查看更多信息</a>。</p>
</html>"                 ));
      end dp_edgedOverall_DP;

      function dp_edgedOverall_MFLOW 
        "直角弯头 | 计算压力损失 | 整体流态 | 表面粗糙度 的压力损失"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //资料来源_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //资料来源_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002, Section Lac 6 (Verification)
        //根据来源对方程进行注释

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Bend;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_con 
          IN_con "函数 dp_edgedOverall_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_IN_var 
          IN_var "函数 dp_edgedOverall_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压力损失" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW 
          "输出函数 dp_edgedOverall_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=IN_con.d_hyd "水力直径";
        SI.Area A_cross=PI*d_hyd^2/4 "圆形横截面积";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "相对粗糙度";
        Real delta=IN_con.delta*180/PI "转弯角度";

        //流动边界的定义
        //资料来源_2: p.207, sec. 9.2.4
        //资料来源_3: p.Lac 6, fig. 16
        SI.ReynoldsNumber Re_min=1 "最小雷诺数";
        SI.ReynoldsNumber Re_lam_min=500 
          "粗糙度促成的过渡区开始";
        SI.ReynoldsNumber Re_lam_max=1e4 
          "粗糙度促成的过渡区结束";
        SI.ReynoldsNumber Re_turb_min=1e5 
          "取决于雷诺数的过渡区最小雷诺数";
        SI.ReynoldsNumber Re_turb_max=2e5 
          "取决于雷诺数的过渡区最大雷诺数（k_Re=1）";
        SI.ReynoldsNumber Re_turb_const=1e6 
          "独立于压力损失系数的雷诺数 (1e6)";

        //资料来源_1: p. 81, sec. 2-2-21: 过渡区开始
        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754* 
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        //资料来源_1: p.366, diag. 6-7
        Real A=0.95 + 33.5/max(MIN, delta) 
          "考虑转角对 zeta_LOC 影响的系数";
        Real C1=1 
          "考虑到横截面积对 zeta_LOC（此处：圆形横截面积）的相对伸长率";

        //资料来源_1: p.366, diag. 6-7
        TYP.LocalResistanceCoefficient zeta_LOC=max(MIN, 0.95*sin(PI/180*delta/2)^2 
             + 2.05*sin(PI/180*delta/2)^4) "局部阻力系数";

        //资料来源_1: p.365: Correction w.r.t. 雷诺数的影响
        Real B=24.8 
          "考虑雷诺数对 zeta_TOT 影响的系数";
        Real exp=0.263 "雷诺数修正指数";
        Real pow=(2 - exp) "压力损失 = f（质量流量^pow）";
      //   Real k_Re = B/(max(MIN, velocity)*IN_con.d_hyd*IN_var.rho)^exp*IN_var.eta^exp;

        SI.Velocity v_min = Re_min*IN_var.eta/(IN_var.rho*d_hyd) 
          "正则化的最小平均速度";

        SI.Pressure dp_min=A*C1*zeta_LOC*(B/2)*(d_hyd/IN_var.eta)^(-exp)*IN_var.rho^(1 - exp) 
            *v_min^(pow) 
          "线性平滑质量流量，减少压力损失";

        SI.Velocity v_lam_min = Re_lam_min*IN_var.eta/(IN_var.rho*d_hyd) 
          "开始过渡到粗糙度区的平均速度";
        SI.Velocity v_lam_leave = Re_lam_leave*IN_var.eta/(IN_var.rho*d_hyd) 
          "向粗糙度区过渡结束时的平均速度";

        SI.Pressure dp_lam_min=A*C1*zeta_LOC*(B/2)*(d_hyd/IN_var.eta)^(-exp)*IN_var.rho^(1 - exp) 
            *v_lam_min^(pow) 
          "开始向粗糙度区过渡时的压力损失";

        TYP.DarcyFrictionFactor lambda_lam_leave_rough=0.25/(Modelica.Math.log10(k/(3.7* 
            IN_con.d_hyd) + 5.74/Re_lam_leave^0.9))^2 
          "考虑到 Re_lem_leave 处表面粗糙度的 Darcy 摩擦系数";
        TYP.DarcyFrictionFactor lambda_lam_leave_smooth=0.25/(Modelica.Math.log10(5.74/Re_lam_leave^0.9))^2 
          "忽略 Re_lem_leave 处表面粗糙度的 Darcy 摩擦系数";

        SI.Pressure dp_lam_leave=A*C1*zeta_LOC*(B/2)*max(1, min(1.4, (lambda_lam_leave_rough/ 
            lambda_lam_leave_smooth)))*(d_hyd/IN_var.eta)^(-exp)*IN_var.rho^(1 - exp) 
            *v_lam_leave^(pow) 
          "过渡到表面粗糙度状态结束时的压力损失";

        TYP.DarcyFrictionFactor lambda_turb_min_rough=0.25/(Modelica.Math.log10(k/(3.7* 
            IN_con.d_hyd) + 5.74/Re_turb_min^0.9))^2 
          "考虑到开始过渡到恒定湍流状态时表面粗糙度的 Darcy 摩擦系数";
        TYP.DarcyFrictionFactor lambda_turb_min_smooth=0.25/(Modelica.Math.log10(5.74/Re_turb_min^0.9))^2 
          "忽略到开始过渡到恒定湍流状态时表面粗糙度的 Darcy 摩擦系数";

        TYP.DarcyFrictionFactor lambda_turb_max_rough=0.25/(Modelica.Math.log10(k/(3.7* 
            IN_con.d_hyd) + 5.74/Re_turb_max^0.9))^2 
          "考虑到开始过渡到恒定湍流状态时表面粗糙度的 Darcy 摩擦系数";
        TYP.DarcyFrictionFactor lambda_turb_max_smooth=0.25/(Modelica.Math.log10(5.74/Re_turb_max^0.9))^2 
          "忽略到开始过渡到恒定湍流状态时表面粗糙度的 Darcy 摩擦系数";

        SI.Velocity v_turb_min = Re_turb_min*IN_var.eta/(IN_var.rho*d_hyd) 
          "开始过渡到恒定湍流状态时的平均速度";

        SI.Velocity v_turb_max = Re_turb_max*IN_var.eta/(IN_var.rho*d_hyd) 
          "过渡到恒定湍流状态结束时的平均速度";

        SI.Pressure dp_turb_min=A*C1*zeta_LOC*(B/2)*max(1, min(1.4, (lambda_turb_min_rough/ 
            lambda_turb_min_smooth)))*(d_hyd/IN_var.eta)^(-exp)*IN_var.rho^(1 - exp) 
            *v_turb_min^(pow) 
          "开始过渡到恒定湍流状态时的压力损失";

        SI.Pressure dp_turb_max=A*C1*zeta_LOC*max(1, min(1.4, (lambda_turb_max_rough/ 
            lambda_turb_max_smooth)))*IN_var.rho/2*v_turb_max^2 
          "过渡到恒定湍流状态结束时的压力损失";

        SI.Velocity v_turb=(A*C1*zeta_LOC*IN_var.rho/2)^(-0.5)* 
            Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
            abs(dp), 
            dp_min, 
            0.5) "湍流条件下的平均速度";

        SI.Velocity v_lam=(2*(d_hyd/IN_var.eta)^exp/(A*C1*zeta_LOC*B*(IN_var.rho)^(1 - exp)))^(1/pow)* 
            Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
            abs(dp), 
            dp_min, 
            1/pow) "层流条件下的平均速度";

        //平滑条件下的平均流速与流态的关系
        SI.Velocity v_smooth=if abs(dp) > dp_turb_max then v_turb 
            else if abs(dp) < dp_turb_min then v_lam 
            else SMOOTH(
            dp_turb_max, 
            dp_turb_min, 
            abs(dp))*v_turb + SMOOTH(
            dp_turb_min, 
            dp_turb_max, 
            abs(dp))*v_lam "平滑条件下的平均速度";

        SI.ReynoldsNumber Re_smooth=max(Re_min, IN_var.rho*v_smooth*d_hyd/IN_var.eta) 
          "平滑条件下的雷诺数";

        //资料来源_2: p.191, eq. 8.4: 考虑到表面粗糙度
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25/(Modelica.Math.log10(k/(3.7* 
            IN_con.d_hyd) + 5.74/max(Re_lam_min, Re_smooth)^0.9)) 
            ^2 "考虑表面粗糙度的 Darcy 摩擦系数";
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.25/(Modelica.Math.log10(5.74/max(Re_lam_min, Re_smooth)^0.9))^2 
          "忽略表面粗糙度的 Darcy 摩擦系数";

        //资料来源_3: Lac 6, Figure 18
        Real CF_fri= SMOOTH(dp_lam_leave, dp_lam_min, abs(dp))*max(1, min(1.4, (lambda_FRI_rough/ 
            lambda_FRI_smooth))) + SMOOTH(dp_lam_min, dp_lam_leave, abs(dp)) 
          "考虑表面粗糙度的修正速度";

        SI.Velocity velocity=v_smooth/max(1, CF_fri)^(0.5) 
          "考虑表面粗糙度的修正速度";

      algorithm
          M_FLOW := sign(dp)*IN_var.rho*A_cross*velocity;

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
考虑表面粗糙度，计算通过带有尖角的直角弯头的弯管的压力损失，属于整体流动，适用于不可压缩和单相流体通过圆形横截面。
</p>

<p>
相比于相同条件下的弯头，直角弯头的压力损失更大。直角弯头中尖角的影响远远大于表面粗糙度的影响。
</p>

<p>
一般来说，如果压力损失（dp）已知（作为压力的状态变量），需要计算质量流量（M_FLOW），则这个函数在<strong>可压缩情况下</strong>使用最佳。另一方面，如果质量流量（m_flow）在所用模型中已知（作为状态变量），需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP\">dp_edgedOverall_DP</a>在<strong>不可压缩情况下</strong>使用最佳。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">查看更多信息</a>。</p>
</html>"                                                                                              , revisions="<html>
2014-12-02 Stefan Wischhusen: 修改了层流到高度湍流域的过渡区域。
</html>"                      ));

      end dp_edgedOverall_MFLOW;

      record dp_edgedOverall_IN_con 
        "函数 dp_edgedOverall_DP 和 dp_edgedOverall_MFLOW 的输入记录表"

        //边缘弯曲变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.EdgedBend;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP\" target=\"\">dp_edgedOverall_DP </a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW\" target=\"\">dp_edgedOverall_MFLOW </a>的<strong>输入记录</strong>。
</p>
</html>"  ));
      end dp_edgedOverall_IN_con;

      record dp_edgedOverall_IN_var 
        "函数 dp_edgedOverall_DP 和 dp_edgedOverall_MFLOW 的输入记录表"

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;
        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_DP\" target=\"\">dp_edgedOverall_DP </a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Bend.dp_edgedOverall_MFLOW\" target=\"\">dp_edgedOverall_MFLOW </a>的<strong>输入记录</strong>。
</p>
</html>"  ));
      end dp_edgedOverall_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>弯管</h4>
<h5>弯头整体流动</h5>
<p>考虑表面粗糙度，计算层流区内不可压缩和单相流体通过圆形横截面的弯管的压力损失。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_curvedOverall\">查看更多信息</a>。</p>

<h5>直角弯头整体流动</h5>
<p>
考虑表面粗糙度，计算通过带有尖角的直角弯头的弯管的压力损失，属于整体流动，适用于不可压缩和单相流体通过圆形横截面。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Bend.dp_edgedOverall\">查看更多信息</a>。</p>

</html>"       ));
    end Bend;

    package Channel "用于计算管道压力损失的库"
    extends Modelica.Icons.VariantsPackage;

      function dp_internalFlowOverall_DP 
        "Pressure loss of internal flow | calculate pressure loss | overall flow regime | surface roughness | several geometries"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //资料来源_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 1978.
        //资料来源_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002
        //根据来源对方程进行注释

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Channel;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_con 
          IN_con "函数 dp_internalFlowOverall_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_var 
          IN_var "函数 dp_internalFlowOverall_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_internalFlowOverall_DP";

      protected
        type TYP = 
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow annotation();

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, if IN_con.geometry == TYP.Annular then (PI/4)*((
            IN_con.D_ann)^2 - (IN_con.d_ann)^2) else if IN_con.geometry == TYP.Circular then 
                  PI/4*(IN_con.d_cir)^2 else if IN_con.geometry == TYP.Elliptical then 
                  PI*IN_con.a_ell*IN_con.b_ell else if IN_con.geometry == TYP.Rectangular then 
                  IN_con.a_rec*IN_con.b_rec else if IN_con.geometry == TYP.Isosceles then 
                  0.5*(IN_con.a_tri*IN_con.h_tri) else 0) 
          "横截面积";
        SI.Length perimeter=max(MIN, if IN_con.geometry == TYP.Annular then PI*(
            IN_con.D_ann + IN_con.d_ann) else if IN_con.geometry == TYP.Circular then 
                  PI*IN_con.d_cir else if IN_con.geometry == TYP.Elliptical then PI*(
            IN_con.a_ell + IN_con.b_ell) else if IN_con.geometry == TYP.Rectangular then 
                  2*(IN_con.a_rec + IN_con.b_rec) else if IN_con.geometry == TYP.Isosceles then 
                  IN_con.a_tri + 2*((IN_con.h_tri)^2 + (IN_con.a_tri/2)^2)^0.5 else 0) 
          "周长";
        SI.Diameter d_hyd=4*A_cross/perimeter "水力直径";
        Real beta=IN_con.beta*180/PI "顶角";

        //资料来源_2: p.138, sec 8.5
        Real Dd_ann=min(max(MIN, IN_con.d_ann), IN_con.D_ann)/max(MIN, max(IN_con.d_ann, 
            IN_con.D_ann)) 
          "环形几何体小直径与大直径之比";
        Real CF_ann=98.7378*Dd_ann^0.0589 
          "环形几何修正系数";
        Real ab_rec=min(IN_con.a_rec, IN_con.b_rec)/max(MIN, max(IN_con.a_rec, IN_con.b_rec)) 
          "矩形几何的长宽比";
        Real CF_rec=-59.85*(ab_rec)^3 + 148.67*(ab_rec)^2 - 128.1*(ab_rec) + 96.1 
          "矩形几何的修正系数";
        Real ab_ell=min(IN_con.a_ell, IN_con.b_ell)/max(MIN, max(IN_con.a_ell, IN_con.b_ell)) 
          "环形几何体小长度与大长度之比";
        Real CF_ell=-169.2211*(ab_ell)^4 + 260.9028*(ab_ell)^3 - 113.7890*(ab_ell)^2 
             + 9.2588*(ab_ell)^1 + 78.7124 
          "椭圆几何修正系数";
        Real CF_tri=-0.0013*(min(90, beta))^2 + 0.1577*(min(90, beta)) + 48.5575 
          "三角形几何的修正系数";
        Real CF_lam=if IN_con.geometry == TYP.Annular then CF_ann else if IN_con.geometry 
             == TYP.Circular then 64 else if IN_con.geometry == TYP.Elliptical then 
            CF_ell else if IN_con.geometry == TYP.Rectangular then CF_rec else if 
            IN_con.geometry == TYP.Isosceles then CF_tri else 0 
          "层流修正系数";

        //资料来源_1: p.81, fig. 2-3, sec 21-22: definition of flow regime boundaries
        Real k=max(MIN, abs(IN_con.K)/d_hyd) "相对粗糙度";
        SI.ReynoldsNumber Re_lam_min=1e3 
          "层流区的最小雷诺数";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635 
          "层流区的最大雷诺数";
        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754* 
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        //直管函数 dp_turbulent 的调整质量流量
        SI.MassFlowRate m_flow_turb=m_flow*(PI/4*d_hyd^2)/A_cross 
          "用于湍流计算的质量流量";
        SI.Velocity velocity=m_flow/(IN_var.rho*A_cross) 
          "内部流速";
        SI.ReynoldsNumber Re=IN_var.rho*abs(velocity)*d_hyd/IN_var.eta;

      protected
        Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con 
          IN_2_con(
          final roughness=IN_con.roughness, 
          final d_hyd=d_hyd, 
          final K=IN_con.K, 
          final L=IN_con.L) "湍流系统的输入记录表" 
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var 
          IN_2_var(                                                                     final eta= 
                IN_var.eta, final rho=IN_var.rho) 
          "湍流系统的输入记录表" 
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

        //说明

      algorithm
        DP := SMOOTH(
                Re_lam_min, 
                Re_lam_max, 
                Re)*(CF_lam/2)*IN_con.L/d_hyd^2*velocity*IN_var.eta + SMOOTH(
                Re_lam_max, 
                Re_lam_min, 
                Re)*Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP(
                IN_2_con, 
                IN_2_var, 
                m_flow_turb);
      annotation(Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
针对不同几何形状的内部流动，计算不可压缩和单相流体流动的整体流动状态下的压降，同时考虑表面粗糙度。
</p>

<p>
通常，此函数在 <strong>不可压缩情况</strong> 下数值上最优使用，其中质量流量 (m_flow) 在所使用的模型中已知（作为状态变量），需要计算相应的压降 (DP)。另一方面，函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\">dp_internalFlowOverall_MFLOW</a> 在 <strong>可压缩情况</strong> 下数值上最优使用，如果压降 (dp) 已知（作为状态变量的压力），则需要计算质量流量 (M_FLOW)。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Channel.dp_internalFlowOverall\">查看更多信息</a>。
</p>
</html>"                           ));

      end dp_internalFlowOverall_DP;

      function dp_internalFlowOverall_MFLOW 
        "Pressure loss of internal flow | calculate mass flow rate | overall flow regime | surface roughness | several geometries"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.Channel;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_con 
          IN_con "函数 dp_internalFlowOverall_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_IN_var 
          IN_var "函数 dp_internalFlowOverall_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压力损失" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW "输出函数 dp_overall_MFLOW";

      protected
        type TYP1 = 
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow annotation();
        type TYP2 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness annotation();

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, if IN_con.geometry == TYP1.Annular then (PI/4)*((
            IN_con.D_ann)^2 - (IN_con.d_ann)^2) else if IN_con.geometry == TYP1.Circular then 
                  PI/4*(IN_con.d_cir)^2 else if IN_con.geometry == TYP1.Elliptical then 
                  PI*IN_con.a_ell*IN_con.b_ell else if IN_con.geometry == TYP1.Rectangular then 
                  IN_con.a_rec*IN_con.b_rec else if IN_con.geometry == TYP1.Isosceles then 
                  0.5*(IN_con.a_tri*IN_con.h_tri) else 0) 
          "横截面积";
        SI.Length perimeter=max(MIN, if IN_con.geometry == TYP1.Annular then PI*(
            IN_con.D_ann + IN_con.d_ann) else if IN_con.geometry == TYP1.Circular then 
                  PI*IN_con.d_cir else if IN_con.geometry == TYP1.Elliptical then PI* 
            (IN_con.a_ell + IN_con.b_ell) else if IN_con.geometry == TYP1.Rectangular then 
                  2*(IN_con.a_rec + IN_con.b_rec) else if IN_con.geometry == TYP1.Isosceles then 
                  IN_con.a_tri + 2*((IN_con.h_tri)^2 + (IN_con.a_tri/2)^2)^0.5 else 0) 
          "周长";
        SI.Diameter d_hyd=4*A_cross/perimeter "水力直径";
        Real beta=IN_con.beta*180/PI "顶角";

        //资料来源_2: p.138, sec 8.5
        Real Dd_ann=min(max(MIN, IN_con.d_ann), IN_con.D_ann)/max(MIN, max(IN_con.d_ann, 
            IN_con.D_ann)) 
          "环形几何体小直径与大直径之比";
        Real CF_ann=98.7378*Dd_ann^0.0589 
          "环形几何修正系数";
        Real ab_rec=min(IN_con.a_rec, IN_con.b_rec)/max(MIN, max(IN_con.a_rec, IN_con.b_rec)) 
          "矩形几何的长宽比";
        Real CF_rec=-59.85*(ab_rec)^3 + 148.67*(ab_rec)^2 - 128.1*(ab_rec) + 96.1 
          "矩形几何的修正系数";
        Real ab_ell=min(IN_con.a_ell, IN_con.b_ell)/max(MIN, max(IN_con.a_ell, IN_con.b_ell)) 
          "环形几何体小长度与大长度之比";
        Real CF_ell=-169.2211*(ab_ell)^4 + 260.9028*(ab_ell)^3 - 113.7890*(ab_ell)^2 
             + 9.2588*(ab_ell)^1 + 78.7124 
          "椭圆几何修正系数";
        Real CF_tri=-0.0013*(min(90, beta))^2 + 0.1577*(min(90, beta)) + 48.5575 
          "三角形几何的修正系数";
        Real CF_lam=if IN_con.geometry == TYP1.Annular then CF_ann else if IN_con.geometry 
             == TYP1.Circular then 64 else if IN_con.geometry == TYP1.Elliptical then 
                  CF_ell else if IN_con.geometry == TYP1.Rectangular then CF_rec else 
                  if IN_con.geometry == TYP1.Isosceles then CF_tri else 0 
          "层流修正系数";

        //资料来源_1: p.81, fig. 2-3, sec 21-22: definition of flow regime boundaries
        Real k=max(MIN, abs(IN_con.K)/d_hyd) "相对粗糙度";
        SI.ReynoldsNumber Re_lam_min=1e3 
          "层流区的最小雷诺数";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635 
          "层流区的最大雷诺数";
        SI.ReynoldsNumber Re_turb_min=4e3 
          "湍流区的最小雷诺数";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754* 
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        //在计算直管压力损失时确定 Darcy 摩擦系数：
        //dp = lambda_FRI*L/d_hyd*(rho/2)*velocity^2 and assuming lambda_FRI == lambda_FRI_calc/Re^2
        TYP.DarcyFrictionFactor lambda_FRI_calc=2*abs(dp)*d_hyd^3*IN_var.rho/(IN_con.L 
            *IN_var.eta^2) "修正 Darcy 摩擦系数";

        //资料来源_3: p.Lab 1, eq. 5: determine Re assuming laminar regime
        SI.ReynoldsNumber Re_lam=lambda_FRI_calc/CF_lam 
          "假设为层流状态的雷诺数";

        //资料来源_3: p.Lab 2, eq. 10: determine Re assuming turbulent regime (Colebrook-White)
        SI.ReynoldsNumber Re_turb=if IN_con.roughness == TYP2.Neglected then (max(MIN, 
            lambda_FRI_calc)/0.3164)^(1/1.75) else -2*sqrt(max(lambda_FRI_calc, MIN)) 
            *Modelica.Math.log10(2.51/sqrt(max(lambda_FRI_calc, MIN)) + k/3.7) 
          "假设为湍流状态的雷诺数";

        //确定实际流态
        SI.ReynoldsNumber Re_check=if Re_lam < Re_lam_leave then Re_lam else Re_turb;
        //确定过渡区的 Re
        SI.ReynoldsNumber Re_trans=if Re_lam >= Re_lam_leave then 
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_Re(
            Re_check, 
            Re_lam_leave, 
            Re_turb_min, 
            k, 
            lambda_FRI_calc) else 0;
        //确定实际 Re
        SI.ReynoldsNumber Re=if Re_lam < Re_lam_leave then Re_lam else if Re_turb > 
            Re_turb_min then Re_turb else Re_trans;

        Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con 
          IN_2_con(
          final roughness=IN_con.roughness, 
          final d_hyd=d_hyd, 
          final K=IN_con.K, 
          final L=IN_con.L) "湍流系统的输入记录表" 
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var 
          IN_2_var(                                                                     final eta= 
                IN_var.eta, final rho=IN_var.rho) 
          "湍流系统的输入记录表" 
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

        //说明

      algorithm
        M_FLOW := SMOOTH(
                Re_lam_min, 
                Re_turb, 
                Re)*IN_var.rho*A_cross*(dp*(2/CF_lam)*(d_hyd^2/IN_con.L)*(1/ 
          IN_var.eta)) + SMOOTH(
                Re_turb, 
                Re_lam_min, 
                Re)*(A_cross/((PI/4)*d_hyd^2))* 
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW(
                IN_2_con, 
                IN_2_var, 
                dp);
      annotation(Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
针对不同几何形状的内部流动，计算不可压缩和单相流体流动的整体流动状态下的压降，同时考虑表面粗糙度。
</p>

<p>
通常，此函数在 <strong>可压缩情况</strong> 下数值上最优使用，如果压降 (dp) 已知（作为状态变量的压力），则需要计算质量流量 (M_FLOW)。另一方面，函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\">dp_internalFlowOverall_DP</a> 在 <strong>不可压缩情况</strong> 下数值上最优使用，其中质量流量 (m_flow) 在所使用的模型中已知（作为状态变量），需要计算相应的压降 (DP)。
</p>

<p>
不同几何形状下内部流体流动的压降计算详见 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Channel.dp_internalFlowOverall\">这里</a>。
</p>
</html>"                                                                                    ));

      end dp_internalFlowOverall_MFLOW;

      record dp_internalFlowOverall_IN_con 
        "函数 dp_internalFlowOverall_DP 和 dp_internalFlowOverall_MFLOW 的输入记录表"

        //管道变量
        Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Considered 
          "考虑表面粗糙度的选择" 
          annotation (Dialog(group="管道"));
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Geometry;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\" target=\"\">dp_internalFlowOverall_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\" target=\"\">dp_internalFlowOverall_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));
      end dp_internalFlowOverall_IN_con;

      record dp_internalFlowOverall_IN_var 
        "函数 dp_internalFlowOverall_DP 和 dp_internalFlowOverall_MFLOW 的输入记录表"

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_DP\" target=\"\">dp_internalFlowOverall_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Channel.dp_internalFlowOverall_MFLOW\" target=\"\">dp_internalFlowOverall_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));
      end dp_internalFlowOverall_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>Channel</h4>
<h5>内部整体流动</h5>
<p>
考虑表面粗糙度，计算通过不同几何形状的内部流动的压力损失，包括层流和湍流区域。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Channel.dp_internalFlowOverall\">查看更多信息</a>.
</p>
</html>"                                                                  ));

    end Channel;

    package General "通用压力损失计算库"
    extends Modelica.Icons.VariantsPackage;

      function dp_idealGas_DP 
        "通用压力损失 | 计算压力损失 | 理想气体 | 平均密度"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;
        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_con 
          IN_con "函数 dp_idealGas_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_var 
          IN_var "函数 dp_idealGas_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_idealGas_DP";

      protected
        Real Km_internal=IN_con.Km "压力损失系数";

        SI.Density rho_internal=IN_var.p_m/(IN_con.R_s*IN_var.T_m) 
          "平均密度";
        SI.VolumeFlowRate V_flow=m_flow/rho_internal "体积流量 [m3/s]";
        SI.VolumeFlowRate V_flow_min=(IN_con.R_s/Km_internal)^(1/IN_con.exp)* 
            rho_internal^(1/IN_con.exp - 1)*IN_con.dp_smooth^(1/IN_con.exp) 
          "开始近似递减体积流量";

        //说明

      algorithm
        DP := (Km_internal/IN_con.R_s)*(rho_internal)^(IN_con.exp - 1)* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                V_flow, 
                V_flow_min, 
                IN_con.exp);
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
使用平均密度计算<strong>理想气体</strong>的通用压降。
</p>

<p>
通常，此函数在 <strong>不可压缩情况</strong> 下数值上最优使用，其中质量流量 (m_flow) 在所使用的模型中已知（作为状态变量），需要计算相应的压降 (DP)。另一方面，函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW\">dp_idealGas_MFLOW</a> 在 <strong>可压缩情况</strong> 下数值上最优使用，如果压降 (dp) 已知（作为状态变量的压力），则需要计算质量流量 (M_FLOW)。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_idealGas\">查看更多信息</a>。
</p>
</html>"                                                          ));

      end dp_idealGas_DP;

      function dp_idealGas_MFLOW 
        "通用压力损失 | 计算压力损失 | 理想气体 | 平均密度"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;
        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_con 
          IN_con "函数 dp_idealGas_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_IN_var 
          IN_var "函数 dp_idealGas_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW "输出函数 dp_idealGas_MFLOW";

      protected
        Real Km_internal=IN_con.Km "压力损失系数";

        SI.Density rho_internal=IN_var.p_m/(IN_con.R_s*IN_var.T_m) 
          "平均密度";

        //说明

      algorithm
        M_FLOW := (IN_con.R_s/Km_internal)^(1/IN_con.exp)*(rho_internal)^(1/ 
          IN_con.exp)*Dissipation.Utilities.Functions.General.SmoothPower(
                dp, 
                IN_con.dp_smooth, 
                1/IN_con.exp);
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
使用平均密度计算<strong>理想气体</strong>的通用压降。
</p>

<p>
通常，此函数在 <strong>可压缩情况</strong> 下数值上最优使用，如果压降 (dp) 已知（作为状态变量的压力），则需要计算质量流量 (M_FLOW)。另一方面，函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\">dp_idealGas_DP</a> 在 <strong>不可压缩情况</strong> 下数值上最优使用，其中质量流量 (m_flow) 在所使用的模型中已知（作为状态变量），需要计算相应的压降 (DP)。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_idealGas\">查看更多信息</a>。
</p>
</html>"                                                          ));

      end dp_idealGas_MFLOW;

      record dp_idealGas_IN_con 
        "函数 dp_idealGas_DP 和 dp_idealGas_MFLOW 的输入记录表"

        //通用变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.IdealGas_con;

        //线性化
        SI.Pressure dp_smooth(min=Modelica.Constants.eps) = 1 
          "开始线性化，以减少压力损失" 
          annotation (Dialog(group="线性化"));

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\" target=\"\">dp_idealGas_DP </a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW\" target=\"\">dp_idealGas_MFLOW </a>的<strong>输入记录</strong>。
</p>
</html>"      ));

      end dp_idealGas_IN_con;

      record dp_idealGas_IN_var 
        "函数 dp_idealGas_DP 和 dp_idealGas_MFLOW 的输入记录表"

        //通用变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.IdealGas_var;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_DP\" target=\"\">dp_idealGas_DP </a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_idealGas_MFLOW\" target=\"\">dp_idealGas_MFLOW </a>的<strong>输入记录</strong>。
</p>
</html>"      ));

      end dp_idealGas_IN_var;

      function dp_nominalDensityViscosity_DP 
        "通用压力损失 | 计算质量流量 | 额定工作点 | 压力损失律（指数） | 密度和动力黏度相关性"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_con 
          IN_con "函数 dp_nominalDensityViscosity_DP 的输入记录表 " 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_var 
          IN_var "函数 dp_nominalDensityViscosity_DP 的输入记录表 " 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP 
          "输出函数 dp_nominalDensityViscosity_DP";

      protected
        SI.MassFlowRate m_flow_smooth=(max(1, 0.01*IN_con.dp_nom)*IN_var.rho/IN_con.rho_nom 
            *(1/IN_var.eta*IN_con.eta_nom)^(IN_con.exp_eta)*(1/IN_con.m_flow_nom))^(1 
            /IN_con.exp) "质量流量递减时的近似值起点";

        //说明

      algorithm
        DP := if IN_con.exp > 1.0 or IN_con.exp < 1.0 then 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                m_flow, 
                m_flow_smooth, 
                IN_con.exp)*(IN_var.eta/IN_con.eta_nom)^IN_con.exp_eta*IN_con.rho_nom 
          /IN_var.rho*IN_con.dp_nom*(1/IN_con.m_flow_nom)^(IN_con.exp) else 
          m_flow/IN_con.m_flow_nom*(IN_var.eta/IN_con.eta_nom)^IN_con.exp_eta* 
          IN_con.rho_nom/IN_var.rho*IN_con.dp_nom;
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
通过插值计算操作点处与额定流体变量（例如额定密度、额定动力黏度）相关的通用压降。此通用函数通过压降指数考虑压降规律，以及密度和动力黏度对压降的影响。
</p>

<p>
通常，此函数在 <strong>不可压缩情况</strong> 下数值上最优使用，其中质量流量 (m_flow) 在所使用的模型中已知（作为状态变量），需要计算相应的压降 (DP)。另一方面，函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\">dp_nominalDensityViscosity_MFLOW</a> 在 <strong>可压缩情况</strong> 下数值上最优使用，如果压降 (dp) 已知（作为状态变量的压力），则需要计算质量流量 (M_FLOW)。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalDensityViscosity\">查看更多信息</a>。
</p>
</html>"                                                          ));

      end dp_nominalDensityViscosity_DP;

      function dp_nominalDensityViscosity_MFLOW 
        "通用压力损失 | 计算质量流量(可压缩) | 额定工作点 | 压力损失律（指数） | 密度和动力黏度相关性"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_con 
          IN_con "函数 dp_nominalDensityViscosity_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));

        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_IN_var 
          IN_var "函数 dp_nominalDensityViscosity_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));

        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW 
          "输出函数 dp_nominalDensityViscosity_MFLOW";

        //说明

      algorithm
        M_FLOW := if IN_con.exp > 1.0 or IN_con.exp < 1.0 then 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp, 
                0.01*IN_con.dp_nom, 
                1/IN_con.exp)*(IN_con.eta_nom/IN_var.eta)^(IN_con.exp_eta/ 
          IN_con.exp)*(1/IN_con.dp_nom*IN_var.rho/IN_con.rho_nom)^(1/IN_con.exp) 
          *IN_con.m_flow_nom else dp/IN_con.dp_nom*(IN_con.eta_nom/IN_var.eta)^ 
          (IN_con.exp_eta)*IN_var.rho/IN_con.rho_nom*IN_con.m_flow_nom;
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
根据额定流体变量（例如额定密度、额定动力黏度）在操作点上的插值计算一般压力损失。
此通用函数考虑了通过压力损失指数以及密度和动力黏度对压力损失的影响的压力损失定律。
</p>

<p>
一般来说，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则此函数在数值上最适用于可压缩情况。另一方面，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_genericDensityViscosity_DP\">dp_genericDensityViscosity_DP</a>在数值上最适用于不可压缩情况。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalDensityViscosity\">查看更多信息</a>。
</p>
</html>"                                                          ));

      end dp_nominalDensityViscosity_MFLOW;

      record dp_nominalDensityViscosity_IN_con 
        "函数 dp_nominalDensityViscosity_DP 和 dp_nominalDensityViscosity_MFLOW 的输出记录表"

        //通用变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.NominalDensityViscosity;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\" target=\"\">dp_nominalDensityViscosity_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\" target=\"\">dp_nominalDensityViscosity_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));
      end dp_nominalDensityViscosity_IN_con;

      record dp_nominalDensityViscosity_IN_var 
        "函数 dp_nominalDensityViscosity_DP 和 dp_nominalDensityViscosity_MFLOW 的输出记录表"

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_DP\" target=\"\">dp_nominalDensityViscosity_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalDensityViscosity_MFLOW\" target=\"\">dp_nominalDensityViscosity_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"      ));
      end dp_nominalDensityViscosity_IN_var;

      function dp_nominalPressureLossLawDensity_DP 
        "通用压力损失 | 计算压力损失 | 额定工作点 | 压力损失律（系数和指数） | 密度相关性"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_con 
          IN_con 
          "函数 dp_nominalPressureLossLawDensity_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_var 
          IN_var 
          "函数 dp_nominalPressureLossLawDensity_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP 
          "输出函数 dp_nominalPressureLossLawDensity_yesAJac_DP";

      protected
        Real exp_density=if IN_con.target ==Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then 
                  1 - IN_con.exp else 1 
          "密度分数 (rho/rho_nom) 的指数";
        SI.MassFlowRate m_flow_nom=if IN_con.target ==Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then 
                  IN_con.m_flow_nom else IN_var.rho*IN_con.V_flow_nom 
          "工作点额定平均流速";

        SI.MassFlowRate m_flow_linear=(0.01*(IN_con.zeta_TOT_nom/IN_var.zeta_TOT)*(
            IN_con.rho_nom/IN_var.rho)^(exp_density)*(IN_con.A_cross/IN_con.A_cross_nom) 
            ^(IN_con.exp)*IN_con.m_flow_nom)^(1/IN_con.exp) 
          "质量流量递减时的近似值起点";

        //说明

      algorithm
        DP := if IN_con.exp > 1.0 or IN_con.exp < 1.0 then 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                m_flow, 
                m_flow_linear, 
                IN_con.exp)*IN_con.dp_nom*(IN_var.zeta_TOT/IN_con.zeta_TOT_nom) 
          *(IN_var.rho/IN_con.rho_nom)^(exp_density)*(IN_con.A_cross_nom/IN_con.A_cross) 
          ^(IN_con.exp)*(1/IN_con.m_flow_nom)^(IN_con.exp) else IN_con.dp_nom*(
          IN_var.zeta_TOT/IN_con.zeta_TOT_nom)*(IN_var.rho/IN_con.rho_nom)^(
          exp_density)*(IN_con.A_cross_nom/IN_con.A_cross)^(1)*(m_flow/IN_con.m_flow_nom) 
          ^(1);

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
根据额定流体变量（例如额定密度）通过插值从一个操作点计算一般压力损失。
此通用函数考虑了通过额定压力损失（dp_nom）、压力损失系数（zeta_TOT）和压力损失定律指数（exp）以及密度对压力损失的影响的压力损失定律。
</p>

<p>
一般来说，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则此函数在数值上最适用于不可压缩情况。另一方面，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\">dp_nominalPressureLossLawDensity_MFLOW</a>在数值上最适用于可压缩情况。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalPressureLossLawDensity\">查看更多信息</a>。
</p>
</html>"                                                          ));

      end dp_nominalPressureLossLawDensity_DP;

      function dp_nominalPressureLossLawDensity_MFLOW 
        "通用压力损失 | 计算质量流量 | 额定工作点 | 压力损失律（系数和指数） | 密度相关性"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_con 
          IN_con 
          "函数 dp_nominalPressureLossLawDensity_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_IN_var 
          IN_var 
          "函数 dp_nominalPressureLossLawDensity_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW 
          "输出函数 dp_nominalPressurelosslawDensity_MFLOW";

      protected
        Real exp_density=if IN_con.target ==Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then 
                  1 - IN_con.exp else 1 
          "密度分数 (rho/rho_nom) 的指数";
        SI.MassFlowRate m_flow_nom=if IN_con.target ==Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then 
                  IN_con.m_flow_nom else IN_var.rho*IN_con.V_flow_nom 
          "工作点额定平均流速";

        //说明

      algorithm
        M_FLOW := if IN_con.exp > 1.0 or IN_con.exp < 1.0 then 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp, 
                0.01*IN_con.dp_nom, 
                1/IN_con.exp)*IN_con.m_flow_nom*(IN_con.A_cross/IN_con.A_cross_nom) 
          *(IN_con.rho_nom/IN_var.rho)^(exp_density/IN_con.exp)*((1/IN_con.dp_nom) 
          *(IN_con.zeta_TOT_nom/IN_var.zeta_TOT))^(1/IN_con.exp) else IN_con.m_flow_nom 
          *(IN_con.A_cross/IN_con.A_cross_nom)*(IN_con.rho_nom/IN_var.rho)^(
          exp_density/1)*((dp/IN_con.dp_nom)*(IN_con.zeta_TOT_nom/IN_var.zeta_TOT)) 
          ^(1/1);
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
根据额定流体变量（例如额定密度）通过插值从一个操作点计算一般压力损失。
此通用函数考虑了通过额定压力损失（dp_nom）、压力损失系数（zeta_TOT）和压力损失定律指数（exp）以及密度对压力损失的影响的压力损失定律。
</p>

<p>
一般来说，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则此函数在数值上最适用于可压缩情况。另一方面，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\">dp_nominalPressureLossLawDensity_DP</a>在数值上最适用于不可压缩情况。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalPressureLossLawDensity\">查看更多信息</a>。
</p>
</html>"                                                          ));

      end dp_nominalPressureLossLawDensity_MFLOW;

      record dp_nominalPressureLossLawDensity_IN_con 
        "函数 dp_nominalPressureLossLawDensity_DP 和 dp_nominalPressureLossLawDensity_MFLOW 的输入记录表"

        //通用变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.NominalPressureLossLawDensity_con;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\" target=\"\">dp_nominalPressureLosslawDensity_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\" target=\"\">dp_nominalPressureLosslawDensity_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"      ));
      end dp_nominalPressureLossLawDensity_IN_con;

      record dp_nominalPressureLossLawDensity_IN_var 
        "函数 dp_nominalPressureLossLawDensity_DP 和 dp_nominalPressureLossLawDensity_MFLOW 的输入记录表"

        //通用变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.NominalPressureLossLawDensity_var;

        //流体性质变量
        SI.Density rho "流体密度" 
          annotation (Dialog(group="流体性质"));

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_DP\" target=\"\">dp_nominalPressureLosslawDensity_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_nominalPressureLossLawDensity_MFLOW\" target=\"\">dp_nominalPressureLosslawDensity_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));
      end dp_nominalPressureLossLawDensity_IN_var;

      function dp_pressureLossCoefficient_DP 
        "通用压力损失 | 计算压力损失 | 压力损失系数 (zeta_TOT)"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_con 
          IN_con "函数 dp_pressureLossCoefficient_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_var 
          IN_var "函数 dp_pressureLossCoefficient_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP 
          "输出函数 dp_pressureLossCoefficient_DP";

        //说明

      algorithm
        DP := 0.5*IN_var.zeta_TOT* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                m_flow, 
                (IN_con.dp_smooth/(0.5*IN_var.zeta_TOT*IN_var.rho))^0.5*IN_var.rho 
            *IN_con.A_cross, 
                2)/(IN_var.rho*(IN_con.A_cross)^2);
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
根据压力损失系数计算一般压力损失。
</p>

<p>
一般来说，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则此函数在数值上最适用于不可压缩情况。另一方面，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW\">dp_pressureLossCoefficient_MFLOW</a>在数值上最适用于可压缩情况。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_pressureLossCoefficient\">查看更多信息</a>。
</p>
</html>"                                                                      ));

      end dp_pressureLossCoefficient_DP;

      function dp_pressureLossCoefficient_MFLOW 
        "通用压力损失 | 计算质量流量 | 压力损失系数 (zeta_TOT)"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_con 
          IN_con "函数 dp_pressureLossCoefficient_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));

        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_IN_var 
          IN_var "函数 dp_pressureLossCoefficient_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW 
          "输出函数 dp_pressureLossCoefficientt_MFLOW";

        //说明

      algorithm
        M_FLOW := IN_var.rho*IN_con.A_cross* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp, 
                IN_con.dp_smooth, 
                0.5)/(0.5*IN_var.zeta_TOT*IN_var.rho)^0.5;
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
根据压力损失系数计算一般压力损失。
</p>

<p>
一般来说，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则此函数在数值上最适用于可压缩情况。另一方面，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\">dp_pressureLossCoefficient_DP</a>在数值上最适用于不可压缩情况。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_pressureLossCoefficient\">查看更多信息</a>。
</p>
</html>"                                                          ));

      end dp_pressureLossCoefficient_MFLOW;

      record dp_pressureLossCoefficient_IN_con 
        "函数 dp_pressureLossCoefficient_DP 和 dp_pressureLossCoefficient_MFLOW 的输入记录表"
        extends Modelica.Icons.Record;

        //通用变量
        SI.Area A_cross=Modelica.Constants.pi*0.1^2/4 "横截面积" 
          annotation (Dialog(group="通用变量"));

        //线性化
        SI.Pressure dp_smooth=1 
          "开始线性化以减少压力损失" 
          annotation (Dialog(group="线性化"));

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\" target=\"\">dp_pressureLossCoefficient_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW\" target=\"\">dp_pressureLossCoefficient_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"            ));
      end dp_pressureLossCoefficient_IN_con;

      record dp_pressureLossCoefficient_IN_var 
        "函数 dp_pressureLossCoefficient_DP 和 dp_pressureLossCoefficient_MFLOW 的输入记录表"
        extends Modelica.Icons.Record;

        //通用变量
        TYP.PressureLossCoefficient zeta_TOT=0.02*1/0.1 
          "压力损失系数" 
          annotation (Dialog(group="通用变量"));

        //流体性质变量
        SI.Density rho "流体密度" 
          annotation (Dialog(group="流体性质"));

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_DP\" target=\"\">dp_pressureLossCoefficient_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_pressureLossCoefficient_MFLOW\" target=\"\">dp_pressureLossCoefficient_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"      ));
      end dp_pressureLossCoefficient_IN_var;

      function dp_volumeFlowRate_DP 
        "通用压力损失 | 计算压力损失 | 二次函数 (dp=a*V_flow^2 + b*V_flow)"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con 
          IN_con "函数 dp_volumeFlowRate_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));

        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var 
          IN_var "函数 dp_volumeFlowRate_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_volumeFlowRate_DP";

      protected
        Real a=abs(IN_con.a);
        Real b=abs(IN_con.b);

        SI.VolumeFlowRate V_flow=m_flow/max(Modelica.Constants.eps, IN_var.rho) 
          "体积流量";
        SI.Pressure dp_min=max(Modelica.Constants.eps, abs(IN_con.dp_min)) 
          "压力损失递减近似值的起点";
        SI.VolumeFlowRate V_flow_smooth=if a > 0 and b <= 0 then (dp_min/a)^0.5 else 0 
          "开始近似递减体积流量";

        //说明

      algorithm
        assert(a+b>0, "请提供函数 dp=a*V_flow^2 + b*V_flow 的的非零因子 a 或 b。");

        // 请注意，如果 b>0 时，该函数将使用参数 b 对零流量进行重新量化。

        DP := a*(if a>0 and b<=0 then Dissipation.Utilities.Functions.General.SmoothPower(
                V_flow, 
                V_flow_smooth, 
                2) elseif a>0 and b>0 then V_flow*abs(V_flow) else 0) + b*V_flow;
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
计算具有体积流量线性和/或二次依赖关系的一般压力损失。<strong>请注意a和b的和必须大于零</strong>。
该函数可用于在已知质量流量时计算压力损失<strong>或</strong>在已知压力损失时计算质量流量。
</p>

<p>
一般来说，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则此函数在数值上最适用于不可压缩情况。另一方面，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\">dp_volumeFlowRate_MFLOW</a>在数值上最适用于可压缩情况。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">查看更多信息</a>。
</p>
</html>"                                                          , revisions="<html>
2018-11-21 Stefan Wischhusen: 修复了线性情况下的问题（a=0且b>0）以及a>0且b>0的过时正则化。
</html>"                                                          ));

      end dp_volumeFlowRate_DP;

      function dp_volumeFlowRate_MFLOW 
        "通用压力损失 | 计算质量流量 | 二次函数 (dp=a*V_flow^2 + b*V_flow)"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.General;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_con 
          IN_con "函数 dp_volumeFlowRate_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));

        input
          Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_IN_var 
          IN_var "函数 dp_volumeFlowRate_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW 
          "输出函数 dp_volumeFlowRate_MFLOW";

      protected
        Real a=abs(IN_con.a);
        Real b=abs(IN_con.b);

        SI.Pressure dp_min=max(Modelica.Constants.eps, abs(IN_con.dp_min)) 
          "压力损失递减近似值的起点";

        //说明

      algorithm
        assert(a+b>0, "请提供函数 dp=a*V_flow^2 + b*V_flow 的的非零因子 a 或 b。");

        // 请注意，如果 b>0 时，该函数将使用参数 b 对零流量进行重新量化。

        M_FLOW := IN_var.rho*(if a>0 and b<=0 then 
                Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                (1/a)*dp, 
                (1/a)*dp_min, 
                0.5) 
                elseif a>0 and b>0 then 
                sign(dp)*(-b/(2*a) + sqrt((b/(2*a))^2 + (1/a)*abs(dp))) 
                else b*dp);
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
计算具有体积流量线性或二次依赖关系的一般压力损失。<strong>请注意a和b的和必须大于零</strong>。
该函数可用于在已知质量流量时计算压力损失<strong>或</strong>在已知压力损失时计算质量流量。
</p>

<p>
一般来说，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则此函数在数值上最适用于可压缩情况。另一方面，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\">dp_volumeFlowRate_DP</a>在数值上最适用于不可压缩情况。<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">查看更多信息</a>。
</p>
</html>"                                                          ,       revisions="<html>
2018-11-21 Stefan Wischhusen: 修复了线性情况下的问题（a=0且b>0）以及a>0且b>0的过时正则化。
</html>"                                                          ));

      end dp_volumeFlowRate_MFLOW;

      record dp_volumeFlowRate_IN_con 
        "函数 dp_volumeFlowRate_DP 和 dp_volumeFlowRate_MFLOW 的输入记录表"

        //通用变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.QuadraticVFLOW;

        SI.Pressure dp_min=0.1 
          "压力损失递减近似值的起点（仅用于 b=0 时）";

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\" target=\"\">dp_volumeFlowRate_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\" target=\"\">dp_volumeFlowRate_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"      ));

      end dp_volumeFlowRate_IN_con;

      record dp_volumeFlowRate_IN_var 
        "函数 dp_volumeFlowRate_DP 和 dp_volumeFlowRate_MFLOW 的输入记录表"
        extends Modelica.Icons.Record;

        SI.Density rho "流体密度" 
          annotation (Dialog(group="流体性质"));
        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_DP\" target=\"\">dp_volumeFlowRate_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.General.dp_volumeFlowRate_MFLOW\" target=\"\">dp_volumeFlowRate_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"      ));

      end dp_volumeFlowRate_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>General</h4>
<h5>理想气体的通用压力损失</h5>
<p>
使用平均密度计算 <strong>理想气体</strong> 的通用压力损失。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_idealGas\">查看更多信息</a>.
</p>

<h5>根据密度和黏度的通用压力损失 </h5>
<p>
根据名义流体变量（例如，名义密度、名义动力黏度）在操作点上的插值，计算通用的压力损失。该通用函数考虑了压力损失定律通过压力损失指数以及密度和动力黏度对压力损失的影响。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalDensityViscosity\">查看更多信息</a>.
</p>

<h5>根据密度的通用压力损失</h5>
<p>
通过从操作点插值，根据名义流体变量（例如，名义密度）计算通用的压力损失。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalPressureLossLawDensity\">查看更多信息</a>.
</p>

<h5>根据压力损失系数的通用压力损失</h5>
<p>
根据压力损失系数计算通用的压力损失。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_pressureLossCoefficient\">查看更多信息</a>.
</p>

<h5>根据体积流量的通用压力损失</h5>
<p>
根据体积流量的线性或二次方依赖关系计算通用的压力损失。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\">查看更多信息</a>.
</p>
</html>"                                              ));

    end General;

    package Orifice "用于计算节流元件压力损失的库"
    extends Modelica.Icons.VariantsPackage;

      function dp_suddenChange_DP 
        "横截面积突变时的节流元件压力损失 | 计算压力损失 | 湍流状态 | 光滑表面 | 任意横截面积 | 无挡板 | 边缘锋利"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //根据来源对方程进行注释

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;

        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_con 
          IN_con "函数 dp_suddenChange_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_var 
          IN_var "函数 dp_suddenChange_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_suddenChange_DP";

      protected
        Real MIN=Modelica.Constants.eps;
        SI.ReynoldsNumber Re_min=1 
          "线性平滑的最小雷诺数";
        //限制局部阻力系数 zeta_LOC >> 数值改进
        TYP.LocalResistanceCoefficient zeta_LOC_min=1e-3 
          "最小局部阻力系数";

        SI.Area A_1=max(MIN, min(IN_con.A_1, IN_con.A_2)) 
          "节流元件的小横截面积";
        SI.Area A_2=max(MIN, max(IN_con.A_1, IN_con.A_2)) 
          "节流元件的大横截面积";
        SI.Length C_1=max(MIN, min(IN_con.C_1, IN_con.C_2)) 
          "节流元件小横截面积的周长";
        SI.Length C_2=max(MIN, max(IN_con.C_1, IN_con.C_2)) 
          "节流元件大横截面积的周长";
        SI.Diameter d_hyd=4*A_1/C_1 
          "节流元件小横截面积的水力直径";

        //突扩：资料来源_1，第 4 节，图 4-1，第 208 页
        //假设突扩时 Re >= 3.3e3
        TYP.LocalResistanceCoefficient zeta_LOC_exp=max(zeta_LOC_min, (1 - A_1/A_2)^2);

        //突缩：资料来源_1，第 4 节，图 4-9，第 216 / 217 页
        //假设突缩时 Re >= 1.0e4
        TYP.LocalResistanceCoefficient zeta_LOC_con=max(zeta_LOC_min, 0.5*(1 - A_1/ 
            A_2)^0.75);

        SI.Velocity velocity_1=m_flow/(IN_var.rho*A_1) 
          "较小截面积内的平均速度";

        //确定节流元件小横截面积的雷诺数
        SI.ReynoldsNumber Re=IN_var.rho*d_hyd*velocity_1/IN_var.eta;

        //实际局部阻力系数
        TYP.LocalResistanceCoefficient zeta_LOC=zeta_LOC_exp*SMOOTH(
            Re_min, 
            0, 
            Re) + zeta_LOC_con*SMOOTH(
            -Re_min, 
            0, 
            Re) + zeta_LOC_min*SMOOTH(
            0, 
            Re_min, 
            abs(Re));

        //说明

      algorithm
        DP := zeta_LOC*IN_var.rho/2*(IN_var.eta/IN_var.rho/d_hyd)^2* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                Re, 
                Re_min, 
                2);

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
计算在截面积突然改变（突扩或突缩）时的局部压力损失，在湍流流动情况下考虑具有尖角的光滑表面的不可压缩单相流体通过任意形状截面积（正方形、圆形等）的情况。流动方向确定了过渡的类型。在设计流量情况下，将考虑突然膨胀。在流动方向改变时，将考虑突然收缩。
</p>

<p>
一般来说，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则此函数在数值上最适用于不可压缩情况。另一方面，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW\">dp_suddenChange_MFLOW</a>在数值上最适用于可压缩情况。  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_suddenChange\">查看更多信息</a>。
</p>
</html>"                                                                    ));

      end dp_suddenChange_DP;

      function dp_suddenChange_MFLOW 
        "横截面积突变时的节流元件压力损失 | 计算质量流量 | 湍流状态 | 光滑表面 | 任意横截面积 | 无挡板 | 边缘锋利"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //根据来源对方程进行注释

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_con 
          IN_con "函数 dp_suddenChange_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_IN_var 
          IN_var "函数 dp_suddenChange_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW 
          "输出函数 dp_suddenChange_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;
        SI.Pressure dp_min=1 "线性平滑的压力损失";
        //限制局部阻力系数 zeta_LOC >> 数值改进
        TYP.LocalResistanceCoefficient zeta_LOC_min=1e-3 
          "最小局部阻力系数";

        SI.Area A_1=max(MIN, min(IN_con.A_1, IN_con.A_2)) 
          "节流元件的小横截面积";
        SI.Area A_2=max(MIN, max(IN_con.A_1, IN_con.A_2)) 
          "节流元件的大横截面积";

        //突扩：资料来源_1，第 4 节，图 4-1，第 208 页
        //假设突扩时 Re >= 3.3e3
        TYP.LocalResistanceCoefficient zeta_LOC_exp=max(zeta_LOC_min, (1 - A_1/A_2)^2);

        //突缩：资料来源_1第 4 节，图 4-9，第 216 / 217 页
        //假设突缩时 Re >= 1.0e4
        TYP.LocalResistanceCoefficient zeta_LOC_con=max(zeta_LOC_min, 0.5*(1 - A_1/ 
            A_2)^0.75);

        //实际局部阻力系数
        TYP.LocalResistanceCoefficient zeta_LOC=max(zeta_LOC_min, zeta_LOC_exp*SMOOTH(
            dp_min, 
            0, 
            dp) + zeta_LOC_con*SMOOTH(
            -dp_min, 
            0, 
            dp)) + zeta_LOC_min*SMOOTH(
            0, 
            dp_min, 
            abs(dp));

        //说明

      algorithm
        M_FLOW := IN_var.rho*A_1* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp, 
                dp_min, 
                0.5)*(max(MIN, 2/(IN_var.rho*zeta_LOC)))^0.5;
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
计算在截面积突然改变（突扩或突缩）时的局部压力损失，在湍流流动情况下考虑具有尖角的光滑表面的不可压缩单相流体通过任意形状截面积（正方形、圆形等）的情况。流动方向确定了过渡的类型。在设计流量情况下，将考虑突然膨胀。在流动方向改变时，将考虑突然收缩。
</p>

<p>
一般来说，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则此函数在数值上最适用于可压缩情况。另一方面，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP\">dp_suddenChange_DP</a>在数值上最适用于不可压缩情况。  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_suddenChange\">查看更多信息</a>。
</p>
</html>"                                                              ));

      end dp_suddenChange_MFLOW;

      record dp_suddenChange_IN_con 
        "函数 dp_suddenChange_DP 和 dp_suddenChange_MFLOW 的输入记录表"

        //节流元件变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.SuddenChange;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP\" target=\"\">dp_suddenChange_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW\" target=\"\">dp_suddenChange_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));
      end dp_suddenChange_IN_con;

      record dp_suddenChange_IN_var 
        "函数 dp_suddenChange_DP 和 dp_suddenChange_MFLOW 的输入记录表"

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_DP\" target=\"\">dp_suddenChange_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_suddenChange_MFLOW\" target=\"\">dp_suddenChange_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));
      end dp_suddenChange_IN_var;

      function dp_thickEdgedOverall_DP 
        "厚而尖的节流元件的压力损失 | 计算压力损失 | 整体流态 | 摩擦力的恒定影响 | 任意截面积"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //根据来源对方程进行注释

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con 
          IN_con "函数 dp_thickEdgedOverall_DP 的输入记录表 " 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var 
          IN_var "函数 dp_thickEdgedOverall_DP 的输入记录表 " 
          annotation (Dialog(group="变量输入"));

        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_thickEdgedOverall_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        TYP.DarcyFrictionFactor lambda_FRI=0.02 
          "根据资料来源_1 假设缩流断面的 Darcy 摩擦因数";
        SI.ReynoldsNumber Re_min=1;
        SI.ReynoldsNumber Re_lim=1e3 
          "dp 为目标时对层流区的限制";

        SI.Area A_0=IN_con.A_0 "缩流断面的横截面积";
        SI.Area A_1=IN_con.A_1 
          "大截面的横截面积";
        SI.Diameter d_hyd_0=max(MIN, 4*A_0/IN_con.C_0) 
          "缩流断面的水力直径";
        SI.Diameter d_hyd_1=max(MIN, 4*A_1/IN_con.C_1) 
          "大截面积的水力直径";
        SI.Length l=IN_con.L "缩流断面的长度";
        Real l_bar=IN_con.L/d_hyd_0;

        //资料来源_1，第 4 节，图 4-15，第 222 页：
        Real phi=0.25 + 0.535*min(l_bar, 2.4)^8/(0.05 + min(l_bar, 2.4)^8);
        Real tau=(max(2.4 - l_bar, 0))*10^(-phi);

        TYP.PressureLossCoefficient zeta_TOT_1=max(MIN, (0.5*(1 - A_0/A_1)^0.75 + tau 
            *(1 - A_0/A_1)^1.375 + (1 - A_0/A_1)^2 + lambda_FRI*l/d_hyd_0)*(A_1/A_0)^ 
            2) 
          "与大横截面积流速有关的压力损失系数";
        SI.Velocity v_0=m_flow/(IN_var.rho*A_0) 
          "缩流断面的平均速度";
        SI.ReynoldsNumber Re=IN_var.rho*v_0*d_hyd_0/max(MIN, IN_var.eta) 
          "缩流断面的雷诺数";

        //说明

      algorithm
        DP := zeta_TOT_1*IN_var.rho/2*(IN_var.eta/IN_var.rho/d_hyd_1)^2* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                Re, 
                Re_min, 
                2)*(d_hyd_1/d_hyd_0*A_0/A_1)^2;
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
计算通过具有尖角的厚边缘孔口的整体流动区域的压力损失，通过任意形状截面积（正方形、圆形等）的不可压缩单相流体考虑表面粗糙度的常量影响。
</p>

<p>
一般来说，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则此函数在数值上最适用于不可压缩情况。另一方面，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW\">dp_thickEdgedOverall_MFLOW</a>在数值上最适用于可压缩情况。  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">查看更多信息</a>。
</p>
</html>"                                                              ));

      end dp_thickEdgedOverall_DP;

      function dp_thickEdgedOverall_MFLOW 
        "厚而尖的节流元件的压力损失 | 计算质量流量 | 整体流态 | 摩擦力的恒定影响 | 任意截面积"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //根据来源对方程进行注释

        import FD = Modelica.Fluid.Dissipation.PressureLoss.Orifice;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_con 
          IN_con "函数 dp_thickEdgedOverall_MFLOW 的输入记录表 " 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_IN_var 
          IN_var "函数 dp_thickEdgedOverall_MFLOW 的输入记录表 " 
          annotation (Dialog(group="变量输入"));

        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW 
          "输出函数 dp_thickEdgedOverall_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;
        TYP.DarcyFrictionFactor lambda_FRI=0.02 
          "根据资料来源_1 假设缩流断面的 Darcy 摩擦因数";
        SI.ReynoldsNumber Re_lim=1e3 
          "dp 为目标时对层流区的限制";

        SI.Area A_0=IN_con.A_0 "缩流断面的横截面积";
        SI.Area A_1=IN_con.A_1 "大截面积";
        SI.Diameter d_hyd_0=max(MIN, 4*A_0/IN_con.C_0) 
          "缩流断面的水力直径";
        SI.Diameter d_hyd_1=max(MIN, 4*A_1/IN_con.C_1) 
          "大截面积的水力直径";
        SI.Length l=IN_con.L "缩流断面的长度";
        Real l_bar=IN_con.L/d_hyd_0;

        //资料来源_1，第 4 节，图 4-15，第 222 页：
        Real phi=0.25 + 0.535*min(l_bar, 2.4)^8/(0.05 + min(l_bar, 2.4)^8);
        Real tau=(max(2.4 - l_bar, 0))*10^(-phi);

        TYP.PressureLossCoefficient zeta_TOT_1=max(MIN, (0.5*(1 - A_0/A_1)^0.75 + tau 
            *(1 - A_0/A_1)^1.375 + (1 - A_0/A_1)^2 + lambda_FRI*l/d_hyd_0)*(A_1/A_0)^ 
            2) 
          "与大横截面积流速有关的压力损失系数";

        //说明

      algorithm
        M_FLOW := IN_var.rho*A_1* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                dp, 
                IN_con.dp_smooth, 
                0.5)/(0.5*IN_var.rho*zeta_TOT_1)^0.5;
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
计算通过具有尖角的厚边缘孔口的整体流动区域的压力损失，通过任意形状截面积（正方形、圆形等）的不可压缩单相流体考虑表面粗糙度的常量影响。
</p>

<p>
一般来说，如果已知压力损失（dp，作为模型中的状态变量之一）并且需要计算质量流量（M_FLOW），则此函数在数值上最适用于可压缩情况。另一方面，如果已知质量流量（m_flow，作为状态变量之一）并且需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP\">dp_thickEdgedOverall_DP</a>在数值上最适用于不可压缩情况。  <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">查看更多信息</a>。
</p>
</html>"                                                              ));

      end dp_thickEdgedOverall_MFLOW;

      record dp_thickEdgedOverall_IN_con 
        "函数 dp_thickEdgedOverall_DP 和 dp_thickEdgedOverall_MFLOW 的输入记录表"

        //节流元件变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.PressureLoss.Orifice;

        //线性化
        SI.Pressure dp_smooth(min=Modelica.Constants.eps) = 1 
          "开始线性化以减少压力损失" 
          annotation (Dialog(group="线性化"));

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP\" target=\"\">dp_thickEdgedOverall_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW\" target=\"\">dp_thickEdgedOverall_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"      ));
      end dp_thickEdgedOverall_IN_con;

      record dp_thickEdgedOverall_IN_var 
        "函数 dp_thickEdgedOverall_DP 和 dp_thickEdgedOverall_MFLOW 的输入记录表"

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_DP\" target=\"\">dp_thickEdgedOverall_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Orifice.dp_thickEdgedOverall_MFLOW\" target=\"\">dp_thickEdgedOverall_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));
      end dp_thickEdgedOverall_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>节流孔</h4>
<h5>突变</h5>
<p>
计算在湍流流动条件下，通过任意形状的横截面积（方形、圆形等）的孔口发生突然变化（突然膨胀或突然收缩）时的局部压力损失，考虑到光滑表面的不可压缩和单相流体流动。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_suddenChange\">查看更多信息</a>.
</p>

<h5>厚边孔口</h5>
<p>
在整体流动状态下，通过具有尖角的厚边孔口的压力损失的计算，考虑到表面粗糙度的恒定影响，用于不可压缩和单相流体流动通过任意形状的横截面积（方形、圆形等）。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Orifice.dp_thickEdgedOverall\">查看更多信息</a>.
</p>
</html>"                                                  ));

    end Orifice;

    package StraightPipe 
      "用于计算直管压力损失的库"
    extends Modelica.Icons.VariantsPackage;

      function dp_laminar_DP 
        "直管的压力损失 | 计算压力损失 | 层流区 (Hagen-Poiseuille)"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_con 
          IN_con "函数 dp_laminar_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_var 
          IN_var "函数 dp_laminar_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_laminar_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=IN_con.d_hyd "水力直径";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "圆形横截面积";

        SI.Velocity velocity=m_flow/max(MIN, IN_var.rho*A_cross) 
          "平均速度";

        //说明

      algorithm
        DP := 32*IN_var.eta*velocity*IN_con.L/d_hyd^2;
      annotation(Inline=true, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
计算直管中不可压缩单相流体的<strong>层流</strong>流动区域的压力损失。
</p>

<p>
一般来说，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则此函数在数值上最适用于不可压缩情况。另一方面，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\">dp_laminar_MFLOW</a>在数值上最适用于可压缩情况。   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_laminar\">查看更多信息</a>.
</p>
</html>"                                                  ));

      end dp_laminar_DP;

      function dp_laminar_MFLOW 
        "直管的压力损失 | 计算质量流量 | 层流区 (Hagen-Poiseuille)"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_con 
          IN_con "函数 dp_laminar_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_var 
          IN_var "函数 dp_laminar_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW "输出函数 dp_laminar_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "水力直径";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "圆形横截面积";

        //说明

      algorithm
        M_FLOW := IN_var.rho*A_cross*(dp*d_hyd^2/(32*IN_var.eta*IN_con.L));
      annotation (Inline=true, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
计算直管中不可压缩单相流体的<strong>层流</strong>流动区域的压力损失。
</p>

<p>
一般来说，如果已知压力损失（dp，作为模型中的状态变量之一）并且需要计算质量流量（M_FLOW），则此函数在数值上最适用于可压缩情况。另一方面，如果已知质量流量（m_flow，作为状态变量之一）并且需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\">dp_laminar_DP</a>在数值上最适用于不可压缩情况。   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_laminar\">查看更多信息</a>.
</p>
</html>"                                                  ));

      end dp_laminar_MFLOW;

      record dp_laminar_IN_con 
        "函数 dp_laminar_DP 和 dp_laminar_MFLOW 的输入记录表"
        extends Utilities.Records.PressureLoss.StraightPipe;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\" target=\"\">dp_laminar_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\" target=\"\">dp_laminar_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));

      end dp_laminar_IN_con;

      record dp_laminar_IN_var 
        "函数 dp_laminar_DP 和 dp_laminar_MFLOW 的输入记录表"

        extends 
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP\" target=\"\">dp_laminar_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW\" target=\"\">dp_laminar_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));

      end dp_laminar_IN_var;

      function dp_overall_DP 
        "直管的压力损失 | 计算压力损失 | 整体流态 | 表面粗糙度"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con 
          IN_con "函数 dp_overall_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var 
          IN_var "函数 dp_overall_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_overall_DP";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "水力直径";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "圆形横截面积";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "相对粗糙度";
        SI.Length perimeter=PI*IN_con.d_hyd "周长";

        //资料来源_1: p.81, fig. 2-3, sec 21-22: 流态边界的定义
        SI.ReynoldsNumber Re_lam_min=1e3 
          "层流区的最小雷诺数";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635 
          "层流区的最大雷诺数";
        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754* 
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        SI.ReynoldsNumber Re= 
            Modelica.Fluid.Dissipation.Utilities.Functions.General.ReynoldsNumber(
            A_cross, 
            perimeter, 
            IN_var.rho, 
            IN_var.eta, 
            m_flow);

        dp_laminar_IN_con IN_con_lam(d_hyd=IN_con.d_hyd, L= IN_con.L);
      algorithm
        DP := SMOOTH(
                Re_lam_min, 
                Re_lam_max, 
                Re)*Dissipation.PressureLoss.StraightPipe.dp_laminar_DP(
                IN_con_lam, 
                IN_var, 
                m_flow) + SMOOTH(
                Re_lam_max, 
                Re_lam_min, 
                Re)*Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP(
                IN_con, 
                IN_var, 
                m_flow);
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
计算直管中不可压缩单相流体的<strong>整体</strong>流动区域的压力损失，考虑表面粗糙度。
</p>

<p>
一般来说，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则此函数在数值上最适用于不可压缩情况。另一方面，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW\">dp_overall_MFLOW</a>在数值上最适用于可压缩情况。   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\">查看更多信息</a>.
</p>
</html>"                                                  ));

      end dp_overall_DP;

      function dp_overall_MFLOW 
        "直管的压力损失 | 计算质量流量 | 整体流态 | 表面粗糙度"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
        import Modelica.Fluid.Dissipation.Utilities.Types.Roughness;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con 
          IN_con "函数 dp_overall_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var 
          IN_var "函数 dp_overall_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW "输出函数 dp_overall_MFLOW";

      protected
        Real MIN=Modelica.Constants.eps;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "水力直径";
        SI.Area A_cross=max(MIN, PI*IN_con.d_hyd^2/4) 
          "圆形横截面积";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "相对粗糙度";

        //资料来源_1: p.81, fig. 2-3, sec 21-22: 流态边界的定义
        SI.ReynoldsNumber Re_lam_min=1e3 
          "层流区的最小雷诺数";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635 
          "层流区的最大雷诺数";
        SI.ReynoldsNumber Re_turb_min=4e3 
          "湍流区的最小雷诺数";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754* 
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        //在计算直管压力损失时确定 Darcy 摩擦系数：
        //dp = lambda_FRI*L/d_hyd*(rho/2)*velocity^2 and assuming lambda_FRI == lambda_FRI_calc/Re^2
        TYP.DarcyFrictionFactor lambda_FRI_calc=2*abs(dp)*d_hyd^3*IN_var.rho/(IN_con.L 
            *IN_var.eta^2) "Adapted Darcy friction factor";

        //资料来源_3: p.Lab 1, eq. 5: 假定为层流状态  (Blasius)，确定 Re 
        SI.ReynoldsNumber Re_lam=lambda_FRI_calc/64 
          "假设为层流状态的雷诺数";

        //资料来源_3: p.Lab 2, eq. 10: 假设为湍流状态  (Colebrook-White)，确定 Re 
        SI.ReynoldsNumber Re_turb=if IN_con.roughness == Roughness.Neglected then (max(MIN, 
            lambda_FRI_calc)/0.3164)^(1/1.75) else -2*sqrt(max(lambda_FRI_calc, MIN)) 
            *Modelica.Math.log10(2.51/sqrt(max(lambda_FRI_calc, MIN)) + k/3.7) 
          "假设为湍流状态的雷诺数";

        //确定实际流态
        SI.ReynoldsNumber Re_check=if Re_lam < Re_lam_leave then Re_lam else Re_turb;
        //确定湍流区的 Re
        SI.ReynoldsNumber Re_trans=if Re_lam >= Re_lam_leave then 
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_Re(
            Re_check, 
            Re_lam_leave, 
            Re_turb_min, 
            k, 
            lambda_FRI_calc) else 0;
        //确定实际的 Re
        SI.ReynoldsNumber Re=if Re_lam < Re_lam_leave then Re_lam else if Re_turb > 
            Re_turb_min then Re_turb else Re_trans;

        dp_laminar_IN_con IN_con_lam(d_hyd=IN_con.d_hyd, L= IN_con.L);

      algorithm
        M_FLOW := SMOOTH(
                Re_lam_min, 
                Re_turb, 
                Re)*Dissipation.PressureLoss.StraightPipe.dp_laminar_MFLOW(
                IN_con_lam, 
                IN_var, 
                dp) + SMOOTH(
                Re_turb, 
                Re_lam_min, 
                Re)*Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW(
                IN_con, 
                IN_var, 
                dp);
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
计算直管中不可压缩单相流体的<strong>整体</strong>流动区域的压力损失，考虑表面粗糙度。
</p>

<p>
一般来说，如果已知压力损失（dp，作为模型中的状态变量之一）并且需要计算质量流量（M_FLOW），则此函数在数值上最适用于不可压缩情况。另一方面，如果已知质量流量（m_flow，作为状态变量之一）并且需要计算相应的压力损失（DP），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP\">dp_overall_DP</a>在数值上最适用于可压缩情况。   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\">查看更多信息</a>.
</p>
</html>"                                                  ));

      end dp_overall_MFLOW;

      record dp_overall_IN_con 
        "函数 dp_overall_DP 和 dp_overall_MFLOW 的输入记录表"

        //直管变量
        extends dp_turbulent_IN_con;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP\" target=\"\">dp_overall_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW\" target=\"\">dp_overall_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));

      end dp_overall_IN_con;

      record dp_overall_IN_var 
        "函数 dp_overall_DP 和 dp_overall_MFLOW 的输入记录表"

        //流体性质变量
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.PressureLoss;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP\" target=\"\">dp_overall_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_MFLOW\" target=\"\">dp_overall_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));

      end dp_overall_IN_var;

      function dp_turbulent_DP 
        "直管的压力损失 | 计算压力损失 | 湍流区 | 表面粗糙度"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //资料来源_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //资料来源_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002.
        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_con 
          IN_con "函数 dp_turbulent_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_var 
          IN_var "函数 dp_turbulent_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "输出函数 dp_turbulent_DP";

      protected
        type TYP1 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness annotation();

        Real MIN=Modelica.Constants.eps;

        SI.ReynoldsNumber Re_min=1;
        SI.Velocity v_min=Re_min*IN_var.eta/(IN_var.rho*IN_con.d_hyd);

        SI.Diameter d_hyd=IN_con.d_hyd "水力直径";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "圆形横截面积";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "相对粗糙度";

        //资料来源_1: p.81, fig. 2-3, sec 21-22: 流态边界的定义
        SI.ReynoldsNumber Re_lam_min=1e3 
          "层流区的最小雷诺数";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635 
          "层流区的最大雷诺数";
        SI.ReynoldsNumber Re_turb_min=4e3 
          "湍流区的最小雷诺数";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754* 
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        SI.Velocity velocity=m_flow/(IN_var.rho*A_cross) "平均速度";
        SI.ReynoldsNumber Re=max(Re_min, IN_var.rho*abs(velocity)*d_hyd/IN_var.eta);

        //资料来源_2: p.191, eq. 8.4: 确定 Darcy 摩擦系数
        //假设 lambda_FRI == lambda_FRI_calc/Re^2
        TYP.DarcyFrictionFactor lambda_FRI_smooth=0.3164*Re^(1.75) 
          "忽略表面粗糙度的 Darcy 摩擦系数 (Blasius)";
        //这里的 lambda_FRI_rough == lambda_FRI*Re^2
        TYP.DarcyFrictionFactor lambda_FRI_rough=0.25*(max(Re, Re_lam_leave)/ 
            Modelica.Math.log10(k/3.7 + 5.74/max(Re, Re_lam_leave)^0.9))^2 
          "考虑表面粗糙度的 Darcy 摩擦系数";
        TYP.DarcyFrictionFactor lambda_FRI=if IN_con.roughness == TYP1.Neglected then 
                  lambda_FRI_smooth else lambda_FRI_rough 
          "Darcy 摩擦系数";
        TYP.DarcyFrictionFactor lambda_FRI_calc=if Re < Re_lam_leave then 64/Re else 
            if Re > Re_turb_min then lambda_FRI/Re^2 else 
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_lambda(
            Re, 
            Re_lam_leave, 
            Re_turb_min, 
            k)/Re^2 "Darcy 摩擦系数";

        TYP.PressureLossCoefficient zeta_TOT=lambda_FRI_calc*IN_con.L/d_hyd 
          "压力损失系数";

        //说明

      algorithm
        DP := zeta_TOT*(IN_var.rho/2)* 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
                velocity, 
                v_min, 
                2);
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(m_flow=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW(
                IN_con, 
                IN_var, 
                DP)), Documentation(info="<html>
<p>
计算直管中不可压缩单相流体的<strong>湍流</strong>流动区域的压力损失，考虑表面粗糙度。
</p>

<p>
一般来说，如果已知质量流量（m_flow，作为模型中的状态变量之一）并且需要计算相应的压力损失（DP），则此函数在数值上最适用于不可压缩情况。另一方面，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW\">dp_turbulent_MFLOW</a>在数值上最适用于可压缩情况。   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_turbulent\">查看更多信息</a>.
</p>
</html>"                                                                    ));

      end dp_turbulent_DP;

      function dp_turbulent_MFLOW 
        "直管的压力损失 | 计算质量流量 | 湍流区 | 表面粗糙度"
        extends Modelica.Icons.Function;
        //资料来源_1: Idelchik, I.E.: HANDBOOK OF HYDRAULIC RESISTANCE, 3rd edition, 2006.
        //资料来源_2: Miller, D.S.: INTERNAL FLOW SYSTEMS, 2nd edition, 1984.
        //资料来源_3: VDI-Waermeatlas, 9th edition, Springer-Verlag, 2002.

        import FD = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_con 
          IN_con "函数 dp_turbulent_MFLOW 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_var 
          IN_var "函数 dp_turbulent_MFLOW 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.Pressure dp "压降" annotation (Dialog(group="输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW "质量流量";

      protected
        type TYP1 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness annotation();

        Real MIN=Modelica.Constants.eps;
        SI.ReynoldsNumber Re_min=1;

        SI.Diameter d_hyd=max(MIN, IN_con.d_hyd) "水力直径";
        SI.Area A_cross=PI*IN_con.d_hyd^2/4 "圆形横截面积";
        Real k=max(MIN, abs(IN_con.K)/IN_con.d_hyd) "相对粗糙度";

        //资料来源_1: p.81, fig. 2-3, sec 21-22: 流态边界的定义
        SI.ReynoldsNumber Re_lam_min=1e3 
          "层流区的最小雷诺数";
        SI.ReynoldsNumber Re_lam_max=2090*(1/max(0.007, k))^0.0635 
          "层流区的最大雷诺数";
        SI.ReynoldsNumber Re_turb_min=4e3 
          "湍流区的最小雷诺数";

        SI.ReynoldsNumber Re_lam_leave=min(Re_lam_max, max(Re_lam_min, 754* 
            Modelica.Math.exp(if k <= 0.007 then 0.0065/0.007 else 0.0065/k))) 
          "雷诺数增大时过渡区的开始（离开层流区）";

        //在计算直管压力损失时确定 Darcy 摩擦系数：
        //dp = lambda_FRI*L/d_hyd*(rho/2)*velocity^2 并假设 lambda_FRI == lambda_FRI_calc/Re^2
        TYP.DarcyFrictionFactor lambda_FRI_calc=2*abs(dp)*d_hyd^3*IN_var.rho/(IN_con.L 
            *IN_var.eta^2) "修正 Darcy 摩擦系数";

        //资料来源_3: p.Lab 1, eq. 5: 假设为层流状态(Hagen-Poiseuille)，确定Re
        SI.ReynoldsNumber Re_lam=lambda_FRI_calc/64 
          "假设为层流状态的雷诺数";

        //资料来源_3: p.Lab 2, eq. 10: 假设为湍流状态  (Colebrook-White)，确定 Re 
        SI.ReynoldsNumber Re_turb=if IN_con.roughness == TYP1.Neglected then (max(MIN, 
            lambda_FRI_calc)/0.3164)^(1/1.75) else -2*sqrt(max(lambda_FRI_calc, MIN)) 
            *Modelica.Math.log10(2.51/sqrt(max(lambda_FRI_calc, MIN)) + k/3.7) 
          "假设为湍流状态的雷诺数";

        //确定实际流态
        SI.ReynoldsNumber Re_check=if Re_lam < Re_lam_leave then Re_lam else Re_turb;
        //确定湍流区的 Re
        SI.ReynoldsNumber Re_trans=if Re_lam >= Re_lam_leave then 
            Modelica.Fluid.Dissipation.Utilities.Functions.General.CubicInterpolation_Re(
            Re_check, 
            Re_lam_leave, 
            Re_turb_min, 
            k, 
            lambda_FRI_calc) else 0;
        //确定实际的 Re
        SI.ReynoldsNumber Re=if Re_lam < Re_lam_leave then Re_lam else if Re_turb > 
            Re_turb_min then Re_turb else Re_trans;

        //确定速度
        SI.Velocity velocity=(if dp >= 0 then Re else -Re)*IN_var.eta/(IN_var.rho* 
            d_hyd) "平均速度";

        //说明

      algorithm
        M_FLOW := IN_var.rho*A_cross*velocity;
      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    inverse(dp=Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP(
                IN_con, 
                IN_var, 
                M_FLOW)), Documentation(info="<html>
<p>
计算直管中不可压缩单相流体的<strong>湍流</strong>流动区域的压力损失，考虑表面粗糙度。
</p>

<p>
一般来说，如果已知压力损失（dp，作为状态变量之一）并且需要计算质量流量（M_FLOW），则函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP\">dp_turbulent_DP</a>在数值上最适用于不可压缩情况，其中质量流量（m_flow）已知（作为模型中的状态变量之一）且需要计算相应的压力损失（DP）。   <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_turbulent\">查看更多信息</a>.
</p>
</html>"                                                              ));

      end dp_turbulent_MFLOW;

      record dp_turbulent_IN_con 
        "函数 dp_turbulent_DP 和 dp_turbulent_MFLOW 的输入记录表"

        Modelica.Fluid.Dissipation.Utilities.Types.Roughness roughness=Dissipation.Utilities.Types.Roughness.Neglected 
          "考虑表面粗糙度的选择" 
          annotation (Dialog(group="直管"));

        extends Utilities.Records.PressureLoss.StraightPipe;

          SI.Length K=0 "粗糙度（表面凸起的平均高度）" 
          annotation (Dialog(group="直管"));

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP\" target=\"\">dp_turbulent_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW\" target=\"\">dp_turbulent_MFLOW</a>的<strong>输入记录</strong>。<br>
</p>
</html>"      ));
      end dp_turbulent_IN_con;

      record dp_turbulent_IN_var 
        "函数 dp_turbulent_DP 和 dp_turbulent_MFLOW 的输入记录表"

        extends 
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var;

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP\" target=\"\">dp_turbulent_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_MFLOW\" target=\"\">dp_turbulent_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"      ));
      end dp_turbulent_IN_var;

      function dp_twoPhaseOverall_DP 
        "两相流直管的压力损失 | 计算（摩擦、动量、大地）压力损失"
        extends Modelica.Icons.Function;
        //资料来源_1: Friedel,L.:IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW, 3R International, Vol. 18, Issue 7, pp. 485-491, 1979
        //资料来源_2: Chisholm,D.:PRESSURE GRADIENTS DUE TO FRICTION DURING THE FLOW OF EVAPORATING TWO-PHASE MIXTURES IN SMOOTH TUBES AND CHANNELS, Int. J. Heat Mass Transfer, Vol. 16, pp. 347-358, Pergamon Press 1973
        //资料来源_3: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
        //资料来源 4: J.M. Jensen and H. Tummescheit. Moving boundary models for dynamic simulations of two-phase flows. In Proceedings of the 2nd International Modelica Conference, pp. 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.
        //资料来源_5: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_IN_con 
          IN_con "函数 dp_twoPhaseOverall_DP 的输入记录表" 
          annotation (Dialog(group="常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_IN_var 
          IN_var "函数 dp_twoPhaseOverall_DP 的输入记录表" 
          annotation (Dialog(group="变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation (Dialog(group="输入"));

        //输出变量
        output SI.Pressure DP "两相压力损失";

      protected
        type TYP = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss annotation();

        Real MIN=Modelica.Constants.eps;

        SI.Area A_cross=max(MIN, IN_con.A_cross) "横截面积";
        SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, IN_con.perimeter)) 
          "水力直径";

        Real mdot_A=abs(m_flow)/A_cross "质量通量";
        Real xflowEnd=min(1, max(0, abs(IN_var.x_flow_end))) 
          "管道长度末端的质量流量特性";
        Real xflowSta=min(1, max(0, abs(IN_var.x_flow_sta))) 
          "管道长度起始处的质量流量特性";
        Real x_flow=(xflowEnd + xflowSta)/2 
          "管道长度上的平均质量流量特性";

        //资料来源_5: p.17-1 to 17-5, sec. 17.1 to 17.2: 考虑截面空隙率 [epsilon=A_g/(A_g+A_l)]
        Real epsilon= 
          Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.VoidFraction(
            IN_con.voidFractionApproach, 
            true, 
            IN_var.rho_g, 
            IN_var.rho_l, 
            x_flow) "空隙率";

        //资料来源_1:考虑到摩擦压力损失与 Friedel 的相关性
        //资料来源_2: 考虑到摩擦压力损失与 Chisholm 的相关性
        SI.Pressure DP_fric=if IN_con.frictionalPressureLoss == TYP.Friedel then 
          Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseFriedel_DP(
            Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con(A_cross=IN_con.A_cross, perimeter=IN_con.perimeter, length=IN_con.length), 
            Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var(rho_g=IN_var.rho_g, rho_l=IN_var.rho_l, eta_g=IN_var.eta_g, eta_l=IN_var.eta_l, sigma=IN_var.sigma, x_flow=IN_var.x_flow), 
            m_flow) else if IN_con.frictionalPressureLoss == TYP.Chisholm then 
          Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseChisholm_DP(
            Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con(A_cross=IN_con.A_cross, perimeter=IN_con.perimeter, length=IN_con.length), 
            Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var(rho_g=IN_var.rho_g, rho_l=IN_var.rho_l, eta_g=IN_var.eta_g, eta_l=IN_var.eta_l, sigma=IN_var.sigma, x_flow=IN_var.x_flow), 
            m_flow) else 0 "摩擦压力损失";

        //资料来源_3: p.Lba 4, eq. 22: 考虑动量压力损失，假设两相流的非均质方法
        //蒸发 >> 正动量压力损失（假定冷凝时反之）。
        SI.Pressure DP_mom=if IN_con.momentumPressureLoss then 
          Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseMomentum_DP(
            IN_con.voidFractionApproach, 
            IN_con.massFlowRateCorrection, 
            IN_con.A_cross, 
            IN_con.perimeter, 
            IN_var.rho_g, 
            IN_var.rho_l, 
            IN_var.x_flow_end, 
            IN_var.x_flow_sta, 
            abs(m_flow)) else 0 "动量压力损失";

        //资料来源_3: p.Lbb 1, eq. 4:  考虑到大地基准压力损失，假设沿流动长度的空隙率不变
        SI.Pressure DP_geo=if IN_con.geodeticPressureLoss then 
          Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.dp_twoPhaseGeodetic_DP(
            IN_con.voidFractionApproach, 
            true, 
            IN_con.length, 
            IN_con.phi, 
            IN_var.rho_g, 
            IN_var.rho_l, 
            IN_var.x_flow) else 0 "大地基准压力损失";

        //说明
      algorithm
        DP := DP_fric + DP_mom + DP_geo;

      annotation (Inline=false, smoothOrder(normallyConstant=IN_con) = 2, 
                    Documentation(info="<html>
<p>
计算水平或垂直直管中<strong>两相流</strong>的压力损失，考虑摩擦、动量和重力压力损失。
</p>

<p>
一般来说，可以计算水平或垂直直管中两相流的压力损失，适用于以下流体流动状态：
</p>
<p>
<strong>水平流动</strong> [(a) 气泡流动, (b) 层流流动, (c) 波状流动, (d) 液团流动, (e) 环状流动]:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/StraightPipe/twoPhaseFlowRegimes_horizontal.png\" alt=\"twoPhaseFlowRegimes_horizontal\"/>
</div>

<p>
<strong>垂直流动</strong> [(a) 气泡流动, (b) 柱塞液柱流动, (c) 泡沫流动, (d) 环状流动, (e) 环状流动]:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/StraightPipe/twoPhaseFlowRegimes_vertical.png\" alt=\"twoPhaseFlowRegimes_vertical\"/>
</div>

<p>
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_twoPhaseOverall\">查看更多信息</a>.
</p>
</html>"                                                        ));

      end dp_twoPhaseOverall_DP;

      record dp_twoPhaseOverall_IN_con 
        "函数 dp_twoPhaseOverall_DP 的输入记录表"

        //选择
        Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss 
          frictionalPressureLoss=Dissipation.Utilities.Types.TwoPhaseFrictionalPressureLoss.Friedel 
          "选择摩擦压力损失方法" 
          annotation (Dialog(group="选择"));
        Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach 
          voidFractionApproach = Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous 
          "选择空隙率方法" annotation (Dialog(group="选择"));

        Boolean momentumPressureLoss=false "考虑到动量压力损失" 
          annotation (Dialog(group="选择"));
        Boolean massFlowRateCorrection=false 
          "考虑异质质量流量修正" annotation (Dialog(group= 
               "选择", enable= momentumPressureLoss));
        Boolean geodeticPressureLoss=false "考虑到大地基准压力损失" 
          annotation (Dialog(group="选择"));

        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con;
        SI.Angle phi=0 "倾斜角度（相对水平面）" 
          annotation (Dialog(group="几何"));

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP\" target=\"\">dp_twoPhaseOverall_DP </a><strong>输入记录</strong>。<br>
</p>
</html>"      ));

      end dp_twoPhaseOverall_IN_con;

      record dp_twoPhaseOverall_IN_var 
        "函数 dp_twoPhaseOverall_DP 的输入记录表"

        Real x_flow_end=0 "管道长度末端的质量流量特性" 
          annotation (Dialog(group="流体性质"));
        Real x_flow_sta=0 "管道长度起始处的质量流量特性" 
          annotation (Dialog(group="流体性质"));
        extends 
          Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var(final
            x_flow=(x_flow_end + x_flow_sta)/2);

        annotation (Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP\" target=\"\">dp_twoPhaseOverall_DP</a><strong>输入记录</strong>。
</p>
</html>"      ));

      end dp_twoPhaseOverall_IN_var;
    annotation (preferredView="info", Documentation(info="<html>
<h4>直管</h4>
<h5>层流</h5>
<p>
计算单相流体中直管的<strong>层流</strong>流动状态下的压力损失。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_laminar\">查看更多信息</a>.
</p>

<h5>湍流</h5>
<p>
计算单相流体中直管的<strong>湍流</strong>流动状态下的压力损失，考虑表面粗糙度。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_turbulent\">查看更多信息</a>.
</p>

<h5>总体流动</h5>
<p>
计算单相流体中直管的<strong>层流或湍流</strong>流动状态下的压力损失，考虑表面粗糙度。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\">查看更多信息</a>.
</p>

<h5>两相总体流动</h5>
<p>
计算水平或垂直直管中<strong>两相流</strong>的压力损失，考虑摩擦、动量和重力压力损失。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_twoPhaseOverall\">查看更多信息</a>.
</p>
</html>"                                      ));

    end StraightPipe;

    package Valve "用于计算阀门压力损失的库"
      extends Modelica.Icons.VariantsPackage;

      function dp_severalGeometryOverall_DP 
        "阀门的压力损失 | 计算压力损失 | 几种几何形状 | 整体流动"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.Valve;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
        import TYP = Modelica.Fluid.Dissipation.Utilities.Types;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con 
          IN_con "函数 dp_severalGeometryOverall_DP 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var 
          IN_var "函数 dp_severalGeometryOverall_DP 的输入记录表" 
          annotation(Dialog(group = "变量输入"));
        input SI.MassFlowRate m_flow "质量流量" 
          annotation(Dialog(group = "输入"));

        //输出变量
        output SI.Pressure DP "压降";

      protected
        type TYP1 = 
          Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient annotation();
        type TYP2 = Modelica.Fluid.Dissipation.Utilities.Types.ValveGeometry annotation();

        Real MIN = Modelica.Constants.eps;

        SI.Area Av = if IN_con.valveCoefficient == TYP1.AV then IN_con.Av else if 
          IN_con.valveCoefficient == TYP1.KV then IN_con.Kv * 27.7e-6 else if IN_con.valveCoefficient 
          == TYP1.CV then IN_con.Cv * 24e-6 else if IN_con.valveCoefficient == TYP1.OP then 
          IN_con.m_flow_nominal / max(MIN, IN_con.opening_nominal * (IN_con.rho_nominal 
          * IN_con.dp_nominal) ^ 0.5) else MIN 
          "(公制) 流量系数 Av [Av]=m^2";

        TYP.PressureLossCoefficient zeta_bal = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 10 ^ (-3.8397 * IN_var.opening + 2.9449) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "球阀";
        TYP.PressureLossCoefficient zeta_dia = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 10 ^ (2.2596 * exp(-1.8816 * IN_var.opening)) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "隔膜阀";
        TYP.PressureLossCoefficient zeta_but = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 619.81 * exp(-7.3211 * IN_var.opening) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "蝶阀";
        TYP.PressureLossCoefficient zeta_gat = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 51.45 * exp(-6.046 * IN_var.opening) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "闸阀";
        TYP.PressureLossCoefficient zeta_slu = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 248.89 * exp(-7.8265 * IN_var.opening) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "水闸阀";

        TYP.PressureLossCoefficient zeta_TOT = if IN_con.geometry == TYP2.Ball then 
          zeta_bal else if IN_con.geometry == TYP2.Diaphragm then zeta_dia else if 
          IN_con.geometry == TYP2.Butterfly then zeta_but else if IN_con.geometry 
          == TYP2.Gate then zeta_gat else if IN_con.geometry == TYP2.Sluice then 
          zeta_slu else 0 "所选阀门的压力损失系数";

        Real valveCharacteristic = (2 / min(IN_con.zeta_TOT_max, max(MIN, max(IN_con.zeta_TOT_min, 
          abs(zeta_TOT))))) ^ 0.5 
          "考虑所选阀门开度的阀门特性";

        SI.MassFlowRate m_flow_small = valveCharacteristic * Av * (IN_var.rho) ^ 0.5 * (IN_con.dp_small) 
          ^ 0.5 "线性化时的质量流量";

        //说明

      algorithm
        DP := 1 / ((valveCharacteristic * Av) ^ 2 * IN_var.rho) * 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
          m_flow, 
          m_flow_small, 
          2);

      annotation(Inline = false, smoothOrder(normallyConstant = IN_con) = 2, 
          inverse(m_flow = Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW(
          IN_con, 
          IN_var, 
          DP)), Documentation(info = "<html>
<p>
阀门在整体流动状态下，根据其开度计算具有不同几何形状的阀门的压力损失，用于不可压缩和单相流体流动。
</p>

<p>
通常情况下，此函数在用于模型的<strong>不可压缩情况</strong>时，其中质量流量（m_flow）已知（作为状态变量），需要计算相应的压力损失（DP）时，数值上效果最佳。另一方面，如果压力损失（dp）已知（作为状态变量之外的压力）且需要计算质量流量（M_FLOW），则数值上最适合使用函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\">dp_severalGeometryOverall_MFLOW</a>，用于<strong>可压缩情况</strong>。 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Valve.dp_severalGeometryOverall\">查看更多信息</a>.
</p>
</html>"                      ));

      end dp_severalGeometryOverall_DP;

      function dp_severalGeometryOverall_MFLOW 
        "阀门的压力损失 | 计算质量流量 | 几种几何形状 | 整体流动"
        extends Modelica.Icons.Function;
        import FD = Modelica.Fluid.Dissipation.PressureLoss.Valve;
        import SMOOTH = 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
        import TYP = Modelica.Fluid.Dissipation.Utilities.Types;

        //输入记录表
        input
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_con 
          IN_con "函数 dp_severalGeometryOverall_MFLOW 的输入记录表" 
          annotation(Dialog(group = "常量输入"));
        input
          Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_IN_var 
          IN_var "函数 dp_severalGeometryOverall_MFLOW 的输入记录表" 
          annotation(Dialog(group = "变量输入"));
        input SI.Pressure dp "压降" annotation(Dialog(group = "输入"));

        //输出变量
        output SI.MassFlowRate M_FLOW "质量流量";

      protected
        type TYP1 = 
          Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient annotation();
        type TYP2 = Modelica.Fluid.Dissipation.Utilities.Types.ValveGeometry annotation();

        Real MIN = Modelica.Constants.eps;

        SI.Area Av = if IN_con.valveCoefficient == TYP1.AV then IN_con.Av else if 
          IN_con.valveCoefficient == TYP1.KV then IN_con.Kv * 27.7e-6 else if IN_con.valveCoefficient 
          == TYP1.CV then IN_con.Cv * 24e-6 else if IN_con.valveCoefficient == TYP1.OP then 
          IN_con.m_flow_nominal / max(MIN, IN_con.opening_nominal * (IN_con.rho_nominal 
          * IN_con.dp_nominal) ^ 0.5) else MIN 
          "(公制) 流量系数 Av [Av]=m^2";

        TYP.PressureLossCoefficient zeta_bal = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 10 ^ (-3.8397 * IN_var.opening + 2.9449) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "球阀";
        TYP.PressureLossCoefficient zeta_dia = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 10 ^ (2.2596 * exp(-1.8816 * IN_var.opening)) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "隔膜阀";
        TYP.PressureLossCoefficient zeta_but = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 619.81 * exp(-7.3211 * IN_var.opening) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "蝶阀";
        TYP.PressureLossCoefficient zeta_gat = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 51.45 * exp(-6.046 * IN_var.opening) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "闸阀";
        TYP.PressureLossCoefficient zeta_slu = SMOOTH(
          0.05, 
          0, 
          IN_var.opening) * 248.89 * exp(-7.8265 * IN_var.opening) + SMOOTH(
          0, 
          0.05, 
          IN_var.opening) * IN_con.zeta_TOT_max "水闸阀";

        TYP.PressureLossCoefficient zeta_TOT = if IN_con.geometry == TYP2.Ball then 
          zeta_bal else if IN_con.geometry == TYP2.Diaphragm then zeta_dia else if 
          IN_con.geometry == TYP2.Butterfly then zeta_but else if IN_con.geometry 
          == TYP2.Gate then zeta_gat else if IN_con.geometry == TYP2.Sluice then 
          zeta_slu else 0 "所选阀门的压力损失系数";

        Real valveCharacteristic = (2 / min(IN_con.zeta_TOT_max, max(MIN, max(IN_con.zeta_TOT_min, 
          abs(zeta_TOT))))) ^ 0.5 
          "考虑所选阀门开度的阀门特性";

        //说明

      algorithm
        M_FLOW := valveCharacteristic * Av * (IN_var.rho) ^ 0.5 * 
          Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower(
          dp, 
          IN_con.dp_small, 
          0.5);
      annotation(Inline = false, smoothOrder(normallyConstant = IN_con) = 2, 
          inverse(dp = Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP(
          IN_con, 
          IN_var, 
          M_FLOW)), Documentation(info = "<html>
<p>
阀门在整体流动状态下，根据其开度计算具有不同几何形状的阀门的压力损失，用于不可压缩和单相流体流动。
</p>

<p>
通常情况下，此函数在用于模型的<strong>可压缩情况</strong>时，其中压力损失（dp）已知（作为状态变量之外的压力），需要计算相应的质量流量（M_FLOW）时，数值上效果最佳。另一方面，如果质量流量（m_flow）已知（作为状态变量）且需要计算压力损失（DP），则数值上最适合使用函数<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\">dp_severalGeometryOverall_DP</a>，用于<strong>不可压缩情况</strong>。 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Valve.dp_severalGeometryOverall\">查看更多信息</a>.
</p>
</html>"                      ));

      end dp_severalGeometryOverall_MFLOW;

      record dp_severalGeometryOverall_IN_con 
        "函数 dp_severalGeometryOverall_DP 和 dp_severalGeometryOverall_MFLOW 的输入记录表"

        extends Modelica.Icons.Record;

        Modelica.Fluid.Dissipation.Utilities.Types.ValveGeometry geometry = Dissipation.Utilities.Types.ValveGeometry.Ball 
          "阀门几何形状的选择" annotation(Dialog(group = "阀门"));
        Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient 
          valveCoefficient = 
          Modelica.Fluid.Dissipation.Utilities.Types.ValveCoefficient.AV 
          "阀门系数的选择" annotation(Dialog(group = "阀门"));

        //valve variables
        Real Av = PI * 0.1 ^ 2 / 4 "（公制）流量系数 Av [Av]=m^2" annotation(Dialog(
          group = "阀门", enable = valveCoefficient == 1));
        Real Kv = Av / 27.7e-6 "（公制）流量系数 Kv [Kv]=m^3/h" annotation(
          Dialog(group = "阀门", enable = valveCoefficient == 2));
        Real Cv = Av / 24.6e-6 "（US）流量系数 Cv [Cv]=USG/min" annotation(Dialog(
          group = "阀门", enable = valveCoefficient == 3));
        SI.Pressure dp_nominal = 1e3 "额定压降" annotation(Dialog(group = 
          "阀门", enable = valveCoefficient == 4));
        SI.MassFlowRate m_flow_nominal = opening_nominal * Av * (rho_nominal * dp_nominal) ^ 
          0.5 "额定质量流量" annotation(Dialog(group = "阀门", enable = 
          valveCoefficient == 4));
        SI.Density rho_nominal = 1000 "额定入口密度" annotation(Dialog(group = 
          "阀门", enable = valveCoefficient == 4));
        Real opening_nominal = 0.5 "额定开度" annotation(Dialog(group = "阀门", 
          enable = valveCoefficient == 4));
        Real zeta_TOT_min = 1e-3 
          "全开时最小压力损失系数" 
          annotation(Dialog(group = "阀门"));
        Real zeta_TOT_max = 1e8 
          "闭合开口时的最大压力损失系数" 
          annotation(Dialog(group = "阀门"));

        //数值方面
        SI.Pressure dp_small = 0.01 * dp_nominal 
          "对小于 dp_small 的压力损失进行线性化处理" 
          annotation(Dialog(group = "线性化"));

        annotation(Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\" target=\"\">dp_severalGeometryOverall_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\" target=\"\">dp_severalGeometryOverall_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"            ));
      end dp_severalGeometryOverall_IN_con;

      record dp_severalGeometryOverall_IN_var 
        "函数 dp_severalGeometryOverall_DP 和 dp_severalGeometryOverall_MFLOW 的输入记录表"

        extends Modelica.Icons.Record;

        //阀门变量
        Real opening = 1 "阀门开度 | 0== 关闭，1== 完全打开" 
          annotation(Dialog(group = "阀门"));

        //流体性质变量
        SI.DynamicViscosity eta "流体动力黏度" 
          annotation(Dialog(group = "流体性质"));
        SI.Density rho "流体密度" 
          annotation(Dialog(group = "流体性质"));

        annotation(Documentation(info="<html><p>
<br>该记录表用作压降函数 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_DP\" target=\"\">dp_severalGeometryOverall_DP</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.Valve.dp_severalGeometryOverall_MFLOW\" target=\"\">dp_severalGeometryOverall_MFLOW</a>的<strong>输入记录</strong>。
</p>
</html>"      ));
      end dp_severalGeometryOverall_IN_var;
    annotation(preferredView = "info", Documentation(info = "<html>
<h4>阀门</h4>
<h5>多种几何形状</h5>
<p>
根据阀门的开度，在不可压缩和单相流体流动的整体流动状态下计算具有不同几何形状的阀门的压力损失。
<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.Valve.dp_severalGeometryOverall\">查看更多信息</a>.
</p>

</html>"          ));

    end Valve;
    annotation();
  end PressureLoss;

  package Utilities "公用子库（不得直接使用）"
  extends Modelica.Icons.UtilitiesPackage;
    package SharedDocumentation "共享文档"
      extends Modelica.Icons.Information;

      package HeatTransfer
        extends Modelica.Icons.Information;

        package Channel
        extends Modelica.Icons.Information;

        class kc_evenGapLaminar
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html><p>
计算不同流体流动和传热情况下，通过均匀间隙的层流流动的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_evenGapLaminar</strong> 和 <strong>kc_evenGapLaminar_KC</strong></h4><p>
基本上有三个不同之处：
</p>
<ul><li>
函数 <strong>kc_evenGapLaminar</strong> 使用 <strong>kc_evenGapLaminar_KC</strong>，但提供了额外的输出变量，例如雷诺数或努塞尔数和故障状态（输出 <strong>1</strong> 表示函数对于输入无效）。</li>
<li>
一般来说，函数 <strong>kc_evenGapLaminar_KC</strong> 在已知质量流量的情况下，数值计算最佳的平均对流传热系数 <strong>kc</strong>。</li>
<li>
您可以从 <strong>kc_evenGapLaminar_KC</strong> 进行逆向计算，即通过给定的平均对流传热系数 <strong>kc</strong> 计算未知的质量流量。</li>
</ul><h4>限制</h4><ul><li>
层流区 (雷诺数 ≤ 2200)</li>
<li>
已开发流体流动</li>
<li>
未开发流体流动</li>
</ul><h4>几何形状</h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/gap.png\" alt=\"间隙\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
通过相应的努塞尔数 <strong>Nu_lam</strong> 计算均匀间隙的平均对流传热系数 <strong>kc</strong>，依据 <em>[VDI 2002, p. Gb 7, eq. 43]</em> :
</p>
<pre><code >Nu_lam = [(Nu_1)^3 + (Nu_2)^3 + (Nu_3)^3]^(1/3)
</code></pre><p>
对应的平均对流传热系数 <strong>kc</strong> 为：
</p>
<pre><code >kc =  Nu_lam * lambda / d_hyd
</code></pre><p>
公式中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> cp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 常压下的比热容 [J/(kg.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd = 2*s </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 间隙的水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的动力黏度 [Pa.s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> h </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 间隙横截面高度 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> kc </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均对流传热系数 [W/(m2.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的热导率 [W/(m.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 间隙的流经长度（垂直于横截面）[m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Nu_lam </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均努塞尔数 [-], </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Pr = eta*cp/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 普朗特数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体密度 [kg/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> s </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平行板之间的间距 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re = rho*v*d_hyd/eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> v </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 间隙中的平均速度 [m/s].</td></tr></tbody></table><p>
选择的流体流动和传热情况的平均努塞尔数 <strong>Nu_lam</strong> 的加和项计算如下：
</p>
<ul><li>
已开发流体流动</li>
<li>
未开发流体流动</li>
</ul><p>
请注意，流体性质应通过流体在间隙入口和出口处的流动温度的算术平均温度来计算。
</p>
<h4>验证</h4><p>
表示平均对流传热系数 <strong>kc</strong> 的平均努塞尔数 <strong>Nu_lam</strong>，根据选择的流体流动和传热情况（目标）显示在下图中。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/kc_evenGapLaminar.png\" alt=\"kc_evenGapLaminar\" data-href=\"\" style=\"\"/>
</p>
<h4>参考文献</h4><p>
Bejan,A.:
</p>
<p>
<strong>传热手册</strong>.<br>Wiley, 2003.
</p>
<p>
VDI:
</p>
<p>
<strong>VDI - 热力图册: 热传导计算表</strong>.<br>Springer Verlag, 第九版, 2002.
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
</html>"    ));
        end kc_evenGapLaminar;

        class kc_evenGapOverall
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html><p>
计算不同流体流动和传热情况下，通过均匀间隙的层流或湍流流动的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_evenGapOverall</strong> 和 <strong>kc_evenGapOverall_KC</strong></h4><p>
基本上有三个不同之处：
</p>
<ul><li>
函数 <strong>kc_evenGapOverall</strong> 使用 <strong>kc_evenGapOverall_KC</strong>，但提供了额外的输出变量，例如雷诺数或努塞尔数和故障状态（输出 <strong>1</strong> 表示函数对于输入无效）。</li>
<li>
一般来说，函数 <strong>kc_evenGapOverall_KC</strong> 在已知质量流量的情况下，数值计算最佳的平均对流传热系数 <strong>kc</strong>。</li>
<li>
您可以从 <strong>kc_evenGapOverall_KC</strong> 进行逆向计算，即通过给定的平均对流传热系数 <strong>kc</strong> 计算未知的质量流量。</li>
</ul><h4>限制</h4><ul><li>
已开发流体流动 </li>
<li>
未开发流体流动 </li>
<li>
湍流区总是计算已开发流体流动，并且从间隙的两侧传热 (target=Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevBoth)</li>
</ul><h4>几何形状和计算</h4><p>
此传热函数支持层流和湍流区的传热系数计算。函数的几何形状、常量和流体参数与 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapLaminar\" target=\"\">kc_evenGapLaminar</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Channel.kc_evenGapTurbulent\" target=\"\">kc_evenGapTurbulent</a> 相同。
</p>
<p>
层流和湍流流动的计算条件与 <strong>kc_evenGapLaminar</strong> 和 <strong>kc_evenGapTurbulent</strong> 的计算条件相同。在 2200 ≤ Re ≤ 30000 之间进行两个函数的平滑过渡（见下图）。
</p>
<h4>验证</h4><p>
表示平均对流传热系数 <strong>kc</strong> 的平均努塞尔数 <strong>Nu</strong>，根据选择的流体流动和传热情况（目标）显示在下图中。
</p>
<ul><li>
目标 1: 已开发流体流动并从间隙的一侧传热</li>
<li>
目标 2: 已开发流体流动并从间隙的两侧传热</li>
<li>
目标 3: 未开发流体流动并从间隙的一侧传热</li>
<li>
目标 4: 未开发流体流动并从间隙的两侧传热</li>
</ul><p>
所有目标的验证见下图，参考：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/kc_evenGapOverall.png\" alt=\"kc_evenGapOverall\" data-href=\"\" style=\"\"/>
</p>
<h4>参考文献</h4><p>
Bejan,A.:
</p>
<p>
<strong>传热手册</strong>.<br>Wiley, 2003.
</p>
<p>
VDI:
</p>
<p>
<strong>VDI - 热力图册: 热传导计算表</strong>.<br>Springer Verlag, 第九版, 2002.
</p>
</html>"    ));
        end kc_evenGapOverall;

        class kc_evenGapTurbulent
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html><p>
计算已开发湍流流动通过均匀间隙时从两侧传热的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_evenGapTurbulent</strong> 和 <strong>kc_evenGapTurbulent_KC</strong></h4><p>
基本上有三个不同之处：
</p>
<ul><li>
函数 <strong>kc_evenGapTurbulent</strong> 使用 <strong>kc_evenGapTurbulent_KC</strong>，但提供了额外的输出变量，例如雷诺数或努塞尔数和失败状态（输出 <strong>1</strong> 表示函数对于输入无效）。</li>
<li>
一般来说，函数 <strong>kc_evenGapTurbulent_KC</strong> 在已知质量流量的情况下，数值计算最佳的平均对流传热系数 <strong>kc</strong>。</li>
<li>
您可以从 <strong>kc_evenGapTurbulent_KC</strong> 进行逆向计算，即通过给定的平均对流传热系数 <strong>kc</strong> 计算未知的质量流量。</li>
</ul><h4>限制</h4><ul><li>
相同且恒定的壁温</li>
<li>
水力直径与间隙长度之比 (d_hyd / L) ≤ 1</li>
<li>
0.5 ≤ 普朗特数 Pr ≤ 100</li>
<li>
湍流区 (3e4 ≤ 雷诺数 ≤ 1e6)</li>
<li>
已开发流体流动</li>
<li>
从间隙的两侧传热 (target = Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap.DevBoth)</li>
</ul><h4>几何形状</h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/gap.png\" alt=\"gap\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
均匀间隙的平均对流传热系数 <strong>kc</strong> 通过相应的努塞尔数 <strong>Nu_turb</strong> 根据 <em>Gnielinski 在 [VDI 2002, p. Gb 7, sec. 2.4]</em> 计算
</p>
<pre><code >Nu_turb =(zeta/8)*Re*Pr/{1+12.7*[zeta/8]^(0.5)*[Pr^(2/3) -1]}*{1+[d_hyd/L]^(2/3)}
</code></pre><p>
压力损失系数 <strong>zeta</strong> 根据 <em> Konakov 在 [VDI 2002, p. Ga 5, eq. 27]</em> 由以下公式确定
</p>
<pre><code >zeta =  1/[1.8*log10(Re) - 1.5]^2
</code></pre><p>
由此得到相应的平均对流传热系数 <strong>kc</strong>
</p>
<pre><code >kc =  Nu_turb * lambda / d_hyd
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> cp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 常压比热容 [J/(kg.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd = 2*s </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 间隙的水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的动力黏度 [Pa.s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> h </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 间隙横截面积的高度 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> kc </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均对流传热系数 [W/(m2.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的热导率 [W/(m.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 间隙的溢流长度（垂直于横截面积）[m] ,</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Nu_turb </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 湍流区的平均努塞尔数 [-], </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Pr = eta*cp/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 普朗特数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体密度 [kg/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> s </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平行板之间的距离 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re = rho*v*d_hyd/eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> v </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 间隙中的平均速度 [m/s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> zeta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 压力损失系数 [-].</td></tr></tbody></table><p>
请注意，流体流动性质应以入口和出口流体温度的算术平均温度计算。
</p>
<h4>验证</h4><p>
表示平均对流传热系数 <strong>kc</strong> 的平均努塞尔数 <strong>Nu_turb</strong> 根据所选的流体流动和传热情况（目标）显示在下图中。
</p>
<ul><li>
目标 2: 已开发流体流动并从间隙的两侧传热</li>
<li>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Channel/kc_evenGapTurbulent.png\" alt=\"kc_evenGapTurbulent\" data-href=\"\" style=\"\"/></li>
</ul><h4>参考文献</h4><p>
VDI:
</p>
<p>
<strong>VDI - 热力图册: 热传导计算表</strong>.<br>Springer Verlag, 第九版, 2002.
</p>
<p>
<br>
</p>
</html>"    ));
        end kc_evenGapTurbulent;
          annotation();

        end Channel;

        package General
        extends Modelica.Icons.Information;

        class kc_approxForcedConvection
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html><p>
已开发湍流流动强制对流下平均对流传热系数 <strong>kc</strong> 的近似计算。
</p>
<h4>函数 <strong>kc_approxForcedConvection</strong> 和 <strong>kc_approxForcedConvection_KC</strong></h4><p>
基本上有三个不同之处：
</p>
<ul><li>
函数 <strong>kc_approxForcedConvection</strong> 使用 <strong>kc_approxForcedConvection_KC</strong>，但提供了额外的输出变量，例如雷诺数或努塞尔数和故障状态（输出 <strong>1</strong> 表示函数对于输入无效）。</li>
<li>
一般来说，函数 <strong>kc_approxForcedConvection_KC</strong> 在已知质量流量的情况下，数值计算最佳的平均对流传热系数 <strong>kc</strong>。</li>
<li>
您可以从 <strong>kc_approxForcedConvection_KC</strong> 进行逆向计算，即通过给定的平均对流传热系数 <strong>kc</strong> 计算未知的质量流量。</li>
</ul><h4>限制</h4><ul><li>
恒定的壁温 <strong>或</strong> 恒定的热流</li>
<li>
湍流区 (雷诺数 2500 &lt; Re &lt; 1e6)</li>
<li>
普朗特数 0.5 ≤ Pr ≤ 500</li>
</ul><h4>计算</h4><p>
平均对流传热系数 <strong>kc</strong> 通过不同的努塞尔数 <strong>Nu</strong> 相关性近似计算，参考 <em>[Bejan 2003, p. 424 ff]</em>。 最粗略的近似根据 Dittus/Boelter (1930):
</p>
<pre><code >Nu_1 = 0.023 * Re^(4/5) * Pr^(exp_Pr)
</code></pre><p>
根据 Sieder/Tate (1936) 考虑流体性质的温度依赖性的中等近似：
</p>
<pre><code >Nu_2 = 0.023 * Re^(4/5) * Pr^(1/3) * (eta/eta_wall)^(0.14)
</code></pre><p>
根据 Gnielinski (1976) 的精细近似：
</p>
<pre><code >Nu_3 = 0.0214 * [Re^(0.8) - 100] * Pr^(0.4) 对于 Pr ≤ 1.5
= 0.012 * [Re^(0.87) - 280] * Pr^(0.4) 对于 Pr &gt; 1.5
</code></pre><p>
平均对流传热系数 <strong>kc</strong> 的计算公式为：
</p>
<pre><code >kc =  Nu * lambda / d_hyd
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的动力黏度 [Pa.s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> eta_wall </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 壁温下流体的动力黏度 [Pa.s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> exp_Pr </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 普朗特数的指数，针对 Dittus/Boelter (0.4 用于加热或 0.3 用于冷却) [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> kc </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均对流传热系数 [W/(m2.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的热导率 [W/(m.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Nu_1/2/3 </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均努塞尔数 [-], </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Pr </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 普朗特数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-].</td></tr></tbody></table><h4>验证</h4><p>
表示平均对流传热系数 <strong>kc</strong> 的平均努塞尔数 <strong>Nu</strong> 针对不同流体的普朗特数显示在下图中。
</p>
<p>
<strong>Dittus/Boelter</strong> (目标 = Modelica.Fluid.Dissipation.Utilities.Types.kc_general.Rough)
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/General/kc_approxForcedConvection_T1.png\" alt=\"kc_approxForcedConvection_T1\" data-href=\"\" style=\"\"/>
</p>
<p>
<strong>Sieder/Tate</strong> (目标 = Modelica.Fluid.Dissipation.Utilities.Types.kc_general.Middle)
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/General/kc_approxForcedConvection_T2.png\" alt=\"kc_approxForcedConvection_T2\" data-href=\"\" style=\"\"/>
</p>
<p>
<strong>Gnielinski</strong> (目标 = Modelica.Fluid.Dissipation.Utilities.Types.kc_general.Finest)
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/General/kc_approxForcedConvection_T3.png\" alt=\"kc_approxForcedConvection_T3\" data-href=\"\" style=\"\"/>
</p>
<p>
请注意，所有流体性质应以装置入口和出口之间的流体平均温度计算。
</p>
<h4>参考文献</h4><p>
Bejan,A.:
</p>
<p>
<strong>传热手册</strong>.<br>Wiley, 2003.
</p>
<p>
<br>
</p>
</html>"    ));
        end kc_approxForcedConvection;
          annotation();
        end General;

        package HeatExchanger
        extends Modelica.Icons.Information;

        class kc_flatTube
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html>
<p>
针对具有平板管和多种鳍片几何形状的换热器的空气侧传热，计算平均对流传热系数 <strong>kc</strong>。
</p>
<h4>函数 <strong>kc_flatTube</strong> 和 <strong>kc_flatTube_KC</strong></h4>
<p>
基本上有三个不同之处：
</p>
<ul>
<li>
函数 <strong>kc_flatTube</strong> 使用 <strong>kc_flatTube_KC</strong>，但提供了额外的输出变量，例如雷诺数或努塞尔数和失败状态（输出 <strong>1</strong> 表示函数对于输入无效）。</li>
<li>
一般来说，函数 <strong>kc_flatTube_KC</strong> 在已知质量流量的情况下，数值计算最佳的平均对流传热系数 <strong>kc</strong>。</li>
<li>
您可以从 <strong>kc_flatTube_KC</strong> 进行逆向计算，即通过给定的平均对流传热系数 <strong>kc</strong> 计算未知的质量流量。
</li>
</ul>

<h4>限制</h4>
<ul>
<li>根据鳍片几何形状，计算在 <strong>Re</strong> 从 100 到 5000 的范围内有效。</li>
<li>介质 = 空气</li>
</ul>

<h4>几何形状</h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HeatExchanger/flatTube.png\" width=\"850\" alt=\"flatTube\"/>
</div>

<h4>计算</h4>
<p>
换热器的平均对流传热系数 <strong>kc</strong> 通过相应的库尔本因子 <strong>j</strong> 计算：
</p>
<blockquote><pre>
j = f(geometry, Re)
</pre></blockquote>

<p>
计算得到的平均对流传热系数 <strong>kc</strong> 为
</p>

<blockquote><pre>
kc =  j * Re_L_p * Pr^(1/3) * lambda / L_p (传热鳍片)
</pre></blockquote>

<p>
或
</p>

<blockquote><pre>
kc =  j * Re_D_h * Pr^(1/3) * lambda / D_h (矩形偏移条鳍片)
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> D_h                        </strong></td><td> 水力直径 [m],</td></tr>
<tr><td><strong> kc                         </strong></td><td> 平均对流传热系数 [W/(m2K)],</td></tr>
<tr><td><strong> lambda                     </strong></td><td> 流体的热导率 [W/(mK)],</td></tr>
<tr><td><strong> L_p                        </strong></td><td> 传热鳍片间距 [m],</td></tr>
<tr><td><strong> Nu_D_h = kc*D_h/lambda     </strong></td><td> 基于水力直径的平均努塞尔数 [-], </td></tr>
<tr><td><strong> Nu_L_p = kc*L_p/lambda     </strong></td><td> 基于传热鳍片间距的平均努塞尔数 [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda         </strong></td><td> 普朗特数 [-],</td></tr>
<tr><td><strong> Re_D_h = rho*v*D_h/eta     </strong></td><td> 基于水力直径的雷诺数 [-],</td></tr>
<tr><td><strong> Re_L_p = rho*v*L_p/eta     </strong></td><td> 基于传热鳍片间距的雷诺数 [-],</td></tr>
</table>

<h4>验证</h4>
<p>
表示平均对流传热系数 <strong>kc</strong> 的平均努塞尔数 <strong>Nu</strong> 如下所示，用于不同鳍片几何形状下的相似尺寸。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HeatExchanger/kc_flatTube.png\" alt=\"kc_flatTube\"/>
</div>

<h4>参考文献</h4>
<dl>
<dt>Y.-J. CHANG 和 C.-C. WANG:</dt>
<dd><strong>传热鳍片几何形状的一般传热关联</strong>.
在《国际传热与质量传递期刊》, 第 40 卷, 第 3 期, 页 533-544, 1997.</dd>
<dt>Y.-J. CHANG 和 C.-C. WANG:</dt>
<dd><strong>钎焊铝换热器的空气侧性能</strong>.
在《增强传热期刊》, 第 3 卷, 第 1 期, 页 15-28, 1996.</dd>
<dt>R.-M. Manglik, A.-E. Bergles:</dt>
<dd><strong>矩形偏移条鳍片紧凑型换热器的传热和压降关联</strong>.
在《实验热与流体科学》, 第 10 卷, 页 171-180, 1995.</dd>
</dl>

</html>"              ));
        end kc_flatTube;

        class kc_roundTube
          extends Modelica.Icons.Information;
            annotation (Documentation(info="<html>
<p>
计算圆管换热器空气侧传热的平均对流传热系数<strong>kc</strong>，以及多种鳍片几何形状的换热器。
</p>
<h4>函数 <strong>kc_roundTube</strong> 和 <strong>kc_roundTube_KC</strong></h4>
<p>
基本上有三个区别：
</p>
<ul>
<li>
函数 <strong>kc_roundTube</strong> 使用 <strong>kc_roundTube_KC</strong>，但提供额外的输出变量，如雷诺数或努塞尔特数以及故障状态（输出<strong>1</strong>表示该函数对于输入无效）。</li>
<li>
通常，函数 <strong>kc_roundTube_KC</strong> 在已知质量流量时最适用于计算平均对流传热系数<strong>kc</strong>。</li>
<li>
您可以通过<strong>kc_roundTube_KC</strong>进行反向计算，从而根据给定的平均对流传热系数<strong>kc</strong>计算出未知的质量流量。
</li>
</ul>

<h4>限制</h4>
<ul>
<li>根据鳍片几何形状的不同，计算在<strong>Re</strong>从300到8000的范围内有效。</li>
<li>介质 = 空气</li>
</ul>

<h4>几何形状 </h4>
<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HeatExchanger/roundTube.png\" width=\"850\" alt=\"roundTube\"/>
</div>

<h4>计算</h4>
<p>
换热器的平均对流传热系数<strong>kc</strong>通过对应的库伯尔因子<strong>j</strong>计算：
</p>

<blockquote><pre>
j = f(geometry, Re)
</pre></blockquote>

<p>
得到平均对流传热系数<strong>kc</strong>
</p>

<blockquote><pre>
kc =  j * Re * Pr^(1/3) * lambda / D_c
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> D_c                        </strong></td><td> 鳍片环直径 [m],</td></tr>
<tr><td><strong> kc                         </strong></td><td> 平均对流传热系数 [W/(m2K)],</td></tr>
<tr><td><strong> lambda                     </strong></td><td> 流体的导热系数 [W/(mK)],</td></tr>
<tr><td><strong> Nu = kc*D_c/lambda         </strong></td><td> 平均努塞尔特数 [-], </td></tr>
<tr><td><strong> Pr = eta*cp/lambda         </strong></td><td> 普朗特数 [-],</td></tr>
<tr><td><strong> Re = rho*v*D_c/eta         </strong></td><td> 雷诺数 [-],</td></tr>
</table>

<h4>验证</h4>
<p>
不同鳍片几何形状的平均努塞尔特数 <strong>Nu</strong> 表示平均对流传热系数 <strong>kc</strong>，如下所示，尺寸相似。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HeatExchanger/kc_roundTube.png\" alt=\"kc_roundTube\"/>
</div>

<h4>参考文献</h4>
<dl>
<dt>C.-C. Wang, C.-T. Chang:</dt>
<dd><strong>板片鳍管式换热器的传热和传质，包括具有和不具有亲水涂层的情况</strong>。
在《国际传热与传质杂志》，卷41，第3109-3120页，1998年。</dd>
<dt>C.-C. Wang, C.-J. Lee, C.-T. Chang, S.-P. Lina:</dt>
<dd><strong>紧凑型镂空鳍片管式换热器的传热和摩擦相关性</strong>。
在《国际传热与传质杂志》，卷42，第1945-1956页，1999年。</dd>
<dt>C.-C. Wang, W.-H. Tao, C.-J. Chang:</dt>
<dd><strong>气缝鳍片管式换热器空气侧性能的研究</strong>。
在《国际制冷学报》，卷22，第595-603页，1999年。</dd>
<dt>C.-C. Wang, W.-L. Fu, C.-T. Chang:</dt>
<dd><strong>典型波浪鳍片管式换热器的传热和摩擦特性</strong>。
在《实验热力学与流体科学》，卷14，第174-186页，1997年。</dd>
</dl>
</html>"              ));
        end kc_roundTube;
          annotation();

        end HeatExchanger;

        package HelicalPipe
        extends Modelica.Icons.Information;

        class kc_laminar
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html><p>
计算层流流动状态下螺旋管的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_laminar</strong> 和 <strong>kc_laminar_KC</strong></h4><p>
基本上有三个区别：
</p>
<ul><li>
函数 <strong>kc_laminar</strong> 使用 <strong>kc_laminar_KC</strong>，但提供额外的输出变量，如雷诺数或努塞尔特数以及故障状态（输出<strong>1</strong>表示该函数对于输入无效）。</li>
<li>
通常，函数 <strong>kc_laminar_KC</strong> 在已知质量流量时最适用于计算平均对流传热系数<strong>kc</strong>。</li>
<li>
您可以通过<strong>kc_laminar_KC</strong>进行反向计算，从而根据给定的平均对流传热系数<strong>kc</strong>计算出未知的质量流量。</li>
</ul><h4>限制</h4><ul><li>
层流区域（雷诺数≤临界雷诺数<strong>Re_crit</strong>）</li>
<li>
依据<em>Sieder和Tate </em>的研究忽略了热传递方向（加热/冷却）的影响。</li>
</ul><p>
螺旋管的临界雷诺数<strong>Re_crit</strong>取决于其平均曲率直径<strong>d_coil</strong>。 螺旋管的平均曲率直径越小，由于高离心力而产生的涡流就越早，湍流区就会开始。
</p>
<h4>几何形状 </h4><p>
<img src=\"D:/GDM/SYSLINK/modelica2/Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/helicalPipe.png\" alt=\"helicalPipe\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
螺旋管的平均对流传热系数<strong>kc</strong>通过对应的努塞尔特数<strong>Nu</strong>根据<em>[VDI 2002, p. Gc 2, eq. 5]</em>计算：
</p>
<pre><code >Nu = 3.66 + 0.08*[1 + 0.8*(d_hyd/d_coil)^0.9]*Re^m*Pr^(1/3)
</code></pre><p>
其中雷诺数的指数<strong>m</strong>
</p>
<pre><code >m = 0.5 + 0.2903*(d_hyd/d_coil)^0.194
</code></pre><p>
以及结果平均对流传热系数<strong>kc</strong>
</p>
<pre><code >kc =  Nu * lambda / d_hyd
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_mean</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的平均直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_coil = f(geometry)</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的平均曲率直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>d_hyd</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>h</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的斜率 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>kc</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均对流传热系数 [W/(m2K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>lambda</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的导热系数 [W/(mK)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>L</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的总长度 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Nu = kc*d_hyd/lambda</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均努塞尔特数 [-], </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Pr = eta*cp/lambda</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 普朗特数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Re = rho*v*d_hyd/eta</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Re_crit = f(geometry)</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 临界雷诺数 [-].</td></tr></tbody></table><h4>验证</h4><p>
不同转数<strong>n_nt</strong>的螺旋管的平均努塞尔特数<strong>Nu</strong>表示平均对流传热系数<strong>kc</strong>，如下所示，在螺旋管的总长度相同的情况下。
</p>
<p>
<img src=\"D:/GDM/SYSLINK/modelica2/Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/kc_laminar.png\" alt=\"kc_laminar\" data-href=\"\" style=\"\"/>
</p>
<p>
与直管相比，螺旋管的对流传热由于由离心力产生的湍流而增强。转数越多，对于相同长度的管道，对流传热就越好。
</p>
<p>
请注意，水力直径与螺旋管的总长度的比值<strong>d_hyd/L</strong>对传热系数<strong>kc</strong>几乎没有影响。
</p>
<h4>参考文献</h4><p>
GNIELINSKI, V.:
</p>
<p>
<strong>螺旋盘管中的传热和压降。</strong>.<br>在第8届国际传热大会上，第6卷，第2847-2854页，Washington,1986. Hemisphere.
</p>
<p>
<br>
</p>
</html>"    ));
        end kc_laminar;

        class kc_overall
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
计算螺旋管在水动力学发展的层流和湍流流动状态下的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_overall</strong> 和 <strong>kc_overall_KC</strong></h4>
<p>
基本上有三个区别：
</p>
<ul>
<li>
函数 <strong>kc_overall</strong> 使用 <strong>kc_overall_KC</strong>，但提供额外的输出变量，如雷诺数或努塞尔特数以及故障状态（输出<strong>1</strong>表示该函数对于输入无效）。</li>
<li>
通常，函数 <strong>kc_overall_KC</strong> 在已知质量流量时最适用于计算平均对流传热系数<strong>kc</strong>。</li>
<li>
您可以通过<strong>kc_overall_KC</strong>进行反向计算，从而根据给定的平均对流传热系数<strong>kc</strong>计算出未知的质量流量。
</li>
</ul>

<h4>几何形状和计算 </h4>

<p>这个传热函数可以计算层流和湍流流动状态下的传热系数。函数的几何形状、常数和流体参数与<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\">kc_laminar</a>和<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">kc_turbulent</a>相同。
</p>
<p>
层流和湍流的计算条件与<strong>kc_laminar</strong>和<strong>kc_turbulent</strong>中的计算相同。在2200 &le; Re &le; 30000范围内，两个函数之间进行平滑过渡（见下图）。</p>

<h4>验证</h4>
<p>
不同转数<strong>n_nt</strong>的螺旋管的平均努塞尔特数<strong>Nu</strong>表示平均对流传热系数<strong>kc</strong>，如下所示，在螺旋管的总长度相同的情况下。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/kc_overall.png\" alt=\"kc_overall\"/>
</div>

<p>
与直管相比，螺旋管的对流传热由于由离心力产生的湍流而增强。转数越多，对于相同长度的管道，对流传热就越好。
</p>

<p>
请注意，水力直径与螺旋管的总长度的比值<strong>d_hyd/L</strong>对传热系数<strong>kc</strong>几乎没有影响。
</p>

<h4>参考文献</h4>
<dl>
<dt>GNIELINSKI, V.:</dt>
<dd><strong>螺旋盘管中的传热和压降。</strong>.
在第8届国际传热大会上，第6卷，第2847-2854页，Washington,1986. Hemisphere.</dd>
</dl>
</html>"              ));
        end kc_overall;

        class kc_turbulent
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html><p>
计算螺旋管在湍流流动状态下的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_turbulent</strong> 和 <strong>kc_turbulent_KC</strong></h4><p>
基本上有三个区别：
</p>
<ul><li>
函数 <strong>kc_turbulent</strong> 使用 <strong>kc_turbulent_KC</strong>，但提供额外的输出变量，如雷诺数或努塞尔特数以及故障状态（输出<strong>1</strong>表示该函数对于输入无效）。</li>
<li>
通常，函数 <strong>kc_turbulent_KC</strong> 在已知质量流量时最适用于计算平均对流传热系数<strong>kc</strong>。</li>
<li>
您可以通过<strong>kc_turbulent_KC</strong>进行反向计算，从而根据给定的平均对流传热系数<strong>kc</strong>计算出未知的质量流量。</li>
</ul><p>
螺旋管中的临界雷诺数<strong>Re_crit</strong>取决于其平均曲率直径。螺旋管的平均曲率直径 <strong>d_mean</strong> 越小，由于更高的离心力造成的涡流，湍流区将越早开始。
</p>
<h4>几何形状 </h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/helicalPipe.png\" alt=\"helicalPipe\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
螺旋管的平均对流传热系数<strong>kc</strong>通过相应的努塞尔特数<strong>Nu</strong>计算，根据 <em>[VDI 2002, p. Ga 2, eq. 6]</em>：
</p>
<pre><code >Nu = (zeta_TOT/8)*Re*Pr/{1 + 12.7*(zeta_TOT/8)^0.5*[Pr^(2/3)-1]},
</code></pre><p>
其中考虑了压力损失对传热计算的影响
</p>
<pre><code >zeta_TOT = 0.3164*Re^(-0.25) + 0.03*(d_hyd/d_coil)^(0.5) and
</code></pre><p>
和得到的平均对流传热系数<strong>kc</strong>
</p>
<pre><code >kc =  Nu * lambda / d_hyd
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_mean </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的平均直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_coil = f(geometry) </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的平均曲率直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> h </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的斜率 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> kc </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均对流传热系数 [W/(m2K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的导热系数 [W/(mK)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 螺旋管的总长度 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Nu = kc*d_hyd/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均努塞尔特数 [-], </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Pr = eta*cp/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 普朗特数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re = rho*v*d_hyd/eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re_crit = f(geometry) </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 临界雷诺数 [-].</td></tr></tbody></table><h4>验证</h4><p>
不同转数<strong>n_nt</strong>的螺旋管的平均努塞尔特数<strong>Nu</strong>表示平均对流传热系数<strong>kc</strong>，如下所示，在螺旋管的总长度相同的情况下。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/HelicalPipe/kc_turbulent.png\" alt=\"kc_turbulent\" data-href=\"\" style=\"\"/>
</p>
<p>
与直管相比，螺旋管的对流传热由于由离心力产生的湍流而增强。转数越多，对于相同长度的管道，对流传热就越好。
</p>
<p>
请注意，水力直径与螺旋管的总长度的比值<strong>d_hyd/L</strong>对传热系数<strong>kc</strong>几乎没有影响。
</p>
<h4>参考文献</h4><p>
GNIELINSKI, V.:
</p>
<p>
<strong>螺旋盘管中的传热和压降。</strong>.<br>在第8届国际传热大会上，第6卷，第2847-2854页，Washington,1986. Hemisphere.
</p>
<p>
<br>
</p>
</html>"    ));
        end kc_turbulent;
          annotation();

        end HelicalPipe;

        package Plate
        extends Modelica.Icons.Information;

        class kc_laminar
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html><p>
计算平板上层流流动的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_laminar</strong> 和 <strong>kc_laminar_KC</strong></h4><p>
基本上有三个区别：
</p>
<ul><li>
函数 <strong>kc_laminar</strong> 使用 <strong>kc_laminar_KC</strong>，但提供额外的输出变量，如雷诺数或努塞尔特数以及故障状态（输出<strong>1</strong>表示该函数对于输入无效）。</li>
<li>
通常，函数 <strong>kc_laminar_KC</strong> 在已知质量流量时最适用于计算平均对流传热系数<strong>kc</strong>。</li>
<li>
您可以通过<strong>kc_laminar_KC</strong>进行反向计算，从而根据给定的平均对流传热系数<strong>kc</strong>计算出未知的质量流量。</li>
</ul><h4>限制</h4><ul><li>
层流区域（雷诺数 ≤ 1e5）</li>
<li>
普朗特数 0.6 ≤ Pr ≤ 2000</li>
</ul><h4>几何形状 </h4><p>
<img src=\"D:/GDM/SYSLINK/modelica2/Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/plate.png\" alt=\"plate\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
平板的平均对流传热系数<strong>kc</strong>通过对应的层流努塞尔特数<strong>Nu_lam</strong>计算得出，根据 <em>[VDI 2002, p. Gd 1, eq. 1]</em>：
</p>
<pre><code >Nu_lam = 0.664 * Re^(0.5) * (Pr)^(1/3)
</code></pre><p>
以及相应的平均对流传热系数<strong>kc</strong>:
</p>
<pre><code >kc =  Nu_lam * lambda / L
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> cp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 在恒定压力下的比热容 [J/(kg.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的动力黏度 [Pa.s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> kc </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均对流传热系数 [W/(m2.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的导热系数 [W/(m.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平板的长度 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Nu_lam </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 层流区域的平均努塞尔特数 [-], </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Pr = eta*cp/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 普朗特数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体密度 [kg/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re = rho*v*L/eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-].</td></tr></tbody></table><h4>验证</h4><p>
不同流体普朗特数下层流区域的平均努塞尔特数<strong>Nu</strong>表示平均对流传热系数<strong>kc</strong>，如下所示。
</p>
<p>
<img src=\"D:/GDM/SYSLINK/modelica2/Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/kc_laminar.png\" alt=\"kc_laminar\" data-href=\"\" style=\"\"/>
</p>
<p>
请注意，该函数最适用于层流区域，雷诺数 <strong>Re</strong> 小于2300。由于在过渡区域中忽略了湍流影响，与文献有偏差，尽管在其引用限制内用于更高雷诺数的情况。建议对于大于2300的雷诺数的模拟使用 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.HeatTransfer.Plate.kc_overall\" target=\"\">kc_overall</a>函数。
</p>
<h4>参考文献</h4><p>
VDI:
</p>
<p>
<strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>.<br>Springer Verlag, 9th edition, 2002.
</p>
<p>
<br>
</p>
</html>"    ));
        end kc_laminar;

        class kc_overall
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
计算平板上层流或湍流流动的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_overall</strong> 和 <strong>kc_overall_KC</strong></h4>
<p>
基本上有三个区别：
</p>
<ul>
<li>
函数 <strong>kc_overall</strong> 使用 <strong>kc_overall_KC</strong>，但提供额外的输出变量，如雷诺数或努塞尔特数以及故障状态（输出<strong>1</strong>表示该函数对于输入无效）。</li>
<li>
通常，函数 <strong>kc_overall_KC</strong> 在已知质量流量时最适用于计算平均对流传热系数<strong>kc</strong>。
</li>
<li>
您可以通过<strong>kc_overall_KC</strong>进行反向计算，从而根据给定的平均对流传热系数<strong>kc</strong>计算出未知的质量流量。
</li>
</ul>

<h4>限制</h4>
<ul>
<li>壁温恒定</li>
<li>整体区域（雷诺数 1e1 &lt; Re &lt; 1e7）</li>
<li> 普朗特数 0.6 &le; Pr &le; 2000</li>
</ul>

<h4>几何形状和计算 </h4>
<p>该传热函数可用于计算层流和湍流区域的传热系数。函数的几何形状、常数和流体参数与
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_laminar\">kc_laminar</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.Plate.kc_turbulent\">kc_turbulent</a> 相同。
</p>
<p>
层流和湍流流动的计算条件等同于<strong>kc_laminar</strong>和<strong>kc_turbulent</strong>中的计算。在 1e5 &le; Re &le; 5e5 范围内对两个函数进行平滑过渡（见下图）。
</p>
<h4>验证</h4>
<p>
不同流体普朗特数下表示平均对流传热系数<strong>kc</strong>的平均努塞尔特数<strong>Nu = sqrt(Nu_lam^2 + Nu_turb^2)</strong>如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/kc_overall.png\" alt=\"kc_overall\"/>
</div>

<h4>参考文献</h4>
<dl>
<dt>VDI:</dt>
<dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
Springer Verlag, 9th edition, 2002.</dd>
</dl>

</html>"              ));
        end kc_overall;

        class kc_turbulent
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html><p>
计算平板上水动力发展湍流流动的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_turbulent</strong> 和 <strong>kc_turbulent_KC</strong></h4><p>
基本上有三个区别：
</p>
<ul><li>
函数 <strong>kc_turbulent</strong> 使用 <strong>kc_turbulent_KC</strong>，但提供额外的输出变量，如雷诺数或努塞尔特数以及故障状态（输出<strong>1</strong>表示该函数对于输入无效）。</li>
<li>
通常，函数 <strong>kc_turbulent_KC</strong> 在已知质量流量时最适用于计算平均对流传热系数<strong>kc</strong>。</li>
<li>
您可以通过<strong>kc_turbulent_KC</strong>进行反向计算，从而根据给定的平均对流传热系数<strong>kc</strong>计算出未知的质量流量。</li>
</ul><h4>限制</h4><ul><li>
壁温恒定</li>
<li>
湍流区域（雷诺数 5e5 &lt; Re &lt; 1e7）</li>
<li>
普朗特数 0.6 ≤ Pr ≤ 2000</li>
</ul><h4>几何形状</h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/plate.png\" alt=\"plate\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
平板的平均对流传热系数<strong>kc</strong>通过相应的努塞尔特数<strong>Nu_turb</strong>计算，根据<em>[VDI 2002, p. Gd 1, eq. 2]</em>：
</p>
<pre><code >Nu_turb = (0.037 * Re^0.8 * Pr) / (1 + 2.443/Re^0.1 * (Pr^(2/3)-1))
</code></pre><p>
以及相应的平均对流传热系数<strong>kc</strong>：
</p>
<pre><code >kc =  Nu_turb * lambda / L
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> cp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">定压比热容[J/(kg.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">流体动力黏度[Pa.s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> kc </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">平均对流传热系数[W/(m2.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">流体导热系数[W/(m.K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">平板长度[m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Nu_turb </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">湍流区域的平均努塞尔特数[-], </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Pr = eta*cp/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">普朗特数[-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">流体密度[kg/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re = v*rho*L/eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">雷诺数[-].</td></tr></tbody></table><h4>验证</h4><p>
湍流区域的平均努塞尔特数 <strong>Nu</strong> 表示不同流体普朗特数的平均对流传热系数<strong>kc</strong>如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/Plate/kc_turbulent.png\" alt=\"kc_turbulent\" data-href=\"\" style=\"\"/>
</p>
<h4>参考文献</h4><p>
VDI:
</p>
<p>
<strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>.<br>Springer Verlag, 9th edition, 2002.
</p>
<p>
<br>
</p>
</html>"    ));
        end kc_turbulent;
          annotation();
        end Plate;

        package StraightPipe
        extends Modelica.Icons.Information;

        class kc_laminar
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html><p>
计算直管道中恒定壁温<strong>或</strong>恒定热流<strong>且</strong>水动力发展<strong>或</strong>未发展的层流流动的平均对流传热系数<strong>kc</strong>。
</p>
<h4>函数 <strong>kc_laminar</strong> 和 <strong>kc_laminar_KC</strong></h4><p>
基本上有三个区别：
</p>
<ul><li>
函数 <strong>kc_laminar</strong> 使用 <strong>kc_laminar_KC</strong>，但提供额外的输出变量，如雷诺数或努塞尔特数以及故障状态（输出<strong>1</strong>表示该函数对于输入无效）。</li>
<li>
通常，函数 <strong>kc_laminar_KC</strong> 在已知质量流量时最适用于计算平均对流传热系数<strong>kc</strong>。</li>
<li>
您可以通过<strong>kc_laminar_KC</strong>进行反向计算，从而根据给定的平均对流传热系数<strong>kc</strong>计算出未知的质量流量。</li>
</ul><h4>限制</h4><ul><li>
圆形横截面积</li>
<li>
壁温恒定（UWT）<strong>或</strong>热流恒定（UHF）</li>
<li>
水动力发展的流体流动（DFF）<strong>或</strong>水动力未发展的流体流动（UFF）</li>
<li>
0.6 ≤ 普朗特数 ≤ 1000</li>
<li>
层流区域（雷诺数 ≤ 2000）</li>
</ul><h4>几何形状</h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
在层流区域内，直管道的平均对流传热系数<strong>kc</strong>可以根据其相应的努塞尔特数<strong>Nu</strong>计算出以下四种热传递边界条件：
</p>
<p>
<strong>发展流体流动中的恒定壁温（heatTransferBoundary == Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuDFF）</strong> 根据<em>[VDI 2002, p. Ga 2, eq. 6]</em>：
</p>
<pre><code >Nu_TD = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3]^1/3
</code></pre><p>
<strong>发展流体流动中的恒定热流（heatTransferBoundary == Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuDFF）</strong> 根据<em>[VDI 2002, p. Ga 4, eq. 19]</em>：
</p>
<pre><code >Nu_qD = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3]^1/3
</code></pre><p>
<strong>未发展流体流动中的恒定壁温（heatTransferBoundary == Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UWTuUFF）</strong> 根据<em>[VDI 2002, p. Ga 2, eq. 12]</em>：
</p>
<pre><code >Nu_TU = [3.66^3 + 0.7^3 + {1.615*(Re*Pr*d_hyd/L)^1/3 - 0.7}^3 + {(2/[1+22*Pr])^1/6*(Re*Pr*d_hyd/L)^0.5}^3]^1/3
</code></pre><p>
<strong>未发展流体流动中的恒定热流（heatTransferBoundary == Modelica.Fluid.Dissipation.Utilities.Types.HeatTransferBoundary.UHFuUFF）</strong> 根据<em>[VDI 2002, p. Ga 5, eq. 25]</em>：
</p>
<pre><code >Nu_qU = [4.364^3 + 0.6^3 + {1.953*(Re*Pr*d_hyd/L)^1/3 - 0.6}^3 + {0.924*Pr^1/3*[Re*d_hyd/L]^0.5}^3]^1/3.
</code></pre><p>
通过以下方式确定所选择的热传递边界的对应平均对流传热系数<strong>kc</strong>：
</p>
<pre><code >kc =  Nu * lambda / d_hyd
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">直管道的水力直径[m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> kc </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">平均对流传热系数[W/(m2K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">流体导热系数[W/(mK)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">直管道长度[m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Nu = kc*d_hyd/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">平均努塞尔特数[-], </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Pr = eta*cp/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">普朗特数[-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re = rho*v*d_hyd/eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">雷诺数[-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> v </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">平均流速[m/s]。</td></tr></tbody></table><h4>验证</h4><p>
根据四种不同的热传递边界条件，代表平均对流传热系数<strong>kc</strong>的平均努塞尔特数<strong>Nu</strong>如下图所示。
</p>
<p>
此验证是使用水的流体特性（普朗特数Pr = 7）和管径与管长比为0.1进行的。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_laminar.png\" alt=\"kc_laminar\" data-href=\"\" style=\"\"/>
</p>
<h4>参考文献</h4><p>
Bejan,A.:
</p>
<p>
<strong>Heat transfer handbook</strong>。<br>Wiley, 2003。
</p>
<p>
VDI:
</p>
<p>
<strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>。<br>Springer Verlag, 9th edition, 2002。
</p>
<p>
<br>
</p>
</html>"    ));
        end kc_laminar;

        class kc_overall
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html>
<p>
计算直管中均匀壁温或均匀热流的层流或湍流流体流动的平均对流换热系数 <strong>kc</strong>，考虑或不考虑压力损失影响。
</p>
<h4>函数 <strong>kc_overall</strong> 和 <strong>kc_overall_KC</strong></h4>
<p>
基本上有三个不同点：
</p>
<ul>
<li>
函数 <strong>kc_overall</strong> 使用 <strong>kc_overall_KC</strong>，但提供额外的输出变量，如雷诺数或努塞尔数和故障状态（输出为 <strong>1</strong> 表示该函数对输入无效）。</li>
<li>
通常函数 <strong>kc_overall_KC</strong> 最适合于已知质量流量时计算平均对流换热系数 <strong>kc</strong>。</li>
<li>
您可以从 <strong>kc_overall_KC</strong> 进行反向计算，其中未知的质量流量是从给定的平均对流换热系数 <strong>kc</strong> 计算出来的。
</li>
</ul>

<h4>限制</h4>
<ul>
<li>圆形横截面积</li>
<li>均匀壁温（UWT）或均匀热流（UHF）</li>
<li>水力直径 / 长度 ≤ 1</li>
<li>0.6 ≤ 普朗特数 ≤ 1000</li>
</ul>

<h4>几何和计算 </h4>

<p>此换热函数可用于计算层流和湍流流动的换热系数。该函数的几何、常数和流体参数与
<a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_laminar\">kc_laminar</a> 和 <a href=\"modelica://Modelica.Fluid.Dissipation.HeatTransfer.HelicalPipe.kc_turbulent\">kc_turbulent</a> 相同。
</p>
<p>
层流和湍流流动的计算条件等同于 <strong>kc_laminar</strong> 和 <strong>kc_turbulent</strong> 中的计算。在 2200 ≤ Re ≤ 10000 之间进行两者之间的平滑过渡（见下图）。</p>

<h4>验证</h4>
<p>
对于水的流体性质（普朗特数 Pr = 7）和管径与管长比为 0.1，在下图中显示了代表平均对流换热系数 <strong>kc</strong> 的平均努塞尔数 <strong>Nu</strong>。
</p>

<p>
以下验证考虑了压力损失影响（粗糙度 =2）。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_overall.png\" alt=\"kc_overall\"/>
</div>

<h4>参考文献</h4>
<dl>
<dt>Bejan,A.：</dt>
<dd><strong>换热手册</strong>。
Wiley, 2003。</dd>
<dt>VDI：</dt>
<dd><strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>。
Springer Verlag，2002年第9版。</dd>
</dl>

</html>"              ));
        end kc_overall;

          class kc_turbulent
            extends Modelica.Icons.Information;

            annotation(Documentation(info="<html><p>
计算在均匀壁温度或均匀热流条件下的流体动力学发展湍流流体流动中直管的平均对流换热系数 <strong>kc</strong>，考虑或不考虑压力损失影响。
</p>
<h4>函数 <strong>kc_turbulent</strong> 和 <strong>kc_turbulent_KC</strong></h4><p>
基本上有三个不同点：
</p>
<ul><li>
函数 <strong>kc_turbulent</strong> 使用 <strong>kc_turbulent_KC</strong>，但提供额外的输出变量，例如雷诺数或努塞尔特数和故障状态（输出<strong>1</strong>表示函数对于输入无效）。</li>
<li>
一般来说，函数 <strong>kc_turbulent_KC</strong> 在已知质量流量时，数值上最适用于计算平均对流换热系数 <strong>kc</strong>。</li>
<li>
您可以从 <strong>kc_turbulent_KC</strong> 进行反向计算，其中未知的质量流量是从给定的平均对流换热系数 <strong>kc</strong> 计算出来的</li>
</ul><h4>限制</h4><ul><li>
圆形横截面积</li>
<li>
流体动力学发展流动</li>
<li>
水力直径 / 长度 ≤ 1</li>
<li>
0.6 ≤ 普朗特数 ≤ 1000</li>
<li>
湍流流动区域 (1e4 ≤ 雷诺数 ≤ 1e6)</li>
</ul><h4>几何 </h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
<strong>忽略压力损失影响（粗糙度 == 1）：</strong>
</p>
<p>
光滑直管的平均对流换热系数 <strong>kc</strong> 通过其对应的努塞尔特数 <strong>Nu</strong> 计算，根据 <em> [Dittus and Boelter in Bejan 2003, p. 424, eq. 5.76]</em>
</p>
<pre><code >Nu = 0.023 * Re^(4/5) * Pr^(1/3).
</code></pre><p>
<strong>考虑压力损失影响（粗糙度 == 2）：</strong>
</p>
<p>
粗糙直管的平均对流换热系数 <strong>kc</strong> 通过其对应的努塞尔特数 <strong>Nu</strong> 计算，根据 <em>[Gnielinski in VDI 2002, p. Ga 5, eq. 26]</em>
</p>
<pre><code >Nu = (zeta/8)*Re*Pr/(1 + 12.7*(zeta/8)^0.5*(Pr^(2/3)-1))*(1+(d_hyd/L)^(2/3)),
</code></pre><p>
其中压力损失对换热计算的影响通过考虑
</p>
<pre><code >zeta =  (1.8*log10(Re)-1.5)^-2.
</code></pre><p>
所选择的计算方式（考虑或不考虑压力损失影响）下的平均对流换热系数 <strong>kc</strong> 的结果为：
</p>
<pre><code >kc =  Nu * lambda / d_hyd
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 直管的水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> kc </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均对流换热系数 [W/(m2K)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体的导热系数 [W/(mK)],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 直管的长度 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Nu = kc*d_hyd/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均努塞尔特数 [-], </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Pr = eta*cp/lambda </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 普朗特数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re = rho*v*d_hyd/eta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> v </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均速度 [m/s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> zeta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 压力损失系数 [-].</td></tr></tbody></table><p>
请注意，在湍流区域中均匀壁温度（UWT）或均匀热流（UHF）作为湍流区域内的热传递边界时，平均努塞尔特数 <strong>Nu</strong> 的计算没有显著差异（Bejan 2003, p.303）。
</p>
<h4>验证</h4><p>
表示不同流体普朗特数下的平均对流换热系数 <strong>kc</strong> 的平均努塞尔特数 <strong>Nu</strong> 在下图中显示
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_turbulent.png\" alt=\"kc_turbulent\" data-href=\"\" style=\"\"/>
</p>
<p>
请注意，普朗特数 <strong>Pr</strong> 越高，考虑和不考虑压力损失时努塞尔特数 <strong>Nu</strong> 的差异越大。
</p>
<h4>参考文献</h4><p>
Bejan,A.:
</p>
<p>
<strong>传热手册</strong>。Wiley, 2003。
</p>
<p>
VDI:
</p>
<p>
<strong>VDI - 热力学图谱：热传递的计算表</strong>。Springer Verlag, 2002年第9版。
</p>
<p>
<br>
</p>
</html>"    ));
          end kc_turbulent;

        class kc_twoPhaseOverall
          extends Modelica.Icons.Information;

            annotation (Documentation(info="<html><p>
计算整体流动情况下（水平/垂直）沸腾或（水平）冷凝的局部<strong>两相</strong>传热系数<strong>kc_2ph</strong>。
</p>
<h4>限制</h4><ul><li>
圆形横截面积</li>
<li>
无亚冷却沸腾</li>
<li>
膜冷凝</li>
</ul><h4>几何 </h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
<strong>水平管道中的沸腾（目标 = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor）：</strong>
</p>
<p>
在整体流动情况下，水平直管中的沸腾过程中，局部两相传热系数 <strong>kc_2ph</strong> 根据 <em>[Gungor/Winterton 1986, p.354, eq. 2]</em> 计算：
</p>
<pre><code >kc_2ph = E_fc*E_fc_hor*kc_fc+S_nb+S_nb_hor*kc_nb
</code></pre><p>
其中
</p>

<table>
<tr><td><strong> Bo</strong>=qdot_A/(mdot_A*dh_lv)  </td><td> 沸腾数[-],</td></tr>
<tr><td><strong> dh_lv                         </strong></td><td> 汽化焓[J/kg],</td></tr>
<tr><td><strong> E_fc</strong>=f(Bo,Fr_l,X_tt)      </td><td> 强制对流增强因子[-],</td></tr>
<tr><td><strong> E_fc_hor</strong> =f(Fr_l)         </td><td> 水平直管强制对流增强因子[-],</td></tr>
<tr><td><strong> Fr_l                          </strong></td><td> 弗洛德数，假设总质量流率全部流动为液体[-],</td></tr>
<tr><td><strong> kc_2ph                        </strong></td><td> 局部两相传热系数[W/(m2K)],</td></tr>
<tr><td><strong> kc_fc                         </strong></td><td> 考虑强制对流的传热系数[W/(m2K)],</td></tr>
<tr><td><strong> kc_nb                         </strong></td><td> 虑核沸腾的传热系数[W/(m2K)],</td></tr>
<tr><td><strong> mdot_A                        </strong></td><td> 总质量流率密度[kg/(m2s)],</td></tr>
<tr><td><strong> qdot_A                        </strong></td><td> 热流密度[W/m2],</td></tr>
<tr><td><strong> Re_l                          </strong></td><td> 雷诺数，假设液体质量流率单独流动[-],</td></tr>
<tr><td><strong> S_nb</strong> =f(E_fc,Re_l)        </td><td> 核沸腾抑制因子[-],</td></tr>
<tr><td><strong> S_nb_hor</strong> =f(Fr_l)         </td><td> 水平直管核沸腾抑制因子[-],</td></tr>
<tr><td><strong> x_flow                        </strong></td><td> 质量流率品质[-],</td></tr>
<tr><td><strong> X_tt</strong> = f(x_flow)          </td><td> 马丁尼利参数[-].</td></tr>
</table>

<p><strong>垂直管道中的沸腾（目标 = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer）：</strong>
</p>
<p>
在整体流动情况下，垂直直管中的沸腾过程中，局部两相传热系数 <strong>kc_2ph</strong> 是根据水平直管中沸腾的相关性计算的，其中水平校正因子 <strong>E_fc_hor,S_nb_hor</strong> 为单位。
</p>
<p>
请注意，由于核沸腾和强制对流具有不同的驱动温度，上述相关性不适用于亚冷却沸腾。在亚冷却沸腾中，没有增强因子（没有蒸汽生成），但抑制因子仍然有效。
</p>
<p>
<strong>水平管道中的冷凝（目标 = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.CondHor）：</strong>
</p>
<p>
在整体流动情况下，水平直管中的冷凝过程中，局部两相传热系数 <strong>kc_2ph</strong> 根据 <em>[Shah 1979, p.548, eq. 8]</em> 计算：
</p>
<pre><code >kc_2ph = kc_1ph*[(1 - x_flow)^0.8 + 3.8*x_flow^0.76*(1 - x_flow)^0.04/p_red^0.38]
</code></pre><p>
其中，假设总质量流率流动为液体的对流传热系数 <strong>kc_1ph</strong> 根据 <em>[Shah 1979, p.548, eq. 5]</em> 计算：
</p>
<pre><code >kc_1ph = 0.023*Re_l^0.8*Pr_l^0.4*lambda_l/d_hyd
</code></pre>

<p>
其中
</p>

<table>
<tr><td><strong> d_hyd                        </strong></td><td> 水力直径[m],</td></tr>
<tr><td><strong> kc_2ph                       </strong></td><td> 局部两相传热系数[W/(m2K)],</td></tr>
<tr><td><strong> kc_1ph                       </strong></td><td> 假设总质量流率流动为液体的对流传热系数[W/(m2K)],</td></tr>
<tr><td><strong> lambda_l                     </strong></td><td> 流体的导热系数[W/(mK)],</td></tr>
<tr><td><strong> pressure                     </strong></td><td> 流体的热力学压力[Pa],</td></tr>
<tr><td><strong> p_crit                       </strong></td><td> 流体的临界压力[Pa],</td></tr>
<tr><td><strong> p_red</strong> = pressure/p_crit  </td><td> 减压比[-],</td></tr>
<tr><td><strong> Pr_l                         </strong></td><td> 普朗特数[-],</td></tr>
<tr><td><strong> Re_l                         </strong></td><td> 雷诺数，假设<strong>总</strong>质量流率全部流动为液体[-],</td></tr>
<tr><td><strong> x_flow                       </strong></td><td> 质量流率品质[-],</td></tr>
</table>

<h4>验证</h4><p>
水平和垂直沸腾以及水平冷凝过程中的局部两相传热系数 <strong>kc_2ph</strong> 在直管中的示意图如下所示。
</p>

<p>
<strong>水平管道中的沸腾（目标 = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer）：</strong>
</p>
<p>
这里展示了水平直管中沸腾的两相传热系数的验证。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_twoPhaseOverall_KC_4.png\" alt=\"kc_twoPhaseOverall_KC_4\" data-href=\"\" style=\"\"/>
</p>
<p>
两相传热系数 (<strong>kc_2ph</strong>) 关于质量流率品质 (<strong>x_flow</strong>) 对不同质量流率密度 (<strong>mdot_A</strong>) 的变化情况。验证是使用R134a作为介质进行的，验证结果来自Kattan/Thome的测量结果。
</p>
<p>
随着质量流率品质的增加，两相传热系数增加到最大值。之后，随着 (<strong>x_flow</strong>) 的增加，(<strong>kc_2ph</strong>) 急剧减小。这可以解释为在高质量流率品质下管壁部分干燥。
</p>
<p>
<strong>水平管道中的冷凝（目标 = Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.CondHor）：</strong>
</p>
<p>
这里展示了水平直管中冷凝的两相传热系数的验证。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/HeatTransfer/StraightPipe/kc_twoPhaseOverall_KC_2.png\" alt=\"kc_twoPhaseOverall_KC_2\" data-href=\"\" style=\"\"/>
</p>
<p>
两相传热系数 (<strong>kc_2ph</strong>) 关于质量流率品质 (<strong>x_flow</strong>) 对不同质量流率密度 (<strong>mdot_A</strong>) 的变化情况。验证是使用R134a作为介质进行的，验证结果来自Dobson/Chato的测量结果。
</p>
<h4>参考文献</h4><p>
Bejan,A.: 
</p>
<p>
<strong>Heat transfer handbook</strong>. Wiley, 2003. 
</p>
<p>
M.K. Dobson and J.C. Chato: 
</p>
<p>
<strong>Condensation in smooth horizontal tubes</strong>. Journal of HeatTransfer, Vol.120, p.193-213, 1998. 
</p>
<p>
Gungor, K.E. and R.H.S. Winterton: 
</p>
<p>
<strong>A general correlation for flow boiling in tubes and annuli</strong>, Int.J. Heat Mass Transfer, Vol.29, p.351-358, 1986. 
</p>
<p>
N. Kattan and J.R. Thome: 
</p>
<p>
<strong>Flow boiling in horizontal pipes: Part 2 - new heat transfer data for five refrigerants.</strong>. Journal of Heat Transfer, Vol.120. p.148-155, 1998. 
</p>
<p>
Shah, M.M.: 
</p>
<p>
<strong>A general correlation for heat transfer during film condensation inside pipes</strong>. Int. J. Heat Mass Transfer, Vol.22, p.547-556, 1979.
</p>
<p>
<br>
</p>
</html>"            ));
        end kc_twoPhaseOverall;
          annotation();

        end StraightPipe;
        annotation();

      end HeatTransfer;

    package PressureLoss
      extends Modelica.Icons.Information;

    package Bend
      extends Modelica.Icons.Information;

    class dp_curvedOverall
      extends Modelica.Icons.Information;
    annotation(Documentation(info="<html><p>
计算在整体流动状态下通过圆形横截面积的不可压缩单相流体流动中弯头中的压力损失。
</p>
<h4>限制</h4><p>
此函数应在根据引用文献的限制条件下使用。
</p>
<ul><li>
<strong>圆形横截面积</strong></li>
<li>
<strong>0.5 ≤ 弯曲半径 / 直径 ≤ 3</strong> <em>[Idelchik 2006, p. 357, diag. 6-1]</em></li>
<li>
<strong>弯曲轴线上的弯曲弯曲长度 / 直径 ≥ 10</strong> <em>[Idelchik 2006, p. 357, diag. 6-1]</em></li>
<li>
<strong>曲率角小于180°（delta ≤ 180）</strong> <em>[Idelchik 2006, p. 357, diag. 6-1]</em></li>
</ul><h4>几何</h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/circularBend.png\" alt=\"circularBend\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
弯头的压力损失 <strong>dp</strong> 由以下公式确定：
</p>
<pre><code >dp = zeta_TOT * (rho/2) * velocity^2
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">rho</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">流体的密度 [kg/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">velocity</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">平均速度 [m/s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">zeta_TOT</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力损失系数 [-].</td></tr></tbody></table><p>
<strong>相对曲率半径 R_0/d_hyd ≤ 3</strong>，根据 <em>[Idelchik 2006, p. 357, diag. 6-1]</em>
</p>
<p>
弯头的压力损失类似于直管中的计算。观察到三种不同的流动状态（层流、过渡、湍流）。湍流区域进一步分为依赖或不依赖雷诺数的本地阻力系数的部分。弯头的本地阻力系数（<strong>zeta_LOC</strong>）根据流动状态的不同计算如下：
</p>
<ul><li>
<strong>层流区域 (Re ≤ Re_lam_leave)</strong>: </li>
<li>
<strong>过渡区域 (Re_lam_leave ≤ 4e4)</strong> </li>
<li>
<strong>湍流区域 (4e4 ≤ 3e5) 且依赖</strong>于雷诺数的本地阻力系数: &nbsp; </li>
<li>
<strong>湍流区域 (Re ≥ 3e5) 且不依赖</strong>于雷诺数的本地阻力系数 </li>
</ul><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">A1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">考虑弯曲角度（delta）影响的系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">A2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">考虑层流区域效应的系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">B1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">考虑相对曲率半径效应（R_0/d_hyd）的系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">C1=1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">考虑横截面积相对延伸（这里为圆形横截面积）的系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">k_Re</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">考虑过渡区域层流影响的系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Re</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">雷诺数 [-].</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">zeta_LOC</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">本地阻力系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">zeta_TOT</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力损失系数 [-].</td></tr></tbody></table><p>
<br><br>弯头的压力损失系数 <strong>zeta_TOT</strong> 包括由于摩擦引起的压力损失，其由本地阻力系数 <strong>zeta_LOC</strong> 乘以表面粗糙度校正因子 <strong>CF</strong> 确定，根据 <em>[Miller, p. 209, eq. 9.4]</em>：
</p>
<pre><code >zeta_TOT = CF*zeta_LOC
</code></pre><p>
其中校正因子 <strong>CF</strong> 由直管的达到弯曲流道长度的 Darcy 摩擦系数确定
</p>
<pre><code >CF = 1 + (lambda_FRI_rough * pi * delta/d_hyd) / zeta_LOC
</code></pre><p>
而 Darcy 摩擦系数 <strong>lambda_FRI_rough</strong> 根据近似的Colebrook-White法则计算，根据 <em>[Miller, p. 191, eq. 8.4]</em>：
</p>
<pre><code >lambda_FRI_rough = 0.25*(lg(K/(3.7*d_hyd) + 5.74/Re^0.9))^-2
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">delta</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">弯曲半径 [rad],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">d_hyd</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">K</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">绝对粗糙度（表面颗粒的平均高度） [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">lambda_FRI_rough</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Darcy 摩擦系数[-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Re</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">雷诺数 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">zeta_LOC</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">本地阻力系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">zeta_TOT</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力损失系数 [-].</td></tr></tbody></table><p>
<br>表面粗糙度校正因子 <strong>CF</strong> 仅用于湍流区域，其中流体流动受到未被层流边界层覆盖的表面颗粒的影响。湍流区域从 <strong>Re ≥ 4e4</strong> 开始，根据 <em>[Idelchik 2006, p. 336, sec. 15]</em>。在湍流区域中，由于粗糙度引起的校正不影响层流区域，直到 <strong>Re ≤ 6.5e3</strong> 根据 <em>[Idelchik 2006, p. 336, sec. 15]</em>。
</p>
<p>
然而，随着绝对粗糙度的增加，从层流到过渡区域的转变点向更小的雷诺数转变。这种效应根据 <em>[Samoilenko in Idelchik 2006, p. 81, sec. 2-1-21]</em> 考虑如下：
</p>
<pre><code >Re_lam_leave = 754*exp(if k ≤ 0.007 then 0.0065/0.007 else 0.0065/k)
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">k = K /d_hyd</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">相对粗糙度 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Re_lam_leave</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">离开层流区域的雷诺数 [-].</td></tr></tbody></table><p>
请注意，层流区域的开始不能低于 <strong>Re ≤ 1e2</strong>。
</p>
<h4>验证</h4><p>
弯头的压力损失系数 <strong>zeta_TOT</strong> 随雷诺数 <strong>Re</strong> 和不同相对曲率半径 <strong>R_0/d_hyd</strong> 和不同弯曲角度 <strong>delta</strong> 的变化如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_curvedOverall_1.png\" alt=\"dp_curvedOverall_1\" data-href=\"\" style=\"\"/>
</p>
<p>
在不同参考文献中，压力损失系数 <strong>zeta_TOT</strong> 存在偏差。通常，在过渡区域的这些偏差必须被接受，因为在不同参考文献中确定可比边界条件的确度存在不确定性。尽管如此，这些计算涵盖了弯头的压力损失系数的通常范围。可以通过改变表面颗粒的平均高度 <strong>K</strong> 来调整相同几何形状的压力损失系数 <strong>zeta_TOT</strong> 进行校准。
</p>
<p>
水质量流率变化的水压力损失如下图所示，对于不同的相对曲率半径：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_curvedOverall_2.png\" alt=\"dp_curvedOverall_2\" data-href=\"\" style=\"\"/>
</p>
<p>
水质量流率变化的水压力损失如下图所示，对于不同的弯曲角度：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_curvedOverall_3.png\" alt=\"dp_curvedOverall_3\" data-href=\"\" style=\"\"/>
</p>
<p>
请注意，由于缺乏直接的解析可逆性，压缩和不可压缩计算之间存在小偏差。
</p>
<h4>参考文献</h4><p>
Elmqvist,H., M.Otter and S.E. Cellier: 
</p>
<p>
<strong>Inline integration: A new mixed symbolic / numeric approach for solving differential-algebraic equation systems.</strong>. In Proceedings of European Simulation MultiConference, Prague, 1995.
</p>
<p>
Idelchik,I.E.: 
</p>
<p>
<strong>Handbook of hydraulic resistance</strong>. Jaico Publishing House, Mumbai, 3rd edition, 2006.
</p>
<p>
Miller,D.S.: 
</p>
<p>
<strong>Internal flow systems</strong>. volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1984. 
</p>
<p>
Samoilenko,L.A.: 
</p>
<p>
<strong>Investigation of the hydraulic resistance of pipelines in the zone of transition from laminar into turbulent motion</strong>. PhD thesis, Leningrad State University, 1968.
</p>
<p>
VDI: 
</p>
<p>
<strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>. Springer Verlag, 9th edition, 2002. 
</p>
<p>
<br>
</p>
</html>"    ));
    end dp_curvedOverall;

    class dp_edgedOverall extends Modelica.Icons.Information;
    annotation(Documentation(info="<html><p>
计算通过圆形横截面的不可压缩和单相流体流经带有尖角边的直角弯头的整体流动条件下的压力损失，考虑表面粗糙度。
</p>
<h4>限制条件</h4><p>
根据参考文献，此函数应在受限条件内使用。
</p>
<ul><li>
<strong>圆形横截面积</strong> <em>[Idelchik 2006, p. 366, diag. 6-7]</em></li>
<li>
<strong>具有尖角转角的直角弯头</strong> <em>[Idelchik 2006, p. 366, diag. 6-7]</em></li>
<li>
<strong>0° ≤ 转角 ≤ 180°</strong> <em>[Idelchik 2006, p. 338, sec. 19]</em></li>
<li>
<strong>沿边缘轴的直角弯头长度 / 直径 ≥ 10</strong> <em>[Idelchik 2006, p. 366, diag. 6-7]</em></li>
</ul><h4>几何形状</h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/edgedBend.png\" alt=\"edgedBend\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
直角弯头的压力损失 <strong>dp</strong> 由以下公式确定:
</p>
<pre><code >dp = zeta_TOT * (rho/2) * velocity^2
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体密度 [kg/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> velocity </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均速度 [m/s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> zeta_TOT </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 压力损失系数 [-].</td></tr></tbody></table><p>
直角弯头的压力损失系数 <strong>zeta_TOT</strong> 可通过以下公式针对不同的转角 <strong>delta</strong> 计算:
</p>
<pre><code >zeta_TOT = A * C1 * zeta_LOC * CF_Fri* CF_Re [Idelchik 2006, p. 366, diag. 6-7] and [Miller 1984, p. 149, sec. 9.4]
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> A </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 考虑转角影响的系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> C1 </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 考虑横截面相对伸展性的系数（这里是圆形横截面） [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> CF_Fri </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 考虑表面粗糙度的校正系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> CF_Re </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 考虑雷诺数的校正系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> delta </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 转角 [deg].</td></tr></tbody></table><p>
表面粗糙度的校正系数 <strong>CF_Fri</strong> 关于表面粗糙度的 Darcy 摩擦系数和光滑表面的比率计算，根据 <em>[Miller, p. 207, eq. 9.3]:</em>
</p>
<pre><code >CF_Fri = lambda_FRI_rough / lambda_FRI_smooth
</code></pre><p>
Darcy 摩擦系数 <strong>lambda_FRI</strong> 使用近似的科尔布克-白定律根据 <em>[Miller, p. 191, eq. 8.4]:</em> 计算
</p>
<pre><code >lambda_FRI = 0.25*(lg(K/(3.7*d_hyd) + 5.74/Re^0.9))^-2
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> K </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 绝对粗糙度（表面突起的平均高度） [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda_FRI </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> Darcy 摩擦系数[-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> zeta_TOT </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 压力损失系数 [-].</td></tr></tbody></table><p>
注意，对于光滑表面的Darcy摩擦系数λ_FRI_smooth是用前述方程和绝对粗糙度K = 0计算的。
</p>
<p>
通过CF_Fri进行表面粗糙度的修正仅用于湍流区，其中流体流动受到未被层流边界层覆盖的表面粗糙度的影响。在这里，根据摩擦，校正从Re ≥ Re_lam_leave开始。在此，层流区的结束受到雷诺数小于2e3的限制。
</p>
<p>
然而，随着绝对粗糙度的增加，从层流到过渡区的转变点会向更小的雷诺数移动。这种效应按照[Samoilenko in Idelchik 2006, p. 81, sec. 2-1-21]中的描述考虑为：
</p>
<pre><code >Re_lam_leave = 754*exp(if k ≤ 0.007 then 0.0065/0.007 else 0.0065/k)
</code></pre><p>
其中，
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> k = K /d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 相对粗糙度 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re_lam_leave </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 离开层流区的雷诺数 [-]。</td></tr></tbody></table><p>
需要注意的是，层流区的开始不能小于Re ≤ 5e2。
</p>
<p>
此外，在层流和湍流区，通过第二个校正因子CF_Re考虑雷诺数Re对压力损失系数zeta_TOT的影响，按照[Miller 1984, p. 149, sec. 9.4]中的描述，通过以下方式进行：
</p>
<pre><code >CF_Re = B/Re^exp for Re ≤ 2e5
</code></pre><p>
其中，
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> B = f(Geometry) </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 考虑层流区雷诺数影响的系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> exp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 层流区雷诺数的指数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-]。</td></tr></tbody></table><p>
需要注意的是，系数B考虑了角度delta对压力损失系数zeta_TOT在层流区的影响，根据[Idelchik 2006, p. 340, sec. 28]中的描述。
</p>
<p>
需要注意的是，在湍流流动区域内，对压力损失系数zeta_TOT的校正受到校正因子CF_Re的影响，仅适用于雷诺数Re减小出湍流流动区域，进入过渡和层流流动区域的情况，此时Re ≤ 2e5。
</p>
<h4>验证</h4><p>
对于不同转角<strong>delta</strong>的边缘弯曲的压力损失系数<strong>zeta_TOT</strong>随着雷诺数<strong>Re</strong>的变化如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_edgedOverall_1.png\" alt=\"dp_edgedOverall_1\" data-href=\"\" style=\"\"/>
</p>
<p>
边缘弯曲的压力损失计算是复杂的，文献数据存在较大差异。尽管如此，这些计算覆盖了边缘弯曲的压力损失系数的通常范围。
</p>
<p>
对于边缘弯曲的压力损失系数的验证显示了四种可能的流动状态：
</p>
<ul><li>
<strong>层流区</strong>，Re ≤ 5e2</li>
<li>
<strong>过渡区</strong>，5e2 ≤ Re ≤ 1e3 ... 1e4</li>
<li>
<strong>湍流区（取决于雷诺数）</strong>，2e3 ... 1e4 ≤ Re ≤ 1e5</li>
<li>
<strong>湍流区（独立于雷诺数）</strong>，Re ≥ 2e5</li>
</ul><p>
<strong>不可压缩情况</strong> [压力损失 = f(m_flow)]:
</p>
<p>
水质量流率的压力损失随着不同转角的变化如下图所示：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_edgedOverall_2.png\" alt=\"dp_edgedOverall_2\" data-href=\"\" style=\"\"/>
</p>
<p>
<strong>可压缩情况</strong> [质量流率 = f(dp)]:
</p>
<p>
水的质量流率随着压力损失的变化而变化，不同转角如下图所示：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Bend/dp_edgedOverall_3.png\" alt=\"dp_edgedOverall_3\" data-href=\"\" style=\"\"/>
</p>
<h4>参考文献</h4><p>
Idelchik,I.E.:
</p>
<p>
<strong>Handbook of hydraulic resistance</strong>.<br>Jaico Publishing House,Mumbai,3rd edition, 2006.
</p>
<p>
Miller,D.S.:
</p>
<p>
<strong>Internal flow systems</strong>.<br>volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1984.
</p>
<p>
Samoilenko,L.A.:
</p>
<p>
<strong>Investigation of the hydraulic resistance of pipelines in the zone of transition from laminar into turbulent motion</strong>.<br>PhD thesis, Leningrad State University, 1968.
</p>
<p>
VDI:
</p>
<p>
<strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>.<br>Springer Verlag, 9th edition, 2002.
</p>
<p>
<br>
</p>
</html>"    ));
    end dp_edgedOverall;

      annotation (DocumentationClass=true);
    end Bend;

    package Channel
      extends Modelica.Icons.Information;

    class dp_internalFlowOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html><p>
通过考虑表面粗糙度，在整体流动状态下计算单相流体流经不同几何形状的内部流动的压力损失。
</p>
<h4>限制</h4><p>
此函数应在所引用文献的限制条件内使用。
</p>
<ul><li>
<strong>发展的流体流动</strong></li>
</ul><h4>几何形状</h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Channel/pLchannel.png\" alt=\"pLchannel\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
通道的压力损失<strong>dp</strong>由以下公式确定：
</p>
<pre><code >dp = zeta_TOT * (rho/2) * velocity^2
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">流体密度[kg/m3]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> velocity </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">平均流速[m/s]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> zeta_TOT </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力损失系数[-]。</td></tr></tbody></table><p>
<strong>具有不同截面形状的通道的计算</strong>参考<em>[Miller 1978, p. 138, fig. 8.5-8-6]</em>
</p>
<p>
这些通道的压力损失类似于直管中的计算。观察到三种不同的流动状态（层流，过渡，湍流）。通道的压力损失系数（<strong>zeta_TOT</strong>）根据流动状态的不同计算如下：
</p>
<ul><li>
<strong>层流区（Re ≤ Re_lam_leave）</strong>: </li>
<li>
<strong>过渡区（Re_lam_leave ≤ 4e4）</strong> </li>
<li>
<strong>湍流区（Re ≥ 4e3）</strong>: </li>
</ul><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> CF_lam </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">考虑几何形状的层流区修正系数[-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">垂直于截面的几何长度[m]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">几何的水力直径[m]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">雷诺数[-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> zeta_TOT </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力损失系数[-]。</td></tr></tbody></table><p>
注意，层流区的开始取决于通道的表面粗糙度，不能低于<strong>Re ≤ 1e3</strong>。
</p>
<h4>验证</h4><p>
不同截面形状的通道的 Darcy 摩擦系数（<strong>lambda_FRI</strong>）随雷诺数（<strong>Re</strong>）的变化如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Channel/dp_internalFlowOverall.png\" alt=\"dp_internalFlowOverall\" data-href=\"\" style=\"\"/>
</p>
<p>
在内部流动的相同水力直径和相同平均流速下获得了不同几何形状的通道的 Darcy 摩擦系数（<strong>lambda_FRI</strong>）。请注意，如果对所有几何形状使用相同的水力直径，则在湍流区没有 Darcy 摩擦系数的差异。可以考虑粗糙度，但在此验证中未使用。
</p>
<h4>参考文献</h4><p>
Miller,D.S.:
</p>
<p>
<strong>Internal flow systems</strong>.<br>Volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1978.
</p>
<p>
VDI:
</p>
<p>
<strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>.<br>Springer Verlag, 9th edition, 2002.
</p>
<p>
<br>
</p>
</html>"    ));
    end dp_internalFlowOverall;

      annotation (DocumentationClass=true);
    end Channel;

    package General
      extends Modelica.Icons.Information;

    class dp_idealGas
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html><p>
使用平均密度计算<strong>理想气体</strong>的通用压力损失。
</p>
<h4>限制</h4><p>
此函数应在所引用文献的限制条件内使用。
</p>
<ul><li>
<strong>理想气体</strong></li>
<li>
理想气体的平均密度</li>
</ul><h4>计算</h4><p>
能量设备的压力损失计算所需的几何参数通常不是完全已知的。 因此，详细的压力损失计算的建模必须简化。
</p>
<p>
压缩性情况下的压力损失 <strong>dp</strong> [质量流量 = f(dp)]由以下公式确定（Eq.1）：
</p>
<pre><code >m_flow = (R_s/Km)^(1/exp)*(rho_m)^(1/exp)*dp^(1/exp)
</code></pre><p>
其中基础方程式使用理想气体定律如下：
</p>
<pre><code >dp^2 = p_2^2 - p_1^2 = Km*m_flow^exp*(T_2 + T_1)
dp   = p_2 - p_1     = Km*m_flow^exp*T_m/p_m, Eq.2，其中[dp] = Pa，[m_flow] = kg/s
</code></pre><p>
因此，系数 <strong>Km</strong>由方程式Eq.2计算得出：
</p>
<pre><code >Km = dp*R_s*rho_m / m_flow^exp , [Km] = [Pa^2/{(kg/s)^exp*K}]
</code></pre><p>
其中平均密度 <strong>rho_m</strong>根据算术平均压力和温度按照理想气体定律计算：
</p>
<pre><code >rho_m = p_m / (R_s*T_m) , p_m = (p_1 + p_2)/2 and T_m = (T_1 + T_2)/2.
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> exp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力损失定律的指数[-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> dp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力损失[Pa]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Km </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">与质量流量有关的系数！[Km] = [Pa^2/{(kg/s)^exp*K}]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> m_flow </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">质量流量[kg/s]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> p_m = (p_2 + p_1)/2 </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">理想气体的平均压力[Pa]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> T_m = (T_2 + T_1)/2 </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">理想气体的平均温度[K]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho_m = p_m/(R_s*T_m) </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">理想气体的平均密度[kg/m3]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> R_s </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">理想气体的比气体常数[J/(kgK)]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> V_flow </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">理想气体的体积流量[m^3/s]。</td></tr></tbody></table><p>
此外，如果没有给出（例如，测量的）值，则可以更详细地定义系数 <strong>Km</strong>，以便于定义压力损失。通常，由于局部损失 <strong>Km,LOC</strong> 或摩擦损失 <strong>Km,FRI</strong>，可以计算压力损失。
</p>
<p>
由于局部损失导致的压力损失给出了 <strong>Km</strong> 的以下定义：
</p>
<pre><code >dp        = zeta_LOC * (rho_m/2)*velocity^2 is leading to
Km,LOC  = (8/π^2)*R_s*zeta_LOC/(d_hyd)^4, considering the cross sectional area of pipes.
</code></pre><p>
由摩擦引起的压力损失导致
</p>
<pre><code >dp        = lambda_FRI*L/d_hyd * (rho_m/2)*velocity^2
Km,FRI  = (8/π^2)*R_s*lambda_FRI*L/(d_hyd)^5, considering the cross sectional area of pipes.
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> dp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">压力损失[Pa]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">管道的水力直径[m]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Km,i </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">与质量流量有关的系数！[Km] = [Pa^2/{(kg/s)^exp*K}]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda_FRI </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Darcy 摩擦系数[-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">管道长度[m]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho_m = p_m/(R_s*T_m) </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">理想气体的平均密度[kg/m3]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> velocity </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">平均速度[m/s]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> zeta_LOC </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">局部阻力系数[-]。</td></tr></tbody></table><p>
请注意，此函数的变量以国际单位制提供，因此系数 Km 应以国际单位制给出。
</p>
<h4>验证</h4><p>
<strong>压缩性情况</strong> [质量流量 = f(dp)]：
</p>
<p>
质量流量 <strong>m_flow</strong> 对于不同的系数 <strong>Km</strong> 作为参数，其压力损失 <strong>dp</strong> 的变化如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_idealGas.png\" alt=\"dp_idealGas\" data-href=\"\" style=\"\"/>
</p>
<p>
请注意，由于使用相同的函数，因此<a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_idealGas\" target=\"\">dp_idealGas</a>的验证对于这种逆向计算也是有效的。
</p>
<h4>参考文献</h4><p>
Elmqvist, H., M.Otter and S.E. Cellier:
</p>
<p>
<strong>Inline integration: A new mixed symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.<br>In Proceedings of European Simulation MultiConference, Prague, 1995.
</p>
<p>
<br>
</p>
</html>"    ));
    end dp_idealGas;

    class dp_nominalDensityViscosity
    extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
依赖额定流体变量（例如，额定密度、额定动力黏度）在操作点上通过插值计算通用压力损失。
此通用函数通过压力损失指数考虑压力损失定律以及密度和动力黏度对压力损失的影响。
</p>
<h4>计算</h4>
<p>
能量设备的几何参数通常并不完全已知，因此必须简化详细的压力损失计算模型。
该函数使用额定变量（例如，已知能量设备操作点处的额定压力损失）来插值实际压力损失，根据压力损失定律（指数）。
</p>
<p>
通用压力损失 <strong>dp</strong> 确定为：
</p>
<ul>
<li>
压缩性情况 [质量流量 = f(dp)]:
<blockquote><pre>
m_flow = m_flow_nom*[(dp/dp_nom)*(rho/rho_nom)]^(1/exp)*(eta_nom/eta)^(exp_eta/exp)
</pre></blockquote>
</li>
<li>
不可压缩性情况 [压力损失 = f(m_flow)]:
<blockquote><pre>
dp = dp_nom*(m_flow/m_flow_nom)^exp*(rho_nom/rho)*(eta/eta_nom)^exp_eta
</pre></blockquote>
</li>
</ul>

<p>
其中
</p>

<table>
<tr><td><strong> dp             </strong></td><td> 压力损失 [Pa],</td></tr>
<tr><td><strong> dp_nom         </strong></td><td> 额定压力损失 [Pa],</td></tr>
<tr><td><strong> eta            </strong></td><td> 流体的动力黏度 [kg/(ms)].</td></tr>
<tr><td><strong> eta_nom        </strong></td><td> 额定流体的动力黏度 [kg/(ms)].</td></tr>
<tr><td><strong> m_flow         </strong></td><td> 质量流量 [kg/s],</td></tr>
<tr><td><strong> m_flow_nom     </strong></td><td> 额定质量流量 [kg/s],</td></tr>
<tr><td><strong> exp            </strong></td><td> 压力损失计算的指数 [-],</td></tr>
<tr><td><strong> exp_eta        </strong></td><td> 动力黏度依赖的指数 [-],</td></tr>
<tr><td><strong> rho            </strong></td><td> 流体密度 [kg/m3],</td></tr>
<tr><td><strong> rho_nom        </strong></td><td> 额定流体密度 [kg/m3].</td></tr>
</table>

<p>
为避免数值困难，对于
</p>
<ul>
<li>
小质量流量，其中
<blockquote><pre>
m_flow &le; (0.01*rho/rho_nom*(1/eta*eta_nom)^(exp_eta))^(1/exp) 和
</pre></blockquote>
</li>
<li>小压力损失，其中
<blockquote><pre>
dp &le; 0.01*dp_nom)
</pre></blockquote>
</li>
</ul>
<p>
此压力损失函数进行了线性平滑处理。
</p>
<p>
请注意，流体的密度（rho）和动力黏度（eta）通过运动黏度（nue）的定义确定。
</p>

<blockquote><pre>
nue = eta / rho
</pre></blockquote>

<p>
因此，如果设置动力黏度的指数（exp_eta == 1）以及密度和动力黏度的关系，变化的密度不会产生差异，因为动力黏度将以相同的方式变化。
</p>
<h4>验证</h4>
<p>
<strong>不可压缩性情况</strong> [压力损失 = f(m_flow)]:
</p>
<p>
质量流量 <strong>m_flow</strong> 对于不同流体密度和动力黏度依赖性的参数，在湍流压力损失情况下（exp == 2）如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_nominalDensityViscosity_i.png\" alt=\"dp_nominalDensityViscosity_i\"/>
</div>

<p>
<strong>压缩性情况</strong> [质量流量 = f(dp)]:
</p>
<p>
质量流量 <strong>M_FLOW</strong> 对于不同流体密度和动力黏度依赖性的参数，在湍流压力损失情况下（exp == 2）如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_nominalDensityViscosity_c.png\" alt=\"dp_nominalDensityViscosity_c\"/>
</div>

<h4>参考文献</h4>
<dl>
<dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
<dd><strong>Inline integration: A new mixed
symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Wischhusen, S.:</dt>
<dd><strong>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</strong>.
PhD thesis, Technische Universit&auml;t Hamburg-Harburg, 2005.</dd>
</dl>

</html>"          ));
    end dp_nominalDensityViscosity;

    class dp_nominalPressureLossLawDensity
    extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
依赖额定流体变量（例如，额定密度）通过从操作点插值计算通用压力损失。
此通用函数考虑通过额定压力损失（dp_nom）、压力损失系数（zeta_TOT）和压力损失定律指数（exp）以及密度对压力损失的影响。
</p>
<h4>计算</h4>
<p>
能量设备的几何参数通常并不完全已知，因此必须简化详细的压力损失计算模型。
该函数使用额定变量（例如，额定压力损失）在已知能量设备操作点处插值实际压力损失，根据压力损失定律（指数）。
</p>
<p>
以下压力损失 <strong>dp</strong> 通常通过相似定律从已知操作点确定：
</p>

<blockquote><pre>
dp/dp_nom = (zeta_TOT/zeta_TOT_nom)*(rho/rho_nom)*(v/v_nom)^exp
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> dp             </strong></td><td> 压力损失 [Pa],</td></tr>
<tr><td><strong> dp_nom         </strong></td><td> 额定压力损失 [Pa],</td></tr>
<tr><td><strong> m_flow         </strong></td><td> 质量流量 [kg/s],</td></tr>
<tr><td><strong> m_flow_nom     </strong></td><td> 额定质量流量 [kg/s],</td></tr>
<tr><td><strong> exp            </strong></td><td> 压力损失计算的指数 [-],</td></tr>
<tr><td><strong> rho            </strong></td><td> 流体密度 [kg/m3],</td></tr>
<tr><td><strong> rho_nom        </strong></td><td> 额定流体密度 [kg/m3],</td></tr>
<tr><td><strong> v              </strong></td><td> 平均流速 [m/s],</td></tr>
<tr><td><strong> v_nom          </strong></td><td> 额定平均流速 [m/s],</td></tr>
<tr><td><strong> zeta_TOT       </strong></td><td> 压力损失系数 [-],</td></tr>
<tr><td><strong> zeta_TOT_nom   </strong></td><td> 额定压力损失系数 [-].</td></tr>
</table>

<p>
平均流速比（v/v_nom）可以通过其相应的<strong>质量流量</strong>、密度和横截面积计算：
</p>

<blockquote><pre>
v/v_nom = (m_flow/m_flow_nom)*(A_cross/A_cross_nom)*(rho_nom/rho)
</pre></blockquote>

<p>
<strong>或者</strong>通过其相应的<strong>体积流量</strong>、密度和横截面积计算：
</p>

<blockquote><pre>
v/v_nom = (V_flow/V_flow_nom)*(A_cross_nom/A_cross).
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> A_cross        </strong></td><td> 横截面积 [m2],</td></tr>
<tr><td><strong> A_cross_nom    </strong></td><td> 额定横截面积 [m2],</td></tr>
<tr><td><strong> rho            </strong></td><td> 流体密度 [kg/m3],</td></tr>
<tr><td><strong> rho_nom        </strong></td><td> 额定流体密度 [kg/m3],</td></tr>
<tr><td><strong> v              </strong></td><td> 平均流速 [m/s],</td></tr>
<tr><td><strong> v_nom          </strong></td><td> 额定平均流速 [m/s],</td></tr>
<tr><td><strong> V_flow         </strong></td><td> 体积流量 [m3/s],</td></tr>
<tr><td><strong> V_flow_nom     </strong></td><td> 额定体积流量 [m3/s].</td></tr>
</table>

<p>
这里的<strong>压缩性情况</strong> [质量流量 = f(dp)] 确定给定压力损失下的未知质量流量：
</p>

<blockquote><pre>
m_flow = m_flow_nom*(A_cross/A_cross_nom)*(rho_nom/rho)^(exp_density/exp)*[(dp/dp_nom)*(zeta_TOT_nom/zeta_TOT)]^(1/exp);
</pre></blockquote>

<p>
其中密度比的指数是根据所选定的额定质量流量或额定体积流量确定的：
</p>

<blockquote><pre>
exp_density = if NominalMassFlowRate == Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate then 1-exp else 1
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> NominalMassFlowRate    </strong></td><td> 压力损失定律的参考（质量流量或体积流量），</td></tr>
<tr><td><strong> exp                    </strong></td><td> 压力损失计算的指数 [-],</td></tr>
<tr><td><strong> exp_density            </strong></td><td> 密度的指数 [-].</td></tr>
</table>

<p>
为避免数值困难，此压力损失函数在压力损失较小的情况下进行线性平滑处理，即
</p>

<blockquote><pre>
dp &le; 0.01*dp_nom
</pre></blockquote>

<p>
请注意，此库中所有函数的输入和输出参数始终使用质量流量。您可以选择 <strong>NominalMassFlowRate == Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate</strong> 使用额定质量流量，或者 <strong>NominalMassFlowRate == Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.VolumeFlowRate</strong> 使用额定体积流量。输出参数将始终是质量流量，以便在热水力框架中进一步用作流动模型。
</p>

<p>
请注意，压力损失系数（zeta_TOT，zeta_TOT_nom）是指其在压力损失定律中的平均流速度（v，v_nom），以获得其相应的压力损失。
</p>

<h4>验证</h4>
<p>
<strong>可压缩情况</strong> [质量流量 = f(压力损失)]:
</p>
<p>
通用质量流量 <strong>M_FLOW</strong> 与压力损失 <strong>dp</strong> 的依赖关系，在下图中显示为湍流压力损失情况（exp == 2）。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_nominalPressureLossLawDensity.png\" alt=\"dp_nominalPressureLossLawDensity\"/>
</div>

<p>
请注意，由于使用相同的函数，因此 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_nominalPressureLossLawDensity\">dp_nominalPressureLossLawDensity</a> 的验证对于这种反向计算也是有效的。
</p>

<h4>参考文献</h4>
<dl>
<dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
<dd><strong>Inline integration: A new mixed
symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Wischhusen, S.:</dt>
<dd><strong>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</strong>.
PhD thesis, Technische Universit&auml;t Hamburg-Harburg, 2005.</dd>
</dl>

</html>"              ));
    end dp_nominalPressureLossLawDensity;

    class dp_pressureLossCoefficient
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html><p>
依赖于压力损失系数的通用压力损失计算。
</p>
<h4>计算</h4><p>
质量流率 <strong>m_flow</strong> 由以下公式确定：
</p>
<pre><code >m_flow = rho*A_cross*(dp/(zeta_TOT *(rho/2))^0.5
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> A_cross </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 横截面积 [m2],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> dp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 压力损失 [Pa],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体密度 [kg/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> m_flow </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 质量流量 [kg/s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> zeta_TOT </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 压力损失系数 [-].</td></tr></tbody></table><h4>验证</h4><p>
<strong>可压缩情况</strong> [质量流量 = f(压力损失)]:
</p>
<p>
质量流量 <strong>M_FLOW</strong> 与压力损失 <strong>dp</strong> 的依赖关系，对于恒定的压力损失系数 <strong>zeta_TOT</strong> 在下图中显示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_pressureLossCoefficient.png\" alt=\"dp_pressureLossCoefficient\" data-href=\"\" style=\"\"/>
</p>
<p>
请注意，由于使用相同的函数，因此 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_pressureLossCoefficient\" target=\"\">dp_pressureLossCoefficient</a> 的验证对于这种反向计算也是有效的。
</p>
<h4>参考文献</h4><p>
Elmqvist, H., M.Otter and S.E. Cellier:
</p>
<p>
<strong>Inline integration: A new mixed symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.<br>In Proceedings of European Simulation MultiConference, Prague, 1995.
</p>
<p>
Wischhusen, S.:
</p>
<p>
<strong>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</strong>.<br>PhD thesis, Technische Universität Hamburg-Harburg, 2005.
</p>
<p>
<br>
</p>
</html>"    ));
    end dp_pressureLossCoefficient;

    class dp_volumeFlowRate
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html><p>
通用压力损失的计算，其对体积流量具有线性或二次依赖性。
</p>
<h4>计算</h4><p>
能量设备的几何参数通常并不完全知晓，这导致了对压力损失的计算必须被简化。该函数使用了压力损失对体积流量的二次依赖性。
</p>
<p>
在可压缩情况下 [质量流量 = f(压力损失)]，质量流量 <strong>m_flow</strong> 被确定为 <em> [见Wischhusen]</em>：
</p>
<pre><code >m_flow = rho*[-b/(2a) + {[b/(2a)]^2 + dp/a}^0.5]
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> a </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 二次系数 [Pa*s^2/m^6],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> b </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 线性系数 [Pa*s/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> dp </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 压力损失 [Pa],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> m_flow </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 质量流量 [kg/s],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体密度 [kg/m3].</td></tr></tbody></table><p>
请注意，系数 <strong>a,b</strong> 必须为正值，以使在正的体积流量时有正的（线性或二次）压力损失，反之亦然。
</p>
<h4>验证</h4><p>
<strong> 可压缩情况</strong> [质量流量 = f(压力损失)]:
</p>
<p>
在下图中显示了不同系数 <strong>a</strong> 作为参数时，压力损失 <strong>dp</strong> 与体积流量 <strong>V_flow</strong> 的依赖关系。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/General/dp_volumeFlowRate.png\" alt=\"dp_volumeFlowRate\" data-href=\"\" style=\"\"/>
</p>
<p>
请注意，由于使用相同的函数，因此 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.General.dp_volumeFlowRate\" target=\"\">dp_volumeFlowRate</a> 的验证对于这种反向计算也是有效的。
</p>
<h4>参考文献</h4><p>
Elmqvist, H., M.Otter and S.E. Cellier:
</p>
<p>
<strong>Inline integration: A new mixed symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.<br>In Proceedings of European Simulation MultiConference, Prague, 1995.
</p>
<p>
Wischhusen, S.:
</p>
<p>
<strong>Dynamische Simulation zur wirtschaftlichen Bewertung von komplexen Energiesystemen.</strong>.<br>PhD thesis, Technische Universität Hamburg-Harburg, 2005.
</p>
<p>
<br>
</p>
</html>"    ));
    end dp_volumeFlowRate;

      annotation (DocumentationClass=true);
    end General;

    package Orifice
      extends Modelica.Icons.Information;

    class dp_suddenChange
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<h4>限制</h4>
<p>
根据参考文献中的限制条件，此函数应在受限范围内使用。
</p>
<ul>
<li>
<strong>光滑表面</strong></li>
<li>
<strong>湍流流动区域</strong></li>
<li>
<strong>突扩的雷诺数 Re &gt; 3.3e3</strong> <em>[Idelchik 2006, p. 208, diag. 4-1]</em></li>
<li>
<strong>突缩的雷诺数 Re &gt; 1e4</strong> <em>[Idelchik 2006, p. 216-217, diag. 4-9]</em></li>
</ul>

<h4>几何</h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/suddenChangeSection.png\" alt=\"suddenChangeSection\"/>
</div>

<h4>计算</h4>
<p>
局部压力损失 <strong>dp</strong> 通常由以下公式确定：
</p>

<blockquote><pre>
dp = 0.5 * zeta_LOC * rho * |v_1|*v_1
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> rho              </strong></td><td> 流体密度 [kg/m3],</td></tr>
<tr><td><strong> v_1             </strong></td><td> 小横截面的平均流速 [m/s].</td></tr>
<tr><td><strong> zeta_LOC         </strong></td><td> 局部阻力系数 [-],</td></tr>
</table>

<p>
突扩的局部阻力系数 <strong>zeta_LOC</strong> 可通过不同截面积比计算得出：
</p>

<blockquote><pre>
zeta_LOC = (1 - A_1/A_2)^2  <em>[Idelchik 2006, p. 208, diag. 4-1]</em>
</pre></blockquote>

<p>
突缩的情况下：
</p>

<blockquote><pre>
zeta_LOC = 0.5*(1 - A_1/A_2)^0.75  <em>[Idelchik 2006, p. 216-217, diag. 4-9]</em>
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> A_1       </strong></td><td> 小横截面积 [m^2],</td></tr>
<tr><td><strong> A_2       </strong></td><td> 大横截面积 [m^2].</td></tr>
</table>

<h4>验证</h4>
<p>
突扩的局部阻力系数 <strong>zeta_LOC</strong> 随截面积比 <strong>A_1/A_2</strong> 的变化关系如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/suddenChangeExpansion.png\" alt=\"suddenChangeExpansion\"/>
</div>

<p>
突缩的局部阻力系数 <strong>zeta_LOC</strong> 随截面积比 <strong>A_1/A_2</strong> 的变化关系如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/suddenChangeContraction.png\" alt=\"suddenChangeContraction\"/>
</div>

<h4>参考文献</h4>
<dl>
<dt>Elmqvist, H., M.Otter and S.E. Cellier:</dt>
<dd><strong>Inline integration: A new mixed
symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Idelchik,I.E.:</dt>
<dd><strong>Handbook of hydraulic resistance</strong>.
Jaico Publishing House, Mumbai, 3rd edition, 2006.</dd>
</dl>
</html>"          ));
    end dp_suddenChange;

    class dp_thickEdgedOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<h4>限制</h4>
<p>
根据参考文献中的限制条件，此函数应在受限范围内使用。
</p>
<ul>
<li>
<strong>突变管道（vena contraction）的雷诺数 Re &gt; 1e3</strong> <em>[Idelchik 2006, p. 222, diag. 4-15]</em></li>
<li>
<strong>相对长度的突变管道 (L/d_hyd_0) &gt; 0.015</strong> <em>[Idelchik 2006, p. 222, diag. 4-15]</em></li>
<li>
<strong>Darcy 摩擦系数 lambda_FRI = 0.02</strong> <em>[Idelchik 2006, p. 222, sec. 4-15]</em></li>
</ul>

<h4>几何</h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/thickEdged.png\" alt=\"thickEdged\"/>
</div>

<h4>计算</h4>
<p>
厚边孔口的压力损失 <strong>dp</strong> 计算公式为：
</p>

<blockquote><pre>
dp = zeta_TOT * (rho/2) * (velocity_1)^2
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> rho            </strong></td><td> 流体密度 [kg/m3],</td></tr>
<tr><td><strong> velocity_1     </strong></td><td> 大横截面的平均速度 [m/s],</td></tr>
<tr><td><strong> zeta_TOT       </strong></td><td> 压力损失系数 [-].</td></tr>
</table>

<p>
厚边孔口的压力损失系数 <strong>zeta_TOT</strong> 可通过不同横截面积 <strong>A_0</strong> 和突变管道的相对长度 <strong>l_bar</strong> = L/d_hyd_0 计算得到：
</p>

<blockquote><pre>
zeta_TOT = (0.5*(1 - A_0/A_1)^0.75 + tau*(1 - A_0/A_1)^1.375 + (1 - A_0/A_1)^2 + lambda_FRI*l_bar)*(A_1/A_0)^2 <em>[Idelchik 2006, p. 222, diag. 4-15]</em>
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> A_0       </strong></td><td> 突变管道的横截面积 [m2],</td></tr>
<tr><td><strong> A_1       </strong></td><td> 厚边孔口的大横截面积 [m2],</td></tr>
<tr><td><strong> d_hyd_0   </strong></td><td> 突变管道的水力直径 [m],</td></tr>
<tr><td><strong> lambda_FRI</strong></td><td> 常数 Darcy 摩擦系数 [-],</td></tr>
<tr><td><strong> l_bar     </strong></td><td> 突变管道的相对长度 [-],</td></tr>
<tr><td><strong> L         </strong></td><td> 突变管道的长度 [m],</td></tr>
<tr><td><strong> tau       </strong></td><td> 几何参数 [-].</td></tr>
</table>

<p>
几何因子 <strong>tau</strong> 由以下公式确定 <em>[Idelchik 2006, p. 219, diag. 4-12]</em>：
</p>

<blockquote><pre>
tau = (2.4 - l_bar)*10^(-phi)
phi = 0.25 + 0.535*l_bar^8 / (0.05 + l_bar^8) .
</pre></blockquote>

<h4>验证</h4>
<p>
厚边孔口的压力损失系数 <strong>zeta_TOT</strong> 随相对长度 <strong>(l_bar = L /d_hyd)</strong> 和不同横截面积比 <strong>A_0/A_1</strong> 的变化关系如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/thickEdgedOverall_1.png\" alt=\"thickEdgedOverall_1\"/>
</div>

<p>
<strong>不可压缩情况</strong> [压力损失 = f(m_flow)]:
</p>
<p>
水的压力损失 <strong>DP</strong> 随质量流量 <strong>m_flow</strong> 的变化关系，对于不同比例的 <strong>A_0/A_1</strong> (其中 <strong>A_0</strong> = 0.001 m^2) 如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/thickEdgedOverall_2.png\" alt=\"thickEdgedOverall_2\"/>
</div>

<p>
<strong>以及可压缩情况</strong> [质量流量 = f(dp)]:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Orifice/thickEdgedOverall_3.png\" alt=\"thickEdgedOverall_3\"/>
</div>

<h4>参考文献</h4>
<dl>
<dt>Elmqvist,H., M.Otter and S.E. Cellier:</dt>
<dd><strong>Inline integration: A new mixed
symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.
In Proceedings of European Simulation MultiConference, Prague, 1995.</dd>
<dt>Idelchik,I.E.:</dt>
<dd><strong>Handbook of hydraulic resistance</strong>.
Jaico Publishing House,Mumbai, 3rd edition, 2006.</dd>
</dl>
</html>"          ));
    end dp_thickEdgedOverall;

      annotation (DocumentationClass=true);
    end Orifice;

    package StraightPipe
      extends Modelica.Icons.Information;

    class dp_laminar
    extends Modelica.Icons.Information;
    annotation(Documentation(info="<html><p>
计算仅在单相流体流动的<strong>层流</strong>流动区域中直管的压力损失。
</p>
<h4>限制</h4><p>
根据参考文献中的限制条件，此函数应在受限范围内使用。
</p>
<ul><li>
<strong>圆形横截面积</strong></li>
<li>
<em><strong>层流流动区域 (雷诺数 Re ≤ 2000) [VDI-Wärmeatlas 2002, p. Lab, eq. 3]</strong></em></li>
</ul><h4>几何</h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
直管的压力损失 <strong>dp</strong> 由以下公式确定：
</p>
<pre><code >dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda_FRI </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> Darcy 摩擦系数 [-].</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 直管长度 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 直管的水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体密度 [kg/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> velocity </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均速度 [m/s].</td></tr></tbody></table><p>
直管在层流流动区域的 Darcy 摩擦系数 <strong>lambda_FRI</strong> 可根据<strong>哈根-泊肃叶</strong>定律计算，如下所示：<em>[Idelchik 2006, p. 77, eq. 2-3]</em>：
</p>
<ul><li>
<strong>层流流动区域</strong> 限制于雷诺数 <strong>Re</strong> ≤ 2000</li>
<li>
通过以下公式计算： &nbsp; </li>
</ul><p>
在层流区域，Darcy 摩擦系数 <strong>lambda_FRI</strong> 与表面粗糙度 <strong>K</strong> 无关，只要相对粗糙度 <strong>k = 表面粗糙度/水力直径</strong> 小于0.007。 相对粗糙度 <strong>k</strong> 大于0.007 将导致层流区域在一定雷诺数 <strong>Re_lam_leave</strong> 值下提前进入过渡区域。本模型仅考虑层流流动，因此未对此提前离开进行建模。
</p>
<h4>验证</h4><p>
Darcy 摩擦系数 <strong>lambda_FRI</strong> 随雷诺数的变化关系如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/laminar.png\" alt=\"laminar\" data-href=\"\" style=\"\"/>
</p>
<p>
在水的质量流量变化下，层流区域的压力损失 <strong>dp</strong> 如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_laminar.png\" alt=\"dp_laminar\" data-href=\"\" style=\"\"/>
</p>
<p>
请注意，即使可以使用此压力损失函数来模拟层流流动区域之外的模型，但不应在层流流动区域之外的模型中使用该函数，即 <em><strong>Re &gt; 2000</strong></em>。
</p>
<p>
如果要对整个流动区域进行建模，可以使用压力损失函数 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\" target=\"\">dp_overall</a>。
</p>
<h4>参考文献</h4><p>
Elmqvist,H., M.Otter and S.E. Cellier:
</p>
<p>
<strong>Inline integration: A new mixed symbolic / numeric approach for solving differential-algebraic equation systems.</strong>.<br>In Proceedings of European Simulation MultiConference, Prague, 1995.
</p>
<p>
Idelchik,I.E.:
</p>
<p>
<strong>Handbook of hydraulic resistance</strong>.<br>Jaico Publishing House, Mumbai, 3rd edition, 2006.
</p>
<p>
VDI:
</p>
<p>
<strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>.<br>Springer Verlag, 9th edition, 2002.
</p>
<p>
<br>
</p>
</html>"    ));
    end dp_laminar;

    class dp_overall
    extends Modelica.Icons.Information;
    annotation(Documentation(info="<html><p>
仅考虑表面粗糙度的单相流体流动的直管中的<strong>层流或湍流</strong>流动区域的压力损失计算。
</p>
<h4>限制</h4><p>
根据参考文献中的限制条件，此函数应在受限范围内使用。
</p>
<ul><li>
<strong>圆形横截面积</strong></li>
</ul><h4>几何</h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\" data-href=\"\" style=\"\"/>
</p>
<h4>计算<br>直管的压力损失 <strong>dp</strong> 由以下公式确定：<br><br></h4><pre><code >dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda_FRI </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> Darcy 摩擦系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 直管长度 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 直管的水力直径 [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 流体密度 [kg/m3],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> velocity </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 平均速度 [m/s].</td></tr></tbody></table><p>
直管的 Darcy 摩擦系数 <strong>lambda_FRI</strong> 取决于流体流动区域（对应的雷诺数 <strong>Re</strong>）和绝对表面粗糙度 <strong>K</strong>。
</p>
<p>
<strong>层流区</strong> 对于 <strong>Re</strong> ≤ 2000，根据<strong>哈根-泊肃叶</strong>定律计算如下：<em>[Idelchik 2006, p. 77, eq. 2-3]</em>
</p>
<pre><code >lambda_FRI = 64/Re
</code></pre><p>
在层流区域，Darcy 摩擦系数 <strong>lambda_FRI</strong> 与表面粗糙度 <strong>k</strong> 无关，只要相对粗糙度 <strong>k</strong> 小于0.007。相对粗糙度 <strong>k</strong> 大于0.007 将导致在一定雷诺数 <strong>Re_lam_leave</strong> 值下哈根-泊肃叶定律提前失效。相对粗糙度 <strong>k</strong> 对层流区域失效的影响根据<em>[Samoilenko in Idelchik 2006, p. 81, sect. 2-1-21]</em> 计算如下：
</p>
<pre><code >Re_lam_leave = 754*exp(if k ≤ 0.007 then 0.93 else 0.0065/k)
</code></pre><p>
<strong>过渡区 </strong>对于 2000 &lt; <strong>Re</strong> ≤ 4000，通过层流和湍流流动区域之间的三次插值计算。不同的三次插值方程用于计算压力损失 <strong>dp</strong> 或质量流量 <strong>m_flow</strong>，导致 Darcy 摩擦系数 <strong>lambda_FRI</strong> 在过渡区域产生偏差。由于在过渡区域确定流体流动的不确定性，可以忽略这种偏差。
</p>
<p>
<strong>湍流区 </strong>可以根据表面平滑（Blasius 定律）<strong>或</strong> 粗糙表面（Colebrook-White 定律）进行计算：
</p>
<p>
<strong>平滑表面（表面粗糙度 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Neglected）</strong> 关于湍流区域的<strong>Blasius</strong> 定律如下：<em>[Idelchik 2006, p. 77, sec. 15]</em>:
</p>
<pre><code >lambda_FRI = 0.3164*Re^(-0.25)
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda_FRI </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> Darcy 摩擦系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-].</td></tr></tbody></table><p>
请注意，平滑直管在湍流区域的 Darcy 摩擦系数 <strong>lambda_FRI</strong> 与表面粗糙度 <strong>K</strong> 无关。
</p>
<p>
<strong>粗糙表面（表面粗糙度 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered）</strong> 关于湍流区域的<strong>Colebrook-White</strong> 定律如下：<em>[Miller 1984, p. 191, eq. 8.4]</em>:
</p>
<pre><code >lambda_FRI = 0.25/{lg[k/(3.7*d_hyd) + 5.74/(Re)^0.9]}^2
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> d_hyd </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 水力直径 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> k= K/d_hyd </strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>对粗糙度考虑 [-],</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> K </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 表面粗糙度（表面不平整的平均高度） [m],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> lambda_FRI </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> Darcy 摩擦系数 [-],</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 雷诺数 [-].</td></tr></tbody></table><h4>验证</h4><p>
Reynolds数的 Darcy 摩擦系数 <strong>lambda_FRI</strong> 与不同相对粗糙度 <strong>k</strong> 的关系如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_overall_1.png\" alt=\"dp_overall_1\" data-href=\"\" style=\"\"/>
</p>
<p>
水的质量流量 <strong>m_flow</strong> 对水的压力损失的依赖关系如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_overall_2.png\" alt=\"dp_overall_2\" data-href=\"\" style=\"\"/>
</p>
<p>
水的压力损失 <strong>dp</strong> 对水的质量流量 <strong>m_flow</strong> 的依赖关系如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_overall_3.png\" alt=\"dp_overall_3\" data-href=\"\" style=\"\"/>
</p>
<h4>参考文献</h4><p>
Idelchik,I.E.:
</p>
<p>
<strong>Handbook of hydraulic resistance</strong>.<br>Jaico Publishing House, Mumbai, 3rd edition, 2006.
</p>
<p>
Miller,D.S.:
</p>
<p>
<strong>Internal flow systems</strong>.<br>volume 5th of BHRA Fluid Engineering Series.BHRA Fluid Engineering, 1984.
</p>
<p>
Samoilenko,L.A.:
</p>
<p>
<strong>Investigation of the hydraulic resistance of pipelines in the zone of transition from laminar into turbulent motion</strong>.<br>PhD thesis, Leningrad State University, 1968.
</p>
<p>
VDI:
</p>
<p>
<strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>.<br>Springer Verlag, 9th edition, 2002.
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"    ));
    end dp_overall;

    class dp_turbulent
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
计算仅考虑表面粗糙度的单相流体流动的直管中的湍流流动状态下的压力损失。
</p>
<h4>限制</h4>
<p>
根据参考文献中的限制条件使用此函数。
</p>
<ul>
<li>
<strong>圆形横截面积</strong></li>
<li>
<strong>湍流流动状态（雷诺数 Re &ge; 4e3）<em>[VDI-W&auml;rmeatlas 2002, p. Lab 3, fig. 1]</em></strong></li>
</ul>

<h4>几何 </h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\"/>
</div>

<h4>计算</h4>
<p>
直管中的压力损失 <strong>dp</strong> 计算公式为：
</p>

<blockquote><pre>
dp = lambda_FRI * (L/d_hyd) * (rho/2) * velocity^2
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> lambda_FRI     </strong></td><td> Darcy 摩擦系数 [-]。</td></tr>
<tr><td><strong> L              </strong></td><td> 直管长度 [m]。</td></tr>
<tr><td><strong> d_hyd          </strong></td><td> 直管的水力直径 [m]。</td></tr>
<tr><td><strong> rho            </strong></td><td> 流体密度 [kg/m3]。</td></tr>
<tr><td><strong> velocity       </strong></td><td> 平均流速 [m/s]。</td></tr>
</table>

<p>
湍流区中直管的 Darcy 摩擦系数 <strong>lambda_FRI</strong> 可以根据表面光滑（Blasius定律）或表面粗糙（Colebrook-White定律）进行计算。
</p>
<p>
<strong>表面光滑（粗糙度 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Neglected）</strong> 关于湍流区的 <strong>Blasius</strong> 定律，根据 <em>[Idelchik 2006, p. 77, sec. 15]</em>：
</p>

<blockquote><pre>
lambda_FRI = 0.3164*Re^(-0.25)
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> lambda_FRI     </strong></td><td> Darcy 摩擦系数 [-]。</td></tr>
<tr><td><strong> Re             </strong></td><td> 雷诺数 [-]。</td></tr>
</table>

<p>
注意，湍流区中光滑直管的 Darcy 摩擦系数 <strong>lambda_FRI</strong> 与表面粗糙度 <strong>K</strong> 无关。
</p>

<p>
<strong>表面粗糙（粗糙度 = Modelica.Fluid.Dissipation.Utilities.Types.Roughness.Considered）</strong> 关于湍流区的 <strong>Colebrook-White</strong> 定律，根据 <em>[Miller 1984, p. 191, eq. 8.4]</em>：
</p>

<blockquote><pre>
lambda_FRI = 0.25/{lg[k/(3.7*d_hyd) + 5.74/(Re)^0.9]}^2
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> d_hyd          </strong></td><td> 水力直径 [-]。</td></tr>
<tr><td><strong> k= K/d_hyd     </strong></td><td> 相对粗糙度 [-]。</td></tr>
<tr><td><strong> K              </strong></td><td> 粗糙度（表面凹凸的平均高度） [m]。</td></tr>
<tr><td><strong> lambda_FRI     </strong></td><td> Darcy 摩擦系数 [-]。</td></tr>
<tr><td><strong> Re             </strong></td><td> 雷诺数 [-]。</td></tr>
</table>

<h4>验证</h4>
<p>
Reynolds数的 Darcy 摩擦系数 <strong>lambda_FRI</strong> 与不同相对粗糙度 <strong>k</strong> 的关系如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/turbulent.png\" alt=\"turbulent\"/>
</div>

<p>
注意，此压力损失函数不应用于模拟湍流流动区外的情况，即 <strong>Re</strong> &lt; 4e3，尽管它可以用于此类情况。
</p>

<p>
如果要模拟整个流动区，则可以使用压力损失函数 <a href=\"modelica://Modelica.Fluid.Dissipation.Utilities.SharedDocumentation.PressureLoss.StraightPipe.dp_overall\">dp_overall</a>。
</p>

<h4>参考文献</h4>
<dl>
<dt>Idelchik,I.E.:</dt>
<dd><strong>Handbook of hydraulic resistance</strong>.
Jaico Publishing House, Mumbai, 3rd edition, 2006.</dd>
<dt>VDI:</dt>
<dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
Springer Verlag, 9th edition, 2002.</dd>
</dl>
</html>"          ));
    end dp_turbulent;

    class dp_twoPhaseOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html><p>
计算水平或垂直直管中的<strong>两相流动</strong>的压力损失，考虑摩擦、动量和大地基准压力损失的整体流动状态。
</p>
<h4>限制</h4><p>
根据参考文献中的限制条件使用此函数。
</p>
<ul><li>
<strong>圆形横截面积</strong></li>
<li>
<strong>忽略表面粗糙度</strong></li>
<li>
<strong>水平流动或垂直向上流动</strong></li>
<li>
<strong>使用质量流量特性（见计算）</strong></li>
<li>
<strong>均匀常量质量流量特性（x_flow）的两相压力损失超过（增量）长度</strong></li>
<li>
<strong>使用考虑变化质量流量特性的沸腾或凝结的离散化两相压力损失函数</strong></li>
</ul><h4>几何 </h4><p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/straightPipe.png\" alt=\"straightPipe\" data-href=\"\" style=\"\"/>
</p>
<h4>计算</h4><p>
直管中的两相压力损失 <strong>dp_2ph</strong> 由以下公式确定：
</p>
<pre><code >dp_2ph = dp_fri + dp_mom + dp_geo
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> dp_fri </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 摩擦压力损失 [Pa]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> dp_mom </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 动量压力损失 [Pa]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> dp_geo </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 大地基准压力损失 [Pa]。</td></tr></tbody></table><p>
<strong>两相流动质量流量特性的定义</strong>：
</p>
<p>
不同的定义存在于两相流动的质量流量特性中。静态质量流量特性、质量流量特性和热力学质量流量特性可用于描述两相流动中气体和液体的分数。 这里使用质量流量特性 <strong>(x_flow)</strong> 来描述两相流动，如下所示：
</p>
<pre><code >x_flow = mdot_g/(mdot_g+mdot_l)
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> x_flow </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 质量流量特性 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> mdot_g </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 气态质量流率 [kg/s]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> mdot_l </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 液态质量流率 [kg/s]。</td></tr></tbody></table><p>
请注意，质量流量特性 <strong>(x_flow)</strong> 仅在忽略气体和液体相速度之间的差异（均匀方法）时等于静态质量流量特性。 此外，热力学质量流量特性仅在两相区域的热力学平衡时等于质量流量特性 <strong>(x_flow)</strong>。
</p>
<p>
<strong>摩擦压力损失</strong>：
</p>
<p>
直管的摩擦压力损失 <strong>dp_fri</strong> 是通过以下方式计算的：<strong>Friedel</strong>相关或<strong>Chisholm</strong>相关。 这两个相关性都可以用于上述命名的两相流动区域。 两相摩擦压力损失来源于假设单相液体流体流动的摩擦压力损失，并考虑到两相流动效应的两相乘数：
</p>
<pre><code >dp_fri = dp_1ph*phi_i
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> dp_1ph </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 假设单相液体流体流动的摩擦压力损失 [Pa]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> phi_i </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 两相乘数 [-]。</td></tr></tbody></table><p>
液体摩擦压力损失是在假定全部质量流率为液体流动的情况下计算的。
</p>
<p>
Friedel和Chisholm的相关性在计算两相乘数时有所不同：
</p>
<pre><code >phi_friedel = (1 - x_flow)^2 + x_flow^2*(rho_l/rho_g)*(lambda_g/lambda_l)
+ 3.43*x_flow^0.685*(1 - x_flow)^0.24*(rho_l/rho_g)^0.8*(eta_g/eta_l)^0.22*(1 - eta_g/eta_l)^0.89*(1/Fr_l^(0.048))*(1/We_l^(0.0334))
</code></pre><pre><code >phi_chisholm = 1 + (gamma^2 - 1)*(B*x_flow^((2 - n_exp)/2)*(1 - x_flow)^((2 -n_exp)/2) + x_flow^(2 - n_exp))
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> B </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> Lockhart-Martinelli系数 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> eta_l </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 液体相的动力黏度 [Pas]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> eta_g </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 气态相的动力黏度 [Pas]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> gamma </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 物性系数 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> n_exp</strong> =0.2 &nbsp; &nbsp; </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> Chisholm相关中的指数 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> phi_i </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 两相乘数 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho_l </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 液体相的密度 [kg/m3]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho_g </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 气态相的密度 [kg/m3]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re_l </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 液体相的雷诺数 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Re_g </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 气态相的雷诺数 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> Fr_l </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 液体相的弗劳德数 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> We_l </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 液体相的韦伯数 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> x_flow </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 质量流量特性 [-]。</td></tr></tbody></table><p>
请注意，用于摩擦压力损失的（均匀常量）质量流量特性 <strong>(x_flow)</strong> 被计算为直管长度末端和起始端的质量流量特性的算术平均值。
</p>
<p>
<strong>动量压力损失</strong>：
</p>
<p>
动量压力损失 <strong>dp_mom</strong> 可以考虑（momentumPressureLoss = true）对均匀或非均匀两相流进行，具体取决于用于空隙率 <strong>(epsilon)</strong> 的方法。 在蒸发过程中，液体相具有较慢的速度必须加速到气体相的较高速度。出口处和入口处的静压差导致了蒸发时的正动量压力损失（假设相反情况是凝结）。 由于凝结或蒸发导致质量流量特性发生变化，因此动量压力损失发生变化，根据<em>[VDI 2006, p.Lba 4, eq. 22]</em>：
</p>
<pre><code >dp_mom = mdot_A^2*[[((1-x_flow)^2/(rho_l*(1-epsilon)) + x_flow^2/(rho_g*epsilon))]_out - [((1-x_flow)^2/(rho_l*(1-epsilon)) + x_flow^2/(rho_g*epsilon))]_in]
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> mdot_A </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 总质量流率密度 [kg/(m2s)]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> epsilon </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 空隙率 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho_l </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 液体相的密度 [kg/m3]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho_g </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 气态相的密度 [kg/m3]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> x_flow </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 质量流量特性 [-]。</td></tr></tbody></table><p>
请注意，在蒸发或凝结期间，只有对质量流量特性 <strong>(x_flow)</strong> 进行变化的动量压力损失考虑在内。在对应的恒定质量流量特性下，不考虑由于压力损失而导致的蒸发的动量压力损失。
</p>
<p>
<strong>空隙率方法</strong>：
</p>
<p>
空隙率是用于表征两相流的最重要参数之一。根据<em>[Thome, J.R]</em>，有几种解析和经验方法：
</p>
<ul><li>
<strong>均匀方法</strong></li>
<li>
<strong>动量通量方法（非均匀模型）</strong></li>
<li>
<strong>Zivi的动能流方法（非均匀模型）</strong></li>
<li>
<strong>Chisholm的经验动量通量方法（非均匀模型）</strong></li>
</ul><p>
这些方法对于空隙率 <strong>epsilon</strong> 隐含了一个滑移比的相关性。滑移比定义为两相流动中气体相到液体相的速度比率。 在非均匀方法中，通过滑移比考虑了两相流动中两相流动速度的不同对两相压力损失的影响。均匀方法的滑移比为1，因此两相流动的两相速度没有差异（例如，适用于气泡流）。
</p>
<p>
<strong>大地基准压力损失</strong>：
</p>
<p>
可以考虑（geodeticPressureLoss=true）根据<em>[VDI 2006, p.Lbb 1, eq. 4]</em>计算两相流的大地基准压力损失：
</p>
<pre><code >dp_geo = (epsilon*rho_g +(1-epsilon)*rho_l)*g*L*sin(phi)
</code></pre><p>
其中
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> epsilon </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 空隙率 [-]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho_l </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 液体相的密度 [kg/m3]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> rho_g </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 气态相的密度 [kg/m3]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> g </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 重力加速度 [m/s2]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> L </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 直管长度 [m]，</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong> phi </strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 与水平面的夹角 [rad]。</td></tr></tbody></table><h4>验证</h4><p>
通过忽略动量和大地基准压力损失，使用<em>Friedel</em>相关计算的水平管道的两相压力损失如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_twoPhaseOverall_1.png\" alt=\"dp_twoPhaseOverall_1\" data-href=\"\" style=\"\"/>
</p>
<p>
通过忽略动量和大地基准压力损失，使用<em>Chisholm</em>相关计算的水平管道的两相压力损失如下图所示。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/StraightPipe/dp_twoPhaseOverall_4.png\" alt=\"dp_twoPhaseOverall_4\" data-href=\"\" style=\"\"/>
</p>
<h4>参考文献</h4><p>
Chisholm,D.:
</p>
<p>
<strong>Pressure gradients due to friction during the flow of evaporating two-phase mixtures in smooth tubes and channels</strong>.<br>Volume 16th of International Journal of Heat and Mass Transfer, 1973.
</p>
<p>
Friedel,L.:
</p>
<p>
<strong>IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW</strong>.3R International, Vol. 18, Issue 7, pp. 485-491, 1979.
</p>
<p>
VDI:
</p>
<p>
<strong>VDI - Wärmeatlas: Berechnungsblätter für den Wärmeübergang</strong>.<br>Springer Verlag, 10th edition, 2006.
</p>
<p>
J.M. Jensen and H. Tummescheit:
</p>
<p>
<strong>Moving boundary models for dynamic simulations of two-phase flows</strong>.<br>In Proceedings of the 2nd International Modelica Conference, pages 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.
</p>
<p>
Thome, J.R.:
</p>
<p>
<strong>Engineering Data Book 3</strong>.Swiss Federal Institute of Technology Lausanne (EPFL), 2009.
</p>
<p>
<br>
</p>
</html>"    ));
    end dp_twoPhaseOverall;

      annotation (DocumentationClass=true);
    end StraightPipe;

    package Valve
      extends Modelica.Icons.Information;

    class dp_severalGeometryOverall
     extends Modelica.Icons.Information;
    annotation(Documentation(info="<html>
<p>
计算阀门在整体流动状态下，根据其开度，针对不可压缩和单相流体流动的压力损失。
</p>
<h4>限制条件</h4>
<p>
此函数应在参考文献规定的限制范围内使用。
</p>
<ul>
<li>
<strong>开发的流体流动</strong>
</li>
<li>
<strong>球阀</strong>
</li>
<li>
<strong>隔膜阀</strong>
</li>
<li>
<strong>蝶阀</strong>
</li>
<li>
<strong>闸阀</strong>
</li>
<li>
<strong>滑阀</strong>
</li>
</ul>

<h4>几何结构</h4>
<p>
阀门几何结构可能有很大的变化，制造商不一定会在不同尺寸的同类型阀门之间保持几何相似性。这里可以估算以下类型阀门的压力损失：
</p>
<ul>
<li>
<strong>球阀</strong>
</li>
<li>
<strong>隔膜阀</strong>
</li>
<li>
<strong>蝶阀</strong>
</li>
<li>
<strong>闸阀</strong>
</li>
<li>
<strong>滑阀</strong>
</li>
</ul>

<h4>计算</h4>
<p>
阀门的质量流量<strong>m_flow</strong>由压力损失确定如下：
</p>

<blockquote><pre>
m_flow = [rho * dp * Av^2 / (zeta_TOT/2)]^0.5
m_flow = (2/zeta_TOT)^0.5 * Av * (rho * dp)^0.5
m_flow = valveCharacteristic * Av * (rho * dp)^0.5
</pre></blockquote>

<p>
其中
</p>

<table>
<tr><td><strong> rho                        </strong></td><td> 流体密度 [kg/m3]，</td></tr>
<tr><td><strong> Av                         </strong></td><td> （公制）流量系数（横截面积）[m^2]，</td></tr>
<tr><td><strong> m_flow                     </strong></td><td> 质量流量 [kg/s]，</td></tr>
<tr><td><strong> valveCharacteristic        </strong></td><td> 阀门系数，取决于其开度 [-]，</td></tr>
<tr><td><strong> velocity                   </strong></td><td> 平均速度 [m/s]，</td></tr>
<tr><td><strong> zeta_TOT                   </strong></td><td> 压力损失系数 [-]。</td></tr>
</table>

<p>
<strong>valveCharacteristic</strong>由其开度相关的压力损失系数（<strong>zeta_TOT</strong>）的相关性确定。引入一个额外变量<strong>valveCharacteristic</strong>是因为以下阀门的压力损失相关性定义不同。
</p>

<h4>验证</h4>
<p>
不同几何结构的阀门的压力损失系数（<strong>zeta_TOT</strong>）与开度的关系如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Valve/dp_severalGeometryOverall_z.png\" alt=\"dp_severalGeometryOverall_z\">
</div>

<p>
请注意，压力损失系数（<strong>zeta_TOT</strong>）在非常小的开度（开度 &le; 5%）下进行了数值优化。在小于5%的开度下，压力损失系数平滑设定为最大值（<strong>zeta_TOT_max</strong>），可调整为参数。因此，在几乎关闭的阀门下可以调整一个非常小的泄漏质量流量。在系统模拟中，阀门的非常小的泄漏质量流量通常可以忽略，而模拟的数值行为得到了改善。
</p>
<p>
在不同压力损失条件下，不同阀门在50%恒定开度下的质量流量如下图所示。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/SharedDocumentation/PressureLoss/Valve/dp_severalGeometryOverall.png\" alt=\"dp_severalGeometryOverall\"/>
</div>

<h4>参考文献</h4>
<dl>
<dt>Miller,D.S.:</dt>
<dd><strong>Internal flow systems</strong>。
BHRA Fluid Engineering Series，第5卷，1978年。</dd>
</dl>
</html>"          ));
    end dp_severalGeometryOverall;

      annotation (DocumentationClass=true);
    end Valve;

      annotation (DocumentationClass=true);
    end PressureLoss;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
此库包含在多个函数中多次使用的文档。为了避免文档的重复，在相应的函数中使用链接来链接到本库中可用的相应文档。
</p>

</html>"    ));

    end SharedDocumentation;

    package Functions "用于实用函数的库"
      extends Modelica.Icons.FunctionsPackage;

    package PressureLoss "用于实用压力损失函数的库"
      extends Modelica.Icons.FunctionsPackage;

    package TwoPhase 
      "用于计算两相压力损失特性的实用函数库"
      extends Modelica.Icons.FunctionsPackage;


          function dp_twoPhaseChisholm_DP 
            "根据Chisholm相关性计算直管的两相流摩擦压力损失 | 计算压力损失 | 总体流动状态"
            extends Modelica.Icons.Function;
            // 资料来源_1: Chisholm,D.: 由于在光滑管道和通道中蒸发两相混合物流动引起的摩擦压力梯度，Int. J. Heat Mass Transfer, Vol. 16, pp. 347-358, Pergamon Press 1973

            // 记录表
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con 
              IN_con 
              annotation (Dialog(group="常量输入"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var 
              IN_var 
              annotation (Dialog(group="变量输入"));
            input SI.MassFlowRate m_flow "质量流量" 
              annotation (Dialog(group="输入"));

            output SI.Pressure DP "输出函数 dp_twoPhaseChisholm_DP";

          protected
            Real MIN=Modelica.Constants.eps;

            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_con 
              IN_con_1ph(
              final roughness=Dissipation.Utilities.Types.Roughness.Neglected, 
              final d_hyd=4*abs(IN_con.A_cross)/max(MIN, abs(IN_con.perimeter)), 
              final K=0, 
              final L=abs(IN_con.length));

            Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_IN_var 
              IN_var_1ph(
                final eta=IN_var.eta_l, final rho=IN_var.rho_l);

          algorithm
            DP := Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_overall_DP(
                        IN_con_1ph, 
                        IN_var_1ph, 
                        m_flow)*(
              Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.TwoPhaseMultiplierChisholm(
                        IN_con, 
                        IN_var, 
                        m_flow));

            annotation (Inline=false);
          end dp_twoPhaseChisholm_DP;

          function dp_twoPhaseFriedel_DP 
            "Friedel相关的直管两相流摩擦压力损失 | 计算压力损失 | 总体流动状态"
            extends Modelica.Icons.Function;
            // 资料来源_1: Friedel,L.:IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW, 3R International, Vol. 18, Issue 7, pp. 485-491, 1979
            // 资料来源_2: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.

            import SMOOTH = 
              Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;
            import SMOOTH2 = 
              Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower;

            // 记录表
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con 
              IN_con 
              annotation (Dialog(group="常数输入"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var 
              IN_var 
              annotation (Dialog(group="变量输入"));
            input SI.MassFlowRate m_flow "质量流量" 
              annotation (Dialog(group="输入"));

            output SI.Pressure DP "输出函数 dp_twoPhaseFriedel_DP ";

          protected
            Real MIN = Modelica.Constants.eps;

            SI.Area A_cross = max(MIN, IN_con.A_cross) "横截面积";
            SI.Diameter d_hyd = max(MIN, 4 * A_cross / max(MIN, IN_con.perimeter)) 
              "水力直径";

            Real mdot_A = abs(m_flow) / A_cross "质量通量";
            SI.ReynoldsNumber Re_liq = max(1, mdot_A * d_hyd / max(MIN, IN_var.eta_l)) 
              "假设（总）质量通量流动为液体时的雷诺数";
            SI.ReynoldsNumber Re_lam_leave = 1055 
              "层流区的最大雷诺数（1055）";
            SI.ReynoldsNumber Re_turb = 1100 
              "湍流区的最小雷诺数（1100）";
            SI.ReynoldsNumber Re_smooth = m_flow / A_cross * d_hyd / max(MIN, abs(IN_var.eta_l)) 
              "平滑处理后的雷诺数";
            TYP.DarcyFrictionFactor lambda_FRI_lam = 64 / Re_liq 
              "层流区的 Darcy 摩阻系数";
            TYP.DarcyFrictionFactor lambda_FRI_turb = (0.86859 * Modelica.Math.log(max(1, (
                Re_liq / max(MIN, (1.964 * Modelica.Math.log(Re_liq) - 3.8215))))))^(-2) 
              "湍流区的 Darcy 摩阻系数";
            TYP.DarcyFrictionFactor lambda_FRI = lambda_FRI_lam * SMOOTH(
                Re_lam_leave, 
                Re_turb, 
                Re_liq) + lambda_FRI_turb * SMOOTH(
                Re_turb, 
                Re_lam_leave, 
                Re_liq);
            TYP.PressureLossCoefficient zeta_FRI = lambda_FRI * IN_con.length / d_hyd 
              "压力损失系数";
            SI.Pressure DP_liq = zeta_FRI * mdot_A^2 / (2 * max(MIN, IN_var.rho_l)) 
              "假设（总）质量通量流动为液体时的摩擦压力损失";

          algorithm
            DP := SMOOTH2(
                        Re_smooth, 
                        1, 
                        0) * DP_liq * (
              Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.TwoPhaseMultiplierFriedel(
                        IN_con, 
                        IN_var, 
                        m_flow));

              annotation (Inline=false);
          end dp_twoPhaseFriedel_DP;

          function dp_twoPhaseGeodetic_DP 
            "直管两相流的地形压力损失 | 计算压力损失"
            extends Modelica.Icons.Function;
            // 资料来源_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.

            import PI = Modelica.Constants.pi;

            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach 
              voidFractionApproach = Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous 
              "空隙率计算方法选择";

            input Boolean crossSectionalAveraged = true 
              "true:横截面平均空隙率，否则是体积空隙率" 
              annotation (Dialog);

            // 几何参数
            input SI.Length length = 1 "流体流动方向的长度" 
              annotation (Dialog(group="几何"));
            input SI.Angle phi = 0 "与水平方向的倾斜角度" 
              annotation (Dialog(group="几何"));

            // 流体性质
            input SI.Density rho_g(min = Modelica.Constants.eps) 
              "气态相密度" annotation (Dialog(group="流体性质"));
            input SI.Density rho_l(min = Modelica.Constants.eps) 
              "液态相密度" annotation (Dialog(group="流体性质"));
            input Real x_flow(
              min = 0, 
              max = 1) = 0 "质量流量特性" 
              annotation (Dialog(group="流体性质"));

            output SI.Pressure DP_geo "大地基准压力损失";

          protected
            Real xflow = min(1, max(0, abs(x_flow))) "质量流量特性";
            Real eps = 
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.VoidFraction(
                voidFractionApproach, 
                crossSectionalAveraged, 
                rho_g, 
                rho_l, 
                xflow) "空隙率";

          algorithm
            // 资料来源_1: p.Lbb 1, eq. 4: 考虑地形压力损失，假设流动长度的空隙率是恒定的
            DP_geo := (eps * rho_g + (1 - eps) * rho_l) * 9.81 * length * sin(phi);

              annotation (Inline=false);
          end dp_twoPhaseGeodetic_DP;

          function dp_twoPhaseMomentum_DP 
            "直管两相流的动量压力损失 | 计算压力损失"
            extends Modelica.Icons.Function;
            // 资料来源_1: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.
            // 资料来源_2: Thome, J.R., Engineering Data Book 3, Swiss Federal Institute of Technology Lausanne (EPFL), 2009.
            // 资料来源_3: J.M. Jensen and H. Tummescheit. Moving boundary models for dynamic simulations of two-phase flows. In Proceedings of the 2nd International Modelica Conference, pp. 235-244, Oberpfaffenhofen, Germany, 2002. The Modelica Association.

            import PI = Modelica.Constants.pi;
            import MIN = Modelica.Constants.eps;
            import SMOOTH = 
              Modelica.Fluid.Dissipation.Utilities.Functions.General.SmoothPower;

            //选择
            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach 
              voidFractionApproach= 
                Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous 
              "空隙率计算方法选择" annotation (Dialog(group="选择"));

            //资料来源_3: p.52, eq. 4.6: 通过修正质量流量考虑异质性对动量压力损失的影响
            input Boolean massFlowRateCorrection=false 
              "考虑非均匀质量流量修正" 
              annotation (Dialog(group="选择"));

            //几何参数
            input SI.Area A_cross(min=Modelica.Constants.eps) = PI*0.1^2/4 
              "横截面积" annotation (Dialog(group="几何"));
            input SI.Length perimeter(min=Modelica.Constants.eps) = PI*0.1 
              "周长" 
              annotation (Dialog(group="几何"));

            //流体性质
            input SI.Density rho_g(min=Modelica.Constants.eps) "气体密度" 
              annotation (Dialog(group="流体性质"));
            input SI.Density rho_l(min=Modelica.Constants.eps) 
              "液体密度" annotation (Dialog(group="流体性质"));
            input Real x_flow_end(
              min=0, 
              max=1) = 0 "长度末端的质量流量特性" 
              annotation (Dialog(group="流体性质"));
            input Real x_flow_sta(
              min=0, 
              max=1) = 0 "长度起始端的质量流量特性" 
              annotation (Dialog(group="流体性质"));

            input SI.MassFlowRate m_flow "质量流量" 
              annotation (Dialog(group="输入"));

            output SI.Pressure DP_mom "动量压力损失";

          protected
            Real MIN=Modelica.Constants.eps;

            SI.Area Across=max(MIN, A_cross) "横截面积";
            SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, perimeter)) 
              "水力直径";

            Real mdot_A=abs(m_flow)/Across "质量流量";
            Real xflowEnd=min(1, max(0, abs(x_flow_end))) 
              "长度末端的质量流量特性";
            Real xflowSta=min(1, max(0, abs(x_flow_sta))) 
              "长度起始端的质量流量特性";
            Real xflowMean=(xflowEnd + xflowSta)/2 
              "长度上平均质量流量分数";

            Real delta_xflow=xflowEnd - xflowSta 
              "末端和起始端质量流量之差（正 >> 蒸发，负 >> 凝结";

            //资料来源_2: 考虑空隙率方法
            Real eps_end= 
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.VoidFraction(
                voidFractionApproach, 
                true, 
                rho_g, 
                rho_l, 
                xflowEnd) "长度末端的空隙率";
            Real eps_sta= 
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.VoidFraction(
                voidFractionApproach, 
                true, 
                rho_g, 
                rho_l, 
                xflowSta) "长度起始端的空隙率";

            //资料来源_2: p.17-6, eq. 17.3.3: 考虑长度末端和起始端的两相平均密度
            SI.Density rho_end= 
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.TwoPhaseDensity(
                voidFractionApproach, 
                massFlowRateCorrection, 
                rho_g, 
                rho_l, 
                eps_end, 
                xflowEnd) "长度末端的平均两相密度";
            SI.Density rho_sta= 
                Modelica.Fluid.Dissipation.Utilities.Functions.PressureLoss.TwoPhase.TwoPhaseDensity(
                voidFractionApproach, 
                massFlowRateCorrection, 
                rho_g, 
                rho_l, 
                eps_sta, 
                xflowSta) "长度起始端的平均两相密度";

            SI.Velocity meanVelEnd=abs(m_flow)/max(MIN, rho_end*A_cross) 
              "长度末端两相流平均速度";
            SI.Velocity meanVelSta=abs(m_flow)/max(MIN, rho_sta*A_cross) 
              "长度起始端两相流平均速度";

            //资料来源_3: p.15, eq. 2.26: 考虑非均质方法的速度差异使用滑移比
            Real SR=Dissipation.Utilities.Functions.PressureLoss.TwoPhase.SlipRatio(
                voidFractionApproach, 
                rho_g, 
                rho_l, 
                xflowMean) "速度空隙率方法的滑移比";
            SI.Velocity deltaVelEnd=meanVelEnd*(SR - 1)/(xflowEnd*(SR - 1) + 1) 
              "长度末端两相速度差";
            SI.Velocity deltaVelSta=meanVelSta*(SR - 1)/(xflowSta*(SR - 1) + 1) 
              "长度起始端两相速

度差"                  ;

            //资料来源_3: p.52, eq. 4.6: 考虑修正质量流量的非均质方法
            SI.MassFlowRate mdotCorEnd=xflowEnd*(1 - xflowEnd)*rho_end*deltaVelEnd*Across 
              "长度末端的修正质量流量";
            SI.MassFlowRate mdotCorSta=xflowSta*(1 - xflowSta)*rho_sta*deltaVelSta*Across 
              "长度起始端的修正质量流量";

            //资料来源_3: p.53, eq. 4.13: 考虑流体相速度差异的质量流量修正的非均质方法计算
            SI.Pressure dp_mom_cor=SMOOTH(
                delta_xflow, 
                0.05, 
                0)*abs(mdot_A*meanVelEnd + mdotCorEnd*deltaVelEnd/Across) - abs(mdot_A* 
                meanVelSta + mdotCorEnd*deltaVelSta/Across) 
              "使用质量流量修正的动量压力损失";

          algorithm
            //资料来源_1: p.Lba 4, eq. 22: 考虑两相流非均质方法的动量压力损失
            //动量压力损失发生在由于蒸发或凝结导致质量流量的变化
            //在蒸发时，必须加速速度较慢的液态相至气态相的较高速度
            //出口和入口处的静压差导致蒸发时的正动量压力损失（假设凝结时相反）
            DP_mom := if massFlowRateCorrection then dp_mom_cor else mdot_A^2*SMOOTH(
              delta_xflow, 
              0.05, 
              0)*abs(1/max(MIN, rho_end) - 1/max(MIN, rho_sta));

            annotation (Inline=false, Documentation(revisions="<html>
2012-11-28 修正了动量压力损失计算中的错误。Stefan Wischhusen.
</html>"                    ));
          end dp_twoPhaseMomentum_DP;

          function TwoPhaseMultiplierFriedel 
            "根据 Friedel 计算两相乘子 | 常数质量流量特性 | 水平流动 | 垂直上下流"
            extends Modelica.Icons.Function;
            // 资料来源_1: Friedel,L.:IMPROVED FRICTION PRESSURE DROP CORRELATIONS FOR HORIZONTAL AND VERTICAL TWO PHASE PIPE FLOW, 3R International, Vol. 18, Issue 7, pp. 485-491, 1979
            // 资料来源_2: VDI-Waermeatlas, 10th edition, Springer-Verlag, 2006.

            import Modelica.Math.log;
            import SMOOTH = 
              Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con 
              IN_con 
              annotation (Dialog(group="常量输入"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var 
              IN_var(
                final sigma=0) annotation (Dialog(group="变量输入"));
            input SI.MassFlowRate m_flow "质量流量" 
              annotation (Dialog(group="输入"));

            output Real phi "基于Friedel的两相乘子";

          protected
            Real MIN=Modelica.Constants.eps;

            SI.Area A_cross=max(MIN, IN_con.A_cross) "横截面积";
            SI.Diameter d_hyd=max(MIN, 4*A_cross/max(MIN, IN_con.perimeter)) 
              "水力直径";

            // 资料来源_2: p.Lba 4, sec. 3.3: 基于常数质量流量特性的相关性(x_flow)，用于增量(dx)
            // 可通过离散化实现整体长度的压力损失（例如，L=n*dx）
            Real mdot_A=abs(m_flow)/A_cross "质量通量";
            Real x_flow=max(0, min(1, abs(IN_var.x_flow))) 
              "质量流量特性";

            // 资料来源_1: p.490 (附录): 基于流体性质流动的总质量流量的特征数
            SI.FroudeNumber Fr_l=max(MIN, mdot_A^2/max(MIN, 9.81*IN_var.rho_l^2*d_hyd)) 
              "基于液体流动的弗洛德数";
            SI.ReynoldsNumber Re_g=max(1, mdot_A*d_hyd/max(MIN, IN_var.eta_g)) 
              "基于气体流动的雷诺数";
            SI.ReynoldsNumber Re_l=max(1, mdot_A*d_hyd/max(MIN, IN_var.eta_l)) 
              "基于液体流动的雷诺数";
            SI.WeberNumber We_l=max(MIN, mdot_A^2*d_hyd/max(MIN, IN_var.sigma*IN_var.rho_l)) 
              "基于液体流动的韦伯数";

            // 资料来源_1: p.490 (附录): 对假定层流区到假定湍流区的突然变化进行平滑处理（在Re=1055时的数值改进）
            SI.ReynoldsNumber Re_lam_max=1025 
              "假定层流区的最大雷诺数";
            SI.ReynoldsNumber Re_turb_min=1075 
              "假定湍流区的最小雷诺数";

            // 资料来源_2: p.Lbb 2, eq. 9-10: 考虑雷诺数对光滑直管道 Darcy 摩擦系数的影响
            // 基于忽略表面粗糙度的相关性
            // 基于假定总质量流量为气体流动的相关性
            TYP.DarcyFrictionFactor lambda_lam_g=64/Re_g 
              "假定层流区域的气体 Darcy 摩擦系数";
            TYP.DarcyFrictionFactor lambda_turb_g=1/max(MIN, 0.86859*log(max(1, Re_g/max(
                MIN, 1.964*log(Re_g) - 3.8215))))^(2) 
              "假定湍流区域的气体 Darcy 摩擦系数";
            TYP.DarcyFrictionFactor lambda_g=lambda_lam_g*SMOOTH(
                Re_lam_max, 
                Re_turb_min, 
                Re_g) + lambda_turb_g*SMOOTH(
                Re_turb_min, 
                Re_lam_max, 
                Re_g) "整体区域的气体 Darcy 摩擦系数";
            // 基于假定总质量流量为液体流动的相关性
            TYP.DarcyFrictionFactor lambda_lam_l=64/Re_l 
              "假定层流区的液体 Darcy 摩擦系数";
            TYP.DarcyFrictionFactor lambda_turb_l=1/max(MIN, 0.86859*log(max(1, Re_l/max(
                MIN, 1.964*log(Re_l) - 3.8215))))^(2) 
              "假定湍流区的液体 Darcy 摩擦系数";
            TYP.DarcyFrictionFactor lambda_l=lambda_lam_l*SMOOTH(
                Re_lam_max, 
                Re_turb_min, 
                Re_l) + lambda_turb_l*SMOOTH(
                Re_turb_min, 
                Re_lam_max, 
                Re_l) "整体区域的液体 Darcy 摩擦系数";

            Real A=(1 - x_flow)^2 + x_flow^2*(IN_var.rho_l/max(MIN, IN_var.rho_g))*(
                lambda_g/max(MIN, lambda_l)) "用于两相乘子的加和项";

            // 资料来源_1: p.490 (附录): 垂直下流的两相乘子
            Real phi_vdo=A + 38.5*x_flow^0.76*(1 - x_flow)^0.314*(IN_var.rho_l/max(MIN, 
                IN_var.rho_g))^0.86*(IN_var.eta_g/max(MIN, IN_var.eta_l))^0.73*(1 - 
                IN_var.eta_g/max(MIN, IN_var.eta_l))^6.84*(1/Fr_l^(0.0001))*(1/We_l^(
                0.087));

            // 资料来源_1: p.490 (附录): 水平和垂直上流的两相乘子（资料来源_2中存在错误）
            Real phi_vup=A + 3.43*x_flow^0.685*(1 - x_flow)^0.24*(IN_var.rho_l/max(MIN, 
                IN_var.rho_g))^0.8*(IN_var.eta_g/max(MIN, IN_var.eta_l))^0.22*(1 - IN_var.eta_g 
                /max(MIN, IN_var.eta_l))^0.89*(1/Fr_l^(0.048))*(1/We_l^(0.0334));

          algorithm
            phi := phi_vup;

              annotation (Inline=false);
          end TwoPhaseMultiplierFriedel;

          function TwoPhaseMultiplierChisholm 
            "根据 Chisholm 计算两相乘数 | 常量质量流量特性"
            extends Modelica.Icons.Function;
            //资料来源_1: Chisholm,D.:PRESSURE GRADIENTS DUE TO FRICTION DURING THE FLOW OF EVAPORATING TWO-PHASE MIXTURES IN SMOOTH TUBES AND CHANNELS, Int. J. Heat Mass Transfer, Vol. 16, pp. 347-358, Pergamon Press 1973
            //资料来源_2: VDI-Waermeatlas, 第10版, Springer-Verlag, 2006.

            import SMOOTH = 
              Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_con 
              IN_con 
              annotation(Dialog(group = "常量输入"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.General.TwoPhaseFlow_var 
              IN_var 
              annotation(Dialog(group = "变量输入"));
            input SI.MassFlowRate m_flow "质量流量" 
              annotation(Dialog(group = "输入"));

            output Real phi "关于 Chisholm 的两相乘数";

          protected
            Real MIN = Modelica.Constants.eps;

            SI.Area A_cross = max(MIN, IN_con.A_cross) "截面积";
            SI.Diameter d_hyd = max(MIN, 4 * A_cross / max(MIN, IN_con.perimeter)) 
              "水力直径";

            Real mdot_A = abs(m_flow) / A_cross "质量通量";
            Real x_flow = max(0, min(1, abs(IN_var.x_flow))) 
              "质量流量特性";

            //资料来源_1: p.357, Appendix 1: 考虑平滑管道的 Darcy 摩擦系数 (lambda_FRI) 对整体流动区的影响
            Real n_exp = 0.2 "雷诺数的指数 (lambda_FRI= A/Re^n)";

            //资料来源_1: p.349, eq. 21: 考虑物理性质的影响 (资料来源_2 中的失败)
            Real gamma = max(1, abs(IN_var.rho_l / max(MIN, IN_var.rho_g)) ^ 0.5 * (IN_var.eta_g / 
              max(MIN, IN_var.eta_l)) ^ (n_exp / 2));

            //资料来源: p. 353, 表2: 考虑质量通量对两相乘数的影响
            Real B_gamma_1 = SMOOTH(
              450, 
              550, 
              mdot_A) * 4.8 + SMOOTH(
              550, 
              450, 
              mdot_A) * 2400 / max(MIN, mdot_A) - SMOOTH(
              1950, 
              1850, 
              mdot_A) * 2400 / max(MIN, mdot_A) + SMOOTH(
              1950, 
              1850, 
              mdot_A) * 55 / max(MIN, mdot_A ^ 0.5) 
              "gamma <= 9.5 的系数 B";
            Real B_gamma_2 = SMOOTH(
              550, 
              650, 
              mdot_A) * 520 / max(1, max(9.5, gamma) * mdot_A ^ 0.5) + SMOOTH(
              650, 
              550, 
              mdot_A) * 21 / max(9.5, gamma) 
              "9.5 <= gamma <= 28 的系数 B";
            Real B_gamma = SMOOTH(
              9.0, 
              10, 
              gamma) * B_gamma_1 + SMOOTH(
              10, 
              9.0, 
              gamma) * B_gamma_2 - SMOOTH(
              28.5, 
              27.7, 
              gamma) * B_gamma_2 + SMOOTH(
              28.5, 
              27.5, 
              gamma) * 15000 / max(MIN, gamma ^ 2 * mdot_A ^ 0.5) 
              "gamma 的系数 B";

            //资料来源_1: p. 350, eq. 24/26: 考虑关于 Chisholm 的两相乘数
          algorithm
            phi := 1 + (gamma ^ 2 - 1) * (B_gamma * x_flow ^ ((2 - n_exp) / 2) * (1 - x_flow) ^ ((2 - 
              n_exp) / 2) + x_flow ^ (2 - n_exp));

            annotation(Inline = false);
          end TwoPhaseMultiplierChisholm;

          function TwoPhaseDensity 
            "两相流的平均密度计算"
            extends Modelica.Icons.Function;
            //资料来源_1: VDI-Waermeatlas, 第10版, Springer-Verlag, 2006.
            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach 
              voidFractionApproach = 
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous 
              "空隙率方法的选择" annotation(Dialog(group = "选择"));

            //资料来源_3: p.52, eq. 4.6: 考虑通过修正质量流量对动量压降的非均匀效应
            input Boolean massFlowRateCorrection = false 
              "考虑非均匀质量流量修正" 
              annotation(Dialog(group = "选择"));

            input SI.Density rho_g(min = Modelica.Constants.eps) 
              "气相密度" 
              annotation(Dialog);
            input SI.Density rho_l(min = Modelica.Constants.eps) 
              "液相密度" 
              annotation(Dialog);
            input Real epsilon_A(min = 0, max = 1) 
              "空隙率（截面平均）" 
              annotation(Dialog(enable = not (twoPhaseDensityApproach == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseDensityApproach.Homogeneous)));
            input Real x_flow(min = 0, max = 1) "质量流量特性" annotation(Dialog);

            output SI.Density rho_2ph "两相流的平均密度";
          protected
            Real MIN = Modelica.Constants.eps;

            Real epsilonA = min(1, max(0, abs(epsilon_A))) 
              "空隙率（截面平均）";
            Real xflow = min(1, max(0, abs(x_flow))) "质量流量特性";

            //资料来源_1: p.Lba 3, eq. 17: 假设均匀方法的平均两相密度
            SI.Density rho_hom = 1 / max(MIN, x_flow / max(MIN, rho_g) + (1 - x_flow) / max(MIN, 
              rho_l));
            //资料来源_1: p.Lbb 7, 表2: 假设动量通量方法的平均两相密度
            SI.Density rho_mom = 1 / max(MIN, (x_flow) ^ 2 / max(MIN, rho_g * epsilonA) + (1 - 
              x_flow) ^ 2 / max(MIN, rho_l * (1 - epsilonA)));
            //资料来源_1: p.Lbb 7, 表2: 假设来自 Zivi 的动能流方法的平均两相密度（修正公式！）
            SI.Density rho_kin = 1 / max(MIN, rho_hom * (x_flow ^ 3 / max(MIN, rho_g ^ 2 * epsilonA ^ 2) 
              + (1 - x_flow) ^ 3 / max(MIN, rho_l ^ 2 * (1 - epsilonA) ^ 2)));

          algorithm
            rho_2ph := if not massFlowRateCorrection then rho_hom else if 
              voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous then 
              rho_hom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Momentum then 
              rho_mom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Energy then 
              rho_kin else MIN;

            annotation(Inline = false, Documentation(info = "<html>
<p>
两相流中的气体和液体部分通常是间断分布的。这种复杂的行为在工程计算中被简化。不同流体流动情况的两相流（例如，泡状流或分层流）被建模为气相和液相连续分布。
</p>

<p>
假设从间断两相流动情况到连续分布的<strong>平均密度</strong>可以通过<strong>均匀或非均匀方法</strong>（参见<a href=\"modelica://Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_twoPhaseOverall_DP\">dp_twoPhaseOverall_DP</a>）来计算。</p>
<p>
以下<strong>建模方法</strong>可用于计算两相流的平均密度：
</p>
<ul>
<li><strong>均匀密度</strong>（均匀方法）</li>
<li><strong>动量通量密度</strong>（非均匀方法）</li>
<li><strong>动能流密度</strong>（非均匀方法）</li>
</ul>

<p>
非均匀方法是通过最小化动量通量或动能流分析得出的，假设隐含两相流将趋向于此量的最小值。
</p>

<h4>参考文献</h4>
<dl>
<dt>VDI:</dt>
<dd><strong>VDI - W&auml;rmeatlas: Berechnungsbl&auml;tter f&uuml;r den W&auml;rme&uuml;bergang</strong>.
Springer Verlag, 第10版, 2006.</dd>
</dl>
</html>"                  , revisions = "<html>
<ul>
<li><em>2011年5月2日</em>
由 Stefan Wischhusen:<br>
修正了使用输入<code>massFlowRateCorrection</code>时的逻辑错误。</li>
</ul>
</html>"                  ));
          end TwoPhaseDensity;

          function VoidFraction 
            "两相流的（截面）空隙率计算"
            extends Modelica.Icons.Function;
            //资料来源_1: VDI-Waermeatlas, 第10版, Springer-Verlag, 2006.
            //资料来源_2: Thome, J.R., Engineering Data Book 3, 瑞士联邦理工学院洛桑分校 (EPFL), 2009.

            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach 
              voidFractionApproach = Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous 
              "空隙率方法的选择" annotation(Dialog(group = "选择"));

            input Boolean crossSectionalAveraged = true 
              "true:截面平均空隙率，否则为体积空隙率" 
              annotation(Dialog);

            input SI.Density rho_g(min = Modelica.Constants.eps) 
              "气相密度" annotation(Dialog);
            input SI.Density rho_l(min = Modelica.Constants.eps) 
              "液相密度" annotation(Dialog);
            input Real x_flow(
              min = 0, 
              max = 1) = 0 "质量流量特性" annotation(Dialog);

            output Real epsilon "空隙率";
            output Real slipRatio "滑移比";

          protected
            Real MIN = Modelica.Constants.eps;

            Real xflow = min(1, max(0, abs(x_flow))) "质量流量特性";

            Real SR = Dissipation.Utilities.Functions.PressureLoss.TwoPhase.SlipRatio(
              voidFractionApproach, 
              rho_g, 
              rho_l, 
              xflow) "空隙率方法的滑移比";

            //资料来源_2: p.17-5, eq. 17.2.5: （非均匀）截面空隙率 [epsilon_A=A_g/(A_g+A_l)]
            Real epsilon_A = rho_l * x_flow / max(MIN, rho_l * x_flow + rho_g * (1 - x_flow) * SR);

          algorithm
            epsilon := if crossSectionalAveraged then epsilon_A else epsilon_A / ((1 / max(
              MIN, SR)) * (1 - epsilon_A) + epsilon_A);
            slipRatio := SR;

            annotation(Inline = false);
          end VoidFraction;

          function SlipRatio "（分析/经验）滑移比的计算"
            extends Modelica.Icons.Function;
            //资料来源_1: VDI-Waermeatlas, 第10版, Springer-Verlag, 2006.
            //资料来源_2: Thome, J.R., Engineering Data Book 3, 瑞士联邦理工学院洛桑分校 (EPFL), 2009.
            //资料来源_3: J.M. Jensen 和 H. Tummescheit. 动态模拟两相流的移动边界模型. 在第二届国际Modelica会议上, pp. 235-244, Oberpfaffenhofen, 德国, 2002. Modelica协会.

            input
              Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach 
              voidFractionApproach = Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous 
              "空隙率方法的选择" annotation(Dialog(group = "选择"));

            input SI.Density rho_g(min = Modelica.Constants.eps) 
              "气相密度" annotation(Dialog);
            input SI.Density rho_l(min = Modelica.Constants.eps) 
              "液相密度" annotation(Dialog);
            input Real x_flow = 0 "质量流量特性" annotation(Dialog);

            output Real SR "滑移比";

          protected
            Real MIN = Modelica.Constants.eps;

            //资料来源_1: p.Lba 3, sec. 3.2
            Real SR_hom = 1 "均相方法的滑移比";
            //资料来源_2: p.17-6, eq. 17.3.4
            Real SR_mom = abs(rho_l / max(MIN, rho_g)) ^ 0.5 
              "动量通量方法的滑移比（非均匀）";
            //资料来源_2: p.17-7, eq. 17.3.13
            Real SR_kin = abs(rho_l / max(MIN, rho_g)) ^ (1 / 3) 
              "动能方法的滑移比（来自 Zivi，非均匀）";
            //资料来源_2: p.17-10, eq. 17.4.3
            Real SR_chi = (1 - x_flow * (1 - abs(rho_l) / max(MIN, abs(rho_g)))) ^ 0.5 
              "动量通量方法的经验滑移比（来自 Chisholm，非均匀）";

          algorithm
            SR := if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Homogeneous then 
              SR_hom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Momentum then 
              SR_mom else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Energy then 
              SR_kin else if voidFractionApproach == Modelica.Fluid.Dissipation.Utilities.Types.VoidFractionApproach.Chisholm then 
              SR_chi else 1;

            annotation(Inline = false);
          end SlipRatio;
      annotation();
        end TwoPhase;
      annotation();
      end PressureLoss;

      package HeatTransfer "用于实用换热函数的库"
        extends Modelica.Icons.FunctionsPackage;

      package TwoPhase 
        "用于计算两相换热特性的实用函数库"
        extends Modelica.Icons.FunctionsPackage;


          function kc_twoPhase_condensationHorizontal_KC 
            "直管局部两相传热系数 | 水平冷凝"
            extends Modelica.Icons.Function;
            //资料来源_1: M.M. Shah. 管内膜状冷凝传热的通用关联式. Int. J. Heat Mass Transfer, 第22卷, p.547-556, 1979.

            //记录表
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_con 
              IN_con annotation(Dialog(group = "常量输入"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_var 
              IN_var annotation(Dialog(group = "变量输入"));

            output SI.CoefficientOfHeatTransfer kc 
              "局部两相传热系数";

          protected
            Real MIN = Modelica.Constants.eps;

            SI.Area A_cross = max(MIN, IN_con.A_cross) "横截面积";
            SI.Diameter d_hyd = max(MIN, 4 * A_cross / max(MIN, IN_con.perimeter)) 
              "水力直径";

            Real x_flow = max(0, min(1, abs(IN_var.x_flow))) 
              "质量流量特性";
            Real p_red = max(MIN, abs(IN_var.pressure) / max(MIN, abs(IN_con.p_crit))) 
              "约简压力";

            SI.Velocity velocity = abs(IN_var.m_flow) / max(MIN, IN_var.rho_l * A_cross) 
              "平均速度";
            SI.ReynoldsNumber Re_l = (IN_var.rho_l * velocity * d_hyd / max(MIN, IN_var.eta_l)) 
              "假设液体（总）质量通量的雷诺数";
            SI.PrandtlNumber Pr_l = abs(IN_var.eta_l * IN_var.cp_l / max(MIN, IN_var.lambda_l)) 
              "假设液体（总）质量通量的普朗特数";

            //资料来源_1: p.548, eq. 8: 考虑到 Shah 的两相冷凝乘数
            SI.CoefficientOfHeatTransfer kc_1ph = 0.023 * Re_l ^ 0.8 * Pr_l ^ 0.4 * IN_var.lambda_l 
              / d_hyd;

          algorithm
            kc := kc_1ph * ((1 - x_flow) ^ 0.8 + 3.8 * x_flow ^ 0.76 * (1 - x_flow) ^ 0.04 / p_red ^ 
              0.38);
            annotation(Inline = false, smoothOrder = 5, 
              Documentation(revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 删除了质量流量为零时 Re 的奇点。</p>
</html>"                        ));
          end kc_twoPhase_condensationHorizontal_KC;

          function kc_twoPhase_boilingVertical_KC 
            "直管局部两相传热系数 | 垂直沸腾"
            extends Modelica.Icons.Function;
            //资料来源_1: Bejan,A.: 传热手册, Wiley, 2003.
            //资料来源_2: Gungor, K.E. 和 R.H.S. Winterton: 管和环中的流动沸腾的一般关联式, Int.J. Heat Mass Transfer, 第29卷, p.351-358, 1986.

            //记录
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_con 
              IN_con annotation(Dialog(group = "常量输入"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_var 
              IN_var annotation(Dialog(group = "变量输入"));

            output SI.CoefficientOfHeatTransfer kc 
              "局部两相传热系数";

          protected
            Real MIN = Modelica.Constants.eps;

            SI.Area A_cross = max(MIN, IN_con.A_cross) "横截面积";
            SI.Diameter d_hyd = max(MIN, 4 * A_cross / max(MIN, IN_con.perimeter)) 
              "水力直径";

            Real mdot_A = abs(IN_var.m_flow) / A_cross "质量通量";
            Real x_flow = max(0, min(1, abs(IN_var.x_flow))) 
              "质量流量特性";
            Real p_red = max(MIN, abs(IN_var.pressure) / max(MIN, abs(IN_con.p_crit))) 
              "约简压力";

            //资料来源_1: p.674, sec. 9.8.3: 考虑到 Gungor-Winterton 方程的核化和对流沸腾
            SI.MassFlowRate mdot_l = abs(IN_var.m_flow) * (1 - x_flow) 
              "仅液体的质量流量";
            SI.Velocity velocity_l = mdot_l / max(MIN, IN_var.rho_l * A_cross) 
              "假设液体质量流量单独流动的平均速度";
            SI.ReynoldsNumber Re_l = (IN_var.rho_l * velocity_l * d_hyd / max(MIN, IN_var.eta_l)) 
              "假设液体质量流量单独流动的雷诺数";
            SI.PrandtlNumber Pr_l = abs(IN_var.eta_l * IN_var.cp_l / max(MIN, IN_var.lambda_l)) 
              "假设液体质量流量单独流动的普朗特数";

            //资料来源_1: p.674, eq. 9.98: 考虑到 Gungor-Winterton 方程的沸腾数对核化沸腾的影响
            //沸腾数（Bo）定义为实际热通量与完全蒸发液体所需最大热通量之比
            Real Bo = abs(IN_var.qdot_A) / (max(MIN, mdot_A * IN_var.dh_lg)) 
              "沸腾数";
            //资料来源_1: p.673, eq. 9.94: 考虑到 Chen 方程的 Martinelli 参数
            Real X_tt = abs(((1 - x_flow) / max(MIN, x_flow)) ^ 0.9 * (IN_var.rho_g / max(MIN, 
              IN_var.rho_l)) ^ 0.5 * (IN_var.eta_l / max(MIN, IN_var.eta_g)) ^ 0.1) 
              "Martinelli 参数";

            //资料来源_1: p.675, eq. 9.105: 考虑到 Gungor-Winterton 方程的强制对流增强因子
            Real E_fc = 1 + 24000 * Bo ^ 1.16 + 1.37 * (1 / max(MIN, X_tt)) ^ 0.86 
              "强制对流增强因子";
            //资料来源_1: p.675, eq. 9.105: 考虑到Gungor-Winterton方程的核化沸腾抑制因子
            Real S_nb = 1 / max(MIN, 1 + 1.15e-6 * E_fc ^ 2 * Re_l ^ 1.17) 
              "核化沸腾抑制因子";

            //资料来源_1: p.672, eq. 9.91: 考虑到 Dittus-Boelter 方程的强制对流沸腾影响
            SI.CoefficientOfHeatTransfer kc_fc = 0.023 * Re_l ^ 0.8 * Pr_l ^ 0.4 * (IN_var.lambda_l 
              / d_hyd) 
              "假设液体质量流量单独流动的对流传热系数";
            //资料来源_1: p.675, eq. 9.107: 考虑到 Cooper 方程的核化沸腾影响
            SI.CoefficientOfHeatTransfer kc_nb = 55 * p_red ^ 0.12 * (1 / max(MIN, 
              Modelica.Math.log10(1 / p_red)) ^ 0.55) * (1 / max(MIN, IN_con.MM) ^ 0.5) * IN_var.qdot_A 
              ^ 0.67 "核化沸腾传热系数";

            //资料来源_2: p.354, sec. final equations: 垂直管道的两相传热系数的计算 Gungor-Winterton 方程
          algorithm
            kc := E_fc * kc_fc + S_nb * kc_nb;
            annotation(Inline = false, smoothOrder = 5, 
              Documentation(revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 删除了质量流量为零时 Re 的奇点。</p>
</html>"                        ));
          end kc_twoPhase_boilingVertical_KC;

          function kc_twoPhase_boilingHorizontal_KC 
            "水平沸腾直管的局部两相换热系数"
            extends Modelica.Icons.Function;
            //资料来源_1: Bejan,A.: 热传递手册, Wiley, 2003.
            //资料来源_2: Gungor, K.E. and R.H.S. Winterton: 管内和环流流动沸腾的通用相关性, Int.J. Heat Mass Transfer, Vol.29, p.351-358, 1986.

            import SMOOTH = 
              Modelica.Fluid.Dissipation.Utilities.Functions.General.Stepsmoother;

            //记录表
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_con 
              IN_con annotation(Dialog(group = "常量输入"));
            input
              Modelica.Fluid.Dissipation.Utilities.Records.HeatTransfer.TwoPhaseFlowHT_IN_var 
              IN_var annotation(Dialog(group = "变量输入"));

            output SI.CoefficientOfHeatTransfer kc 
              "局部两相换热系数";

          protected
            Real MIN = Modelica.Constants.eps;

            SI.Area A_cross = max(MIN, IN_con.A_cross) "横截面积";
            SI.Diameter d_hyd = max(MIN, 4 * A_cross / max(MIN, IN_con.perimeter)) 
              "水力直径";

            Real mdot_A = abs(IN_var.m_flow) / A_cross "质量流量";
            Real x_flow = max(0, min(1, abs(IN_var.x_flow))) 
              "质量流量特性";
            Real p_red = max(MIN, abs(IN_var.pressure) / max(MIN, abs(IN_con.p_crit))) 
              "约简压力";

            //资料来源_1: p.674, sec. 9.8.3: 考虑 Gungor-Winterton 方程中的核沸腾和对流沸腾
            SI.MassFlowRate mdot_l = abs(IN_var.m_flow) * (1 - x_flow) 
              "只有液体的质量流量";
            SI.Velocity velocity_l = mdot_l / max(MIN, IN_var.rho_l * A_cross) 
              "假设液体质量流量单独流动的平均速度";
            SI.ReynoldsNumber Re_l = (IN_var.rho_l * velocity_l * d_hyd / max(MIN, IN_var.eta_l)) 
              "假设液体质量流量单独流动的雷诺数";
            SI.PrandtlNumber Pr_l = abs(IN_var.eta_l * IN_var.cp_l / max(MIN, IN_var.lambda_l)) 
              "假设液体质量流率单独流动的普朗特数";
            //资料来源_1: p.352, sec. 术语: 考虑弗洛德数的分层效应
            SI.FroudeNumber Fr_l = abs(mdot_A ^ 2 / max(MIN, IN_var.rho_l ^ 2 * 9.81 * d_hyd)) 
              "假设(总)质量流量作为液体流动的弗洛德数";

            //资料来源_1: p.674, eq. 9.98: 考虑沸腾数对核沸腾的热流影响
            //沸腾数(Bo)定义为实际热流到完全蒸发液体所需的最大热流的比值
            Real Bo = abs(IN_var.qdot_A) / (max(MIN, mdot_A * IN_var.dh_lg)) 
              "沸腾数";
            //资料来源_1: p.673, eq. 9.94: 考虑Chen方程中的Martinelli参数
            Real X_tt = abs(((1 - x_flow) / max(MIN, x_flow)) ^ 0.9 * (IN_var.rho_g / max(MIN, 
              IN_var.rho_l)) ^ 0.5 * (IN_var.eta_l / max(MIN, IN_var.eta_g)) ^ 0.1) 
              "Martinelli参数";

            //资料来源_1: p.675, eq. 9.105: 考虑Gungor-Winterton方程中的对流增强因子
            Real E_fc = 1 + 24000 * Bo ^ 1.16 + 1.37 * (1 / max(MIN, X_tt)) ^ 0.86 
              "强迫对流的增强因子";
            //资料来源_1: p.675, eq. 9.105: 考虑Gungor-Winterton方程中的沸腾抑制因子
            Real S_nb = 1 / max(MIN, 1 + 1.15e-6 * E_fc ^ 2 * Re_l ^ 1.17) 
              "核沸腾的抑制因子";
            //资料来源_1: p.680, eq. 9.123: 考虑水平管道对对流增强因子的校正
            Real E_fc_hor = SMOOTH(
              0.049, 
              0.051, 
              Fr_l) * Fr_l ^ max(0, abs(0.1 - 2 * Fr_l)) + SMOOTH(
              0.051, 
              0.049, 
              0.051, 
              Fr_l) 
              "水平管道强迫对流增强因子的校正";
            //资料来源_1: p.680, eq. 9.124: 考虑水平管道核沸腾抑制因子的校正
            Real S_nb_hor = SMOOTH(
              0.049, 
              0.051, 
              Fr_l) * Fr_l ^ 0.5 + SMOOTH(
              0.051, 
              0.049, 
              Fr_l) 
              "水平管道核沸腾抑制因子的校正";

            //资料来源_1: p.672, eq. 9.91: 考虑Dittus-Boelter方程中的强迫对流沸腾效应
            SI.CoefficientOfHeatTransfer kc_fc = 0.023 * Re_l ^ 0.8 * Pr_l ^ 0.4 * (IN_var.lambda_l 
              / d_hyd) 
              "假设只有液体质量流量的对流换热系数";
            //资料来源_1: p.675, eq. 9.107: 考虑Cooper方程中的核沸腾效应
            SI.CoefficientOfHeatTransfer kc_nb = 55 * p_red ^ 0.12 * (1 / max(MIN, 
              Modelica.Math.log10(1 / p_red)) ^ 0.55) * (1 / max(MIN, IN_con.MM ^ 0.5)) * abs(
              IN_var.qdot_A) ^ 0.67 
              "核沸腾换热系数";

            //资料来源_2: p.354, sec. final equations: 计算水平管道的两相换热系数，参考Gungor-Winterton方程
          algorithm
            kc := E_fc * E_fc_hor * kc_fc + S_nb * S_nb_hor * kc_nb;
            annotation(Inline = false, smoothOrder = 5, 
              Documentation(revisions = "<html>
<p>2016-04-11 Stefan Wischhusen: 修正了零质量流速率时雷诺数的奇异性。</p>
</html>"                        ));
          end kc_twoPhase_boilingHorizontal_KC;
        annotation();

        end TwoPhase;
        annotation();
      end HeatTransfer;

      package General "实用函数库"
        extends Modelica.Icons.FunctionsPackage;


        function CubicInterpolation_Re 
          "Moody 图中过渡区雷诺数的三次 Hermite 样条插值（反向表达式）"
          extends Modelica.Icons.Function;
          import Modelica.Math;
          input Real Re_turbulent "未使用的输入";
          input SI.ReynoldsNumber Re1 "层流区的边界雷诺数";
          input SI.ReynoldsNumber Re2 "湍流区的边界雷诺数";
          input Real Delta "相对粗糙度";
          input Real lambda2 "修改的摩擦系数（= 独立变量）";
          output SI.ReynoldsNumber Re "过渡区域中插值的雷诺数";
        protected
          // 在y1=lg(Re1)处具有导数yd1=1的点x1=lg(lambda2(Re1))
          Real x1 = Math.log10(64 * Re1) "较小横坐标值";
          Real y1 = Math.log10(Re1) "较小纵坐标值";
          Real yd1 = 1 "左边界斜率";

          // 在 y2≈lg(Re2) 处，具有导数 yd2 的点 x2=lg(lambda2(Re2))
          Real aux1 = (0.5 / Math.log(10)) * 5.74 * 0.9;
          Real aux2 = Delta / 3.7 + 5.74 / Re2 ^ 0.9;
          Real aux3 = Math.log10(aux2);
          Real L2 = 0.25 * (Re2 / aux3) ^ 2;
          Real aux4 = 2.51 / sqrt(L2) + 0.27 * Delta;
          Real aux5 = -2 * sqrt(L2) * Math.log10(aux4);
          Real x2 = Math.log10(L2) "较大横坐标值";
          Real y2 = Math.log10(aux5) "较大纵坐标值";
          Real yd2 = 0.5 + (2.51 / Math.log(10)) / (aux5 * aux4) "右边界斜率";

          // 常数：在 x1=lg(lambda2(Re1)) 和 x2=lg(lambda2(Re2)) 之间的三次多项式
          Real diff_x = x2 - x1 "区间长度";
          Real m = (y2 - y1) / diff_x;
          Real c2 = (3 * m - 2 * yd1 - yd2) / diff_x;
          Real c3 = (yd1 + yd2 - 2 * m) / (diff_x * diff_x);
          Real lambda2_1 = 64 * Re1;
          Real dx = Math.log10(lambda2 / lambda2_1);

        algorithm
          // 优先选择对 Re 的优化插值公式，以避免调用 cubicHermite 函数
          // Re := 10^Modelica.Fluid.Utilities.cubicHermite(Math.log10(lambda2), x1, x2, y1, y2, yd1, yd2);
          Re := Re1 * (lambda2 / lambda2_1) ^ (yd1 + dx * (c2 + dx * c3));
          annotation(Inline = false, smoothOrder = 5, 
            Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Re = <strong>CubicInterpolation_Re</strong>(0, Re1, Re2, Delta, lambda2);
</pre></blockquote>
<h4>描述</h4>
<p>
函数 <strong>CubicInterpolation_Re</strong>(..) 通过三次埃尔米特样条插值的反向表达式来近似Moody图中层流和湍流之间的过渡区域的雷诺数<code>Re</code>。详细说明请参见<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">
Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction</a>（特别是<strong>Region 2</strong>）。
</p>
</html>"                      , revisions = "<html>
2018-11-20 Stefan Wischhusen: 将函数从CubicInterpolation_DP重命名为CubicInterpolation_Re。
</html>"                      ));
        end CubicInterpolation_Re;

        function CubicInterpolation_lambda 
          "Moody图中过渡区域的修改摩擦系数的三次 Hermite 条插值（直接表达式）"
          extends Modelica.Icons.Function;
          import Modelica.Math;
          input SI.ReynoldsNumber Re "雷诺数（= 独立变量）";
          input SI.ReynoldsNumber Re1 "层流区的边界雷诺数";
          input SI.ReynoldsNumber Re2 "湍流区的边界雷诺数";
          input Real Delta "相对粗糙度";
          output Real lambda2 "过渡区域中插值的修改摩擦系数";
        protected
          // 在y1=lg(lambda2(Re1))处具有导数yd1=1的点x1=lg(Re1)
          Real x1 = Math.log10(Re1) "较小横坐标值";
          Real y1 = Math.log10(64 * Re1) "较小纵坐标值";
          Real yd1 = 1 "左边界斜率";

          // 在y2=lg(lambda2(Re2))处，具有导数yd2的点x2=lg(Re2)
          Real aux1 = (0.5 / Math.log(10)) * 5.74 * 0.9;
          Real aux2 = Delta / 3.7 + 5.74 / Re2 ^ 0.9;
          Real aux3 = Math.log10(aux2);
          Real L2 = 0.25 * (Re2 / aux3) ^ 2;
          Real aux4 = 2.51 / sqrt(L2) + 0.27 * Delta;
          Real aux5 = -2 * sqrt(L2) * Math.log10(aux4);
          Real x2 = Math.log10(Re2) "较高横坐标值";
          Real y2 = Math.log10(L2) "较高纵坐标值";
          Real yd2 = 2 + 4 * aux1 / (aux2 * aux3 * (Re2) ^ 0.9) "右边界斜率";

          // 常数：在x1=lg(Re1)和x2=lg(Re2)之间的三次多项式
          Real diff_x = x2 - x1 "区间长度";
          Real m = (y2 - y1) / diff_x;
          Real c2 = (3 * m - 2 * yd1 - yd2) / diff_x;
          Real c3 = (yd1 + yd2 - 2 * m) / (diff_x * diff_x);
          Real dx = Math.log10(Re / Re1);

        algorithm
          // 优先选择对lambda2的优化插值公式，以避免调用 cubicHermite 函数
          // lambda2 := 10^Modelica.Fluid.Utilities.cubicHermite(Math.log10(Re), x1, x2, y1, y2, yd1, yd2);
          lambda2 := 64 * Re1 * (Re / Re1) ^ (yd1 + dx * (c2 + dx * c3));
          annotation(Inline = false, smoothOrder = 5, 
            Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
lambda2 = <strong>CubicInterpolation_lambda</strong>(Re, Re1, Re2, Delta);
</pre></blockquote>
<h4>描述</h4>
<p>
函数 <strong>CubicInterpolation_lambda</strong>(..) 通过（直接）三次埃尔米特样条插值来近似Moody图中层流和湍流之间的过渡区域的修改摩擦系数
<code>lambda2</code>=<code>lambda*Re^2</code>。详细说明请参见<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction\">
Modelica.Fluid.UsersGuide.ComponentDefinition.WallFriction</a>（特别是<strong>Region 2</strong>）。
</p>
</html>"                      , revisions = "<html>
2018-11-20 Stefan Wischhusen: 将函数从CubicInterpolation_MFLOW重命名为CubicInterpolation_lambda。
</html>"                      ));
        end CubicInterpolation_lambda;

        function LambertW 
          "求解 f(x) = x exp(x) 的 Lambert w 函数的封闭近似"
          extends Modelica.Icons.Function;
          input Real y "输入 f(x)";
          output Real x "输出 W(y)";
        protected
          Real xl;

        algorithm
          if (y <= 500.0) then
            xl := Modelica.Math.log(y + 1.0);
            x := 0.665 * (1 + 0.0195 * xl) * xl + 0.04;
          else
            xl := 0;
            x := Modelica.Math.log(y - 4.0) - (1.0 - 1.0 / Modelica.Math.log(y)) * 
              Modelica.Math.log(Modelica.Math.log(y));
          end if;

          assert(y > -1 / Modelica.Math.exp(1), 
            "Lambert-w函数仅对输入 y > -1/Modelica.Math.exp(1) 有效!");

          annotation(Inline = false, smoothOrder = 5, 
            Documentation(info = "<html>

<p>
此函数计算
</p>
<blockquote><pre>
f(x) = y = x * exp( x )
</pre></blockquote>

<p>
在 &infin; > y > -1/e 范围内的<strong>逆</strong>的近似值。下图显示了Lambert w函数<strong>x = W(y)</strong>的相对偏差。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/Functions/General/LambertW_deviation.png\" alt=\"LambertW_deviation\"/>
</div>

<p>
对于 y > 10 及更高的值，相对偏差小于2%。
</p>

</html>"                      ));
        end LambertW;

        function LambertWIter 
          "求解f(x) = x exp(x)的Lambert w函数的迭代形式"
          extends Modelica.Icons.Function;
          input Real y "输入 f(x)";
          output Real x "输出 W(y)";
          output Integer iter;
        protected
          Real w;
          Real prec = 1e-12;
          Real c1;
          Real c2;
          Real dw;
          Real w1;
          /*Real wTimesExpW;
          Real wPlusOneTimesExpW;*/
          Real dev;
          Integer i;

        algorithm
          w := if y > 0.1 then Modelica.Fluid.Dissipation.Utilities.Functions.General.LambertW(
            y) else sqrt(5.43656 * max(y, -1 / Modelica.Math.exp(1)) + 2) - 1;
          dev := 1;
          i := 0;
          while prec < dev and i < 100 loop
            /*wTimesExpW := w*Modelica.Math.exp(w);
            wPlusOneTimesExpW := (w+1)*Modelica.Math.exp(w);
            w := w-(wTimesExpW-y)/(wPlusOneTimesExpW-(w+2)*(wTimesExpW-y)/(2*w+2));
            dev := abs((y-wTimesExpW)/wPlusOneTimesExpW);
            i := i+1;*/

            c1 := Modelica.Math.exp(w);
            c2 := w * c1 - y;
            w1 := if w <> 1 then w + 1 else w;
            dw := c2 / (c1 * w1 - ((w + 2) * c2 / (2 * w1)));
            w := w - dw;
            //dev := abs(dw)/(2+abs(w));
            dev := abs((y - w * c1) / (w + 1) * c1);
            i := i + 1;
          end while;
          x := w;
          iter := i;

          annotation(Inline = false, smoothOrder = 5, 
            Documentation(info = "<html>

<p>
此函数计算
</p>
<blockquote><pre>
f(x) = y = x * exp( x )
</pre></blockquote>

<p>
在 &infin; > y > -1/e 范围内的<strong>逆</strong>的近似值。请注意，对于负输入，存在<strong>两个</strong>解。该函数目前为该特定范围提供 x = -1 ... 0 的结果。
</p>

</html>"                      ));
        end LambertWIter;

        function PrandtlNumber "计算普朗特数"
          extends Modelica.Icons.Function;
          import MIN = Modelica.Constants.eps;

          //流体性质
          input SI.SpecificHeatCapacityAtConstantPressure cp 
            "流体在恒定压力下的比热容";
          input SI.DynamicViscosity eta "流体的动力黏度";
          input SI.ThermalConductivity lambda "流体的导热系数";

          output SI.PrandtlNumber Pr "普朗特数";

        algorithm
          Pr := eta*cp/max(MIN, lambda);
          annotation (Inline=true, smoothOrder=1);
        end PrandtlNumber;

        function ReynoldsNumber "计算雷诺数"
          extends Modelica.Icons.Function;
          import MIN = Modelica.Constants.eps;

          //几何
          input SI.Area A_cross "横截面积";
          input SI.Length perimeter "湿周";

          //流体性质
          input SI.Density rho "流体密度";
          input SI.DynamicViscosity eta "流体动力黏度";

          input SI.MassFlowRate m_flow "质量流量";

          output SI.ReynoldsNumber Re "雷诺数";
          output SI.Velocity velocity "平均速度";

        protected
          SI.Diameter d_hyd=4*A_cross/max(MIN, perimeter) "水力直径";

        algorithm
          Re := 4*abs(m_flow)/max(MIN, (perimeter*eta));
          velocity := m_flow/max(MIN, (rho*A_cross));
          annotation (Inline=true, smoothOrder=1);
        end ReynoldsNumber;

        function SmoothPower 
          "限制函数如果 x>=0 则 y = x^pow 否则 y = -(-x)^pow 的导数"
          extends Modelica.Icons.Function;
          input Real x "输入变量";
          input Real deltax "插值范围";
          input Real pow "x 的指数";
          output Real y "输出变量";
        protected
          Real adeltax=abs(deltax);
          Real C3=(pow - 1)/2*adeltax^(pow - 3);
          Real C1=(3 - pow)/2*adeltax^(pow - 1);

        algorithm
          y := if x >= adeltax then x^pow else if x <= -adeltax then -(-x)^pow else (C1 
             + C3*x*x)*x;
          annotation (derivative(zeroDerivative=deltax, zeroDerivative=pow)=SmoothPower_der, 
            Inline=false, 
            smoothOrder=1, 
            Documentation(info="<html>
<p>
该函数用于限制在 x=0 处的以下函数的导数：
</p>
<blockquote><pre>
y = <strong>如果</strong> x &ge; 0 <strong>则</strong> x<sup><strong>pow</strong></sup> <strong>否则</strong> -(-x)<sup><strong>pow</strong></sup>;  // pow &gt; 0
</pre></blockquote>

<p>
通过在范围 -<strong>deltax</strong>&lt; x &lt; <strong>deltax</strong> 内用一个具有与上述函数相同导数的三阶多项式来近似该函数。
</p>

<h4>示例 </h4>
<p>
在下面的图片中，输入 x 从 -1 增加到 1。插值范围由相同范围定义。显示的是函数 SmoothPower 的输出与函数 y=x*|x| 的比较结果。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/Functions/General/SmoothPower.png\" alt=\"SmoothPower\"/>
</div>

<h4>参考</h4>
<dl>
<dt>ThermoFluid Library</dt>
<dd><strong><a href=\"http://sourceforge.net/projects/thermofluid/\">http://sourceforge.net/projects/thermofluid/</a></strong></dd>
</dl>
</html>"                        , revisions="<html>
2014-04-29 Stefan Wischhusen: 引入 deltax 和 pow 作为零导数。
</html>"                        ));
        end SmoothPower;

        function SmoothPower_der 
          "函数 SmoothPower 的导数"
          extends Modelica.Icons.Function;
          input Real x "输入变量";
          input Real deltax "插值范围";
          input Real pow "x 的指数";
          input Real dx "x 的导数";
          output Real dy "SmoothPower 的导数";
        protected
          Real C3;
          Real C1;
          Real adeltax;

        algorithm
          adeltax := abs(deltax);
          if x >= adeltax then
            dy := dx * pow * x ^ (pow - 1);
          elseif x <= -adeltax then
            dy := dx * pow * (-x) ^ (pow - 1);
          else
            C3 := (pow - 1) / 2 * adeltax ^ (pow - 3);
            C1 := (3 - pow) / 2 * adeltax ^ (pow - 1);
            dy := (C1 + 3 * C3 * x * x) * dx;
          end if;
          annotation(Documentation(revisions = "<html>
2014-04-29 Stefan Wischhusen: 修正 x<=-adeltax 的分支，移除 dpow 和 ddeltax。
2015-10-13 Stefan Wischhusen: 从 if 子句中移除 noEvent()。
</html>"                      ));
        end SmoothPower_der;

        function Stepsmoother "连续插值函数"

          extends Modelica.Icons.Function;
          input Real func "结果等于 100% 的输入值";
          input Real nofunc "结果等于 0% 的输入值";
          input Real x "连续插值的输入变量";
          output Real result "输出值";

        protected
          Real m=Modelica.Constants.pi/(func - nofunc);
          Real b=-Modelica.Constants.pi/2 - m*nofunc;

        algorithm
          result := if x >= func and func > nofunc or x 
             <= func and nofunc > func then 1 else if x 
             <= nofunc and func > nofunc or x >= nofunc and nofunc > func then 0 else (1+Modelica.Math.tanh(Modelica.Math.tan(m*x + b)))/2;
          annotation (
            Inline=false, 
            derivative=Stepsmoother_der, 
            Documentation(info="<html><p>
该函数用于在定义范围内连续淡化变量输入的影响。它允许在函数输出之间进行可微且平滑的过渡，例如层流和湍流压降或某些范围的相关性。
</p>
<h4>函数</h4><p>
使用 tanh 函数，因为它提供了现有的导数，并且在插值域 [<strong>nofunc</strong>, <strong>func</strong>] 的边界处导数为零（过渡的平滑导数）。<br> <br> 为了正确工作，需要按照外部任意输入 <strong>x</strong> 的内部插值范围进行缩放，使得：
</p>
<pre><code >f(func)   = 0.5 π
f(nofunc) = -0.5 π
</code></pre><h4>示例 </h4><p>
在下面的图片中，输入 x 从 0 增加到 1。插值范围由以下定义：
</p>
<ul><li>
func = 0.75</li>
<li>
nofunc = 0.25</li>
<li>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Dissipation/Utilities/Functions/General/Stepsmoother.png\" alt=\"Stepsmoother\" data-href=\"\" style=\"\"/></li>
</ul><h4>参考文献</h4><p>
Wischhusen, St.
</p>
<p>
<strong>Simulation von Kältemaschinen-Prozessen mit MODELICA / DYMOLA</strong>.<br>Diploma thesis, Hamburg University of Technology, Institute of Thermofluiddynamics, 2000.
</p>
<p>
<br>
</p>
</html>"                      ), smoothOrder=5);
        end Stepsmoother;

        function Stepsmoother_der "函数 Stepsmoother 的导数"
          extends Modelica.Icons.Function;
          input Real func "结果等于 100% 时的输入";
          input Real nofunc "结果等于 0% 时的输入";
          input Real x "插值的输入";
          input Real dfunc "func 的导数";
          input Real dnofunc "nofunc 的导数";
          input Real dx "x 的导数";
          output Real dresult;

        protected
          Real m = Modelica.Constants.pi / (func - nofunc);
          Real b = -Modelica.Constants.pi / 2 - m * nofunc;
          annotation();

        algorithm
          dresult := if x >= func and func > nofunc or x <= func and nofunc > func or x <= nofunc and func > nofunc or x >= nofunc 
            and nofunc > func then 0 else (1 - Modelica.Math.tanh(Modelica.Math.tan(m * x + b)) ^ 2) * 
            (1 + Modelica.Math.tan(m * x + b) ^ 2) * (-m ^ 2 / Modelica.Constants.pi * (dfunc - dnofunc) * x 
            + m * dx + m ^ 2 / Modelica.Constants.pi * (dfunc - dnofunc) * nofunc - m * dnofunc) / 2;
        end Stepsmoother_der;
        annotation();
      end General;
      annotation();
    end Functions;

    package Icons "流体耗散和流体配件库的图标"
      extends Modelica.Icons.IconsPackage;

      package HeatTransfer "传热计算图标"
      extends Modelica.Icons.IconsPackage;

        partial model Gap1_d "间隙几何图形"

          annotation(Diagram(coordinateSystem(
            preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
            graphics = {
            Rectangle(
            extent = {{-100, -40}, {60, -60}}, 
            fillPattern = FillPattern.Forward, 
            fillColor = {255, 255, 170}, 
            lineThickness = 1), 
            Polygon(
            points = {{60, -40}, {60, -60}, {100, -20}, {100, 0}, {60, -40}}, 
            lineThickness = 1, 
            fillColor = {255, 255, 170}, 
            fillPattern = FillPattern.Forward), 
            Rectangle(
            extent = {{-100, 40}, {60, 20}}, 
            fillPattern = FillPattern.Forward, 
            fillColor = {255, 255, 170}, 
            lineThickness = 1), 
            Polygon(
            points = {{60, 40}, {60, 20}, {100, 60}, {100, 80}, {60, 40}}, 
            lineThickness = 1, 
            fillColor = {255, 255, 170}, 
            fillPattern = FillPattern.Forward), 
            Polygon(
            points = {{100, 60}, {100, 0}, {60, 0}, {60, 20}, {100, 60}}, 
            lineThickness = 1, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            pattern = LinePattern.None), 
            Polygon(
            points = {{-100, -40}, {-100, 20}, {60, 20}, {60, 0}, {-60, 0}, {-100, -40}}, 
            lineThickness = 1, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            pattern = LinePattern.None), 
            Polygon(
            points = {{-100, 40}, {-60, 80}, {100, 80}, {60, 40}, {-100, 40}}, 
            lineThickness = 1, 
            fillColor = {255, 255, 170}, 
            fillPattern = FillPattern.Forward), 
            Line(
            points = {{-100, 20}, {60, 20}, {100, 60}}, 
            thickness = 1), 
            Line(
            points = {{-100, -40}, {60, -40}, {100, 0}}, 
            thickness = 1), 
            Line(
            points = {{20, 80}, {-20, 40}}, 
            arrow = {Arrow.Filled, Arrow.Filled}, 
            thickness = 0.5), 
            Rectangle(
            extent = {{-4, 66}, {4, 56}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            lineThickness = 1, 
            pattern = LinePattern.None), 
            Text(
            extent = {{-10, 66}, {10, 54}}, 
            textString = "h"), 
            Line(
            points = {{60, -66}, {-100, -66}}, 
            arrow = {Arrow.Filled, Arrow.Filled}, 
            thickness = 0.5), 
            Rectangle(
            extent = {{-22, -62}, {-14, -72}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            lineThickness = 1, 
            pattern = LinePattern.None), 
            Text(
            extent = {{-28, -62}, {-8, -74}}, 
            textString = "L"), 
            Polygon(
            points = {{-100, -40}, {-60, 0}, {100, 0}, {60, -40}, {-100, -40}}, 
            lineThickness = 1, 
            fillColor = {255, 255, 170}, 
            fillPattern = FillPattern.Forward), 
            Line(
            points = {{-80, 20}, {-80, -40}}, 
            arrow = {Arrow.Filled, Arrow.Filled}, 
            thickness = 0.5), 
            Rectangle(
            extent = {{-84, -4}, {-76, -14}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            pattern = LinePattern.None), 
            Text(
            extent = {{-90, -2}, {-70, -14}}, 
            textString = "s"), 
            Line(
            points = {{26, -10}, {-24, -10}}, 
            arrow = {Arrow.Filled, Arrow.None}, 
            thickness = 1), 
            Rectangle(
            extent = {{-4, -4}, {4, -14}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            lineThickness = 1, 
            pattern = LinePattern.None), 
            Text(
            extent = {{-10, -2}, {10, -14}}, 
            textString = "v"), 
            Ellipse(
            extent = {{78, 52}, {82, 48}}, 
            pattern = LinePattern.None, 
            lineThickness = 0.5, 
            fillPattern = FillPattern.Solid), 
            Ellipse(
            extent = {{78, -28}, {82, -32}}, 
            pattern = LinePattern.None, 
            lineThickness = 0.5, 
            fillPattern = FillPattern.Solid), 
            Line(
            points = {{80, -28}, {80, 48}}, 
            arrow = {Arrow.Filled, Arrow.Filled}, 
            thickness = 0.5), 
            Rectangle(
            extent = {{76, 16}, {84, 6}}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            lineThickness = 1, 
            pattern = LinePattern.None), 
            Text(
            extent = {{70, 16}, {90, 4}}, 
            textString = "T_wall"), 
            Text(
            extent = {{-30, 36}, {-10, 24}}, 
            textString = "wall 1"), 
            Text(
            extent = {{-30, -44}, {-10, -56}}, 
            textString = "wall 2")}));

        end Gap1_d;

        partial model HelicalPipe1_d "螺旋管几何图形"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
                graphics={
                Line(
                  points={{-60,82},{-60,-84}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dash), 
                Line(
                  points={{-62,-26},{60,-36}}, 
                  thickness=1), 
                Line(
                  points={{-62,24},{60,14}}, 
                  thickness=1), 
                Line(
                  points={{-60,-16},{62,-26}}, 
                  thickness=1), 
                Line(
                  points={{-60,34},{62,24}}, 
                  thickness=1), 
                Ellipse(
                  extent={{38,64},{78,24}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Ellipse(
                  extent={{38,14},{78,-26}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Ellipse(
                  extent={{-78,24},{-38,-16}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Ellipse(
                  extent={{-78,-26},{-38,-66}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Polygon(
                  points={{-60,-26},{60,-36},{60,-76},{-60,-66},{-60,-26}}, 
                  lineThickness=0.5, 
                  fillPattern=FillPattern.Forward, 
                  fillColor={255,255,170}, 
                  pattern=LinePattern.None), 
                Line(
                  points={{-60,-46},{60,-56}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dash), 
                Polygon(
                  points={{-60,24},{60,14},{60,-26},{-60,-16},{-60,24}}, 
                  lineThickness=0.5, 
                  fillPattern=FillPattern.Forward, 
                  fillColor={255,255,170}, 
                  pattern=LinePattern.None), 
                Line(
                  points={{-60,4},{60,-6}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dash), 
                Ellipse(
                  extent={{40,-36},{80,-76}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Polygon(
                  points={{-62,74},{58,64},{58,24},{-62,34},{-62,74}}, 
                  lineThickness=0.5, 
                  fillPattern=FillPattern.Forward, 
                  fillColor={255,255,170}, 
                  pattern=LinePattern.None), 
                Line(
                  points={{-60,54},{60,44}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dash), 
                Ellipse(
                  extent={{-80,74},{-40,34}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Polygon(
                  points={{-60,24},{60,64},{60,24},{-60,-16},{-60,24}}, 
                  lineThickness=0.5, 
                  fillPattern=FillPattern.Forward, 
                  fillColor={255,255,170}, 
                  pattern=LinePattern.None), 
                Line(
                  points={{8,28},{-8,22}}, 
                  arrow={Arrow.None,Arrow.Filled}, 
                  thickness=1), 
                Line(
                  points={{12,-24},{-4,-30}}, 
                  arrow={Arrow.None,Arrow.Filled}, 
                  thickness=1), 
                Polygon(
                  points={{-60,-26},{60,14},{60,-26},{-60,-66},{-60,-26}}, 
                  lineThickness=0.5, 
                  fillPattern=FillPattern.Forward, 
                  fillColor={255,255,170}, 
                  pattern=LinePattern.None), 
                Line(
                  points={{60,24},{-60,-16}}, 
                  thickness=0.5), 
                Line(
                  points={{60,14},{-60,-26}}, 
                  thickness=0.5), 
                Line(
                  points={{60,-26},{-60,-66}}, 
                  thickness=0.5), 
                Line(
                  points={{-60,74},{60,64}}, 
                  thickness=0.5), 
                Line(
                  points={{-60,24},{60,64}}, 
                  thickness=0.5), 
                Line(
                  points={{-60,-66},{60,-76}}, 
                  thickness=0.5), 
                Line(
                  points={{10,-22},{-6,-28}}, 
                  arrow={Arrow.None,Arrow.Filled}, 
                  thickness=1), 
                Ellipse(
                  extent={{46,-42},{74,-70}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Ellipse(
                  extent={{-74,68},{-46,40}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Line(
                  points={{-74,78},{-46,78}}, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Line(
                  points={{2,3},{-14,3}}, 
                  arrow={Arrow.None,Arrow.Filled}, 
                  thickness=1, 
                  origin={-38,55}, 
                  rotation=180), 
                Line(
                  points={{0,82},{0,-86}}, 
                  thickness=0.5, 
                  pattern=LinePattern.DashDot), 
                Line(
                  points={{60,-32},{60,-82}}, 
                  thickness=0.5, 
                  pattern=LinePattern.DashDot), 
                Line(
                  points={{-60,-82},{60,-82}}, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Rectangle(
                  extent={{-18,-76},{18,-88}}, 
                  fillPattern=FillPattern.Solid, 
                  fillColor={255,255,255}, 
                  lineThickness=0.5, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-14,-76},{12,-86}}, 
                  textString="d_mean"), 
                Line(
                  points={{46,-56},{88,-56}}, 
                  thickness=0.5, 
                  pattern=LinePattern.DashDot), 
                Line(
                  points={{60,18},{60,-30}}, 
                  thickness=0.5, 
                  pattern=LinePattern.DashDot), 
                Line(
                  points={{46,-6},{88,-6}}, 
                  thickness=0.5, 
                  pattern=LinePattern.DashDot), 
                Line(
                  points={{84,-6},{84,-56}}, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Rectangle(
                  extent={{74,-24},{98,-36}}, 
                  fillPattern=FillPattern.Solid, 
                  fillColor={255,255,255}, 
                  lineThickness=0.5, 
                  pattern=LinePattern.None), 
                Line(
                  points={{-74,82},{-74,52}}, 
                  thickness=0.5, 
                  pattern=LinePattern.DashDot), 
                Line(
                  points={{-46,82},{-46,52}}, 
                  thickness=0.5, 
                  pattern=LinePattern.DashDot), 
                Text(
                  extent={{72,-26},{98,-36}}, 
                  textString="h"), 
                Rectangle(
                  extent={{-68,84},{-50,76}}, 
                  fillPattern=FillPattern.Solid, 
                  fillColor={255,255,255}, 
                  lineThickness=0.5, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-72,86},{-50,78}}, 
                  textString="d_hyd"), 
                Rectangle(
                  extent={{-36,56},{-30,48}}, 
                  fillPattern=FillPattern.Solid, 
                  fillColor={255,255,255}, 
                  lineThickness=0.5, 
                  pattern=LinePattern.None), 
                Line(
                  points={{-40,54},{-40,50}}, 
                  thickness=1), 
                Text(
                  extent={{-44,56},{-22,48}}, 
                  textString="L")}));
        end HelicalPipe1_d;

        partial model Plate1_d "平板的几何图形 1"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
                graphics={
                Rectangle(
                  extent={{-100,10},{100,-10}}, 
                  fillPattern=FillPattern.Forward, 
                  fillColor={255,255,170}), 
                Line(
                  points={{-100,-20},{100,-20}}, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Text(
                  extent={{-14,-20},{12,-30}}, 
                  textString="L"), 
                Line(
                  points={{-20,16},{20,16}}, 
                  arrow={Arrow.None,Arrow.Filled}), 
                Text(
                  extent={{-14,26},{12,16}}, 
                  textString="velocity")}));
        end Plate1_d;

        partial model Plate2_d "平板的几何图形 2"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
                  Rectangle(
                  extent={{-100,-20},{60,-40}}, 
                  fillPattern=FillPattern.Forward, 
                  fillColor={255,255,170}, 
                  lineThickness=0.5),Polygon(
                  points={{-100,-20},{-60,20},{100,20},{60,-20},{-100,-20}}, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward, 
                  lineThickness=0.5),Polygon(
                  points={{60,-20},{60,-40},{100,0},{100,20},{60,-20}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward),Line(
                  points={{-20,0},{20,0}}, 
                  thickness=1, 
                  arrow={Arrow.None,Arrow.Filled}),Text(
                  extent={{-14,10},{12,0}}, 
                  textString="v"),Line(
                  points={{-100,-48},{60,-48}}, 
                  arrow={Arrow.Filled,Arrow.Filled}),Rectangle(
                  extent={{-26,-44},{-18,-54}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  lineThickness=1, 
                  pattern=LinePattern.None),Text(
                  extent={{-34,-44},{-8,-54}}, 
                  textString="L")}));
        end Plate2_d;

        partial model Channel_i "管道传热图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName= 
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/channel/icon_channel.png")}));
        end Channel_i;

        partial model General_i "一般传热组件图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName= 
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/general/icon_general.png")}));
        end General_i;

        partial model HeatExchanger_i 
          "换热器传热图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName= 
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/heatExchanger/icon_heatExchanger.png")}));
        end HeatExchanger_i;

        partial model HelicalPipe_i "螺旋管传热图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName= 
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/helicalPipe/icon_helicalPipe.png")}));
        end HelicalPipe_i;

        partial model Plate_i "平板传热图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName="modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/plate/icon_plate.png")}));
        end Plate_i;

        partial model StraightPipe_i 
          "直管传热图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName= 
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/heatTransfer/straightPipe/icon_straightPipe.png")}));

        end StraightPipe_i;
        annotation();
      end HeatTransfer;

      package PressureLoss "用于计算压力损失的图标"
        extends Modelica.Icons.IconsPackage;

        partial model BendEdged_d "直角弯头几何图形"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
                graphics={
                Rectangle(
                  extent={{-100,10},{0,-20}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Polygon(
                  points={{0,10},{100,-48},{100,-80},{0,-20},{0,10}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Ellipse(
                  extent={{-6,16},{8,2}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Polygon(
                  points={{0,40},{100,-20},{100,-48},{0,10},{0,40}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Rectangle(
                  extent={{-100,40},{0,10}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Polygon(
                  points={{-100,-40},{-100,-20},{0,-20},{0,-40},{-100,-40}}, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Polygon(
                  points={{0,-40},{0,-20},{100,-80},{100,-100},{0,-40}}, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Polygon(
                  points={{0,40},{0,60},{100,0},{100,-20},{0,40}}, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Polygon(
                  points={{-100,40},{-100,60},{0,60},{0,40},{-100,40}}, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Line(
                  points={{0,10},{100,-48}}, 
                  arrow={Arrow.None,Arrow.Filled}, 
                  thickness=0.5), 
                Line(
                  points={{-100,10},{0,10}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.None}), 
                Line(
                  points={{-78,40},{-78,-20}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Rectangle(
                  extent={{-90,32},{-62,18}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-90,30},{-64,20}}, 
                  textString="d_hyd"), 
                Text(
                  extent={{-10,20},{16,10}}, 
                  textString="delta"), 
                Rectangle(
                  extent={{-54,18},{-44,2}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-58,14},{-40,4}}, 
                  textString="L"), 
                Ellipse(
                  extent={{-2,6},{0,4}}, 
                  lineThickness=0.5, 
                  fillPattern=FillPattern.Solid), 
                Line(
                  points={{-2,4},{2,10}}, 
                  thickness=0.5)}));

        end BendEdged_d;

        partial model Channel_d "管道几何图形"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
                graphics={
                Line(
                  points={{-92,80},{-60,80}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot), 
                Ellipse(
                  extent={{20,80},{-20,40}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Ellipse(
                  extent={{80,74},{40,46}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Ellipse(
                  extent={{14,74},{-14,46}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Line(
                  points={{0,74},{0,46}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Rectangle(
                  extent={{-10,66},{10,56}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-9,66},{9,56}}, 
                  textString="d_cir"), 
                Ellipse(
                  extent={{-40,80},{-80,40}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  lineThickness=0.5), 
                Ellipse(
                  extent={{-46,74},{-74,46}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Line(
                  points={{0,14},{0,-14}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={-60,36}, 
                  rotation=90), 
                Line(
                  points={{-92,40},{-60,40}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot), 
                Line(
                  points={{-90,80},{-90,40}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Rectangle(
                  extent={{-98,64},{-82,54}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-99,65},{-81,55}}, 
                  textString="D_ann"), 
                Line(
                  points={{-16,0},{16,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={-74,46}, 
                  rotation=270), 
                Line(
                  points={{-16,0},{16,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={-46,46}, 
                  rotation=90), 
                Rectangle(
                  extent={{-68,38},{-52,28}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-69,39},{-51,29}}, 
                  textString="d_ann"), 
                Ellipse(
                  extent={{78,72},{42,48}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Line(
                  points={{-22,0},{22,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={60,60}, 
                  rotation=90), 
                Line(
                  points={{0,4},{0,-14}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={46,42}, 
                  rotation=90), 
                Rectangle(
                  extent={{46,46},{55,39}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{46,46},{55,39}}, 
                  textString="a_ell"), 
                Line(
                  points={{0,0},{22,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={42,38}, 
                  rotation=90), 
                Line(
                  points={{60,72},{92,72}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot), 
                Line(
                  points={{38,60},{92,60}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot), 
                Line(
                  points={{0,4},{0,-8}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={88,68}, 
                  rotation=360), 
                Rectangle(
                  extent={{82,68},{94,65}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{83,69},{95,63}}, 
                  textString="b_ell"), 
                Rectangle(
                  extent={{-60,24},{-20,-6}}, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward, 
                  lineThickness=0.5), 
                Rectangle(
                  extent={{-56,20},{-24,-2}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  lineThickness=0.5), 
                Line(
                  points={{-16,0},{16,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={-56,-2}, 
                  rotation=270), 
                Line(
                  points={{-16,0},{16,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={-24,-2}, 
                  rotation=270), 
                Line(
                  points={{0,14},{0,-18}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={-42,-14}, 
                  rotation=90), 
                Rectangle(
                  extent={{-50,-10},{-30,-20}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-48,-9},{-31,-18}}, 
                  textString="a_rec"), 
                Line(
                  points={{-16,0},{16,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={-31,20}, 
                  rotation=360), 
                Line(
                  points={{-16,0},{16,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={-31,-2}, 
                  rotation=360), 
                Line(
                  points={{0,12},{0,-10}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={-16,10}, 
                  rotation=180), 
                Rectangle(
                  extent={{-19,15},{0,3}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-18,13},{-1,4}}, 
                  textString="b_rec"), 
                Polygon(
                  points={{20,-10},{40,30},{60,-10},{20,-10}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Polygon(
                  points={{26,-6},{40,22},{54,-6},{26,-6}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Line(
                  points={{-16,0},{-4,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={26,-22}, 
                  rotation=270), 
                Line(
                  points={{0,20},{0,-8}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={46,-16}, 
                  rotation=90), 
                Line(
                  points={{-16,0},{-4,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={54,-22}, 
                  rotation=270), 
                Line(
                  points={{-16,0},{12,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={56,22}, 
                  rotation=360), 
                Line(
                  points={{-16,0},{12,0}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dot, 
                  origin={56,-6}, 
                  rotation=360), 
                Line(
                  points={{0,20},{0,-8}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={64,14}, 
                  rotation=180), 
                Rectangle(
                  extent={{55,15},{74,3}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{56,13},{73,4}}, 
                  textString="h_tri"), 
                Rectangle(
                  extent={{31,-11},{50,-23}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{32,-11},{49,-20}}, 
                  textString="a_tri"), 
                Line(
                  points={{36,14},{38,12},{42,12},{44,14}}, 
                  thickness=0.5), 
                Line(
                  points={{-12,-2},{0,-8}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.None}, 
                  origin={40,24}, 
                  rotation=360), 
                Text(
                  extent={{12,27},{29,18}}, 
                  textString="beta")}));

        end Channel_d;

        partial model OrificeSuddenChangeSection_d 
          "截面积突变孔口几何图形"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
                graphics={
                Rectangle(
                  extent={{-100,60},{100,-60}}, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Backward), 
                Rectangle(
                  extent={{-100,20},{0,-20}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Rectangle(
                  extent={{0,40},{100,-42}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Text(
                  extent={{-80,88},{86,76}}, 
                  textString="sudden expansion"), 
                Text(
                  extent={{-82,-76},{86,-88}}, 
                  textString="sudden contraction"), 
                Line(
                  points={{-20,0},{20,0}}, 
                  thickness=0.5, 
                  arrow={Arrow.None,Arrow.Filled}, 
                  origin={0,-72}, 
                  rotation=180), 
                Line(
                  points={{-20,0},{20,0}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={-48,0}, 
                  rotation=90), 
                Line(
                  points={{-62,0},{20,0}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={52,20}, 
                  rotation=90), 
                Rectangle(
                  extent={{42,6},{62,-8}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{38,4},{64,-6}}, 
                  textString="A_2"), 
                Rectangle(
                  extent={{-58,6},{-38,-8}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-62,4},{-36,-6}}, 
                  textString="A_1"), 
                Rectangle(
                  extent={{0,20},{0,-20}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-44,10},{40,2}}, 
                  textString="design flow direction"), 
                Line(
                  points={{-24,-4},{16,-4}}, 
                  thickness=0.5, 
                  arrow={Arrow.None,Arrow.Filled}), 
                Line(
                  points={{-20,70},{20,70}}, 
                  thickness=0.5, 
                  arrow={Arrow.None,Arrow.Filled})}));

        end OrificeSuddenChangeSection_d;

        partial model OrificeThickEdged_d 
          "厚边缩流断面孔几何图形"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
                graphics={
                Rectangle(
                  extent={{-100,60},{100,-60}}, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Backward), 
                Rectangle(
                  extent={{-40,20},{40,-20}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Rectangle(
                  extent={{40,40},{100,-42}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Line(
                  points={{-20,0},{20,0}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={-48,0}, 
                  rotation=90), 
                Line(
                  points={{-62,0},{20,0}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={70,20}, 
                  rotation=90), 
                Rectangle(
                  extent={{60,6},{80,-8}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{56,4},{82,-6}}, 
                  textString="A_1"), 
                Rectangle(
                  extent={{0,20},{0,-20}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Line(
                  points={{-40,-32},{40,-32}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Rectangle(
                  extent={{-100,40},{-40,-42}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid), 
                Line(
                  points={{-62,0},{20,0}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={-70,20}, 
                  rotation=90), 
                Rectangle(
                  extent={{-80,6},{-60,-8}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-84,4},{-58,-6}}, 
                  textString="A_1"), 
                Line(
                  points={{-42,0},{-2,0}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}, 
                  origin={0,22}, 
                  rotation=90), 
                Rectangle(
                  extent={{-2,6},{18,-8}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-14,4},{12,-6}}, 
                  textString="A_0"), 
                Rectangle(
                  extent={{-44,20},{-40,-20}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Rectangle(
                  extent={{40,20},{44,-20}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Rectangle(
                  extent={{-4,-28},{4,-38}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-12,-28},{14,-38}}, 
                  textString="L")}));
        end OrificeThickEdged_d;

        partial model StraightPipe_d "直管几何图形"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
                graphics={
                Ellipse(
                  extent={{98,46},{62,-54}}, 
                  lineThickness=0.5, 
                  fillPattern=FillPattern.Forward, 
                  fillColor={255,255,170}), 
                Polygon(
                  points={{-80,-54},{-80,46},{80,46},{80,-54},{-80,-54}}, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward, 
                  lineThickness=0.5, 
                  pattern=LinePattern.None), 
                Line(
                  points={{-80,52},{80,52}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Rectangle(
                  extent={{-4,58},{6,48}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-8,58},{10,48}}, 
                  textString="L"), 
                Ellipse(
                  extent={{90,26},{70,-34}}, 
                  pattern=LinePattern.Dash, 
                  lineThickness=0.5), 
                Line(
                  points={{0,26},{0,-34}}, 
                  thickness=0.5, 
                  arrow={Arrow.Filled,Arrow.Filled}), 
                Rectangle(
                  extent={{-6,-74},{10,-86}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Ellipse(
                  extent={{-62,46},{-98,-54}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,170}, 
                  fillPattern=FillPattern.Forward), 
                Ellipse(
                  extent={{-70,26},{-90,-34}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  lineThickness=0.5), 
                Line(
                  points={{-80,46},{80,46}}, 
                  thickness=0.5), 
                Line(
                  points={{-80,-54},{80,-54}}, 
                  thickness=0.5), 
                Line(
                  points={{-80,26},{80,26}}, 
                  pattern=LinePattern.Dash, 
                  thickness=0.5), 
                Line(
                  points={{-80,-34},{80,-34}}, 
                  thickness=0.5, 
                  pattern=LinePattern.Dash), 
                Line(
                  points={{-62,-4},{98,-4}}, 
                  thickness=0.5), 
                Rectangle(
                  extent={{-12,2},{10,-8}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Text(
                  extent={{-14,2},{12,-8}}, 
                  textString="d_hyd")}));

        end StraightPipe_d;

        partial model Valve_d "阀门图标"

          annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
                graphics={
                Rectangle(
                  extent={{-6,-74},{10,-86}}, 
                  lineThickness=0.5, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Line(points={{-60,0},{-100,0}}, color={0,127,255}), 
                Polygon(
                  points={{-60,50},{-60,-50},{60,-50},{60,50},{-60,50}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Line(points={{60,0},{100,0}}, color={0,127,255}), 
                Line(
                  points={{-60,50},{-60,-50},{60,50},{60,-50},{-60,50}}, 
                  thickness=0.5)}));

        end Valve_d;

        model FlowModel "Modelica.Fluid 应用程序中流动模型的图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
                    -100},{100,100}}), graphics={
                Polygon(
                  points={{-60,50},{-60,-50},{60,-50},{60,50},{-60,50}}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid, 
                  pattern=LinePattern.None), 
                Line(points={{-60,0},{-100,0}}, color={0,127,255}), 
                Line(
                  points={{-60,50},{-60,-50},{60,50},{60,-50},{-60,50}}, 
                  thickness=0.5), 
                Line(points={{60,0},{100,0}}, color={0,127,255})}));
        end FlowModel;

        partial model Bend_i "弯管图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName="modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/bend/icon_bend.png")}));
        end Bend_i;

        partial model Channel_i "管道图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName= 
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/channel/icon_channel.png")}));
        end Channel_i;

        partial model General_i "一般压降图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName= 
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/general/icon_general.png")}));
        end General_i;

        partial model HeatExchanger_i

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
                    {100,100}}), graphics={Bitmap(extent={{-100,-100},{100,100}}, 
                  fileName= 
                  "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/heatExchanger/icon_heatExchanger.png")}));
        end HeatExchanger_i;

        partial model Orifice_i "节流孔图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName= 
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/orifice/icon_orifice.png")}));
        end Orifice_i;

        partial model StraightPipe_i "直管图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName= 
                      "modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/StraightPipe/icon_straightPipe.png")}));
        end StraightPipe_i;

        partial model Valve_i "阀门图标"

          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
                    -100},{100,100}}), graphics={Bitmap(extent={{-100,-100},{
                      100,100}}, 
                    fileName="modelica://Modelica/Resources/Images/Fluid/Dissipation/PressureLoss/valve/icon_valve.png")}));
        end Valve_i;
        annotation();
      end PressureLoss;
      annotation();

    end Icons;

    package Records "基础记录库"
    extends Modelica.Icons.RecordsPackage;
      package General
        extends Modelica.Icons.RecordsPackage;
        record PressureLoss 
          "压力损失的流体性质基础记录"
          extends Modelica.Icons.Record;

          SI.DynamicViscosity eta "流体的动力黏度" 
            annotation(Dialog(group = "流体性质"));
          SI.Density rho "流体的密度" 
            annotation(Dialog(group = "流体性质"));
          annotation();
        end PressureLoss;

        record FluidProperties "流体性质基础记录"
          extends Modelica.Icons.Record;

          SI.SpecificHeatCapacityAtConstantPressure cp 
            "流体在恒定压力下的比热容" 
            annotation(Dialog(group = "流体性质"));

          SI.DynamicViscosity eta "流体的动力黏度" 
            annotation(Dialog(group = "流体性质"));

          SI.ThermalConductivity lambda "流体的热导率" 
            annotation(Dialog(group = "流体性质"));

          SI.Density rho "流体的密度" 
            annotation(Dialog(group = "流体性质"));
          annotation();
        end FluidProperties;

        record IdealGas_con 
          "通用压力损失函数的基础记录 | 理想气体 | 平均密度"
          extends Modelica.Icons.Record;

          Real exp = 2 "压力损失定律的指数" 
            annotation(Dialog(group = "通用变量"));
          SI.SpecificHeatCapacity R_s "理想气体的比热容" 
            annotation(Dialog(group = "流体性质"));
          Real Km = 6824.86 
            "压力损失定律的系数 [(Pa)^2/{(kg/s)^exp*K}]" 
            annotation(Dialog(group = "通用变量"));
          annotation();

        end IdealGas_con;

        record IdealGas_var 
          "通用压力损失函数的基础记录 | 理想气体 | 平均密度"
          extends Modelica.Icons.Record;

          SI.Density rho_m "理想气体的平均密度" 
            annotation(Dialog(group = "流体性质", enable = useMeanDensity));
          SI.Temperature T_m "理想气体的平均温度" 
            annotation(Dialog(group = "流体性质", enable = not (useMeanDensity)));
          SI.Pressure p_m "理想气体的平均压力" 
            annotation(Dialog(group = "流体性质", enable = not (useMeanDensity)));
          annotation();

        end IdealGas_var;

        record NominalDensityViscosity 
          "通用压力损失函数的基础记录"

          extends Modelica.Icons.Record;

          SI.Pressure dp_nom = 2 
            "额定压力损失（在额定质量流率和密度的额定值下）" 
            annotation(Dialog(group = "通用变量"));
          Real exp = 2 "压力损失定律的指数" 
            annotation(Dialog(group = "通用变量"));
          SI.MassFlowRate m_flow_nom = 1 
            "额定质量流率（在压力损失和密度的额定值下）" 
            annotation(Dialog(group = "通用变量"));
          SI.Density rho_nom 
            "额定密度（在质量流率和压力损失的额定值下）" 
            annotation(Dialog(group = "通用变量"));
          Real exp_eta = 1 "动力黏度依赖的指数" 
            annotation(Dialog(group = "通用变量"));
          SI.DynamicViscosity eta_nom 
            "在额定压力损失下的动力黏度" 
            annotation(Dialog(group = "通用变量"));
          annotation();

        end NominalDensityViscosity;

        record NominalPressureLossLawDensity_con 
          "通用压力损失函数的基础记录"

          extends Modelica.Icons.Record;

          //额定质量流率
          Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate 
            target = Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate 
            "MassFlowRate == 使用额定质量流率 | VolumeFlowRate == 使用额定体积流率" 
            annotation(Dialog(group = "通用变量"));

          SI.Area A_cross = A_cross_nom "横截面积" 
            annotation(Dialog(group = "通用变量"));
          SI.Area A_cross_nom = Modelica.Constants.pi * 0.1 ^ 2 / 4 
            "额定横截面积" 
            annotation(Dialog(group = "通用变量"));

          SI.Pressure dp_nom = 2 
            "额定压力损失（在额定质量流率和密度的额定值下）" 
            annotation(Dialog(group = "通用变量"));
          SI.MassFlowRate m_flow_nom = 1 
            "额定质量流率（在压力损失和密度的额定值下）" 
            annotation(Dialog(group = "通用变量", enable = target == 
            Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate));
          Real exp = 2 "压力损失定律的指数" 
            annotation(Dialog(group = "通用变量"));

          SI.VolumeFlowRate V_flow_nom = m_flow_nom / rho_nom 
            "额定体积流率（在压力损失和密度的额定值下）" 
            annotation(Dialog(group = "通用变量", enable = target == 
            Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.VolumeFlowRate));
          SI.Density rho_nom 
            "额定密度（在质量流率和压力损失的额定值下）" 
            annotation(Dialog(group = "通用变量"));

          Types.PressureLossCoefficient zeta_TOT_nom = 0.02 * 1 / 0.1 
            "额定压力损失系数（对于额定值）" 
            annotation(Dialog(group = "通用变量"));
          annotation();

        end NominalPressureLossLawDensity_con;

        record NominalPressureLossLawDensity_var 
          "通用压力损失函数的基础记录"

          extends Modelica.Icons.Record;

          TYP.PressureLossCoefficient zeta_TOT = 0.2 "压力损失系数" 
            annotation(Dialog(group = "通用变量"));
          annotation();

        end NominalPressureLossLawDensity_var;

        record QuadraticVFLOW 
          "通用压力损失函数的基础记录 | 二次函数 (dp=a*Vdot^2 + b*Vdot)"

          extends Modelica.Icons.Record;

          Real a(unit = "(Pa.s2)/m6") = 15 "二次项系数" 
            annotation(Dialog(group = "通用变量"));
          Real b(unit = "(Pa.s)/m3") = 0 "一次项系数" 
            annotation(Dialog(group = "通用变量"));
          annotation();

        end QuadraticVFLOW;

        record TwoPhaseFlow_con "两相流的基础记录"
          extends Modelica.Icons.Record;

          SI.Area A_cross = PI * 0.1 ^ 2 / 4 "横截面积" 
            annotation(Dialog(group = "几何"));
          SI.Length perimeter = PI * 0.1 "湿周" 
            annotation(Dialog(group = "几何"));
          SI.Length length = 1 "流体流动方向上的长度" 
            annotation(Dialog(group = "几何"));
          annotation();

        end TwoPhaseFlow_con;

        record TwoPhaseFlow_var "两相流的基础记录"
          extends Modelica.Icons.Record;

          SI.Density rho_g "气体的密度" 
            annotation(Dialog(group = "流体性质"));
          SI.Density rho_l "液体的密度" 
            annotation(Dialog(group = "流体性质"));
          SI.DynamicViscosity eta_g "气体的动力黏度" 
            annotation(Dialog(group = "流体性质"));
          SI.DynamicViscosity eta_l "液体的动力黏度" 
            annotation(Dialog(group = "流体性质"));
          SI.SurfaceTension sigma "表面张力" 
            annotation(Dialog(group = "流体性质"));

          //输入变量
          Real x_flow = 0 "长度上的平均质量流率质量分数" 
            annotation(Dialog(group = "输入"));
          annotation();
        end TwoPhaseFlow_var;

        record IdealGas 
          "通用压力损失函数的基础记录 | 理想气体 | 平均密度"
          extends Modelica.Icons.Record;

          parameter Real exp(min = Modelica.Constants.eps) = 2 
            "压力损失定律的指数" 
            annotation(Dialog(group = "通用变量"));
          parameter SI.SpecificHeatCapacity R_s(min = 1) 
            "理想气体的比热容" 
            annotation(Dialog(group = "流体性质"));

          Real Km(min = Modelica.Constants.eps) = R_s * (2e3) / ((10) ^ exp / rho_m) 
            "压力损失定律的系数 [(Pa)^2/{(kg/s)^exp*K}]" 
            annotation(Dialog(group = "通用变量"));
          SI.Density rho_m = p_m / (R_s * T_m) "理想气体的平均密度" 
            annotation(Dialog(group = "流体性质", enable = useMeanDensity));
          SI.Temperature T_m "理想气体的平均温度" 
            annotation(Dialog(group = "流体性质", enable = not (useMeanDensity)));
          SI.Pressure p_m "理想气体的平均压力" 
            annotation(Dialog(group = "流体性质", enable = not (useMeanDensity)));
          annotation();

        end IdealGas;

        record NominalPressureLossLawDensity 
          "通用压力损失函数的基础记录"

          extends Modelica.Icons.Record;

          //额定质量流率
          Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate 
            target = Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate 
            "MassFlowRate == 使用额定质量流率 | VolumeFlowRate == 使用额定体积流率" 
            annotation(Dialog(group = "通用变量"));

          parameter SI.Area A_cross = A_cross_nom "横截面积" 
            annotation(Dialog(group = "通用变量"));
          parameter SI.Area A_cross_nom = Modelica.Constants.pi * 0.1 ^ 2 / 4 
            "额定横截面积" 
            annotation(Dialog(group = "通用变量"));

          parameter SI.Pressure dp_nom(min = Modelica.Constants.eps) = 2 
            "额定压力损失（在额定质量流率和密度的额定值下）" 
            annotation(Dialog(group = "通用变量"));
          parameter SI.MassFlowRate m_flow_nom(min = Modelica.Constants.eps) = 1 
            "额定质量流率（在压力损失和密度的额定值下）" 
            annotation(Dialog(group = "通用变量", enable = target == 
            Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate));
          parameter Real exp(min = Modelica.Constants.eps) = 2 
            "压力损失定律的指数" 
            annotation(Dialog(group = "通用变量"));

          SI.VolumeFlowRate V_flow_nom(min = Modelica.Constants.eps) = m_flow_nom / rho_nom 
            "额定体积流率（在压力损失和密度的额定值下）" 
            annotation(Dialog(group = "通用变量", enable = not (target == 
            Modelica.Fluid.Dissipation.Utilities.Types.MassOrVolumeFlowRate.MassFlowRate)));
          SI.Density rho_nom(min = Modelica.Constants.eps) 
            "额定密度（在质量流率和压力损失的额定值下）" 
            annotation(Dialog(group = "通用变量"));

          Types.PressureLossCoefficient zeta_TOT = zeta_TOT_nom 
            "压力损失系数" annotation(Dialog(group = "通用变量"));
          parameter Types.PressureLossCoefficient zeta_TOT_nom = 0.02 * 1 / 0.1 
            "额定压力损失系数（对于额定值）" 
            annotation(Dialog(group = "通用变量"));
          annotation();

        end NominalPressureLossLawDensity;

        record TwoPhaseFlow "两相流的基础记录"
          extends Modelica.Icons.Record;

          SI.Density rho_l "液体的密度" 
            annotation(Dialog(group = "流体性质"));
          SI.Density rho_g "气体的密度" annotation(Dialog(group = 
            "流体性质", enable = (KC == 1 or KC == 2)));
          SI.DynamicViscosity eta_l "液体的动力黏度" 
            annotation(Dialog(group = "流体性质"));
          SI.DynamicViscosity eta_g "气体的动力黏度" annotation(
            Dialog(group = "流体性质", enable = (KC == 1 or KC == 2)));
          SI.MassFraction x = 0.5 "蒸汽的质量分数" 
            annotation(Dialog(group = "流体性质"));
          SI.SurfaceTension sigma "表面张力" annotation(Dialog(group = 
            "流体性质", enable = DP_fric == 1));
          Real n = 0.25 "Blasius 方程中的指数 (0.2-0.25)" annotation(Dialog(
            group = "其他", enable = DP_fric == 2));
          annotation();
        end TwoPhaseFlow;
        annotation();
      end General;

      package HeatTransfer
        extends Modelica.Icons.RecordsPackage;
        record EvenGap "均匀间隙的输入"
          extends Modelica.Icons.Record;

          //选择
          Modelica.Fluid.Dissipation.Utilities.Types.kc_evenGap target = Dissipation.Utilities.Types.kc_evenGap.DevBoth 
            "计算的目标变量" annotation(Dialog(group = "均匀间隙"));

          SI.Length h = 0.1 "横截面积的高度" 
            annotation(Dialog(group = "均匀间隙"));
          SI.Length s = 0.05 
            "横截面积中平行板之间的距离" 
            annotation(Dialog(group = "均匀间隙"));
          SI.Length L = 1 "间隙的溢流长度" annotation(Dialog(group = "均匀间隙"));
          annotation();
        end EvenGap;

        record General "通用相关性的输入"
          extends Modelica.Icons.Record;

          //选择
          Modelica.Fluid.Dissipation.Utilities.Types.kc_general target = Dissipation.Utilities.Types.kc_general.Finest 
            "目标相关性" annotation(Dialog(group = "通用变量"));

          //几何
          SI.Area A_cross = Modelica.Constants.pi * 0.1 ^ 2 / 4 "横截面积" 
            annotation(Dialog(group = "通用变量"));
          SI.Length perimeter = Modelica.Constants.pi * 0.1 "湿周" 
            annotation(Dialog(group = "通用变量"));
          annotation();
        end General;

        record HelicalPipe "螺旋管道的输入"
          extends Modelica.Icons.Record;

          Real n_nt = 1 "总转数" annotation(Dialog(group = "螺旋管道"));
          SI.Diameter d_hyd = 0.1 "水力直径" 
            annotation(Dialog(group = "螺旋管道"));
          SI.Length h = 0.01 "螺距" 
            annotation(Dialog(group = "螺旋管道"));
          SI.Length L = 1 "螺旋管道的总长度" 
            annotation(Dialog(group = "螺旋管道"));
          annotation();

        end HelicalPipe;

        record Plate "平板的输入"
          extends Modelica.Icons.Record;

          SI.Length L = 1 "平板的长度" annotation(Dialog(group = "平板"));
          annotation();

        end Plate;

        record StraightPipe "直管的输入"
          extends Modelica.Icons.Record;

          SI.Diameter d_hyd = 0.1 "水力直径" 
            annotation(Dialog(group = "直管"));
          SI.Length L = 1 "长度" annotation(Dialog(group = "直管"));
          annotation();
        end StraightPipe;

        record TwoPhaseFlowHT_IN_con 
          "两相传热系数的基本记录"
          extends Modelica.Icons.Record;

          //选择
          Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget 
            target = 
            Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor 
            "在管道中 (水平/垂直) 沸腾或 (水平) 冷凝的选择" 
            annotation(Dialog(group = "选择"));

          SI.Area A_cross = Modelica.Constants.pi * 0.1 ^ 2 / 4 "横截面积" 
            annotation(Dialog(group = "几何"));
          SI.Length perimeter = Modelica.Constants.pi * 0.1 "湿周" 
            annotation(Dialog(group = "几何"));

          Modelica.Fluid.Dissipation.Utilities.Types.MolarMass_gpmol MM = 18.02 
            "流体的摩尔质量" annotation(Dialog(group = 
            "流体性质", enable = if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor 
            or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then 
            true else false));
          SI.Pressure p_crit "流体的临界压力" 
            annotation(Dialog(group = "流体性质"));

          annotation(Documentation(revisions = "<html>
<ul>
<li><em>2011年5月13日</em>
by Stefan Wischhusen:<br>
更正了参数 MM 的所需单位。</li>
</ul>
</html>"          ));
        end TwoPhaseFlowHT_IN_con;

        record TwoPhaseFlowHT_IN_var 
          "两相传热系数的基本记录"
          extends Modelica.Icons.Record;

          //选择
          Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget 
            target = 
            Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor 
            "在管道中 (水平/垂直) 沸腾或 (水平) 冷凝的选择" 
            annotation(Dialog(group = "选择"));

          //fluid properties
          SI.SpecificHeatCapacityAtConstantPressure cp_l 
            "液体的定压比热容" 
            annotation(Dialog(group = "流体性质"));
          SI.ThermalConductivity lambda_l "液体的热导率" 
            annotation(Dialog(group = "流体性质"));
          SI.Density rho_g "气体的密度" annotation(Dialog(group = 
            "流体性质", enable = if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor 
            or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then 
            true else false));
          SI.Density rho_l "液体的密度" 
            annotation(Dialog(group = "流体性质"));
          SI.DynamicViscosity eta_g "气体的动力黏度" annotation(
            Dialog(group = "流体性质", enable = if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor 
            or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then 
            true else false));
          SI.DynamicViscosity eta_l "液体的动力黏度" 
            annotation(Dialog(group = "流体性质"));

          SI.Pressure pressure "流体的平均压力" 
            annotation(Dialog(group = "流体性质"));
          SI.SpecificEnthalpy dh_lg "流体的汽化焓" 
            annotation(Dialog(group = "流体性质", enable = if target == 
            Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor 
            or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then 
            true else false));

          //输入变量
          SI.MassFlowRate m_flow "质量流量" annotation(Dialog(group = "输入"));
          SI.HeatFlux qdot_A = 0 "沸腾时的热流量" annotation(Dialog(group = "输入", 
            enable = if target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilHor 
            or target == Modelica.Fluid.Dissipation.Utilities.Types.TwoPhaseHeatTransferTarget.BoilVer then 
            true else false));

          Real x_flow = 0 "质量流量特性" annotation(Dialog(group = "输入"));
          annotation();
        end TwoPhaseFlowHT_IN_var;
        annotation();
      end HeatTransfer;

      package PressureLoss
        extends Modelica.Icons.RecordsPackage;

        record Bend "弯管输入"
          extends EdgedBend;
          SI.Radius R_0 = 0.5 * d_hyd "曲率半径" annotation(Dialog(group = "弯管"));
          annotation();

        end Bend;

        record Geometry "内部流体几何形状输入"
          extends Modelica.Icons.Record;

          Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow 
            geometry = 
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Circular 
            "内部流体几何形状选择" annotation(Dialog(group = "通道"));

          SI.Length K = 0 "粗糙度（表面凹凸的平均高度）" 
            annotation(Dialog(group = "通道"));
          SI.Length L = 1 "长度" annotation(Dialog(group = "通道"));

          //几何变量
          //环形(1)
          SI.Diameter d_ann = d_cir "小直径" annotation(Dialog(group = 
            "环形横截面积", enable = geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Annular));
          SI.Diameter D_ann = 2 * d_ann "大直径" annotation(Dialog(group = 
            "环形横截面积", enable = geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Annular));
          //圆形(2)
          SI.Diameter d_cir = 0.1 "内径" annotation(Dialog(group = 
            "圆形横截面积", enable = geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Circular));
          //椭圆形(3)
          SI.Length a_ell = (3 / 4) * d_cir "长基线的一半长度" annotation(
            Dialog(group = "椭圆形横截面积", enable = geometry == 
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Elliptical));
          SI.Length b_ell = 0.5 * a_ell "短基线的一半长度" annotation(Dialog(
            group = "椭圆形横截面积", enable = geometry == 
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Elliptical));
          //矩形(4)
          SI.Length a_rec = d_cir "水平长度" annotation(Dialog(group = 
            "矩形横截面积", enable = geometry == 
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Rectangular));
          SI.Length b_rec = a_rec "垂直长度" annotation(Dialog(group = 
            "矩形横截面积", enable = geometry == 
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Rectangular));
          //三角形(5)
          SI.Length a_tri = d_cir * (1 + 2 ^ 0.5) "底边长度" annotation(Dialog(
            group = "矩形横截面积", enable = geometry == 
            Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Rectangular));
          SI.Length h_tri = 0.5 * a_tri 
            "与底边垂直的顶角高度" 
            annotation(Dialog(group = "三角形横截面积", enable = geometry 
            == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Isosceles));
          SI.Angle beta = 90 * PI / 180 "顶角" annotation(Dialog(group = 
            "三角形横截面积", enable = geometry == Modelica.Fluid.Dissipation.Utilities.Types.GeometryOfInternalFlow.Isosceles));
          annotation();
        end Geometry;

        record Orifice "节流孔输入"

          extends Modelica.Icons.Record;

          SI.Area A_0 = 0.1 * A_1 "缩流截面积" 
            annotation(Dialog(group = "节流孔"));
          SI.Length C_0 = 0.1 * C_1 "缩流周长" 
            annotation(Dialog(group = "节流孔"));
          SI.Area A_1 = PI * 0.01 ^ 2 / 4 "节流孔的大截面积" 
            annotation(Dialog(group = "节流孔"));
          SI.Length C_1 = PI * 0.01 "节流孔的大周长" 
            annotation(Dialog(group = "节流孔"));
          SI.Length L = 1e-3 "缩流截面长度" 
            annotation(Dialog(group = "节流孔"));
          annotation();
        end Orifice;

        record PressureLossInput "压力损失计算的输入"
          extends Modelica.Icons.Record;

          //目标变量
          Modelica.Fluid.Dissipation.Utilities.Types.PressureLossTarget target = Dissipation.Utilities.Types.PressureLossTarget.PressureLoss 
            "计算目标变量" annotation(Dialog(group = "输入"));

          SI.Pressure dp = 0 "压力损失" annotation(Dialog(group = "输入", enable = 
            target == Modelica.Fluid.Dissipation.Utilities.Types.PressureLossTarget.pressureLoss));
          SI.MassFlowRate m_flow = 0 "质量流量" annotation(Dialog(group = "输入", 
            enable = target == Modelica.Fluid.Dissipation.Utilities.Types.PressureLossTarget.massFlowRate));
          annotation();

        end PressureLossInput;

        record StraightPipe "直管输入"

          extends Modelica.Icons.Record;

          SI.Diameter d_hyd = 0.1 "水力直径" 
            annotation(Dialog(group = "直管"));
          SI.Length L = 1 "长度" annotation(Dialog(group = "直管"));
          annotation();
        end StraightPipe;

        record Tjunction "T型管输入"
          extends Modelica.Icons.Record;

          //T型管变量
          Boolean united_converging_cross_section = true 
            "true:A_cross_total = 2*A_cross_branch，否则 A_cross_total > 2*A_cross_branch" 
            annotation(Dialog(group = "T型管"));
          Boolean velocity_reference_branches = true 
            "true:相对于速度的各通道压力损失系数，否则相对于总速度" 
            annotation(Dialog(group = "T型管"));

          Integer alpha = 90 "分支角度" annotation(Dialog(group = "T型管"));

          SI.Diameter d_hyd[3] = ones(3) * 0.1 
            "通道的水力直径 [侧面，直通，整体]" 
            annotation(Dialog(group = "T型管"));

          //限制条件
          SI.MassFlowRate m_flow_min = 1e-3 
            "用于平滑反向流体流动的限制条件" 
            annotation(Dialog(group = "限制条件"));
          SI.Velocity v_max = 2e2 "最大流体流速的限制条件" 
            annotation(Dialog(group = "限制条件"));
          Real zeta_TOT_max = 1e3 
            "压力损失系数最大值的限制条件" 
            annotation(Dialog(group = "限制条件"));
          annotation();
        end Tjunction;

        record Diffuser "扩散器输入"
          extends Modelica.Icons.Record;

          SI.Angle alpha = PI * 45 / 180 "扩散角度" 
            annotation(Dialog(group = "扩散器"));

          SI.Area A_1 = PI * 0.01 ^ 2 / 4 
            "扩散器段前的小恒定横截面积" 
            annotation(Dialog(group = "扩散器"));
          SI.Area A_2 = 2 * A_1 
            "扩散器段后的大恒定横截面积" 
            annotation(Dialog(group = "扩散器"));
          SI.Length C_1 = PI * 0.01 "扩散器段前的小周长" 
            annotation(Dialog(group = "扩散器"));
          SI.Length C_2 = 2 * C_1 "扩散器段后的大周长" 
            annotation(Dialog(group = "扩散器"));
          SI.Length L_1 = 0.1 "扩散器段前的直管长度" 
            annotation(Dialog(group = "扩散器"));
          SI.Length L_2 = L_1 "扩散器段后的直管长度" 
            annotation(Dialog(group = "扩散器"));
          SI.Length L_d = L_1 
            "扩散器段长度（与整体流体流动平行）" 
            annotation(Dialog(group = "扩散器"));

          //数值方面
          SI.Pressure dp_small = 1 
            "小于 dp_small 的压力损失的线性化" 
            annotation(Dialog(group = "数值方面"));
          Real zeta_TOT_min = 1e-3 
            "无限雷诺数的最小压力损失系数" 
            annotation(Dialog(group = "数值方面"));
          Real zeta_TOT_max = 1e8 
            "雷诺数趋近于零时的最大压力损失系数" 
            annotation(Dialog(group = "数值方面"));
          annotation();
        end Diffuser;

        record EdgedBend "弯管输入"
          extends Modelica.Icons.Record;

          SI.Diameter d_hyd(min = Modelica.Constants.eps) = 0.1 
            "水力直径" 
            annotation(Dialog(group = "弯管"));
          SI.Angle delta = 90 * PI / 180 "转向角度" annotation(Dialog(group = "弯管"));
          SI.Length K = 0 
            "粗糙度（表面凹凸的绝对平均高度）" annotation(Dialog(group = "弯管"));
          annotation();

        end EdgedBend;

        record SuddenChange "直径突变输入"

          extends Modelica.Icons.Record;

          SI.Area A_1 = PI * 0.01 ^ 2 / 4 "节流孔的小横截面积" 
            annotation(Dialog(group = "节流孔"));
          SI.Area A_2 = A_1 "节流孔的大横截面积" 
            annotation(Dialog(group = "节流孔"));
          SI.Length C_1 = PI * 0.01 "节流孔的小周长" 
            annotation(Dialog(group = "节流孔"));
          SI.Length C_2 = C_1 "节流孔的大周长" 
            annotation(Dialog(group = "节流孔"));
          annotation();
        end SuddenChange;
        annotation();
      end PressureLoss;
      annotation();
    end Records;

    package Types "类型库"
      extends Modelica.Icons.TypesPackage;
      type DarcyFrictionFactor = Modelica.Icons.TypeReal(
        final quantity = 
        "Darcy 摩擦系数 | lambda_fri = zeta_fri / (length/diameter)", 
        final unit = "1", 
        min = 0, 
        max = 1111) annotation();
      type FrictionalResistanceCoefficient = Modelica.Icons.TypeReal(
        final quantity = "摩擦阻力系数 | zeta_fri", 
        final unit = "1", 
        min = 0, 
        max = 1111) annotation();
      type LocalResistanceCoefficient = Modelica.Icons.TypeReal(
        final quantity = "局部阻力系数 | zeta_loc", 
        final unit = "1", 
        min = 0, 
        max = 1111) annotation();
      type PressureLossCoefficient = Modelica.Icons.TypeReal(
        final quantity = "压力损失系数 | zeta_tot = zeta_loc + zeta_fri", 
        final unit = "1", 
        min = 0, 
        max = 1111) annotation();
      type TwoPhaseFrictionalPressureLoss = enumeration(
        Friedel "Friedel 关于摩擦压力损失的相关性", 
        Chisholm "Chisholm 关于摩擦压力损失的相关性") annotation();
      type Roughness = enumeration(
        Neglected "忽略表面粗糙度", 
        Considered "考虑表面粗糙度") annotation();
      type TwoPhaseHeatTransferTarget = enumeration(
        BoilHor "水平沸腾", 
        BoilVer "垂直沸腾", 
        CondHor "水平冷凝") annotation();
      type PressureLossTarget = enumeration(
        PressureLoss "从质量流速计算压力损失", 
        MassFlowRate "从压力损失计算质量流速") annotation();
      type GeometryOfInternalFlow = enumeration(
        Annular "环形几何", 
        Circular "圆形几何", 
        Elliptical "椭圆形几何", 
        Rectangular "矩形几何", 
        Isosceles "等腰三角形几何") annotation();
      type kc_evenGap = enumeration(
        DevOne 
        "在一个侧面处于流动发展的层流区域，同时在一侧传热", 
        DevBoth 
        "在两侧都处于流动发展的层流区域，同时在两侧传热", 
        UndevOne 
        "处于流动和传热起始的层流区域，在一侧传热", 
        UndevBoth 
        "处于流动和传热起始的层流区域，在两侧传热") annotation();

      type kc_general = enumeration(
        Rough "对 Dittus/Boelter (1930) 最粗糙的近似", 
        Middle "对 Sieder/Tate (1936) 中等的近似", 
        Finest "对 Gnielinski (1976) 最精确的近似") annotation();
      type HeatTransferBoundary = enumeration(
        UWTuDFF "在发展流体流动中的均匀壁温度（UWT+DFF）", 
        UHFuDFF "在发展流体流动中的均匀热流密度（UHF+DFF）", 
        UWTuUFF 
        "在未发展流体流动中的均匀壁温度（UWT+UFF）", 
        UHFuUFF "在未发展流体流动中的均匀热流密度（UHF+UFF）") annotation();

      type MassOrVolumeFlowRate = enumeration(
        MassFlowRate "质量流量", 
        VolumeFlowRate "体积流量") annotation();
      type VoidFractionApproach = enumeration(
        Homogeneous "均相方法", 
        Momentum "动量流方法（非均匀）", 
        Energy "基于 Zivi 的动能流方法（非均匀）", 
        Chisholm 
        "基于 Chisholm 的经验动量流方法（非均匀）") annotation();

      type OrificeGeometry = enumeration(
        SharpEdged "节流孔入口的锐缘形状", 
        ThickEdged "节流孔入口的厚边缘形状", 
        TiltedEdged "节流孔入口的倾斜边缘形状", 
        RoundedEdged "节流孔入口的圆角边缘形状") annotation();
      type ValveGeometry = enumeration(
        Ball "球阀", 
        Diaphragm "隔膜阀", 
        Butterfly "蝶阀", 
        Gate "闸阀", 
        Sluice "水门阀") annotation();
      type ValveCoefficient = enumeration(
        AV "Av（公制）流量系数", 
        KV "Kv（公制）流量系数", 
        CV "Cv（US）流量系数", 
        OP "由操作点定义的 Av") annotation();
      type FluidFlowRegime = enumeration(
        Laminar "层流流体流动区域", 
        Overall "总体流体流动区域", 
        Turbulent "湍流流体流动区域") annotation();
      type HTXGeometry_flatTubes = enumeration(
        LouverFin "隔条鳍片", 
        RectangularFin "矩形偏移条鳍片") annotation();
      type HTXGeometry_roundTubes = enumeration(
        PlainFin "平鳍片", 
        LouverFin "散热鳍片", 
        SlitFin "开缝鳍片", 
        WavyFin "波浪鳍片（人字形波浪鳍片）") annotation();

      type MolarMass_gpmol = Real(final quantity = "摩尔质量", final unit = "g/mol") annotation();
      annotation();
    end Types;
    annotation();
  end Utilities;
annotation (Documentation(info="<html><h4>库描述</h4><p>
 &nbsp; &nbsp; &nbsp;该库包含用基于Modelica&reg;语言编写的<strong>对流换热</strong>与<strong>压降特性关联</strong>函数。压降计算通常基于不可压缩流体和总压差原理。 对于横截面积恒定的装置，计算所得总压降等于静压差。全库均未考虑流体重力引起的压降，所提供的函数可独立使用。
</p>
<p>
 &nbsp; &nbsp; &nbsp;该库是 XRG Simulation GmbH 的非商业产品。
</p>
<h4>致谢</h4><p>
 &nbsp; &nbsp; &nbsp;以下人员为 Fluid.Dissipation 库做出了贡献（按字母顺序排列）： Jörg Eiden、Ole Engel、Nina Peci、Sven Rutkowski、Thorben Vahlenkamp、Stefan Wischhusen。
</p>
<p>
 &nbsp; &nbsp; &nbsp;Fluid.Dissipation 库的开发由德国联邦教育与研究部（资助编号： 01IS07022B）在 ITEA 研究项目 EuroSysLib-D 框架下资助完成的。 该项目于 2007 年 10 月启动，并于2010 年 6 月结束。
</p>
<p>
 &nbsp; &nbsp; &nbsp;版权<span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">© </span> 2007-2020，Modelica 协会及贡献者
</p>
<h4>联系地址<br><br>XRG Simulation GmbH<br><br>Harburger Schlossstraße 6-12<br><br>21079 Hamburg<br><br>Germany<br><a href=\"mailto:info@xrg-simulation.de\" target=\"\">info@xrg-simulation.de</a>&nbsp; &nbsp;</h4></html>"));

end Dissipation;