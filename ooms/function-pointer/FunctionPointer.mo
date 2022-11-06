model FunctionPointer

function AddInt
  input Integer i;
  output Integer out;
algorithm
  out := i+1;
end AddInt;

function ApplyIntOp

  input FuncIntToInt inFunc;
  input Integer i;
  output Integer outInt;

  partial function FuncIntToInt
    input Integer in1;
    output Integer out1;
  end FuncIntToInt;

algorithm
  outInt := inFunc(i);
end ApplyIntOp;

Integer i1;
Integer i2;
equation
  i1 = AddInt(17);
  i2 = ApplyIntOp(AddInt,i1);
end FunctionPointer;
