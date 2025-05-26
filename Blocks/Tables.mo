within Modelica.Blocks;
package Tables 
  "Library of blocks to interpolate in one and two-dimensional tables"
  extends Modelica.Icons.Package;
  block CombiTable1Ds 
    "Table look-up in one dimension (matrix/file) with one input and n outputs"
    extends Modelica.Blocks.Interfaces.SIMO(final nout = size(columns, 1));
    parameter Boolean tableOnFile = false 
      "= true, if table is defined on file or in function usertab" 
      annotation(Dialog(group = "Table data definition"));
    parameter Real table[:,:] = fill(0.0, 0, 2) 
      "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])" 
      annotation(Dialog(group = "Table data definition", enable = not tableOnFile));
    parameter String tableName = "NoName" 
      "Table name on file or in function usertab (see docu)" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter String fileName = "NoName" "File where matrix is stored" 
      annotation(Dialog(
      group = "Table data definition", 
      enable = tableOnFile, 
      loadSelector(filter = "Text files (*.txt);;MATLAB MAT-files (*.mat);;csv files (*.csv)", 
      caption = "Open file in which table is present")));
    parameter Boolean verboseRead = true 
      "= true, if info message that file is loading is to be printed" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter Integer columns[:] = 2:size(table, 2) 
      "Columns of table to be interpolated" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments 
      "Smoothness of table interpolation" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints 
      "Extrapolation of data outside the definition range" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Boolean verboseExtrapolation = false 
      "= true, if warning messages are to be printed if table input is outside the definition range" 
      annotation(Dialog(group = "Table data interpretation", enable = extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter Real u_min = Internal.getTable1DAbscissaUmin(tableID) 
      "Minimum abscissa value defined in table";
    final parameter Real u_max = Internal.getTable1DAbscissaUmax(tableID) 
      "Maximum abscissa value defined in table";
  protected
    parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID = 
      Modelica.Blocks.Types.ExternalCombiTable1D(
      if tableOnFile then tableName else "NoName", 
      if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName", 
      table, 
      columns, 
      smoothness, 
      extrapolation, 
      if tableOnFile then verboseRead else false) "External table object";
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
      assert(noEvent(u >= u_min), "
Extrapolation warning: The value u (="     + String(u) + ") must be greater or equal
than the minimum abscissa value u_min (="     + String(u_min) + ") defined in the table.
"    , level = AssertionLevel.warning);
      assert(noEvent(u <= u_max), "
Extrapolation warning: The value u (="     + String(u) + ") must be less or equal
than the maximum abscissa value u_max (="     + String(u_max) + ") defined in the table.
"    , level = AssertionLevel.warning);
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:nout loop
        y[i] = Internal.getTable1DValueNoDer(tableID, i, u);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:nout loop
        y[i] = Internal.getTable1DValueNoDer2(tableID, i, u);
      end for;
    else
      for i in 1:nout loop
        y[i] = Internal.getTable1DValue(tableID, i, u);
      end for;
    end if;
    annotation(
      Documentation(info = "<html>
<p>
<strong>Univariate constant</strong>, <strong>linear</strong> or <strong>cubic Hermite
spline interpolation</strong> in <strong>one</strong> dimension of a
<strong>table</strong>.
Via parameter <strong>columns</strong> it can be defined how many columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output interpolates
via column 2 and the second output interpolates via column 4 of the
table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<blockquote><pre>
table = [0,  0;
         1,  1;
         2,  4;
         4, 16]
If, e.g., the input u = 1.0, the output y =  1.0,
    e.g., the input u = 1.5, the output y =  2.5,
    e.g., the input u = 2.0, the output y =  4.0,
    e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
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
<li>No second derivative is provided for linear interpolation.</li>
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
<li>If the table has only <strong>one row</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column) have to be strictly increasing.</li>
</ul>
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
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
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
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
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
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable1Ds.png\"
     alt=\"CombiTable1Ds.png\">
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
</html>"    ), 
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-60.0, 40.0}, {-60.0, -40.0}, {60.0, -40.0}, {60.0, 40.0}, {30.0, 40.0}, {30.0, -40.0}, {-30.0, -40.0}, {-30.0, 40.0}, {-60.0, 40.0}, {-60.0, 20.0}, {60.0, 20.0}, {60.0, 0.0}, {-60.0, 0.0}, {-60.0, -20.0}, {60.0, -20.0}, {60.0, -40.0}, {-60.0, -40.0}, {-60.0, 40.0}, {60.0, 40.0}, {60.0, -40.0}}), 
      Line(points = {{0.0, 40.0}, {0.0, -40.0}}), 
      Rectangle(fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-60.0, 20.0}, {-30.0, 40.0}}), 
      Rectangle(fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-60.0, 0.0}, {-30.0, 20.0}}), 
      Rectangle(fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-60.0, -20.0}, {-30.0, 0.0}}), 
      Rectangle(fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-60.0, -40.0}, {-30.0, -20.0}})}));
  end CombiTable1Ds;

  block CombiTable1Dv 
    "Table look-up in one dimension (matrix/file) with n inputs and n outputs"
    extends Modelica.Blocks.Interfaces.MIMOs(final n = size(columns, 1));
    parameter Boolean tableOnFile = false 
      "= true, if table is defined on file or in function usertab" 
      annotation(Dialog(group = "Table data definition"));
    parameter Real table[:,:] = fill(0.0, 0, 2) 
      "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])" 
      annotation(Dialog(group = "Table data definition", enable = not tableOnFile));
    parameter String tableName = "NoName" 
      "Table name on file or in function usertab (see docu)" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter String fileName = "NoName" "File where matrix is stored" 
      annotation(Dialog(
      group = "Table data definition", 
      enable = tableOnFile, 
      loadSelector(filter = "Text files (*.txt);;MATLAB MAT-files (*.mat);;csv files (*.csv)", 
      caption = "Open file in which table is present")));
    parameter Boolean verboseRead = true 
      "= true, if info message that file is loading is to be printed" 
      annotation(Dialog(group = "Table data definition", enable = tableOnFile));
    parameter Integer columns[:] = 2:size(table, 2) 
      "Columns of table to be interpolated" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments 
      "Smoothness of table interpolation" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints 
      "Extrapolation of data outside the definition range" 
      annotation(Dialog(group = "Table data interpretation"));
    parameter Boolean verboseExtrapolation = false 
      "= true, if warning messages are to be printed if table input is outside the definition range" 
      annotation(Dialog(group = "Table data interpretation", enable = extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
    final parameter Real u_min = Internal.getTable1DAbscissaUmin(tableID) 
      "Minimum abscissa value defined in table";
    final parameter Real u_max = Internal.getTable1DAbscissaUmax(tableID) 
      "Maximum abscissa value defined in table";
  protected
    parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID = 
      Modelica.Blocks.Types.ExternalCombiTable1D(
      if tableOnFile then tableName else "NoName", 
      if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName", 
      table, 
      columns, 
      smoothness, 
      extrapolation, 
      if tableOnFile then verboseRead else false) "External table object";
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
      for i in 1:n loop
        assert(noEvent(u[i] >= u_min), "
Extrapolation warning: The value u["     + String(i) + "] (=" + String(u[i]) + ") must be greater or equal
than the minimum abscissa value u_min (="     + String(u_min) + ") defined in the table.
"    , level = AssertionLevel.warning);
        assert(noEvent(u[i] <= u_max), "
Extrapolation warning: The value u["     + String(i) + "] (=" + String(u[i]) + ") must be less or equal
than the maximum abscissa value u_max (="     + String(u_max) + ") defined in the table.
"    , level = AssertionLevel.warning);
      end for;
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for i in 1:n loop
        y[i] = Internal.getTable1DValueNoDer(tableID, i, u[i]);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for i in 1:n loop
        y[i] = Internal.getTable1DValueNoDer2(tableID, i, u[i]);
      end for;
    else
      for i in 1:n loop
        y[i] = Internal.getTable1DValue(tableID, i, u[i]);
      end for;
    end if;
    annotation(
      Documentation(info = "<html>
<p>
<strong>Univariate constant</strong>, <strong>linear</strong> or <strong>cubic Hermite
spline interpolation</strong> in <strong>one</strong> dimension of a
<strong>table</strong>.
Via parameter <strong>columns</strong> it can be defined how many columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that 2 input
and 2 output signals are present and that the first output interpolates
the first input via column 2 and the second output interpolates the
second input via column 4 of the table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<blockquote><pre>
table = [0,  0;
         1,  1;
         2,  4;
         4, 16]
If, e.g., the input u = 1.0, the output y =  1.0,
    e.g., the input u = 1.5, the output y =  2.5,
    e.g., the input u = 2.0, the output y =  4.0,
    e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
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
<li>No second derivative is provided for linear interpolation.</li>
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
<li>If the table has only <strong>one row</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column) have to be strictly increasing.</li>
</ul>
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
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
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
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
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
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable1Dv.png\"
     alt=\"CombiTable1Dv.png\">
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
</html>"    ), 
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-60.0, 40.0}, {-60.0, -40.0}, {60.0, -40.0}, {60.0, 40.0}, {30.0, 40.0}, {30.0, -40.0}, {-30.0, -40.0}, {-30.0, 40.0}, {-60.0, 40.0}, {-60.0, 20.0}, {60.0, 20.0}, {60.0, 0.0}, {-60.0, 0.0}, {-60.0, -20.0}, {60.0, -20.0}, {60.0, -40.0}, {-60.0, -40.0}, {-60.0, 40.0}, {60.0, 40.0}, {60.0, -40.0}}), 
      Line(points = {{0.0, 40.0}, {0.0, -40.0}}), 
      Rectangle(fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-60.0, 20.0}, {-30.0, 40.0}}), 
      Rectangle(fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-60.0, 0.0}, {-30.0, 20.0}}), 
      Rectangle(fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-60.0, -20.0}, {-30.0, 0.0}}), 
      Rectangle(fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-60.0, -40.0}, {-30.0, -20.0}})}));
  end CombiTable1Dv;

  block CombiTable2Ds "Table look-up in two dimensions (matrix/file)"
    extends Modelica.Blocks.Interfaces.SI2SO;
    extends Internal.CombiTable2DBase;
  equation
    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      assert(noEvent(u1 >= u_min[1]), "
Extrapolation warning: The value u1 (="     + String(u1) + ") must be greater or equal
than the minimum abscissa value u_min[1] (="     + String(u_min[1]) + ") defined in the table.
"    , level = AssertionLevel.warning);
      assert(noEvent(u1 <= u_max[1]), "
Extrapolation warning: The value u1 (="     + String(u1) + ") must be less or equal
than the maximum abscissa value u_max[1] (="     + String(u_max[1]) + ") defined in the table.
"    , level = AssertionLevel.warning);
      assert(noEvent(u2 >= u_min[2]), "
Extrapolation warning: The value u2 (="     + String(u2) + ") must be greater or equal
than the minimum abscissa value u_min[2] (="     + String(u_min[2]) + ") defined in the table.
"    , level = AssertionLevel.warning);
      assert(noEvent(u2 <= u_max[2]), "
Extrapolation warning: The value u2 (="     + String(u2) + ") must be less or equal
than the maximum abscissa value u_max[2] (="     + String(u_max[2]) + ") defined in the table.
"    , level = AssertionLevel.warning);
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      y = Internal.getTable2DValueNoDer(tableID, u1, u2);
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      y = Internal.getTable2DValueNoDer2(tableID, u1, u2);
    else
      y = Internal.getTable2DValue(tableID, u1, u2);
    end if;
    annotation(
      Documentation(info = "<html>
<p>
<strong>Bivariate constant</strong>, <strong>bilinear</strong> or <strong>bivariate
Akima interpolation</strong> of a <strong>two-dimensional table</strong>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li>the first column \"table[2:,1]\" contains the u1 grid points,</li>
<li>the first row \"table[1,2:]\" contains the u2 grid points,</li>
<li>the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
        |       |       |       |
        |  1.0  |  2.0  |  3.0  |  // u2
    ----*-------*-------*-------*
    1.0 |  1.0  |  3.0  |  5.0  |
    ----*-------*-------*-------*
    2.0 |  2.0  |  4.0  |  6.0  |
    ----*-------*-------*-------*
  // u1
is defined as
   table = [0.0,   1.0,   2.0,   3.0;
            1.0,   1.0,   3.0,   5.0;
            2.0,   2.0,   4.0,   6.0]
If, e.g., the input u1 is 1.0, input u2 is 1.0 and smoothness is LinearSegments, the output y is 1.0,
    e.g., the input u1 is 2.0, input u2 is 1.5 and smoothness is LinearSegments, the output y is 3.0.
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Bilinear interpolation
           = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Not supported
           = 5: Steffen interpolation: Not supported
           = 6: Modified Akima interpolation: Not supported
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last values of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
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
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
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
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0

double table2D_2(4,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0
3.0,3.0,5.0,7.0
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable2Ds.png\"
     alt=\"CombiTable2Ds.png\">
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
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"    ));
  end CombiTable2Ds;

  block CombiTable2Dv "Table look-up in two dimensions (matrix/file) with vector inputs and vector output of size n"
    extends Modelica.Blocks.Interfaces.MI2MO;
    extends Internal.CombiTable2DBase;
  equation
    if verboseExtrapolation and (
      extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or 
      extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint) then
      for j in 1:n loop
        assert(noEvent(u1[j] >= u_min[1]), "
Extrapolation warning: The value u1["     + String(j) + "] (=" + String(u1[j]) + ") must be greater or equal
than the minimum abscissa value u_min[1] (="     + String(u_min[1]) + ") defined in the table.
"    , level = AssertionLevel.warning);
        assert(noEvent(u1[j] <= u_max[1]), "
Extrapolation warning: The value u1["     + String(j) + "] (=" + String(u1[j]) + ") must be less or equal
than the maximum abscissa value u_max[1] (="     + String(u_max[1]) + ") defined in the table.
"    , level = AssertionLevel.warning);
        assert(noEvent(u2[j] >= u_min[2]), "
Extrapolation warning: The value u2["     + String(j) + "] (=" + String(u2[j]) + ") must be greater or equal
than the minimum abscissa value u_min[2] (="     + String(u_min[2]) + ") defined in the table.
"    , level = AssertionLevel.warning);
        assert(noEvent(u2[j] <= u_max[2]), "
Extrapolation warning: The value u2["     + String(j) + "] (=" + String(u2[j]) + ") must be less or equal
than the maximum abscissa value u_max[2] (="     + String(u_max[2]) + ") defined in the table.
"    , level = AssertionLevel.warning);
      end for;
    end if;

    if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValueNoDer(tableID, u1[j], u2[j]);
      end for;
    elseif smoothness == Modelica.Blocks.Types.Smoothness.LinearSegments then
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValueNoDer2(tableID, u1[j], u2[j]);
      end for;
    else
      for j in 1:n loop
        y[j] = Modelica.Blocks.Tables.Internal.getTable2DValue(tableID, u1[j], u2[j]);
      end for;
    end if;
    annotation(Documentation(info = "<html>
<p>
<strong>Bivariate constant</strong>, <strong>bilinear</strong> or <strong>bivariate
Akima interpolation</strong> of a <strong>two-dimensional table</strong>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li>the first column \"table[2:,1]\" contains the u1 grid points,</li>
<li>the first row \"table[1,2:]\" contains the u2 grid points,</li>
<li>the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<blockquote><pre>
        |       |       |       |
        |  1.0  |  2.0  |  3.0  |  // u2
    ----*-------*-------*-------*
    1.0 |  1.0  |  3.0  |  5.0  |
    ----*-------*-------*-------*
    2.0 |  2.0  |  4.0  |  6.0  |
    ----*-------*-------*-------*
  // u1
is defined as
   table = [0.0,   1.0,   2.0,   3.0;
            1.0,   1.0,   3.0,   5.0;
            2.0,   2.0,   4.0,   6.0]
If, e.g., the input u1 is {1.0}, input u2 is {1.0} and smoothness is LinearSegments, the output y is {1.0},
    e.g., the input u1 is {2.0}, input u2 is {1.5} and smoothness is LinearSegments, the output y is {3.0}.
</pre></blockquote>
<ul>
<li>The interpolation interval is found by a binary search where the interval used in the
    last call is used as start interval.</li>
<li>Via parameter <strong>smoothness</strong> it is defined how the data is interpolated:
<blockquote><pre>
smoothness = 1: Bilinear interpolation
           = 2: Bivariate Akima interpolation: Smooth interpolation by bicubic Hermite
                splines such that der(y) is continuous, also if extrapolated.
           = 3: Constant segments
           = 4: Fritsch-Butland interpolation: Not supported
           = 5: Steffen interpolation: Not supported
           = 6: Modified Akima interpolation: Not supported
</pre></blockquote></li>
<li>First and second <strong>derivatives</strong> are provided, with exception of the following two smoothness options.
<ol>
<li>No derivatives are provided for interpolation by constant segments.</li>
<li>No second derivative is provided for linear interpolation.</li>
</ol></li>
<li>Values <strong>outside</strong> of the table range, are computed by
    extrapolation according to the setting of parameter <strong>extrapolation</strong>:
<blockquote><pre>
extrapolation = 1: Hold the first or last values of the table,
                   if outside of the table scope.
              = 2: Extrapolate by using the derivative at the first/last table
                   points if outside of the table scope.
                   (If smoothness is LinearSegments or ConstantSegments
                   this means to extrapolate linearly through the first/last
                   two table points.).
              = 3: Periodically repeat the table data (periodical function).
              = 4: No extrapolation, i.e. extrapolation triggers an error
</pre></blockquote></li>
<li>If the table has only <strong>one element</strong>, the table value is returned,
    independent of the value of the input signal.</li>
<li>The grid values (first column and first row) have to be strictly
    increasing.</li>
</ul>
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
    preferred as otherwise the table is reallocated and transposed.
    See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
    documentation for more details.</li>
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
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre></blockquote>
<p>
If tables are read from a csv file, the file needs to have the
following structure to be opened using text editor (\"-----\" is not part of the file content):
</p>
<blockquote><pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0

double table2D_2(4,4)   # comment line
0.0,1.0,2.0,3.0  # u[2] grid points
1.0,1.0,3.0,5.0
2.0,2.0,4.0,6.0
3.0,3.0,5.0,7.0
-----------------------------------------------------
</pre></blockquote>
<p>
This csv file is opened with Excel, and the data format is displayed as shown in the following image:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTable2Dv.png\"
     alt=\"CombiTable2Dv.png\">
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
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"    ));
  end CombiTable2Dv;
  package NTables"Library of blocks to interpolate in N-dimensional tables"
    annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  grid={2,2}),graphics = {Rectangle(origin={0,0}, 
  lineColor={200,200,200}, 
  fillColor={248,248,248}, 
  fillPattern=FillPattern.HorizontalCylinder, 
  extent={{-100,-100},{100,100}}, 
  radius=25), Rectangle(origin={0,0}, 
  lineColor={128,128,128}, 
  extent={{-100,-100},{100,100}}, 
  radius=25), Rectangle(origin={2,-51}, 
  lineColor={95,95,95}, 
  fillColor={235,235,235}, 
  fillPattern=FillPattern.Solid, 
  extent={{-78,25},{78,-25}}), Rectangle(origin={2,-1}, 
  lineColor={95,95,95}, 
  fillColor={235,235,235}, 
  fillPattern=FillPattern.Solid, 
  extent={{-78,25},{78,-25}}), Rectangle(origin={2,49}, 
  lineColor={95,95,95}, 
  fillColor={235,235,235}, 
  fillPattern=FillPattern.Solid, 
  extent={{-78,25},{78,-25}}), Line(origin={-28,-1}, 
  points={{0,75},{0,-75}}, 
  color={95,95,95}), Line(origin={24,-1}, 
  points={{0,75},{0,-75}}, 
  color={95,95,95})}));
    model LookupTable1D "One-dimensional linear interpolation table"
      parameter Tables.Types.InterpolationMethod interpMethod =Tables.Types.InterpolationMethod.Linear 
        "Interpolation method";
      parameter Tables.Types.ExtrapolationMethod extrapMethod =Tables.Types.ExtrapolationMethod.Linear 
        "Extrapolation method";

      parameter Boolean tableDataOnFile = false "= true, if table is defined on file" 
        annotation (Dialog(group = "Table data Switch"));
      parameter Boolean breakPointsOnFile = false "= true, if breakPoints is defined on file" 
        annotation (Dialog(group = "Table data Switch"));

      parameter Real breakPoints1[:] = {0} "breakpoints 1, specified as a vector with strictly monotonically increasing values." 
        annotation (Dialog(group = "Table data definition", enable = not breakPointsOnFile));

      parameter Real tableData[:] = {0} "tabledata, specifies as an associated set of output values" 
        annotation (Dialog(group = "Table data definition", enable = not tableDataOnFile));
      parameter String filePath = "none" "file path where data is stored" 
        annotation (Dialog(group = "Table data definition", enable = (tableDataOnFile or breakPointsOnFile), 
          loadSelector(filter = "Text files (*.csv)", caption = "Open file in which table is present")));
      parameter Integer bp_cols[:] = {-1} "columns of the data to be interpolated in the table" 
        annotation (Dialog(group = "Table data definition", enable = breakPointsOnFile));
      parameter Integer tableData_col = -1 "columns of the data to be interpolated in the table" 
        annotation (Dialog(group = "Table data definition", enable = tableDataOnFile));

      Modelica.Blocks.Interfaces.RealInput u 
        annotation (Placement(transformation(origin={-120.116,-0.405796}, 
    extent={{-20,-20},{20,20}})));
      Modelica.Blocks.Interfaces.RealOutput y 
        annotation (Placement(transformation(origin={110.377,2.02899e-7}, 
    extent={{-10,-10},{10,10}})));

    protected
      Integer bp_sizes[:] = {size(breakPoints1, 1)} "columns of the data to be interpolated in the table";
      Tables.Types.External1DTable externalTable =Tables.Types.External1DTable(filePath, tableData_col, bp_cols, breakPoints1, bp_sizes, tableData);

    equation
      y = Tables.Types.evaluate(
        externalTable, 
        {u}, 
        interpMethod, 
        extrapMethod);

      annotation (Documentation(info="<html><p>
Performs an n-dimensional interpolation table lookup where n=1. The table is a sampled representation of N variables among the function. The breakpoint sets associates input values with positions in the table.
</p>
<p>
The 1-D Lookup Table, 2-D Lookup Table and n-D Lookup Table compute the n-variable sampling representation of a function:
</p>
<p>
<span data-w-e-type=\"formula\" data-w-e-is-void data-w-e-is-inline data-value=\"y=F(x_1,x_2,x_3,...,x_N)\"></span><br>Where function F is an empirical function.
</p>
<p>
The module maps the input to the output value by finding or inserting a table of values that you defined using the module parameters. The Homogeneous (constant), Linear (linear point-slope), Nearest, Akima spline, Fritsch-Butland spline, &nbsp;Steffen spline interpolation methods and the Homogeneous (constant), Linear (linear point-slope) extrapolation methods are supported.
</p>
<p>
In the following table, the first column identifies breakPoints 1, and the second column identifies the tableData.
</p>
<p>
For example, when the breakPoints1 is {-1,0,1.2},and the corresponding value is {1, 2, 3},you can set the tableData to be {1, 2, 3} directly.
</p>
<p>
<img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWgAAAD3CAYAAAAwos73AAAelUlEQVR4Ae3dz48k5XnA8fLN8WEP4QQSrIUjBQT+0S05FpK1a0VIgUgoWttq7AaZNYd4kXa5gCI1Pwaym8OAgI19QFFLpiX7sAzalTEWJIP2Mo7kQy7hYs0BCfWfEC5cjPRGT808NW+/U291dddbM09Vfw89NV1d9dZbb73vp55+663qzLkvnbzm88/yqb5nelAulEO3yoF63K3jRfsqP15ajzP5R15ZlvGiDKgD1AHqgJE6kLusZzAB+qP9z3lRBp2uA1KPP5j/Jy/KoNN1QOqx2JwBNCelPp2YAZqTUx9O0ABNpNzpSDl2UgFogAZocOslbjH0ujQfoAEaoAEaoI3WAYAGaIA22ji7FOmR13b6/gEaoAEaoImgjdYBgAZogDbaOIlK24lKu1SuAA3QAA3QRNBG6wBAAzRAG22cXYr0yGs70T5AAzRAAzQRtNE6ANAADdBGGydRaTtRaZfKFaABGqABmgjaaB0AaIAGaKONs0uRHnltJ9oHaIAGaIAmgjZaBwAaoAHaaOMkKm0nKu1SuQI0QAM0QBNBG60DAA3QAG20cXYp0iOv7UT7AA3QAA3QRNBG6wBAAzRAG22cRKXtRKVdKleABmiABmgiaKN1AKABGqCNNs4uRXrktZ1oH6ABGqAjQN+YPFj6k+1fy77rBoOL7qnpn931/S86EX2+v/+Jmwwylw2ur5TnvenjpWUgcGSDc+4Hkw9WSq8O5OvmtU7abS0jeX579EBeVndOPk1WJ04D6Fvzd9yrwyx+3OXYl72Gz7rX57fX/vXpYrtrpNNk3RiAN7fuKd/Pw33/2+H97vtb2+7Xe5xEYmWo86W+JP9VbwFaMBaErk5vFq/nR2N3dvCVg4M3uOSe2f9LsgbZJiBNgP7ryX8V+y9lsT15wj0m4GdZXkY/3E1XBl0D+vbujaIspDy6DrQ0qp3ZS+6V2dWF1wuzX7jzgtPwgvvxbHvhM1n232a/Xhtn2WYTZJusq4iEUwX6r7auH9vXn239o3tieG8B+F3jK+75vfVPTuG2+/a+VaBj+BQR9ujj3gP90PTL0n38cPeaO5dl7o7sqU6cqFKfAKfTJ/P9zwaX3IXpW/n/fQC6DIh359fccznQzSLlsrRlXhNkm6wby48CPZz9MXrike2+tvVwfuL6anafe3QvvmxsO5sw/1SA1kivCzhpXtft4ogBLeDpiSolTKkhlfR29m+5y1nmqvZlle3qft8/+n3ezaMnq5TlIBXbSgMG6HhXxkd7T+dIn8kecRfn6ZDWMq86SVipH1X5OBWgpTG/MepG9Ngm0ArfqvivgmGKZRXQVED/bjJyw+lRf7OmD9BxyKoacZMouMm6sTzViaD9dXX5M1vvJTupKvwAXXKhUPugY10cit6mR9BdAVoveKYCOjxpAPR6MCtyTZBtsq5uP5wquHVx1Gg3W+MiZ7htff+n2fm8n7tuHnQ9a9NTiaC1wYcRk8KdHfZNF/2U0n8X9FfLsvJ5cdHx8KLbvaM33Yu78REiv5lec48Pvn3Q/3l4VVkuaOrX7RCPIk+RURyKi/Sl+hc9dR+rUFsGtOZVDlLxqhgBEstrMd8rV7/cJO2yctN9KLa9kI/FUS1SDlKu/rI6Yics0/C9lmFYH8LlVnkv+bDS2FYF6Lezn+cX0vILi4dlLv20Z8fbpaM9QmRv7728cCFO1o1djAvXDctMPn9n9rD7+vDw4n6Wuar0ZP1VgZZ1fjU+SLesL3qV8lCY/XpY/F9yAlgl7bBsTuK95L21URxhBP3fu/+Tj2KQi2NlX+sLSAbXc3wFzocmb+WjIF6b/m9xsU1g05EQgsBPpgejRS6PvpPDK+uF25bGXYAzOFek++J028l6UhBlEb2fp3BooMJSti+6rSqgdZkQpmKbeTldKkbD/Pvk6hGCwQlB9q9YLziZ+POfHh1gLyBLucn+K6zh/svxkpEnr04Gefn4I1L846H7ocMHZR3Jqx6jqjKQfGs5huWwCsjhsnI8T6IB1dnGKkAXwAwH7ntbV/JREDIK5NnxN/JjUNZX6yMrmArsArKMGPHXLbsY568bDvWTfP/ocNjgt4aPFiNQJC+yjbL0pDzWATq2zqrlsbf3H3mZXdv6m7y8/JEk4WiZVdOuc6xTL9Ma0JJw2Uvw9Psf/YZ1BMk5d//g70qRleWl/1rSLktHhm7JBa0Qm6O0FyM/3b4iEyIRW09RKcNZ0tT0YjhpumUnk6r9k7Tlm0NethUQ+ycT3ZasU7Y9SVMv3IXfVJbti6Ydlresp59Jmn5+5DP/pWUZlr2/zKr/y76mbizrplcX6CosZdsKSthXW6w3/qn7+fDvS4etaZ9s2I1QrFsSXUpUK+X4zdnOsbKUKF1GppSdMGLYVpVf2b5V5a2qPPzPYl0cTdKu2o/Un0n5txZBh+OgZQywRmvSJRBGuUWDrhgTq425DBJtxMtw1OX8aay7ociTh2GRB2+en5b8X5UH6brQ6DJEqUg76NIJ01dQ/RNAWV5lvWJ+RbnG9n/ZvhRpV5RFmPfwve5zWBbhcqu87yLQyxp3DPoCGwlaKoa2lcFZrBsAXYA+/uUxnDWfimq4zbLt6DqxqaYVnnxiy8v8WHnIZ5pemLeq9PzPqtL2l2v7/1aBDgHWBqY3KITRnDb2cL6uJ9MymPzP5f8CmyXI+evptsOIOJyvmITL+WnJ/wq0FHDpa3Apv6MyXG/ZBVZdXvPhoxbmVZfV+WVRbp1ldF/8k4GuJ1OJ+KuOmb9s2f9l+1K23Crz+gh0DFOdXxbN+oCUoavrhpF1HWQLxALE66zr50v+X2edWN4lvaZAV6Ud5r3N96cCtDQ0bZQ+dHUgqYOBpuOnrY1b+8GlC6UczsUuED+tt3Zfy/u4q6DT7Shqfr+t3lX5m93/W/iKr+vIVPavTvplJyE/r36Xgs5flm5s27ovMaCLY3nYZ35lctNV7aO/v/K/ru+fbMJlVn3fZaClH1Vu4pBbokvraBDt1sWkDNTYulUX7RSk2LrrYFu1zqrlsQrQ66St+38S01MDugyNsnlhwxRESittWaQafO3W6FvWl4uLj4yOLjDKxbK82yFYR/MkEaJc3FTYl2GyDLVwv/R9DEn9XKcF0F5+Na/hiSk2X9PSaWzbdfZFTnzyTI38AvDhsZAyq/PMEYA+GmanUEkdlQtzj4yPLs7JBb/8ol1ToL31Y8hq/3OttualJ2jpPtTtXtA8lH0D0LRWKY+6QK+b9knArNuQ/W6tDzrWxeGD4H81VkiqIj1BRBu+RqSxqYw00EhSkQnx0rzotsPPi/le/62eJGIRpaSp26taRrftT2NI+svI/wXQXjdOkVcPbVk2Nj9MM7btVfdFtuf3s1ddL5A8APQB0Pq1POxu0MaqkIWfx+brejpdJ4KWhxqFzxYJ38voCH8EiMJXF+iyrhfJ87rl4a8by0OTtLU8T2J6akArGj7GZfNCROr20YbrKeyxk4ZuOwq0h54u659cwu2tipquX3f/ylDTfNXZB92eP00FdJhmVTnJsmX74qexzv9SsU+iAdXZRgFjEGmG6y7rVohBrPPLIlB/GwqhfyFO1w3RF2Rjw+j8NMv+XxVojdZDTNctD8mTAhymqfltkramcRLTUwNaG6WPiQLjox02Tl2vqotBosunBj9dGCUSw0fT13T9/MhnmqdwvkawsbyuC3SRDy8y1jz607ITTiyvsfl+evJ/rIzW3RdJs84JR/e56piGeV32vqtAVyGrwIaYFsi2MIrDxzwESU48MqwvvLlkFaB12Sy40CjbEkTXKQ9Ztw7Q66YdlkOb708FaB3FIRv3uwAUkhh62ijLcNLPNI0watP+Z397uo6OnZb8hBBreuF8WVfhKvsKr5+VbU+3G5vK/kleysZ5yzrFOOgA8VheY/PD7S8DugzQZfsZS9PfNkAfdHEoVmVRn447zutoEIn7QAs6ZY/vXIp7kKYCGYuidZtln1fth2Im60/Hdx9cTyrZtixXlU5Veci6CnTsBNMkbd2Hk5jK8W6tDzocB+3fCSeA/sPkzwujGRSSZUBL9KrjiP07CX82+XlxkSqEUSNe2WH/Ljq9i1BGW5Q991nzVAa0IKPwh3gtg8sHKvy/2KY3KkL62f1nSZflp1jP646RtGPzw+3GMFVA5ZjpMX1p9K95/36Rtty9Nvrn4q5OP69+2cjyO9Mbx56RLRcX5bj41xOqbtkP8x6+l+N8Eg2ozjbqdnEUy0XuBJS74vIfBAhAK9Yb/0v+uaApdxJKX7F/J2FZxKjQhlG57JekW3YnoTzTWW9DLzuZKH7+XXzab3196+A29vxEk2XR29d1+/ljWlcsD1lXT0hSFtqP/sL4YtFXXpTZGmnXOeaplmkNaD0Ax6aHz5IoG4aljX0Z0IqOIOA/U0IAKXumhDbePFI+vB28yNfheGTddghfbL6mKVONeP2TQhOgNe2yZ3FUPd8iltfYfN2OTmNAy+cLz0U5PHHos0ck/fBYSPmW5dU/URbH4HDUR/jeh13zWHcqaaVqJE3TKTAIYC1LVyJDvZW6KI/hBffT2W+jz30u0h//Ml9GhuiFz86o+xyPME8CeFl6sWd7yPoKdJH/8PgOB7V/UWWd8tB90Nvei3wMLyw80rRJ2rqNtqeS9+QRdN1GxHKLtzxTHunKQyp2242H9I+GB1IW7ZQFQAfPhQDJdEieZlkCdDtgAPHJlitAA/TCdYDTRDXltgH6ZCEB7nbKG6ABGqDn7TQu0KJcm9YBgAZogAZo+uuN1gGABmiANto4m0ZfrN/9CB6gARqgAZoI2mgdAGiABmijjZMIuPsRcNNjCNAADdAATQRttA4ANEADtNHG2TT6Yv3uR+AADdAADdBE0EbrAEADNEAbbZxEwN2PgJseQ4AGaIAGaCJoo3UAoAEaoI02zqbRF+t3PwIHaIAGaIAmgjZaBwAaoAHaaOMkAu5+BNz0GAI0QAM0QBNBG60DAA3QAG20cTaNvli/+xE4QAM0QAM0EbTROlAAPZ9/5uQlM3hRBtQB6gB1wEYdyF2WHybMf5wwy3oZUaX8tQ7Ssv+zWIILX/G7/xV/04+h1GN+NJZujt6dlAEanPuAO0CDc+9wlm84AA3QAA1uvcStD104AA3QAA3QAG20DgA0QAO00cbZhwiQfWh2IRKgARqgAZoI2mgdAGiABmijjZPos1n02YfyA2iABmiAJoI2WgcAGqAB2mjj7EMEyD40+xYA0AAN0ABNBG20DgA0QAO00cZJ9Nks+uxD+QE0QAM0QBNBG60DAA3QAG20cfYhAmQfmn0LAGiABmiAJoI2WgcAGqAB2mjjJPpsFn32ofwAGqABGqCJoI3WAYAGaIA22jj7EAGyD82+BQA0QAM0QBNBG60DAA3QAG20cRJ9Nos++1B+AA3QAA3QRNBG6wBAAzRAG22cfYgA2Ydm3wIAGqABGqCTRtDv73/i3h49kP+e3p2TT5OmvWngA3S7QN+av+Om47vzunpm6z1+QX3eTnlLPeZXvQ2caG7v3nCPDbK8wstBAWgiaKsR4O29l92Phkd1FaDbwVmOP0AbwHk6fdKdyzKXDS65C9O38v8BGqAtAv3O7GF3Xurq8IL7p9mV/H+ABujeft2/MXkwP0veP/q9u77/hftw9xpAJzhp0sWRHo2bW/fkdfXseNu9Pr/tPtp7GqBb6trQkzMRdAIMmvTv/m4ycsPpUX8zQDeLnPVYAHR6oP+wdc59c7ZT9DcDdPoyVph1CtCnDLSColOABmhtnNanAA3Qve3aUJDDKUADtHWYNX8ADdAAbSzCD08oVt/TxdE+HgDdfhnTxWEMQCJoImiNUK1PARqgiaCNnUCsRsxhvoig28cDoNsvYyJoYwASQRNBW4+cNX8ADdBE0MZOIGGkavU9EXT7eAB0+2VMBJ0IwJ39W+6y3GEVedW9M5AImghaI1TrU4AG6M5E0PKgo+dHY/fI6GLp66npn2vtC0ADtHWYNX8ADdC1ULP6NXudfAE0QCuA1qcADdAAnagLZp2TRZfXoQ+6fTwAuv0ypg/aGIBE0ETQ1iNnzR9AA3SvI2jpt96Z3nBXpzeL1/bkifxpdveO3izmyecv7n7R67JIHa0TQafFQx7QvzN7yb0yu1q8Xts6ePToXeMrxTz5/Pm928UDlRRzpusdDyLoU4ygl438kIOjr7qjQFJD19X0AHo9EGKQvju/5p7z6qPWy7Ipz4dOV/ZSvvyiyiki3VUArecboNMhEUOb+e2XMUCDcy+7TgC6fTwAuv0yBmiABuiWfxUDyNqHrK9lDNAADdAAzUU9o3UAoAEaoI02zr5GhexX/W8UAA3QAA3QRNBG6wBAAzRAG22cRJr1I82+lhVAAzRAAzQRtNE6ANAADdBGG2dfo0L2q/43A4AGaIAGaCJoo3UAoAEaoI02TiLN+pFmX8sKoAEaoAGaCNpoHQBogAZoo42zr1Eh+1X/mwFAAzRAAzQRtNE6ANAADdBGGyeRZv1Is69lBdAADdAATQRttA4ANEADtNHG2deokP2q/80AoAEaoAGaCNpoHQBogAZoo42TSLN+pNnXsiqAns8/c/KSGbwoA+oAdYA6YKMO5C7LDxPmP06YZb2MqKz/hh75+zxpvRNc+hpVsV+bE1lLPeZHY+nmSIqjhZMNQG8OYn0+YQE0OPcOZzlBADRA9wFugAZogOYiId1BRusAQAM0QBttnH2IANmHZt9kABqgARqgiaCN1gGABmiANto4iT6bRZ99KD+ABmiABmgiaKN1AKABGqCNNs4+RIDsQ7NvAQAN0AAN0ETQRusAQAM0QBttnESfzaLPPpQfQAM0QAM0EbTROgDQAA3QRhtnHyJA9qHZtwCABmiABmgiaKN1AKABGqCNNk6iz2bRZx/KD6ABGqABmgjaaB0AaIAGaKONsw8RIPvQ7FsAQAM0QAM0EbTROgDQAA3QRhsn0Wez6LMP5QfQAA3QAE0EbbQOADRAA7TRxtmHCJB9aPYtAKABGqABmgjaaB0A6BMEejp90p0dfCX/vTwp+K9l33U/mHzgru9/0UskT/PHY6V8id6aRW9l5Xdr/o57beth9/XhUT3+anafOzvedq/Pb1PmiaEH6BMC+u3RAwcwDy65n0w/cC9Ot93l0XcO510H6cTHAaDbwfnVYZbX2W8NH3U/nm27F2a/cM+Ov5HPO5M94i7O/wjSCZEG6MQwlEWNe9PH8wp85+TTY5GyfpaNPj72WVlazPu8VjkBdHqgfzU+wPmbs51jCH+097Q7n2UuGz5LJA3Q9RqpBcze3//ETQaZywbxKPmNUebuyJ5yz+z/pRY+FvbLeh4AOi3Q786vuecE4PEvj+GsXSECuHR3PLpHFK1l0nRKBN1yBP3h7jV3LstcWfSsyGkU/dD0S4BOdDwAOi3QGiGf2XovCvTNrXvyb4rDGUA3hVnXB+hEICi24bQOvjv7t9xliU7o5kh2ggLotEArGFVTAZoIOm25A3TLQN+YPJiP1vjhbrz7ok43SAg/76u7uQA6LRRVMOtn0sXBhcK05Q7QLQNdp38ZoKuxXedkBNBpoVCEY1PtAqnqo46ty/z4sQJoQ0BzoTAd1AAdb/SpQZSx0TL8ju6N9GUO0ACdrN93nUi3rXUAOj0WMdh1+F3VBcTYusyvPk4ADdAAnXDc6iaBI5HzdHz3wU0qFaM7NqlMUu8rQBsCumqsdFuRZl/TJYKujsyaQqLdGlLORM7tlTVAtwx0nVEcxTC7iptZ+gppW/sF0O2hAc7tlW144gToloGuMw66zs0sbUHW13QBuh1EwLmdcg1h1vcA3TLQdfCtg3hfIW1rvwC6HUi4INhOuSrI4RSgWwZaxzhXDaGrM1a6Lcj6mi5Ap4fkT7Pz+QVBxjqnL9sQZn0P0C0DLQBqhFz2PA55RrQchLLP+ornSewXQKdFRB+WxJ2CactVIY5NAfoEgBaQyp4H/fjg2wcRyehjnged+DgAdFpINHq+a3zFvTK7Wvl6fo8H98fAXXU+QCeGoSo6DH9RJRucc8Pp8WdEV6XBZ/XuNgTotEDrk+qkXJe9GHaXruwB+gSBBtd6uKYoJ4BOh8SqUR/Lpyt7gAZo7iTkTsLoM57BNh2265QlQAM0QAM0QButAwAN0ABttHGuE3GxzulGvKnLH6ABGqABmgjaaB0AaIAGaKONM3U0Rnrdi64BGqABGqCJoI3WAYAGaIA22jiJeLsX8aY+ZgAN0AAN0ETQRusAQAM0QBttnKmjMdLrXkQO0AAN0ABNBG20DgA0QAO00cZJxNu9iDf1MQNogAZogCaCNloHABqgAdpo40wdjZFe9yJygAZogAZoImijdQCgARqgjTZOIt7uRbypjxlAAzRAAzQRtNE6ANAADdBGG2fqaIz0uheRAzRAAzRAE0EbrQMF0PP5Z05eMoMXZUAdoA5QB2zUgdxl57508pKDkuI34Ujj5H5/j7I+XtZSj/lK372v9ByzxWMm9Th3GaCPN3Lg626ZAPRiQwe+bpYHQNMH3ctvTADdTZA4kSweN4AGaIA2eoEIrBax2sTyAGiABmiApr/eaB0AaIAGaKONcxMjRvZ58VsDQAM0QAM0EbTROgDQAA3QRhsn0eRiNLmJ5QHQAA3QAE0EbbQOADRAA7TRxrmJESP7vPitAaABGqABmgjaaB0AaIAGaKONk2hyMZrcxPIAaIAGaIAmgjZaBwAaoAHaaOPcxIiRfV781gDQAA3QAE0EbbQOADRAA7TRxkk0uRhNbmJ5ADRAAzRAE0EbrQMADdAAbbRxbmLEyD4vfmsAaIAGaIAmgjZaBwAaoAHaaOMkmlyMJjexPAAaoAEaoImgjdYBgAZogDbaODcxYmSfF781AHQioN/f/8S9PXog/1X0Oyefro2epLM9ecKdHXwlT0sO0Ney77r7R7931/e/WDvdTfsBXCk3GvtiY09RHrfm77jp+G53PsuK+pkNB+77W9vu9fltyjzxyR6gEwB9e/eGe2xwVGHXBVpwnhymMxhcdD+ZfuBenG67y6Pv5I3hjuwp98z+X0C6xjED6PQ439572T2XZe6r2X3urvEV98rsqnth9gv3xPDeA6yHz4I0QH9uCqjp9El3TqKJwSV3YfpW/v+6QL8xOkB+OD0egX+4e+1wO9eJpAH6xCNViZxfHWbuTPaIe37veKR8c+ueHOkzW++deN5SfDOwmgYRdI3GHuseuDF5MK+U2v2giK4D9M7+LXdZoB99HD0BCeDS3fHDXaLo2DHR+UTQaSPoj/aezrs1YgAr4BlRdNITFEA3APp3k5Hzo90mQNdZV08ID02/jCKuQG36FKDTAv2HrXN518aje3+MAvSr8UGEfXEeX8ZqpGo1XwDdAOgQwTrIhuus8l6AJoKu18UF0GmBrgMYQKcvc4DuENDSxcGFQoCug+VJL0MXR3qc5RgCdEeA1ui8qo96lWi878sSQbcDRgz+P83Oc5Ew8QgOgE6Is4CniK5zkbAKTB1+R/dGvehZyhKgTwZoiZxf23o4v4B4drwd7Z+Owc786uNEBJ0Q6baA1uF3qeGvOil0/TOArm74TWB8d34tHw8tZZy/hhdc1cXDJtva9HUB2jDQqe5O7Dq26+QfoNsDWqLmndlL+Y0qEj3rjSpy8wp3E6Ytd4A2CrR2a8gBInKu37WhmAN0WiiWRbI6Tppx0GnLHaANAg3Oq4OsMOsUoNNCsQxo+VzvJhzOGAddp7zqLAPQxoAG5+Y4C9IAffJAaxQdu9uwDkgss3jcANoY0FwQBGhrSNUd4wzQi7imOI4AbQjovenjB1fFK57HoV/hmVZDTgSdFgu5S1CeYlc1WoMujrRlLsADtBGg9WFJ3ClYDW/dExNAp8VCo+PYRUB9FGns8xTR5CamAdBrAi19xTvTG+7q9Gbxkgfty6NH7x29WcyTz1/cPXrQfgxijZ7Ddf309X8/vbpgbdpyAJ0WaMFRI2SJpL+3dfQ86GfH38gjvWUR9iYC23SfAXpNoBVaKcBlL3+YnK4XRsr6pLplacnnfnqbBm/d/ZVyato4WP848hIpC8jhL6rIXYS/3ju+PGXYrEykHjv3pcvkT/5PlvEoyzXRrosHy6XpxqgqR4BuBgOw2ig/gAbjXp6QAdoGMEDf7DgANEADdAtPIQOmZjBRfgflB9AADdAATX+90ToA0AAN0EYbJ1EkUThAAzRAAzQRtNE6ANAADdBGGycRNBE0QAM0QAM0EbTROgDQAA3QRhsnETQRNEADNEADNBG00ToA0AAN0EYbJxE0ETRAAzRAAzQRtNE6ANAADdBGGycRNBE0QAM0QAM0EbTROgDQAA3QRhsnETQRNEADNEADNBG00ToA0AAN0EYbJxE0ETRAAzRAAzQRtNE6ANAADdBGGycRNBF0AfR8/pmTl8zgRRlQB6gD1AEbdSB3WX+TUN7o/0wPfqeRcuheOVCPu3fMaGfHj5nW4/8HVWGbpDtLS9QAAAAASUVORK5CYII=\" alt=\"image.png\" data-href=\"\" style=\"\"/>
</p>
<p>
<br>
</p>
</html>"    ), Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
    grid={2,2}),graphics = {Rectangle(origin={0.215072,-0.86029}, 
    fillColor={255,255,255}, 
    fillPattern=FillPattern.Solid, 
    extent={{-100,100},{100,-100}}), Rectangle(origin={2,0}, 
    lineColor={47,49,172}, 
    fillColor={255,255,125}, 
    fillPattern=FillPattern.Solid, 
    extent={{-60,60},{60,-60}}), Line(origin={-18,0}, 
    points={{0,60},{0,-60}}, 
    color={161,159,189}), Line(origin={22,0}, 
    points={{0,60},{0,-60}}, 
    color={161,159,189}), Line(origin={6,-21}, 
    rotation=90, 
    points={{1,64},{1,-56}}, 
    color={161,159,189}), Line(origin={18,19}, 
    rotation=90, 
    points={{1,76},{1,-44}}, 
    color={161,159,189}), Text(origin={3,-132}, 
    lineColor={0,0,0}, 
    extent={{-150,-20},{150,20}}, 
    textString="%name", 
    textColor={0,0,0}), Rectangle(origin={2,0}, 
    lineColor={47,49,172}, 
    extent={{-60,60},{60,-60}})}));
    end LookupTable1D;
    model LookupTable2D "Two-dimensional linear interpolation table"
      parameter Tables.Types.InterpolationMethod interpMethod = Tables.Types.InterpolationMethod.Linear 
        "Interpolation method";
      parameter Tables.Types.ExtrapolationMethod extrapMethod = Tables.Types.ExtrapolationMethod.Linear 
        "Extrapolation method";

      parameter Boolean tableDataOnFile = false "= true, if table is defined on file" 
        annotation(Dialog(group = "Table data Switch"));
      parameter Boolean breakPointsOnFile = false "= true, if breakPoints is defined on file" 
        annotation(Dialog(group = "Table data Switch"));

      parameter Real breakPoints1[:] = {0} "breakpoints 1, specified as a vector with strictly monotonically increasing valuess" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));
      parameter Real breakPoints2[:] = {0} "breakpoints 2, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));

      parameter Real tableData[:,:] = {{0}} "tabledata, specifies as an 2-D array of elements arranged in main order of columns" 
        annotation(Dialog(group = "Table data definition", enable = not tableDataOnFile));
      parameter String filePath = "none" "file path where data is stored" 
        annotation(Dialog(group = "Table data definition", enable = (tableDataOnFile or breakPointsOnFile), 
        loadSelector(filter = "Text files (*.csv)", caption = "Open file in which table is present")));
      parameter Integer bp_cols[:] = {-1, -1} "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = breakPointsOnFile));
      parameter Integer tableData_col = -1 "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = tableDataOnFile));

      Modelica.Blocks.Interfaces.RealInput u1 
        annotation(Placement(transformation(origin = {-121.058, 40.1216}, 
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealInput u2 
        annotation(Placement(transformation(origin = {-121.582, -39.899}, 
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y 
        annotation(Placement(transformation(origin = {110.377, 2.02899e-7}, 
        extent = {{-10, -10}, {10, 10}})));

    protected
      Integer bp_sizes[:] = {size(breakPoints1, 1), size(breakPoints2, 1)} "columns of the data to be interpolated in the table";
      Real tableDataVec[size(breakPoints1, 1) * size(breakPoints2, 1)] = Utilities.arr2D2vec(tableData);
      Tables.Types.External2DTable externalTable = Tables.Types.External2DTable(filePath, tableData_col, bp_cols, breakPoints1, breakPoints2, bp_sizes, tableDataVec);

    equation
      y = Tables.Types.evaluate(
        externalTable, 
        {u1, u2}, 
        interpMethod, 
        extrapMethod);

      annotation(Documentation(info = "<html><p>
Performs an n-dimensional interpolation table lookup where n=1. The table is a sampled representation of N variables among the function. The breakpoint sets associates input values with positions in the table.
</p>
<p>
The 1-D Lookup Table, 2-D Lookup Table and n-D Lookup Table compute the n-variable sampling representation of a function:
</p>
<p>
<span data-w-e-type=\"formula\" data-w-e-is-void data-w-e-is-inline data-value=\"y=F(x_1,x_2,x_3,...,x_N)\"></span><br>Where function F is an empirical function.
</p>
<p>
The module maps the input to the output value by finding or inserting a table of values that you defined using the module parameters. The Homogeneous (constant), Linear (linear point-slope), Nearest, Akima spline, Fritsch-Butland spline, &nbsp;Steffen spline interpolation methods and the Homogeneous (constant), Linear (linear point-slope) extrapolation methods are supported.
</p>
<p>
In the following table, the first column identifies the breakPoints 1, the first row identifies the breakPoints 2, and the tableData &nbsp;is identified by the others.
</p>
<p>
For example, when the breakPoints1 is {-1,0,1.2}, the breakPoints2 is {-2.3, -1.07, 0.05} and the corresponding value is {1, 2, 3, 4, 5, 6, 7, 8, 9},you can set the tableData {{1, 4, 7}, {2, 5, 8}, {3, 6, 9}}.
</p>
<p>
<img src=\"data:image/png;base64,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\" alt=\"image.png\" data-href=\"\" style=\"\"/><br>
</p>
</html>"    ), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
        grid = {2, 2}), graphics = {Rectangle(origin = {0.215072, -0.86029}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {2, 0}, 
        lineColor = {47, 49, 172}, 
        fillColor = {255, 255, 125}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-60, 60}, {60, -60}}), Line(origin = {-18, 0}, 
        points = {{0, 60}, {0, -60}}, 
        color = {161, 159, 189}), Line(origin = {22, 0}, 
        points = {{0, 60}, {0, -60}}, 
        color = {161, 159, 189}), Line(origin = {6, -21}, 
        rotation = 90, 
        points = {{1, 64}, {1, -56}}, 
        color = {161, 159, 189}), Line(origin = {18, 19}, 
        rotation = 90, 
        points = {{1, 76}, {1, -44}}, 
        color = {161, 159, 189}), Text(origin = {3, -132}, 
        lineColor = {0, 0, 0}, 
        extent = {{-150, -20}, {150, 20}}, 
        textString = "%name", 
        textColor = {0, 0, 0}), Rectangle(origin = {2, 0}, 
        lineColor = {47, 49, 172}, 
        extent = {{-60, 60}, {60, -60}})}), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
        grid = {2, 2})));
    end LookupTable2D;
    model LookupTable3D "Three-dimensional linear interpolation table"
      parameter Tables.Types.InterpolationMethod interpMethod = Tables.Types.InterpolationMethod.Linear 
        "Interpolation method";
      parameter Tables.Types.ExtrapolationMethod extrapMethod = Tables.Types.ExtrapolationMethod.Linear 
        "Extrapolation method";

      parameter Boolean tableDataOnFile = false "= true, if table is defined on file" 
        annotation(Dialog(group = "Table data Switch"));
      parameter Boolean breakPointsOnFile = false "= true, if breakPoints is defined on file" 
        annotation(Dialog(group = "Table data Switch"));

      parameter Real breakPoints1[:] = {0} "breakpoints 1, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));
      parameter Real breakPoints2[:] = {0} "breakpoints 2, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));
      parameter Real breakPoints3[:] = {0} "breakpoints 3, specified as a vector with strictly monotonically increasing values" 
        annotation(Dialog(group = "Table data definition", enable = not breakPointsOnFile));

      parameter Real tableData[:,:,:] = {{{0}}} "tabledata, specifies as an 3-D array of elements arranged in main order of columns" 
        annotation(Dialog(group = "Table data definition", enable = not tableDataOnFile));
      parameter String filePath = "none" "file path where data is stored" 
        annotation(Dialog(group = "Table data definition", enable = (tableDataOnFile or breakPointsOnFile), 
        loadSelector(filter = "Text files (*.csv)", caption = "Open file in which table is present")));
      parameter Integer bp_cols[:] = {-1, -1, -1} "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = breakPointsOnFile));
      parameter Integer tableData_col = -1 "columns of the data to be interpolated in the table" 
        annotation(Dialog(group = "Table data definition", enable = tableDataOnFile));

      Modelica.Blocks.Interfaces.RealInput u1 
        annotation(Placement(transformation(origin = {-120.43, 59.914}, 
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealInput u2 
        annotation(Placement(transformation(origin = {-120.325, -0.314147}, 
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealInput u3 
        annotation(Placement(transformation(origin = {-120.325, -59.6914}, 
        extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y 
        annotation(Placement(transformation(origin = {110.377, 2.02899e-7}, 
        extent = {{-10, -10}, {10, 10}})));

    protected
      Integer bp_sizes[:] = {size(breakPoints1, 1), size(breakPoints2, 1), size(breakPoints3, 1)} "columns of the data to be interpolated in the table";
      Real tableDataVec[size(breakPoints1, 1) * size(breakPoints2, 1) * size(breakPoints3, 1)] = Utilities.arr3D2vec(tableData);
      Tables.Types.External3DTable externalTable = Tables.Types.External3DTable(filePath, tableData_col, bp_cols, breakPoints1, breakPoints2, breakPoints3, bp_sizes, tableDataVec);

    equation
      y = Tables.Types.evaluate(
        externalTable, 
        {u1, u2, u3}, 
        interpMethod, 
        extrapMethod);

      annotation(Documentation(info = "<html><p>
Performs an n-dimensional interpolation table lookup where n=1. The table is a sampled representation of N variables among the function. The breakpoint sets associates input values with positions in the table.<br>The 1-D Lookup Table, 2-D Lookup Table and n-D Lookup Table compute the n-variable sampling representation of a function:
</p>
<p>
<span data-w-e-type=\"formula\" data-w-e-is-void data-w-e-is-inline data-value=\"y=F(x_1,x_2,x_3,...,x_N)\"></span><br>Where function F is an empirical function.
</p>
<p>
The module maps the input to the output value by finding or inserting a table of values that you defined using the module parameters. The Homogeneous (constant), Linear (linear point-slope), Nearest, Akima spline, Fritsch-Butland spline, &nbsp;Steffen spline interpolation methods and the Homogeneous (constant), Linear (linear point-slope) extrapolation methods are supported.
</p>
<p>
The 3DLookupTable is obtained by superimposing and expanding 2DLookupTable. Each page of the 3DLookupTable is a 2DLookupTable.
</p>
<p>
For example, when the breakPoints1 is {-1,0,1.2}, the breakPoints2 is {-2.3, -1.07, 0.05} and the corresponding value is {1, 2, 3, 4, 5, 6, 7, 8, 9},you can set the tableData {{1, 4, 7}, {2, 5, 8}, {3, 6, 9}}.
</p>
<p>
<img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAlcAAADaCAYAAACLimerAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAFxEAABcRAcom8z8AACNASURBVHhe7d3PbxznecBxcpX/xXRIupBkInF7jWIKPJhSAAKmAzC2LB94sFznxNaWlIsI1FIaJ7qERCyDp3jTVLXdCw9FTCAp+gO8tFFzStp/oL31x+3t+7wzs/vu7DuzuyRFzvs8XwEfyNqZXc7sLLlfv/PucM7/cQAAADgTX/Pm3N/97r/GFsptAC7e3Px8+J7833/+pfs/qDXvj/P//tNfJZdBh16v5/7nH3+RXAYdvnbpkvy8HsbV2A/0KLSa1gHw/BFXNhBX+hFX+k2MqzpZL5ZaB8DZI65sIK70I670mzmu6uR+ldRyAGeDuLKBuNKPuNLv1HEVk8eIpdYBcDLElQ3ElX7ElX5nGld18pix1DoApkNc2UBc6Udc6fdc46pOvkYstQ6ANOLKBuJKP+JKv3ONqzr5mpXUcgBDxJUNxJV+xJV+FxpXMfn6sdQ6gGXElQ3ElX7ElX6dias62Z5Yah3AEuLKBuJKP+JKv87GVZ1sXyy1DqAZcWUDcaUfcaVfNnFVJ9tbSS0HtCGubCCu9COu9Ms2rmKy7bHUOqocHruDutR6F2lvyy1e3nK7qWV1qf05TKx3UocP3Jrflu2zfMxTOtjru93KlNtFXNlAXOlHXOmnIq7qZF9iqXXy1XdrYb9WfLyIaF+7FBA+rubmpomr+v6sRPuz4rb3jhP3mZGPq0X/+J14bsK2lPu7seWjr9zfKUKUuLKBuNKPuNJPZVzVhTevSGqdfBQxsrhTi47DvtsOodWRiJgxrsb253fHbnejCI+1vfj2i3Ww9+AUwVeG5EZ/dKTRH7vq9tH1RxFXNhBX+hFX+pmIqzrZ10pqebc1xchw2aQ36XNx6rgq7G7IcZry9OI5kO1p2tZJDnYkFhv2ZYrni7iygbjSj7jSz2RcxWS/Y6l1uqUtRo6L0au2uCrnNCWX+ftXc57Sy4cmzo06o7gqHqd9NG7itkyleoy2fS+e37a4at2WQ5ljdfL9JK5sIK70I670Mx9XdfI8xFLrXKzJI1cjywaRU4ZX2K/6m7hfVp6Ck3lOxZwg/ziJSDvY2RouH8yPSkRBU1yVc46G23jSuBqeNpTl8bas1R8rNecqfl7KxxnOX/OPUTsVWYw6VcuHBuvFc6mq53CWOXBNz1eEuLKBuNKPuNKPuJpAnpdKavn5a4oRHxup005lWKz5gFjcqc31CYajXfEymVs0GkFeGRBrI6MvEjny/NS+bioWxsJKtMdV+lRauc0yCbwWLwf+66a3uxZX4bat8nkZ3Z/txlORxdcd39b07eF5ufxgik9yDo9BenmBuLKBuNKPuNKPuJqBPEex1DrPXxEjEhZr8mmzoBgpWdx4MP6x/jJomt642+YBjS079CGVOq01iK7otnpcJcNKtMRV00Tv8Nip0azC+HY3xVXD85Lan6AhrlKPX5rmVGWxvc37UyGubCCu9COu9COuTkGes1hqnbOXiqsisGQbJLBGP4nWFAqFMLrSNGIy4b5DxTY1xlX5OMmAquJKwjC69pOcqgvxkxj5ad1mUd/uVPy07ltT8DWNXDWtP5mMtMlxm/wcE1dWEFf6EVf6EVdnSJ7DWGqd02t7Iy9PL8XXTEqFxUAZC7WwGUpH0YFMzN4ZD7tkXE28zEC53G9jdZ2rwG9T+pIHTYETq63TGFcTnpexr9H8tYvRp+K5306efh1XjVhNE1aCuLKBuNKPuNKPuHqOwpttKbX8ZCaNkhTLW0dtauuOj4KNGkaOX9/HRQiCkSArImw8rop9Xwzx1b4N7bEUm2b984+rwIfkYMRNSOQmH19G39qekzTiygbiSj/iSj/i6pyEN9tIap3pTIqLKcKiad1WxbrpCdrFNqXiqpr8npz0HswaV9Nsc+0xzyuuYhJa8nwl9vkkYSWsxNWzjz9wn1eeptdp9viU9794+uLKH5MTHodnT0eP5dhr/6k89gT1+3RArnH17OmH0fH4q5l/Fk19/9RxrKTW7yDi6oLI8x1LrZM2KUamCIvIxPlLA4mAqoSvkYqrOCya4mzWuCq3ue1TePXtuYi4EonnZdrJ6ynq4+rpm+6Vefl+eMF98+Y1d2v5hbC/c8vX3N/8U2L9mmfvX3OvhPVfcLei+3/z5pvut1Pcvys0xdWz73/bH1P/ul3+nvvXmfbpA/f2S/NuXl4LN4pjOS/H8safR8fysXsU1pHXTLNv/ulP3P907PjnF1cfutt/VByPb1THw3+vfsMfj+mOa3n/+eL+bw3u/2eJ+/vj+kc915N1l/zx9+uOuPnn7r//sfvfH8RVR1Q/CCqpdQrtMTL25t0aEV6IoIblcl8fMUUgNX/dar5Re1x5ZWyMPsbscTUcFUss88biK/UctD4vs8VVuPxD46cO68dixn2N6I4r/2YqYXXzA/fb+Panw9tb97sMs1s/+snoeuXt8gaby/OmIq7kuEn4LH/LfXTTv5EuvzlDXJXR5N9E/zWOovBamC+O5TSx9PG3/Ru0D3P/Rty1Y59XXJWxE45HdAyf+mDqyfH48YR4bbt/z70ydv9i/bd/9IvORfEsiKuOkuNRGV1WxUh/eDXwct5TMR+q9ubdGhGiHFGSdaIJ5IPrXEXRMDi1N3is4kKe4RcQ+3UnxtXg9njdE8SVV51ak9OOw4iqLiw6RUidIq4G4SbPffg7FU3l9b+iyKuev+3BXLVxbZdu0BxXz96XkYmGEaqPr/ngaB+9+vymvBmnA+zZ+wvhzT2X0av840oiaMHdKiPo2fcXXO+lGeIqRNEL7qO/TkTR1MFUBNorHRy1ElnF1Y+/7S71XnB/8cvEcx6WXXNP247H4P6/mPL+Prou9dytvySu8JzJsYmtxZ+qi6yF4Krd37/xr8kn2FretEMI7PjHGPk68niJuAjxMlxP4utAAkm+fi2uFuNPLUZCkMUjYmHbZ4srEUaMyqAcbE9qEnnqOWh9Xor9TG5TuF/09ap1areHZSOXxSgeM3XcYk2jcUL1yFWYW/M4vSzEVfFmm1wunj5unl81RZx1Sf5xJXNjhv+eNa6++I6MeDWdRvTh1pt3t37UHlczB905yymuvvhOz/XkeCRPxRWjV20hNPn+9ZAirnBB5FjFUutAHysT2secMo4YubpYs4XOcMQpfepv0nIxXYBdpHziqjhFN37q7nkul7hacB+lRroyQlwpIMculloH+bMZV4/dwzD/ZsKcqybMubpwzyOuZD5W06hG10ethLa4kvlU/518vqe9/58N7//0LffHvSKufvvxW+7Rd665t29ecx/96CdZfTCFuFJIjmUltRx5shhXYdRpbsIpwZpwKYb333S3bsqnBV9wt/70cVbPme24mjxpPZw2bIyr7o9aiXziqjjt1zZpPZz2a4yr4v7NcVXdvx5X/hjLe9jSt9xb8slfTz51Kj8LknO3Ooi4Uk6Oayy1DvJgLa6ehdOB8gnAWd4oH7uHPqrkI9vhNe//vvUxcXWRThJXbce8Na46/AnBWG5xNXFO1YS4mnz/OK4+dI++8233UD75O3KfcpRr+XvuX5Lzt7qFuDImvOFEUuugm/KMq9oFACvJdYeqEatTj0CUH9+f8z/8m+fodEt34ypxHKc5luc2cuXffCecMuwKRq6GxuKqzdO33J/4x3srg8nuxJVxctxjqXXQDTnGVbhEQu01FrTMofpcros046nAVmHe1Qvu4Vk93nPW1bj6XKJGrjlWP5Y32mPmecy5Si6X00n+uev6KUHBhPZpl9f5WLvk13/vxz7GUsu7g7jCiMEPTF4PnWPhtOCZh1Uw+VRTl9g+Ldg2MiVa5lRlckpQ5BNX041Mne604SyXXSCuoIC8JmKpdXB+tMdVcSFRGWFKL28m8dQ2N4u4ukizxlXr+mF0Kn2B0fbrY3VLTnFVHI+G61RFn+xr+t569v0XZ7p/8fsHH6dHLjktCI3kNRJLrYPnR3VcVZdMeP8nJ9i/8nINTdeymuYipB1iPa7aRqeaA6o4XZjDfCuRU1y1jU6FUanGC4RWJt8/nqAuMXZp/pp7+g/jxz8skyu6J5Z1DXGFE5PXTCy1Ds6O5rgq5mZdcw+r35ifMLjqdyqWqji7+ab7/Gl5pXf/9+fyy5zldpmjU63bcRriKp7w/rl8OMHH1d/89fC2wboNv+omBJm//S25tlG47bF/I/aP0zBqVcVV+8VFuyOvuIqOx19W15oqjofcNnJphIZfdRNGr6a5f1Cc+ptf+pZ7+svy+9a/Zr4I2zCXxaiVIK5wZuQ1VEktx+nojavh5RPa3Pq4fFP1cfXKsg+x+unD8MuCR4OfSzFcAB9Mr7yUPoaFa8NACutG/448k2Xla744lt/ygZYKKyHHfvj7DMeXd0tucSWe+XAaXH9KSPzUj4esI8cz8XsIk/dP/b5CES7HUMTU4Pj79f9i7PIM3UVc4bkYfEOUUutgNhYmtEPfaUGMyzGuMBviCudCXl+x1DpoR1zZQFzpR1zpN11cHR67g7rUehdpb8stXt5yu6lldan9OUysd1KHD9ya35bts3zMM3HG+3kK8nqLpdbBKOLKBuJKP+JKvyniqu/Wwhvgio8XEb0pdikgfFzNzU0TV/X9WYn2Z8Vt7x0n7jMjH1eL/vG7FFcHOz4+wz4+6F4Ye4Nj4KWWg7iygrjSj7jSb+q4WtypRcdh322H0OpIRMwYV2P787tjt7tRhNbaXnz7xTrYe3C64PPHaU2Ok4Sw7F9H4yomxyCWWsci4soG4ko/4kq/k8dVtGxuo59Yds5OHVeF3Q15Q5/y9OI5kO1p2tbJZF9X3Fp5/4OdPOKqTl6bsdQ6FhBXNhBX+hFX+p0yro6L0atJcVXOaxpfNpzzNL5s1MS5UWcUV8XjtI/GTdyWqVSP0bbvxfPbFlft2zJ6e65xVSev1VhqHY2IKxuIK/2IK/3OZORqbNkgdMr48uuMBou/vTwFJ/OcwlwgeZxEpA3mCsnywfyoRPw0xVWY/xRv40njanjaUJbH21KNDA2k5lzFz0n5OMP5a/4xaqciQwiFZaMG65X7VW1LMZ+qfQ6clriqi5+f1HItiCsbiCv9iCv9ThFXPjZCADQFjQ8GHxGLO/3am/lwtCu+XeYWjUaQVwbE2sicI4kceSOtfd1UXI2FlWiPqyJq6vtUbrN8GrEWLwf+66a3uxZX4bat8jkZ3Z/txlORxdcd39b07eF5aYknrXEVk9dxLLVOrogrG4gr/Ygr/aaOKwmLtY1KMVKyuPFgLDaCMmpSpwvT8dKw7NCHVGoy9yC6otvqcZUMK9ESVzL5O7XdjaNZhfHtboqr9HOS3J+gIa5Sj19qO1VpIa7q5HUdS62TC+LKBuJKP+JKvxPGVRFYch8JrLE368ZYKEdXUoEhWu43qtimxrgqHycZUFVcSRju9QfkVF2In0R8tG6zqG93Kn5a960p+JpGrprWb2cxrurkNVtJLe8y4soG4ko/4kq/s5nQLqfL4ttTcRGUsVALm6F0FB0c+mU742GXjKum0aeBcrnfvuo6V4HfpvQlD5oCJ1ZbpzGu0qNNzV+j+WsXo2XFc789duo1jbgaFZ6/SGqdLiGubCCu9COu9DtlXA2Xj4ROY0iUYTM2CjZqGDl+fR8XYcL3SJAVETYeV8Wb5GKIr6aQmbQ/ddOsf/5xFci1xqoRNyGRm3z8AnHVrnr9VFLrXCTiygbiSj/iSr8ziKtEADSGxIRYGFGsm46BYptScVVNfk9Oeg9mjatptrn2mOcVVzEJLXm+kvtcIK5mI6+nWGqd80Rc2UBc6Udc6XdmI1cjy1tCYuL8pYFEQFXC46fiKg6LpjibNa4mfwpvbHsuIq5E6nmJEFenI98jldTy5424soG40o+40u/UcVXM/ZkhJEIENSyT+/k3/yKQmr9u8TUnxZVXxsboY8weV8NRscQybyy+Uvvf9pzMGFfh8g+Nnzps+hrE1VmS10Mstc5ZI65sIK70I670myGu+uWVwL1y3lMxHyoRBVOERAisaAL54DpXUTQMTu0NHqe4kOeizM3y606Mq8Ht8boniCuvuICoXOzT7391u1wqIjW/64zjahBE8tyHv8vnamT98vpftXgaXsHdLy/jaje6bXh/nIa8xmKpdU6LuLKBuNKPuNJvuriKP1UXWQvBlbiPf/Nfk0+xJUNCFG/0EgjydQvyeIm4CPEyXE/i66DcpnpcLdY/tVgKQSZREf5d3nfGuBJhxKgMysH2pCaRp/a/9Tkp9jO5TeF+0der1qndHpbVL4sRtnf0mI1qO0Y4jfi4iNQ6syKubCCu9COu9JsirgCclnx/VVLLp0Fc2UBc6Udc6UdcAedMvtdiqXVSiCsbiCv9iCv9iCvggsn3Xiy1jiCubCCu9COu9COugI6R78XY3/3bfxa3E1cmEFf6EVf6jcQVAAAAzgRxBQAAcIY4LQh0XXVa8O///W/d3/8HtJLTgr/59y+Ty6CDnBb89R++SC6DDpe+xpwrIAvElQ3ElX7ElX7EFZAJ4soG4ko/4ko/4grIBHFlA3GlH3GlH3EFZIK4soG40o+40o+4AjJBXNlAXOlHXOlHXAGZIK5sIK70I670I66ATBBXNhBX+hFX+hFXQCaIKxuIK/2IK/2IKyATxJUNxJV+xJV+xBWQCeLKBuJKP+JKP+IKyARxZQNxpR9xpR9xBWSCuLKBuNKPuNKPuAIyQVzZQFzpR1zpR1wBmSCubCCu9COu9COugEwQVzYQV/oRV/oRV0AmiCsbiCv9iCv9iCsgE8SVDcSVfsSVfsSVOcfu4DB1O7rOblztu/5R6nadTMfVkT/WqduVMRFXciwnSd1PCeLKkIOdLbfoj/Pc5QfuILEc3WYxrvp3V92SvGav3HafGdlvs3H15HrY97nX77lfKz/W+uNq3733cs8fT/+9K9+/DRY/+KnaY01cWXDYd2uX/Yv58pbb3lghrjJlKq6O7rv1q35/r6y6O5sLxJV6992N3ryblzdd4kq/T6/752DVffT7L91vUssVIK7U82E1t+LWdo7Dvw92iKtc2YkrH1bzC2797n74d//ui26euFLt0Rs+rDbvuYebxd/ElWbFqNbyh3pHrQRxpd7oHCviKl924krmYwz/TVwpd/SOW55fdQ//8OUgsogrvfr3vu56V992P/fHO7VcC+LKGOIqX1YntBNXmu27967Ou6UP9/w+D0ewiCutfuBuXOq59Z99EY53eh0diCtjiKt8EVfp5dpYiqv+PX9sr8qxLfaXuNLNyqiVIK6MIa7yRVyll2tjJq7C6cAFd+er4aRm4kozO6NWgrgyhrjKF3GVXq6NjbgaPR1Y3U5cKWbgE4Ix4ipbMlE9IbnuEHGVL+IqvVwbC3FVPx1YIa60Kq97JcfWwClBQVxlandj9GJsAxv95PoV4ipfxFV6uTbq4ypxOrBCXCnlj/lLvXkzpwQFcWUMcZUv4iq9XBvtcRVGrebn3NKVhTHy+hbh3z6ytL4Rm4srY6cEBXFlDHGVL+IqvVwb/acFa79fLlKNXH32lf938r46WIurH36353pXbHxKsEJcGUNc5Yu4Si/XxsaE9jROC2pkb76VIK4MiCe875ZxtRvdlroPusdSXI2MZtxdCHH1UEYzyttS99GCuCKudLHx627qiCvt9rbc4uWVFltuO/r1OOguM3H1ZNUt1+bijFp1d75K3E8J23H1oltWPNeqYiuufuBuvPyiW69ddkM74grIhNXTgtZYjisrzE1oN4i4AjJBXNlAXOlHXOlHXAGZIK5sIK70I670I66ATBBXNhBX+hFX+hFXQCaIKxuIK/2IK/2IKyATxJUNxJV+xJV+xBWQCeLKBuJKP+JKP+IKyARxZQNxpR9xpR9xBWSCuLKBuNKPuNKPuAIyQVzZQFzpR1zpR1wBmSCubCCu9COu9COugEwQVzYQV/oRV/oRV0AmiCsbiCv9iCv9iCsgE8SVDcSVfsSVfsQVkAniygbiSj/iSr+xuJK/AQAAcCpFXAEAAOBMcFoQ6DpOC9rAaUH9OC2oH3OugEwQVzYQV/oRV/oRV0AmiCsbiCv9iCv9iCsgE8SVDcSVfsSVfsQVkAniygbiSj/iSj/iCsgEcWUDcaUfcaUfcQVkgriygbjSj7jSj7gCMkFc2UBc6Udc6UdcAZkgrmwgrvQjrvQjroBMEFc2EFf6EVf6EVdAJogrG4gr/Ygr/YgrIBPElQ3ElX7ElX7EFZAJ4soG4ko/4ko/4grIBHFlA3GlH3GlH3EFZIK4soG40o+40o+4AjJBXNlAXOlHXOlHXAGZIK5sIK70I670I66ATBBXNhBX+hFX+hFXSh0c9t3uXukwvQ7yYjGu+k/uu0eVo/Q62piJq6N912+SWl8RW3Hlj+en8ffxl+43yfV0Ia7U6bu1y3P+oK64xY0t/98r4Q15caPvDpLrIxem4urotluel9fxglvaXHXrVxbCvs9dWXUPle+/jbjad+9dnXfzcnz9sR2zec8/B6n76WAmrj697l7q+eN8+VX3mnwfb/pj67+v5y+/7X7+B92vceJKlWO3LWFVD6lDH1wSWDvH0brIjZ24uu/WZV8377vP4n09Gt6u+Y3XUlytf2JjFKPORFwdvRPCav1nP619v/pj/3LPzW/e9c+B3tc5caXJ3pY/mCtuO3UaMCzbcrv125ENK3HVv7vg5ucaRqierPr40D16ZSOu7rsb8sZLXKnVv/d11/Pfqx/9PnGMP73un4OGZUoQV4rsbsy5ucsPGk7/FaNXa3upZciBmZGrI5mbsZ9eFuJqwd35Sm98EFf6mYmrqw2n/0JcLbh3f/UFcYWuK04JNp/6m7QcXWdxQvsYRq6UkLh6MUQycaVU2+gUI1fIx3RxJfOx0svRdcTVvrtzlTlXKhy945bLEcj+k3fcnTdksvOqu/PJnvpPCgobE9p/4G5c6rmlD3/qfh1/vx752/3+L31Qu10Z4kqNyZPWw2lD4ipb1uOqf/fF8OkyzacEhZ24Kl7Pc1eqT5KtuqVwm5wu0j2iZSOuPAkpmbzuQ3rx9eJTv/Lfr32wp/p/kARxpcbkOVXEVd4sx1U/nA6cC3N0Uss1sRFX9917bxQjVaMRVV6i4crb7jPFz4GVuOp/et0t9+bd0uuvunc/uece3b3uboTj+6r7SHlAE1dqMHKlndW4qkasLISVsDHnqoWMalWT3ZW+1u3MuUpPWg+T3ZlzhTwwoV07i3H16A0bpwJj5uOq/CTh0od6Tx1ZiKsffrfnepv3/H6mXsvFfKz1n/nwUnqMiStF2kemuBRD7qzFlcWwEsQVcZW/4kKhy/XJ7FMvzx9xpcjBzkrzda4OH7jFpguMIguW4srK5PUUC3HVb7uWGacFFZgUT+UnCRV/YpC4UqV5dKr9AqPIgZm4Kn+v4NLd+mRnG0zE1T0fz3K9ssQpo7ZlWpg5LXiFi4gSV0qE0au5FR9Yx2VIHfuwKm5j1CpvVuLq0ab8Ql/5JFn0m/Rr+kfp+2pg47RgcepPPjX28Ku94rajffdIRix9WL+meNRKmJjQXo5OyS9pjj8Z2P+0+J2D86/zuwWRmYO9Lbfoj6cc0+DyltslrLJnI6723R35zflX2q0/0ftD2cycq3A5hiKmBj+rfGy9K5dnUP4/EDbiyjv6wfgxnuM6VwA6xNqEdquY0K6fmbgyjLgCMkFc2UBc6Udc6UdcAZkgrmwgrvQjrvQjroBMEFc2EFf6EVf6EVdAJogrG4gr/Ygr/YgrIBPElQ3ElX7ElX7EFZAJ4soG4ko/4ko/4grIBHFlA3GlH3GlH3EFZIK4soG40o+40o+4AjJBXNlAXOlHXOlHXAGZIK5sIK70I670I66ATBBXNhBX+hFX+hFXQCaIKxuIK/2IK/2IKyATxJUNxJV+xJV+xBWQCeLKBuJKP+JKP+IKyARxZQNxpR9xpd9IXAEAAOBMMHIFdB0jVzYwcqUfI1f6cVoQyARxZQNxpR9xpR9xBWSCuLKBuNKPuNKPuAIyQVzZQFzpR1zpR1wBmSCubCCu9COu9COugEwQVzYQV/oRV/oRV0AmiCsbiCv9iCv9iCsgE8SVDcSVfsSVfsQVkAniygbiSj/iSj/iCsgEcWUDcaUfcaUfcQVkgriygbjSj7jSj7gCMkFc2UBc6Udc6UdcAZkgrmwgrvQjrvQjroBMEFc2EFf6EVf6EVdAJogrG4gr/Ygr/YgrIBPElQ3ElX7ElX7EFZAJ4soG4ko/4ko/4grIBHFlA3GlH3GlH3GVtWN3cJi6fbKDvb7brZzwMXC+7MXVvus/ue8eVY5S6+hjLq6O9ofH+Ik/5ql1lLEVV/6Yfjr8Pu4beW0TV5k62Nlyi/6YzV1+4A4SyxsdPijuN7fiFje23NrllfCGPXd5y+2m1kdnWIqr/t1VtySvyysLbn1z1a37v2XflzZv+x/O6ftoYSmu+vde9Psrx/lV95o/zkvhNb7g3v3Vl+43ifW1MBNXn153L/Xm3bw/pq+97o/vFf/f8/6/P9jzr/HE+ooQV7k57PsgKmJoe8OH0Uxx5e8rb1gb/dH7yGOWt4+ujy4xE1dHt92yf8Nd/2QvefvSXf+DOb5dGStxVYSVD6mv4pDad4/e8G/AV952nyl+DkzE1dE7IayWPvyp+3X0M6vvg6vXk4D+QvX3MXGVFYmgFbe2cxz+fbAzW1yF9ecaRqj2tpqXoROsxNWjTf/munk/+X+2/bv+DfnKbf/GO75MCxtxdd/dCG+8iRGMcJpwX/Xr3EJc/fC7PdfzkfzzP4y/lsOyzbv+OdD7OieusjI6x2rWuJIRqt29IszGhLhacdvMv+osOyNX/s21aX7Vk1UfH6vuIXGVtyfXi+Oo+M21jf642nfvvdxzy7VRq4EwerXqPvq93tO/xFXGZo6rNoxcdZ69Ce3jGLnSIZwSvCrHkbjSaUJchVOGL6o+NUhcZezs4urYbcs8LuZcdZr5uGLOlRphXtXmPb+f++7Rvetu+eqCW7oiVt3Dr/QHF3FVzMda/5mPK6U/z4irjJ1VXBVzsTgl2HUW4ypciuHubbe+KZ8WXHDrd/eT62liJ67edu9KUG3e9kG17/pH992dN4pPD772yZdq33SF9TlX/Xtf98+BP87EFbroLOLqIJwOnHNre+nl6A57cbXv32yLEQ3Z73BZBpnonFxXDzNxVUVUbVnxKULd87EsxFXTpwXD7S+Xx5+4QhedNq6qESvCKg+cFrzv1uU5aPgkoRZm4qrpcgv+zXdZThkpHr0yEVcidZ2rK6+6d391z63754DTguik08TVrlwji1OBWWFCuxfmXS24O4rn5ZiPq7bLNChhJq6C6ArtR/vFSCUT2tFlJ40rwipPxJUoRq9kVCO9PH8W4qr904LElXpcigFddpK4qk4FElb5sRFXEk9ydfamuCCuVGi9zlURV5wW1KttsrsWxFXGZo6r8vcKLpZXeEdebMTVvrtz1e9n07WswkVEOS2Yv333nj/OqdEpJrTrED4ReDURUAYuwyCIq8wcHMpV2gu7ZVztRrcN1k1ccX13Y87ftuW29+RK7WnxFeDRLWZOC1bXs9q8HeZoFLftu0flL3PmOldKhNErCax7ZUjv+zfk6ja9pwSFiZGr6tOCr/vjWwZW3992Qz4pqPxX3wjiKic+mBYvr7Tw4VTFUVg3+rdcKHQjdZ9RfHKwu0zNuZJPBsoIlt/fAS7FoE7/iX+z9cd5fnCcF9xrn+gOK2HmtGAVU/5/lqrju/jBPfdzA69v4grIBBPabbAUV1aZn9BuAHEFZIK4soG40o+40o+4AjJBXNlAXOlHXOlHXAGZIK5sIK70I670I66ATBBXNhBX+hFX+hFXQCaIKxuIK/2IK/2IKyATxJUNxJV+xJV+xBWQCeLKBuJKP+JKP+IKyARxZQNxpR9xpR9xBWSCuLKBuNKPuNKPuAIyQVzZQFzpR1zpR1wBmSCubCCu9COu9COugEwQVzYQV/oRV/oRV0AmiCsbiCv9iCv9iCsgE8SVDcSVfsSVfsQVkAniygbiSj/iSr+RuAIAAMCZCHHFH/7whz/84Q9/+MOfM/kzN/f/zKA7K9N8938AAAAASUVORK5CYII=\" alt=\"image.png\" data-href=\"\" style=\"\"/>
</p>
<p>
In the following module, the <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">breakPoints 1 is </span>identified by <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">the first column of each page of the table</span>, the <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\"> breakPoints 2 is </span>identifiesd by <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">the first row of each page of the table</span>, and the <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">breakPoints 3 is </span>identifiesd by the <span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">pages of the table, the tableData is identified by the others.</span>
</p>
<p>
<img src=\"data:image/png;base64,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\" alt=\"image.png\" data-href=\"\" style=\"\"/>
</p>
</html>"    ), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
        grid = {2, 2}), graphics = {Rectangle(origin = {0.215072, -0.86029}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {2, 0}, 
        lineColor = {47, 49, 172}, 
        fillColor = {255, 255, 125}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-60, 60}, {60, -60}}), Line(origin = {-18, 0}, 
        points = {{0, 60}, {0, -60}}, 
        color = {161, 159, 189}), Line(origin = {22, 0}, 
        points = {{0, 60}, {0, -60}}, 
        color = {161, 159, 189}), Line(origin = {6, -21}, 
        rotation = 90, 
        points = {{1, 64}, {1, -56}}, 
        color = {161, 159, 189}), Line(origin = {18, 19}, 
        rotation = 90, 
        points = {{1, 76}, {1, -44}}, 
        color = {161, 159, 189}), Text(origin = {3, -132}, 
        lineColor = {0, 0, 0}, 
        extent = {{-150, -20}, {150, 20}}, 
        textString = "%name", 
        textColor = {0, 0, 0}), Rectangle(origin = {2, 0}, 
        lineColor = {47, 49, 172}, 
        extent = {{-60, 60}, {60, -60}})}), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
        grid = {2, 2})));
    end LookupTable3D;
    end NTables;

  package Internal "Internal external object definitions for table functions that should not be directly utilized by the user"
    extends Modelica.Icons.InternalPackage;
    partial block CombiTable2DBase "Base class for variants of table look-up in two dimensions"
      parameter Boolean tableOnFile=false 
        "= true, if table is defined on file or in function usertab" 
        annotation (Dialog(group="Table data definition"));
      parameter Real table[:, :] = fill(0.0, 0, 2) 
        "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0, 0; 0, 1])" 
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
      parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments 
        "Smoothness of table interpolation" 
        annotation (Dialog(group="Table data interpretation"));
      parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints 
        "Extrapolation of data outside the definition range" 
        annotation (Dialog(group="Table data interpretation"));
      parameter Boolean verboseExtrapolation=false 
        "= true, if warning messages are to be printed if table input is outside the definition range" 
        annotation (Dialog(group="Table data interpretation", enable=extrapolation == Modelica.Blocks.Types.Extrapolation.LastTwoPoints or extrapolation == Modelica.Blocks.Types.Extrapolation.HoldLastPoint));
      final parameter Real u_min[2]=getTable2DAbscissaUmin(tableID) 
        "Minimum abscissa value defined in table";
      final parameter Real u_max[2]=getTable2DAbscissaUmax(tableID) 
        "Maximum abscissa value defined in table";
      protected
        parameter Modelica.Blocks.Types.ExternalCombiTable2D tableID= 
          Modelica.Blocks.Types.ExternalCombiTable2D(
            if tableOnFile then tableName else "NoName", 
            if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName", 
            table, 
            smoothness, 
            extrapolation, 
            if tableOnFile then verboseRead else false) "External table object";
      equation
        if tableOnFile then
          assert(tableName <> "NoName", 
            "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0, 
            "tableOnFile = false and parameter table is an empty matrix");
        end if;
      annotation(Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100.0,-100.0},{100.0,100.0}}), 
        graphics={
      Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}), 
      Line(points={{0.0,40.0},{0.0,-40.0}}), 
      Line(points={{-60.0,40.0},{-30.0,20.0}}), 
      Line(points={{-30.0,40.0},{-60.0,20.0}}), 
      Rectangle(origin={2.3077,-0.0}, 
        fillColor={255,215,136}, 
        fillPattern=FillPattern.Solid, 
        extent={{-62.3077,0.0},{-32.3077,20.0}}), 
      Rectangle(origin={2.3077,-0.0}, 
        fillColor={255,215,136}, 
        fillPattern=FillPattern.Solid, 
        extent={{-62.3077,-20.0},{-32.3077,0.0}}), 
      Rectangle(origin={2.3077,-0.0}, 
        fillColor={255,215,136}, 
        fillPattern=FillPattern.Solid, 
        extent={{-62.3077,-40.0},{-32.3077,-20.0}}), 
      Rectangle(fillColor={255,215,136}, 
        fillPattern=FillPattern.Solid, 
        extent={{-30.0,20.0},{0.0,40.0}}), 
      Rectangle(fillColor={255,215,136}, 
        fillPattern=FillPattern.Solid, 
        extent={{0.0,20.0},{30.0,40.0}}), 
      Rectangle(origin={-2.3077,-0.0}, 
        fillColor={255,215,136}, 
        fillPattern=FillPattern.Solid, 
        extent={{32.3077,20.0},{62.3077,40.0}})}));
    end CombiTable2DBase;
    function readTimeTableData "Read table data from text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
      input Boolean forceRead = false 
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      output Real readSuccess "Table read success";
      input Boolean verboseRead = true 
        "= true: Print info message; = false: No info message";
      external"C" readSuccess = ModelicaStandardTables_CombiTimeTable_read(tableID, forceRead, verboseRead) 
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation(__ModelicaAssociation_Impure=true);
    end readTimeTableData;

    pure function getTimeTableValue 
      "Interpolate 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          noDerivative=nextTimeEvent, 
          noDerivative=pre_nextTimeEvent) = getDerTimeTableValue);
    end getTimeTableValue;

    pure function getTimeTableValueNoDer 
      "Interpolate 1-dim. table where first column is time (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableValueNoDer;

    pure function getTimeTableValueNoDer2 
      "Interpolate 1-dim. table where first column is time (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          noDerivative=nextTimeEvent, 
          noDerivative=pre_nextTimeEvent) = getDerTimeTableValueNoDer);
    end getTimeTableValueNoDer2;

    pure function getDerTimeTableValue 
      "Derivative of interpolated 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(
          order=2, 
          noDerivative=nextTimeEvent, 
          noDerivative=pre_nextTimeEvent) = getDer2TimeTableValue);
    end getDerTimeTableValue;

    pure function getDerTimeTableValueNoDer 
      "Derivative of interpolated 1-dim. table where first column is time (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTimeTableValueNoDer;

    pure function getDer2TimeTableValue 
      "Second derivative of interpolated 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Integer icol "Column number";
      input Real timeIn "(Scaled) time value";
      discrete input Real nextTimeEvent "(Scaled) next time event in table";
      discrete input Real pre_nextTimeEvent "Pre-value of (scaled) next time event in table";
      input Real der_timeIn "Derivative of (scaled) time value";
      input Real der2_timeIn "Second derivative of (scaled) time value";
      output Real der2_y "Second derivative of interpolated value";
      external "C" der2_y = ModelicaStandardTables_CombiTimeTable_getDer2Value(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn, der2_timeIn) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2TimeTableValue;

    pure function getTimeTableTmin 
      "Return minimum abscissa value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      output Real timeMin "Minimum abscissa value in table";
      external "C" timeMin = ModelicaStandardTables_CombiTimeTable_minimumTime(tableID) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableTmin;

    pure function getTimeTableTmax 
      "Return maximum abscissa value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      output Real timeMax "Maximum abscissa value in table";
      external "C" timeMax = ModelicaStandardTables_CombiTimeTable_maximumTime(tableID) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTimeTableTmax;
    function readTable1DData "Read table data from text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
      input Boolean forceRead = false 
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      input Boolean verboseRead = true 
        "= true: Print info message; = false: No info message";
      output Real readSuccess "Table read success";
      external"C" readSuccess = ModelicaStandardTables_CombiTable1D_read(tableID, forceRead, verboseRead) 
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation(__ModelicaAssociation_Impure=true);
    end readTable1DData;

    pure function getNextTimeEvent 
      "Return next time event value of 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTimeTable tableID "External table object";
      input Real timeIn "(Scaled) time value";
      output Real nextTimeEvent "(Scaled) next time event in table";
      external "C" nextTimeEvent = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(tableID, timeIn) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getNextTimeEvent;

    pure function getTable1DValue "Interpolate 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable1DValue);
    end getTable1DValue;

    pure function getTable1DValueNoDer 
      "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DValueNoDer;

    pure function getTable1DValueNoDer2 
      "Interpolate 1-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable1DValueNoDer);
    end getTable1DValueNoDer2;

    pure function getDerTable1DValue 
      "Derivative of interpolated 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      input Real der_u "Derivative of abscissa value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(order=2) = getDer2Table1DValue);
    end getDerTable1DValue;

    pure function getDerTable1DValueNoDer 
      "Derivative of interpolated 1-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      input Real der_u "Derivative of abscissa value";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTable1DValueNoDer;

    pure function getDer2Table1DValue 
      "Second derivative of interpolated 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      input Integer icol "Column number";
      input Real u "Abscissa value";
      input Real der_u "Derivative of abscissa value";
      input Real der2_u " Second derivative of abscissa value";
      output Real der2_y "Second derivative of interpolated value";
      external "C" der2_y = ModelicaStandardTables_CombiTable1D_getDer2Value(tableID, icol, u, der_u, der2_u) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2Table1DValue;

    pure function getTable1DAbscissaUmin 
      "Return minimum abscissa value of 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      output Real uMin "Minimum abscissa value in table";
      external "C" uMin = ModelicaStandardTables_CombiTable1D_minimumAbscissa(tableID) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DAbscissaUmin;

    pure function getTable1DAbscissaUmax 
      "Return maximum abscissa value of 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable1D tableID "External table object";
      output Real uMax "Maximum abscissa value in table";
      external "C" uMax = ModelicaStandardTables_CombiTable1D_maximumAbscissa(tableID) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable1DAbscissaUmax;
    function readTable2DData "Read table data from text or MATLAB MAT-file"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
      input Boolean forceRead = false 
        "= true: Force reading of table data; = false: Only read, if not yet read.";
      input Boolean verboseRead = true 
        "= true: Print info message; = false: No info message";
      output Real readSuccess "Table read success";
      external"C" readSuccess = ModelicaStandardTables_CombiTable2D_read(tableID, forceRead, verboseRead) 
        annotation (Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation(__ModelicaAssociation_Impure=true);
    end readTable2DData;

    pure function getTable2DValue "Interpolate 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable2DValue);
    end getTable2DValue;

    pure function getTable2DValueNoDer 
      "Interpolate 2-dim. table defined by matrix (but do not provide a derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DValueNoDer;

    pure function getTable2DValueNoDer2 
      "Interpolate 2-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      output Real y "Interpolated value";
      external "C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative = getDerTable2DValueNoDer);
    end getTable2DValueNoDer2;

    pure function getDerTable2DValue 
      "Derivative of interpolated 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      input Real der_u1 "Derivative of first independent variable";
      input Real der_u2 "Derivative of second independent variable";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
      annotation (derivative(order=2) = getDer2Table2DValue);
    end getDerTable2DValue;

    pure function getDerTable2DValueNoDer 
      "Derivative of interpolated 2-dim. table defined by matrix (but do not provide a second derivative function)"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      input Real der_u1 "Derivative of first independent variable";
      input Real der_u2 "Derivative of second independent variable";
      output Real der_y "Derivative of interpolated value";
      external "C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDerTable2DValueNoDer;

    pure function getDer2Table2DValue 
      "Second derivative of interpolated 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      input Real u1 "Value of first independent variable";
      input Real u2 "Value of second independent variable";
      input Real der_u1 "Derivative of first independent variable";
      input Real der_u2 "Derivative of second independent variable";
      input Real der2_u1 "Second derivative of first independent variable";
      input Real der2_u2 "Second derivative of second independent variable";
      output Real der2_y "Second derivative of interpolated value";
      external "C" der2_y = ModelicaStandardTables_CombiTable2D_getDer2Value(tableID, u1, u2, der_u1, der_u2, der2_u1, der2_u2) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getDer2Table2DValue;

    pure function getTable2DAbscissaUmin 
      "Return minimum abscissa value of 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      output Real uMin[2] "Minimum abscissa value in table";
      external "C" ModelicaStandardTables_CombiTable2D_minimumAbscissa(tableID, uMin) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DAbscissaUmin;

    pure function getTable2DAbscissaUmax 
      "Return maximum abscissa value of 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input Modelica.Blocks.Types.ExternalCombiTable2D tableID "External table object";
      output Real uMax[2] "Maximum abscissa value in table";
      external "C" ModelicaStandardTables_CombiTable2D_maximumAbscissa(tableID, uMax) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end getTable2DAbscissaUmax;
  end Internal;

  annotation (Documentation(info="<html>
<p>This package contains blocks for one- and two-dimensional interpolation in tables.</p>
<h4>Special interest topic: Statically stored tables for real-time simulation targets</h4>
<p>Especially for use on real-time platform targets (e.g., HIL-simulators) with <strong>no file system</strong>, it is possible to statically
store tables using a function &quot;usertab&quot; in a file conventionally named &quot;usertab.c&quot;. This can be more efficient than providing the tables as Modelica parameter arrays.</p>
<p>This is achieved by providing the tables in a specific structure as C-code and compiling that C-code together with the rest of the simulation model into a binary
that can be executed on the target platform. The &quot;Resources/Data/Tables/&quot; subdirectory of the MSL installation directory contains the files
<a href=\"modelica://Modelica/Resources/Data/Tables/usertab.c\">&quot;usertab.c&quot;</a> and <a href=\"modelica://Modelica/Resources/Data/Tables/usertab.h\">&quot;usertab.h&quot;</a>
that can be used as a template for own developments. While &quot;usertab.c&quot; would be typically used unmodified, the
&quot;usertab.h&quot; needs to adapted for the own needs.</p>
<p>In order to work it is necessary that the compiler pulls in the &quot;usertab.c&quot; file. Different Modelica tools might provide different mechanisms to do so.
Please consult the respective documentation/support for your Modelica tool.</p>
<p>A possible (though slightly makeshift) approach is to pull in the required files by utilizing a &quot;dummy&quot;-function that uses the Modelica external function
interface to include the required &quot;usertab.c&quot;. An example how this can be done is given below.</p>
<blockquote><pre>
model ExampleCTable \"Example utilizing the usertab.c interface\"
  extends Modelica.Icons.Example;
  parameter Real dummy(fixed=false) \"Dummy parameter\" annotation(HideResult=true);
  Modelica.Blocks.Tables.CombiTable1Dv table(tableOnFile=true, tableName=\"TestTable_1D_a\")
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
protected
  encapsulated impure function getUsertab \"External dummy function to include \\\"usertab.c\\\"\"
    input Real dummy_u[:];
    output Real dummy_y;
    external \"C\" dummy_y = mydummyfunc(dummy_u);
    annotation(IncludeDirectory=\"modelica://Modelica/Resources/Data/Tables\",
           Include = \"#include \"usertab.c\"
double mydummyfunc(double* dummy_in) {
   return 0;
}
\");
  end getUsertab;
initial equation
  dummy = getUsertab(table.y);
equation
  connect(clock.y, table.u[1]) annotation (Line(points={{-59,10},{-42,10}}, color={0,0,127}));
  annotation (experiment(StartTime=0, StopTime=5), uses(Modelica(version=\"4.0.0\")));
end ExampleCTable;
</pre></blockquote>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={
        Rectangle(
          extent={{-76,-26},{80,-76}}, 
          lineColor={95,95,95}, 
          fillColor={235,235,235}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-76,24},{80,-26}}, 
          lineColor={95,95,95}, 
          fillColor={235,235,235}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-76,74},{80,24}}, 
          lineColor={95,95,95}, 
          fillColor={235,235,235}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-28,74},{-28,-76}}, 
          color={95,95,95}), 
        Line(
          points={{24,74},{24,-76}}, 
          color={95,95,95})}));

  package Utilities 
  "Utility functions that should not be directly utilized by the user"
  annotation(Protection(hideFromBrowser=true ));
    extends Modelica.Icons.UtilitiesPackage;
    function arr2D2vec "Expand the matrix into a vector"
      input Real mat[:,:];
      output Real vec[:];
      protected
        Integer size1 = size(mat, 1);
        Integer size2 = size(mat, 2);
        Integer totalSize;
        Integer index;
      algorithm
        totalSize := size1 * size2;
        vec := zeros(totalSize);
        index := 1;
        for i in 1:size1 loop
          for j in 1:size2 loop
            vec[index] := mat[i,j];
            index := index + 1;
          end for;
        end for;
    end arr2D2vec;
    function arr3D2vec "Expand the 3D-Array into a vector"
      input Real arr[:,:,:];
      output Real vec[:];
      protected
        Integer size1 = size(arr, 1);
        Integer size2 = size(arr, 2);
        Integer size3 = size(arr, 3);
        Integer totalSize;
        Integer index;
      algorithm
        totalSize := size1 * size2 * size3;
        vec := zeros(totalSize);
        index := 1;
        for i in 1:size2 loop
          for j in 1:size3 loop
            for k in 1:size1 loop
              vec[index] := arr[k,i,j];
              index := index + 1;
            end for;
          end for;
        end for;
    end arr3D2vec;
  end Utilities;
  package Types "Library of constants, external objects and types with choices, especially to build menus"
  annotation(Protection(hideFromBrowser=true ));
  extends Modelica.Icons.TypesPackage;

    type InterpolationMethod = enumeration(
      Hold  "Hold the last value", 
      Nearest  "Take the nearest value", 
      Linear  "Linear interpolation", 
      Akima  "Akima spline interpolation", 
      FritschButland  "Fritsch-Butland spline interpolation", 
      Steffen  "Steffen spline interpolation") "Interpolation Method";
    type ExtrapolationMethod = enumeration(
      Hold  "Hold the last value", 
      Linear  "Linear extrapolation", 
      None  "No extrapolation") "Extrapolation Method";
    class ExternalNDTable "External object of NDTable"
      extends ExternalObject;

      function constructor "Initialize table"
        input Integer ndims;
        input Real data[:];
        output Types.ExternalNDTable externalTable;
      external "C" externalTable = ModelicaNDTable_open(
      ndims, data, size(data, 1))annotation (
        Include = "#include <ModelicaNDTable.c>", 
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");

      end constructor;

      function destructor "Close table"
        input Types.ExternalNDTable externalTable;
      external "C" ModelicaNDTable_close(externalTable)annotation (
        Include = "#include <ModelicaNDTable.c>", 
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end destructor;

    end ExternalNDTable;
    class External1DTable "External object of 1DTable"
      extends ExternalObject;

      function constructor "Initialize table"
        input String fileName;
        input Integer tableCol;
        input Integer breakCols[:];
        input Real break1[:];
        input Integer bp_sizes[:];
        input Real table[:];
        output External1DTable externalTable;
      external "C" externalTable = TY_Modelica1DTable(
      fileName, tableCol, breakCols, 
      break1, bp_sizes, 
      table, size(table, 1)) 
      annotation (
        Include = "#include <ModelicaNDTable.c>", 
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");

      end constructor;

      function destructor "Close table"
        input External1DTable externalTable;
      external "C" ModelicaNDTable_close(externalTable)annotation (
        Include = "#include <ModelicaNDTable.c>", 
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end destructor;

    end External1DTable;
    class External2DTable "External object of 2DTable"
      extends ExternalObject;

      function constructor "Initialize table"
        input String fileName;
        input Integer tableCol;
        input Integer breakCols[:];
        input Real break1[:];
        input Real break2[:];
        input Integer bp_sizes[:];
        input Real table[:];
        output External2DTable externalTable;
      external "C" externalTable = TY_Modelica2DTable(
      fileName, tableCol, breakCols, 
      break1, break2, bp_sizes, 
      table, size(table, 1)) 
      annotation (
        Include = "#include <ModelicaNDTable.c>", 
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");

      end constructor;

      function destructor "Close table"
        input External2DTable externalTable;
      external "C" ModelicaNDTable_close(externalTable)annotation (
        Include = "#include <ModelicaNDTable.c>", 
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end destructor;

    end External2DTable;
    class External3DTable "External object of 3DTable"
      extends ExternalObject;

      function constructor "Initialize table"
        input String fileName;
        input Integer tableCol;
        input Integer breakCols[:];
        input Real break1[:];
        input Real break2[:];
        input Real break3[:];
        input Integer bp_sizes[:];
        input Real table[:];
        output External3DTable externalTable;
      external "C" externalTable = TY_Modelica3DTable(
      fileName, tableCol, breakCols, 
      break1, break2, break3, bp_sizes, 
      table, size(table, 1)) 
      annotation (
        Include = "#include <ModelicaNDTable.c>", 
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");

      end constructor;

      function destructor "Close table"
        input External3DTable externalTable;
      external "C" ModelicaNDTable_close(externalTable)annotation (
        Include = "#include <ModelicaNDTable.c>", 
        IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
      end destructor;

    end External3DTable;
    function evaluate "The universal interface to do interpolate"
      input Types.ExternalNDTable table;
      input Real[:] params;
      input Types.InterpolationMethod interpMethod;
      input Types.ExtrapolationMethod extrapMethod;
      output Real value;
    external "C" value = ModelicaNDTable_evaluate(table, size(params, 1), params, interpMethod, extrapMethod)annotation (
      Include = "#include <ModelicaNDTable.c>", 
      IncludeDirectory = "modelica://Modelica/Resources/C-Sources");
    end evaluate;
  end Types;
end Tables;