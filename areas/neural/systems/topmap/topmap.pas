
{=========================================================================
 The following two Turbo Pascal programs were written by Teuvo Kohonen
 from Finland and were distributed at the First International Conference
 on Neural Networks in San Diego, June 1987.
 =========================================================================}

program ToPreM1 (output) ;
{ Demonstration program of Topology Preserving Mappings:
  linear topology, input and weight vectors two-dimensional
  Copyright (c) Teuvo Kohonen, June 1987 }

const
  iMax = 35 ; {number of units minus one in the array}
  jMax = 1 ; {two-dimensional input and weight vectors}
  A0 = 0.3 ; {initializing value for the forgetting constant}
  G = 0.2 ; {adjusting parameter for the width of the initial value for the
            weights}

type
  DensityFunctions = (Square, triangle, cross, lettera, letterk, lettery) ;
  {area options where input vectors will be uniformly distributed}

var
  Tk : integer ; {number of time instances or steps elapsed since the
                 beginning of the process}
  A : real ; {the alpha function a=a(Tk) is A piecewise linearly decreasing
             function of Tk}
  T1 : integer ; {T1 is the end of the initial time interval during which
                 a(Tk) decreases linearly ; thereafter A new greater T1
                 value is set to define the next interval etc.}
  t : integer ; {the number of time instances elapsed since the beginning of
                the interval described above}
  T2 : integer ; {defines the interval for graphic display update, selected
                 small in the beginning but becomes larger in each linear
                 segment}
  A1, A2 : real ; {the forgetting constant A1 keeps track of a(t) in A linear
                  segment, A2 is always 1-A1}
  W0 : 0..iMax ; {initializing value for the kernel width}
  w : 0..iMax ; {defines the topological neighborhood which is selected wide
                in the beginning (with W0) and then it is let to shrink with
                time Tk}
  H1, h, V1, V : 0..iMax ; {indices for the kernel units}
  i : 0..iMax ; j : 0..jMax ; {indices for vectors defined below}
  M : array [0..iMax,0..jMax] of real ; {vector of input weights (memory)}
  X : array [0..jMax] of real ; {vector of input signals}
  N : array [0..iMax] of real ; {0.5*Squared norms of M-vectors used in the
                                short-cut computation of the best-matching
                                unit selection}
  Y : array [0..iMax] of real ; {vector of output signals}
  C : 0..iMax ; {index of best-matching unit}
  MinY : real ; {MinY = y[c]}
  DensityFunction : DensityFunctions ; {input vector density function}

procedure askDensityFunction ; {asks input vector density function}
var d : char ;
begin {ask input vector density function}
  writeln ('Topology Preserving Mappings:') ;
  writeln ('-linear topology') ;
  writeln ('-input and weight vectors two-dimensional') ;
  writeln ;
  writeln ('Select density function') ;
  DensityFunction := Square ;
  writeln ('square  s') ;
  writeln ('triangle  t') ;
  writeln ('cross  c') ;
  writeln ('letter A  a') ;
  writeln ('letter K  k') ;
  write ('letter Y  y:') ;
  readln (d) ;
  writeln ;
  case d of
    's' : DensityFunction := Square ;
    't' : DensityFunction := triangle ;
    'c' : DensityFunction := cross ;
    'a' : DensityFunction := lettera ;
    'k' : DensityFunction := letterk ;
    'y' : DensityFunction := lettery ;
  end ;
end ; {askDensityFunction}

procedure ReadInput ; {reads the vector of input signals}
var
  inside : boolean ;
begin
  repeat {impose uniform density within the framed area}
    inside := false ;
    x[0] := random ;
    x[1] := random ;
    case DensityFunction of
      Square : inside := true ;
      triangle : if x[1] >= 2*abs(x[0] - 0.5) then inside := true ;
      cross : if (abs (x[0] - 0.5) <= 1/4) or (abs (x[1] - 0.5) <= 1/4) then
                inside := true ;
      lettera : if ((x[1] - 5/16 <= 11/4 * abs (x[0] - 0.5)) and
                (x[1] + 3/8 >= 11/4*abs(x[0] - 0.5))) or
                ((x[1] >= 7/16) and (x[1] <= 11/16) and
                (x[1] - 5/16 >= 11/4*abs (x[0] - 0.5))) then inside := true ;
      letterk : if (x[0] <= 2/8) or ((x[0] - 4/8 <= abs (x[1] - 0.5)) and
                (x[1] >= 4/8)) or ((x[1] >= 21/64 - 21/16*abs(x[0]-0.5)))
                then inside := true ;
    end ;
  until inside ;
