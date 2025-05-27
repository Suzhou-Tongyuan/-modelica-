within Modelica.Mechanics.Rotational.Interfaces;
model InternalSupport 
    "适配器模型，用于利用有条件的支撑连接器"
  input SI.Torque tau 
    "外部支撑力矩（必须通过在使用InternalSupport模型的模型中进行力矩平衡计算而得出；= flange.tau)";
  SI.Angle phi "外部支撑角度（= flange.phi）";
  Flange_a flange 
    "内部支撑一维转动接口（必须连接到条件支撑连接器以使用useSupport=true，连接到条件固定模型以使用useSupport=false）" 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  flange.tau = tau;
  flange.phi = phi;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Ellipse(
              extent={{-20,20},{20,-20}}, 
              lineColor={135,135,135}, 
              fillColor={175,175,175}, 
              fillPattern=FillPattern.Solid),Text(
              extent={{-200,80},{200,40}}, 
              textColor={0,0,255}, 
              textString="%name")}), Documentation(info="<html>
<p>
这是一个适配器模型，用于在组件中利用一个条件
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Support\">support connector</a>。
它可以应用于文本定义的组件和图形定义的组件：
</p>

<ul>
<li> 如果<em>useSupport = true</em>，则此一维转动接口必须连接到条件支撑连接器。</li>
<li> 如果<em>useSupport = false</em>，则此一维转动接口必须连接到条件固定模型。</li>
</ul>

<p>
变量<strong>tau</strong>被定义为<strong>input</strong>。在文本定义的组件中使用此模型时，必须作为修饰符提供并通过力矩平衡计算而得。
这种内部支撑的方法通常通过以下部分模型来利用：
</p>

<ul>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialOneFlangeAndSupport\">PartialOneFlangeAndSupport</a>,</li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport\">PartialTwoFlangesAndSupport</a>,</li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational\">PartialElementaryRotationalToTranslational</a>。</li>
</ul>

<p>
注意，支撑角度始终可以作为internalSupport.phi访问，支撑力矩始终可以作为internalSupport.tau访问。
</p>
</html>"));
end InternalSupport;