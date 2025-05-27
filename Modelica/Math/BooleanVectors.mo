within Modelica.Math;
package BooleanVectors "布尔向量运算函数库"
 extends Modelica.Icons.Package;
function allTrue 
    "如果布尔输入向量的所有元素都为真('与')，则返回true"
  extends Modelica.Icons.Function;
  input Boolean b[:] "布尔向量";
  output Boolean result "= true，如果b的所有元素都为真";
algorithm
  result := size(b,1) > 0;
  for i in 1:size(b,1) loop
     result := result and b[i];
  end for;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
<strong>allTrue</strong>(b);
</pre></blockquote>

<h4>描述</h4>
<p>
如果输入布尔向量b的所有元素都为<strong>true</strong>，则返回<strong>true</strong>。
否则，函数返回<strong>false</strong>。如果b是空向量，
即size(b,1)=0，函数返回<strong>false</strong>(与此不同的是，<a href=\"modelica://Modelica.Math.BooleanVectors. andTrue\">andTrue</a>返回<strong>true</strong>).
</p>

<h4>示例</h4>
<blockquote><pre>
  Boolean b1[3] = {true, true, true};
  Boolean b2[3] = {false, true, false};
  Boolean r1, r2;
<strong>algorithm</strong>
  r1 = allTrue(b1);  // r1 = true
  r2 = allTrue(b2);  // r2 = false
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>

</html>"));
end allTrue;

function andTrue 
    "如果布尔输入向量的所有元素都为真('与')，则返回true"
  extends Modelica.Icons.Function;
  input Boolean b[:] "布尔向量";
  output Boolean result "= true，如果b的所有元素都为真";
algorithm
  result := true;
  for i in 1:size(b,1) loop
     result := result and b[i];
  end for;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
<strong>andTrue</strong>(b);
</pre></blockquote>

<h4>描述</h4>
<p>
如果输入布尔向量b的所有元素都为<strong>true</strong>，则返回<strong>true</strong>。
否则，函数返回<strong>false</strong>。如果b是空向量，
即size(b,1)=0，函数返回<strong>true</strong>(与此不同的是，<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>返回<strong>false</strong>)。
</p>

<h4>示例</h4>
<blockquote><pre>
  Boolean b1[3] = {true, true, true};
  Boolean b2[3] = {false, true, false};
  Boolean r1, r2;
<strong>algorithm</strong>
  r1 = andTrue(b1);  // r1 = true
  r2 = andTrue(b2);  // r2 = false
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>

</html>"));
end andTrue;

function anyTrue 
    "如果布尔输入向量中至少有一个元素为真('或')，则返回true"

  extends Modelica.Icons.Function;
  input Boolean b[:] "布尔向量";
  output Boolean result "= true，如果b中至少有一个元素为真";
algorithm
  result := false;
  for i in 1:size(b,1) loop
     result := result or b[i];
  end for;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
<strong>anyTrue</strong>(b);
</pre></blockquote>

<h4>描述</h4>
<p>
如果输入布尔向量b中至少有一个元素为<strong>true</strong>，则返回<strong>true</strong>。
否则，函数返回<strong>false</strong>。如果b是空向量，
即size(b,1)=0，函数返回<strong>false</strong>。
</p>

<h4>示例</h4>
<blockquote><pre>
  Boolean b1[3] = {false, false, false};
  Boolean b2[3] = {false, true, false};
  Boolean r1, r2;
<strong>algorithm</strong>
  r1 = anyTrue(b1);  // r1 = false
  r2 = anyTrue(b2);  // r2 = true
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end anyTrue;

function countTrue "返回布尔向量中为真的元素个数"

  extends Modelica.Icons.Function;
  input Boolean b[:] "布尔向量";
  output Integer n "b中真元素的个数";
algorithm
  n := sum(if b[i] then 1 else 0 for i in 1:size(b, 1));

    annotation (Inline=true,Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
<strong>countTrue</strong>(b);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数返回布尔向量b中<strong>真</strong>元素的个数。
</p>

<h4>示例</h4>
<p><code>countTrue({false, true, false, true})</code> returns 2.</p>

<h4>另外</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end countTrue;

function enumerate 
    "枚举布尔向量中的真元素(0表示假元素)"
  extends Modelica.Icons.Function;

  input Boolean b[:] "布尔向量";
  output Integer enumerated[size(b, 1)] 
      "b中真元素的索引(递增顺序；0表示假元素)";

  protected
  Integer count;

algorithm
    count := 1;
    for i in 1:size(b, 1) loop
      if b[i] then
        enumerated[i] := count;
        count := count + 1;
      else
        enumerated[i] := 0;
      end if;
    end for;

    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
<strong>enumerate</strong>(b);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数返回一个整数向量，按顺序编号布尔向量 b 中为<strong>真</strong>的元素。<strong>假</strong>元素用 0 表示。
</p>

<h4>示例</h4>
<p><code>enumerate({false, true, false, true})</code> returns <code>{0,1,0,2}</code>.</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end enumerate;

function firstTrueIndex 
    "返回布尔向量的第一个真元素的索引"
  extends Modelica.Icons.Function;
  input Boolean b[:] "布尔向量";
  output Integer index "b的第一个真元素的索引";
algorithm
   index :=0;
   for i in 1:size(b,1) loop
      if b[i] then
         index :=i;
         return;
      end if;
   end for;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
<strong>firstTrueIndex</strong>(b);
</pre></blockquote>

<h4>描述</h4>
<p>
返回布尔向量b的第一个<strong>真</strong>元素的索引。
如果没有元素为<strong>真</strong>或者b是空向量(即size(b,1)=0)，则函数返回0。
</p>

<h4>示例</h4>
<blockquote><pre>
  Boolean b1[3] = {false, false, false};
  Boolean b2[3] = {false, true, false};
  Boolean b3[4] = {false, true, false, true};
  Integer r1, r2, r3;
<strong>algorithm</strong>
  r1 = firstTrueIndex(b1);  // r1 = 0
  r2 = firstTrueIndex(b2);  // r2 = 2
  r3 = firstTrueIndex(b3);  // r3 = 2
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end firstTrueIndex;

function index "返回布尔向量中真元素的下标"
  extends Modelica.Icons.Function;

  input Boolean b[:] "布尔向量";
  output Integer indices[countTrue(b)] "b的真元素的下标";

  protected
  Integer count;
  constant Integer ndic = countTrue(b);
algorithm
    if ndic > 0 then
      count := 1;
      for i in 1:size(b, 1) loop
        if b[i] then
          indices[count] := i;
          count := count + 1;
        end if;
      end for;
    end if;

    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
<strong>index</strong>(b);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数返回一个整数向量，其中包含布尔向量 b 中为<strong>真</strong>元素的索引。
整数向量中的元素个数等于 b 中为<strong>真</strong>元素的数量。
</p>

<h4>示例</h4>
<p>
<code>index({false, true, false, true})</code> returns <code>{2,4}</code>.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.oneTrue\">oneTrue</a>.
</p>
</html>"));
end index;

function oneTrue 
    "如果布尔输入向量中只有一个元素为真(\"xor\")，则返回true"
  extends Modelica.Icons.Function;

  input Boolean b[:] "布尔向量";
  output Boolean result "= true，如果b中只有一个元素为真";

algorithm
  result := countTrue(b) == 1;

  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
<strong>oneTrue</strong>(b);
</pre></blockquote>

<h4>描述</h4>
<p>
如果输入布尔向量b中只有一个元素为<strong>true</strong>，则返回<strong>true</strong>。
否则，函数返回<strong>false</strong>。如果b是空向量，
即size(b,1)=0，函数返回<strong>false</strong>。
</p>

<h4>示例</h4>
<blockquote><pre>
  Boolean b1[3] = {false, false, false};
  Boolean b2[3] = {false, true, false};
  Boolean b3[3] = {false, true, true};
  Boolean r1, r2, r3;
<strong>algorithm</strong>
  r1 = oneTrue(b1);  // r1 = false
  r2 = oneTrue(b2);  // r2 = true
  r3 = oneTrue(b3);  // r3 = false
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.BooleanVectors.allTrue\">allTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.andTrue\">andTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.anyTrue\">anyTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.countTrue\">countTrue</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.enumerate\">enumerate</a>,
<a href=\"modelica://Modelica.Math.BooleanVectors.firstTrueIndex\">firstTrueIndex</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors.index\">index</a>.
</p>
</html>"));
end oneTrue;
  annotation (Documentation(info="<html>
<p>
这个库提供了对向量进行操作的函数，这些函数的输入参数是布尔向量。
</p>
</html>"), Icon(graphics={Rectangle(
          extent={{-16,62},{14,14}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-16,-18},{14,-66}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid)}));
end BooleanVectors;