end ; {ReadInput}

function max (x, Y : integer) : integer ;
begin {returns the maximum of the two integers}
  if X >= Y then max := x
  else max := Y ;
end ; {max}

function min (x, Y : integer) : integer ;
begin {returns the minimum of the two integers}
  if X <= Y then min := x
  else min := Y ;
end ; {min}

procedure DrawDistribution ; {draws the distribution of weight vectors:
                             linear array}
const
  cl = white ;
  xw = 320 ;
  yw = 160 ;
var
  x, y, xo, yo : integer ;

  procedure DrawLine (i : integer) ;
  begin {draw A line connecting two weight vectors}
    xo := X ;
    X := round ((xw div 2) * (m[i,0] + m[i+1,0])) ;
    yo := Y ;
    Y := round ((yw div 2) * (m[i,1] + m[i+1,1])) ;
    draw (xo, yo, x, y, cl) ;
    draw (x-1, y-1, x+1, y-1, cl) ;
    draw (x-1, y, x+1, y, cl) ;
    draw (x-1, y+1, x+1, y+1, cl) ;
  end ; {DrawLine}

begin {DrawDistribution}
  hires ;
{  graphbackground (black) ;  }
  case DensityFunction of {draw the corresponding frame}
    Square : begin
               draw (159, 19, 481, 19, cl) ;
               draw (481, 19, 481, 181, cl) ;
               draw (481, 181, 159, 181, cl) ;
               draw (159, 181, 159, 19, cl) ;
             end ;
    triangle : begin
                 draw (159, 181, 481, 181, cl) ;
                 draw (159, 181, 320, 20, cl) ;
                 draw (481, 181, 320, 20, cl) ;
               end ;
    cross : begin
              draw (159, 80, 280, 80, cl) ;
              draw (280, 80, 280, 19, cl) ;
              draw (280, 19, 360, 19, cl) ;
              draw (360, 19, 360, 80, cl) ;
              draw (360, 80, 481, 80, cl) ;
              draw (481, 80, 481, 120, cl) ;
              draw (481, 120, 360, 120, cl) ;
              draw (360, 120, 360, 181, cl) ;
              draw (360, 181, 280, 181, cl) ;
              draw (280, 181, 280, 120, cl) ;
              draw (280, 120, 159, 120, cl) ;
              draw (159, 120, 159, 80, cl) ;
            end ;
    lettera : begin
                draw (159, 181, 280, 19, cl) ;
                draw (280, 19, 360, 19, cl) ;
                draw (360, 19, 481, 181, cl) ;
                draw (481, 181, 400, 181, cl) ;
                draw (400, 181, 369, 130, cl) ;
                draw (345, 90, 320, 50, cl) ;
                draw (320, 50, 295, 90, cl) ;
                draw (271, 130, 240, 181, cl) ;
                draw (240, 181, 159, 181, cl) ;
                draw (271, 130, 369, 130, cl) ;
                draw (295, 90, 345, 90, cl) ;
              end ;
    letterk : begin
                draw (159, 19, 159, 181, cl) ;
                draw (240, 100, 400, 19, cl) ;
                draw (240, 100, 400, 181, cl) ;
                draw (320, 100, 481, 19, cl) ;
                draw (320, 100, 481, 181, cl) ;
                draw (159, 19, 240, 19, cl) ;
                draw (400, 19, 481, 19, cl) ;
                draw (159, 181, 240, 181, cl) ;
                draw (400, 181, 481, 181, cl) ;
              end ;
    lettery : begin
                draw (159, 19, 280, 100, cl) ;
                draw (280, 100, 280, 181, cl) ;
                draw (280, 181, 360, 181, cl) ;
                draw (360, 181, 360, 100, cl) ;
                draw (360, 100, 481, 19, cl) ;
                draw (481, 19, 400, 19, cl) ;
                draw (400, 19, 320, 75, cl) ;
                draw (320, 75, 240, 19, cl) ;
                draw (240, 19, 159, 19, cl) ;
              end ;
  end ;
  graphwindow (160, 20, 480, 180) ;
  write ('Step ') ;
  write (Tk) ;
  write (' Alpha ') ;
  write (A1:1:3) ;
  X := round (xw * M [0,0]) ;
  Y := round (yw * M [0,1]) ; {initialize coordinates}
  for i := 0 to iMax - 1 do {draw distribution: linear array}
    DrawLine (i) ;
