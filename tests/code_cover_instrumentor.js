// this object counts the number of times each
// function and each statement is executed
const c = (window.__coverage__ = {
    // "f" counts the number of times each function is called
    // we only have a single function in the source code
    // thus it starts with [0]
    f: [0],
    // "s" counts the number of times each statement is called
    // we have 3 statements and they all start with 0
    s: [0, 0, 0],
  })
  
  // the original code + increment statements
  // uses "c" alias to "window.__coverage__" object
  // the first statement defines the function,
  // let's increment it
  c.s[0]++
  function add(a, b) {
    // function is called and then the 2nd statement
    c.f[0]++
    c.s[1]++
  
    return a + b
  }
  // 3rd statement is about to be called
  c.s[2]++