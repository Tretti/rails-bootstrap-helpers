#
class AbstractError < Exception; end

# Class method that marks one or several methods as abstract, or a whole
# class. If an abstract method is called an AbstractError will be thrown.
#
# Note: when making a whole class abstract the call to "abstract" must come
# after any constructors.
#
# ==== Parameters
# @param args [Array<String, Symbol>] A list of methods that should be abstract.
#        If the list is empty the class that called the method will be made
#        abstract instead.
#
# ==== Examples
#
#   class Foo
#     abstract
#   end
#
#   class Bar < Foo
#   end
#
#   Foo.new
#   # => AbstractError: Cannot instantiate abstract class Foo.
#
#   Bar.new
#   # => #<Bar:0x100123a30>
#
#   class Base
#     abstract :foo
#   end
#
#   class Sub < Base
#   end
#
#   class Foo < Base
#     def foo
#       3
#     end
#   end
#
#   Sub.new.foo
#   # => AbstractError: Unimplemented abstract method foo.
#
#   Foo.new.foo
#   # => 3
def abstract(*args)
  if args.length == 0
    class_eval do
      alias __abstract_initialize__ initialize

      def initialize (*params, &block)
        raise AbstractError.new("Cannot instantiate abstract class #{self.class.name}.")
      end

      def self.inherited (subclass)
        subclass.send(:define_method, :initialize) do |*args|
          __abstract_initialize__ *args
        end
      end
    end
  else
    class_eval do
      args.each do |name|
        define_method name do |*params, &block|
          raise AbstractError.new("Unimplemented abstract method #{name}.")
        end
      end
    end
  end
end