end ; {DrawDistribution}

begin {ToPreM1}
  askDensityFunction ;
  randomize ;
  {initialize forgetting constant, kernel width and step counters}
  A := A0 ;
  A1 := A ;
  W0 := iMax div 4 ;
  T1 := 100 ;
  T2 := 5 ;
  t := 0 ;
  Tk := 0 ;

  {*** initialize the vector of input weights M[i] with random and compute
   0.5 * the Squared norm of M[i] to be used in the computation of the
   best-matching unit selection***}
  for i := 0 to iMax do
    begin
      N [i] := 0 ;
      for j := 0 to jMax do
        begin {adjust the width of the initial values for weights}
          M [i, j] := (0.5 - g/2.0) + g*random ;
          N [i] := N [i] + M [i, j] * M [i, j] ;
        end ;
      N [i] := N [i] / 2.0 ; {N is 0.5 * Squared norm of M}
    end ; {memory vector initialization}

  DrawDistribution ; {draw the initial distribution of weight vectors}
  repeat
    for t := 1 to T1 do
      begin
        Tk := Tk + 1 ;
        ReadInput ;

        {*** the best-matching unit selection ***}
        MinY := N [0] ; {initializing value for the best-matching unit}
        for i := 0 to iMax do
          begin {use Euclidean distance}
            Y [i] := N [i] ;
            for j := 0 to jMax do
              Y [i] := Y [i] - M [i, j] * X [j] ;
            if Y [i] <= MinY then
              begin {update best-matching unit and index}
                MinY := Y [i] ;
                C := i ;
              end ;
          end ; {best-matching unit selection}

        A1 := A * (1 - t/T1) ;
        A2 := 1 - A1 ;
        w := trunc (W0 * (1 - t/T1)) + 1 ; {update kernel width}

        {*** update the vector of input weights M [i] inside the kernel =
         LEARNING and compute 0.5 * the Squared norm of M [i] for the best
         matching unit selection ***}
        for i := max (0, c-w) to min (iMax, c+w) do
          begin
            N [i] := 0 ;
            for j := 0 to jMax do
              begin
                M [i, j] := A1 * X [j] + A2 * M [i, j] ;
                N [i] := N [i] + M [i, j] * M [i, j] ;
              end ;
            N [i] := N [i] / 2.0 ; {N is 0.5 * the Squared norm of M}
          end ; {memory vector update}

        if t mod T2 = 0 then DrawDistribution ;
      end ;
    A := 0.2 * A ;
    W0 := 0 ;
    T1 := 5 * T1 ;
    T2 := 4 * T2 ; {values for the next linear segment}
  until A = 0 ; { the process ends with A = 0}
end.

{================== CUT HERE TO SEPARATE THE TWO PROGRAMS ================}

program ToPreM2 (output) ;
{ Demonstration program of Topology Preserving Mappings:
  array topology two-dimensional, input and weight vectors two-dimensional
  Copyright (c) Teuvo Kohonen, June 1987 }

const
  iMax = 63 ; {number of units minus one in the array}
  jMax = 1 ; {two-dimensional input and weight vectors}
  side = 8 ; {side of array is square of iMax + 1}
  A0 = 0.3 ; {initializing value for the forgetting constant}
  G = 0.2 ; {adjusting parameter for the width of the initial value for the
            weights}

type
  DensityFunctions = (Square, triangle, cross) ;
  {area options where input vectors will be uniformly distributed}

