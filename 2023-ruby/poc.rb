#!/usr/bin/env ruby


# case #1
m = ["a", "b", "c"]
pp r = m.map { |i|
  2 + 2     # this basically ignored
  i + i
}.map { |j|
  j.upcase
}

# case #2
m = ["a", "b", "c"]
pp r = m.each { |i|
  i + i     # this is just a local env

}

# case #3
m = ["a", "b", "c"]
pp r = m.each { |i|
  i = "d"   # this creates local env
}

# case #4
m = ["a", "b", "c"]
pp r = m.each { |i|
  i.upcase! # i is a reference to a real array element
}

# case #5
m = ["a", "b", "c"]
pp r = m.select { |i|
  i == "b"  # this returns new array, just like map
}

pp "------------------------------------------------------"

# case #1
m = ["a", "b", "c"]
def foobar(m)
  m.each { |i|
    i.upcase!
  }
end
a = m.dup
foobar(a)
pp m

# case #2  - shalow copy
a = [1,2]
b = a.dup
a << 3
puts b.inspect

a = [ [1,2] ]
b = a.dup
a[0] << 3
puts b.inspect

a = [ [1,2] ]
b = a.map {|x| p x; x.dup}
a[0] << 3
puts b.inspect

pp "------------------------------------------------------"

a = [1, 2, 3]
def foo(a)
  pp a.select {|i| i == 2}
end

pp foo(a)
