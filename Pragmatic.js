// Notes on Christophe Porteneuve's _Pragmatic Guide to Javascript_

// 2. Achieving Code Privacy with the Module Pattern
(function() {
  var privateField = 42;

  function innerFunc() {
    notSoPrivate = 43;
    return notSoPrivate;
  }

  alert(privateField);  // -> 42
  innerFunc();
  alert(noSoPrivate);   // -> 43