var
  Tk : integer ; {number of time instances or steps elapsed since the
                 beginning of the process}
  A : real ; {the alpha function a=a(Tk) is A piecewise linearly decreasing
             function of Tk}
  T1 : integer ; {T1 is the end of the initial time interval during which
                 a(Tk) decreases linearly ; thereafter A new greater T1
                 value is set to define the next interval etc.}
  t : integer ; {the number of time instances elapsed since the beginning of
                the interval described above}
  T2 : integer ; {defines the interval for graphic display update, selected
                 small in the beginning but becomes larger in each linear
                 segment}
  A1, A2 : real ; {the forgetting constant A1 keeps track of a(t) in A linear
                  segment, A2 is always 1-A1}
  W0 : 0..side ; {initializing value for the kernel width}
  w : 0..side ; {defines the topological neighborhood which is selected wide
                in the beginning (with W0) and then it is let to shrink with
                time Tk}
  H1, h, V1, V : 0..side ; {indices for the kernel units}
  i : 0..iMax ; j : 0..jMax ; {indices for vectors defined below}
  M : array [0..iMax,0..jMax] of real ; {vector of input weights (memory)}
  X : array [0..jMax] of real ; {vector of input signals}
  N : array [0..iMax] of real ; {0.5*Squared norms of M-vectors used in the
                                short-cut computation of the best-matching
                                unit selection}
  Y : array [0..iMax] of real ; {vector of output signals}
  C : 0..iMax ; {index of best-matching unit}
  MinY : real ; {MinY = y[c]}
  DensityFunction : DensityFunctions ; {input vector density function}

procedure askDensityFunction ; {asks input vector density function}
var d : char ;
begin {ask input vector density function}
  writeln ('Topology Preserving Mappings:') ;
  writeln ('-array topology two-dimensional') ;
  writeln ('-input and weight vectors two-dimensional') ;
  writeln ;
  writeln ('Select density function') ;
  DensityFunction := Square ;
  writeln ('square   s') ;
  writeln ('triangle   t') ;
  write ('cross   c') ;
  readln (d) ;
  writeln ;
  case d of
    's' : DensityFunction := Square ;
    't' : DensityFunction := triangle ;
    'c' : DensityFunction := cross ;
  end ;
end ; {askDensityFunction}

procedure ReadInput ; {reads the vector of input signals}
var
  inside : boolean ;
begin
  repeat {impose uniform density within the framed area}
    inside := false ;
    x [0] := random ;
    x [1] := random ;
    case DensityFunction of
      Square : inside := true ;
      triangle : if x[1] >= 2*abs(x[0] - 0.5) then inside := true ;
      cross : if (abs (x[0] - 0.5) <= 1/4) or (abs (x[1] - 0.5) <= 1/4) then
                inside := true ;
    end ;
  until inside ;
end ; {ReadInput}

function max (x, Y : integer) : integer ;
begin {returns the maximum of the two integers}
  if X >= Y then max := x
  else max := Y ;
end ; {max}

function min (x, Y : integer) : integer ;
begin {returns the minimum of the two integers}
  if X <= Y then min := x
  else min := Y ;
end ; {min}

procedure DrawDistribution ; {draws the distribution of weight vectors:
                             linear array}
const
  cl = white ;
  xw = 320 ;
  yw = 160 ;
var
  x1, x2, y1, y2 : integer ;

  procedure DrawLine (var x, y : integer ;
                      i, e : integer) ;

  var xo, yo : integer;

  begin {draw A line connecting two weight vectors}
    xo := X ;
    X := round ((xw div 2) * (m[i,0] + m[i+e,0])) ;
    yo := Y ;
    Y := round ((yw div 2) * (m[i,1] + m[i+e,1])) ;
    draw (xo, yo, x, y, cl) ;
  end ; {DrawLine}

begin {DrawDistribution}
  hires ;
{  graphbackground (black) ;  }
  case DensityFunction of {draw the corresponding frame}
    Square : begin
               draw (159, 19, 481, 19, cl) ;
               draw (481, 19, 481, 181, cl) ;
               draw (481, 181, 159, 181, cl) ;
               draw (159, 181, 159, 19, cl) ;
             end ;
    triangle : begin
                 draw (159, 181, 481, 181, cl) ;
                 draw (159, 181, 320, 20, cl) ;
                 draw (481, 181, 320, 20, cl) ;
               end ;
    cross : begin
              draw (159, 95, 310, 19, cl) ;
              draw (310, 95, 310, 19, cl) ;
              draw (310, 19, 330, 19, cl) ;
              draw (330, 19, 330, 95, cl) ;
              draw (330, 95, 481, 95, cl) ;
              draw (481, 95, 481, 105, cl) ;
              draw (481, 105, 330, 105, cl) ;
              draw (330, 105, 330, 181, cl) ;
              draw (330, 181, 310, 181, cl) ;
              draw (310, 181, 310, 105, cl) ;
              draw (310, 105, 159, 105, cl) ;
              draw (159, 105, 159, 95, cl) ;
            end ;
  end ;
  graphwindow (160, 20, 480, 180) ;
  write ('Step ') ;
  write (Tk) ;
  write (' Alpha ') ;
  write (A1:1:3) ;
  for h := 0 to side-1 do
    begin {horizontal}
      X1 := round (xw * M [h,0]) ;
      Y1 := round (yw * M [h,1]) ; {initialize coordinates}
      X2 := round (xw * M [side * H,0]) ;
      Y2 := round (yw * M [side * H,1]) ;
      drawline (x1, y1, h, side) ;
      drawline (x2, y2, side * h, 1) ;
      for V := 1 to side-2 do
        begin {vertical}
          drawline (x1, y1, side * v + h,0) ;
          drawline (x1, y1, side * v + h,side) ;
          drawline (x2, y2, side * h + v,0) ;
          drawline (x2, y2, side * h + v,1) ;
        end ;
      drawline (x1, y1, side * (side-1) + h,0) ;
      drawline (x2, y2, side * h + side - 1,0) ;
    end ;
end ; {DrawDistribution}

begin {ToPreM1}
  askDensityFunction ;
  randomize ;
  {initialize forgetting constant, kernel width and step counters}
  A := A0 ;
  A1 := A ;
  W0 := side div 2 ;
  T1 := 1000 ;
  T2 := 10 ;
  t := 0 ;
  Tk := 0 ;

  {*** initialize the vector of input weights M[i] with random and compute
   0.5 * the Squared norm of M[i] to be used in the computation of the
   best-matching unit selection***}
  for i := 0 to iMax do
    begin
      N [i] := 0 ;
      for j := 0 to jMax do
        begin {adjust the width of the initial values for weights}
          M [i, j] := (0.5 - g/2.0) + g*random ;
          N [i] := N [i] + M [i, j] * M [i, j] ;
        end ;
      N [i] := N [i] / 2.0 ; {N is 0.5 * Squared norm of M}
    end ; {memory vector initialization}

  DrawDistribution ; {draw the initial distribution of weight vectors}
  repeat
    for t := 1 to T1 do
      begin
        Tk := Tk + 1 ;
        ReadInput ;

        {*** the best-matching unit selection ***}
        MinY := N [0] ; {initializing value for the best-matching unit}
        for i := 0 to iMax do
          begin {use Euclidean distance}
            Y [i] := N [i] ;
            for j := 0 to jMax do
              Y [i] := Y [i] - M [i, j] * X [j] ;
            if Y [i] <= MinY then
              begin {update best-matching unit and index}
                MinY := Y [i] ;
                C := i ;
              end ;
          end ; {best-matching unit selection}

        A1 := A * (1 - t/T1) ;
        A2 := 1 - A1 ;
        H1 := C mod side ;
        V1 := C div side ;
        w := trunc (W0 * (1 - t/T1)) + 1 ; {update kernel width}

        {*** update the vector of input weights M [i] inside the kernel =
         LEARNING and compute 0.5 * the Squared norm of M [i] for the best
         matching unit selection ***}
        for h := max (0,h1-w) to min (side-1,h1+w) do
          for V := max (0,V1-W) to min (side-1,V1+W) do
            begin
              i := side * V + H ;
              N [i] := 0 ;
              for j := 0 to jMax do
                begin
                  M [i,j] := A1 * X [j] + A2 * M [i,j] ;
                  N [i] := N [i] + M [i,j] * M [i,j] ;
                end ;
              N [i] := N [i] / 2.0 ; {N is 0.5 * the squared norm of M}
            end ; {memory vector update}

        if t mod T2 = 0 then DrawDistribution ;
      end ;
    A := 0.2 * A ;
    W0 := 0 ;
    T1 := 5 * T1 ;
    T2 := 5 * T2 ; {values for the next linear segment}
  until A = 0 ; { the process ends with A = 0}
end.

