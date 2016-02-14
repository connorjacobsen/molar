require 'molar/version'

# Mixin providing method_missing attribute lookup. Defines appropriate
# getters and setters on the fly so as not to incur method_missing penalty
# on each access.
#
# Example:
#
# class Jedi
#   include Molar
#
#   def initialize(attributes)
#     @attributes = attributes
#   end
# end
#
# jedi = Jedi.new(name: 'Yoda', title: 'Master')
# jedi.name
# # => 'Yoda'
#
# jedi.name = 'Luke'
# jedi.name
# # => 'Luke'
#
# Note:
# Currently, Molar only performs the lookup in @attributes.
module Molar
  def self.included(descendant)
    descendant.class_eval do
      alias_method :__method_missing, :method_missing

      attr_reader :attributes
      private :attributes

      def method_missing(method, *args, &block)
        __attribute?(method) ? __register_and_call(method, *args, &block) : super
      end
    end
  end
  private_class_method :included

  def __attribute?(name)
    attributes.key?(__attr_name(name))
  end
  private :__attribute?

  def __register_and_call(method, *args, &block)
    __register(method)
    send(method, *args, &block)
  end
  private :__register_and_call

  def __register(method)
    attr_name = __attr_name(method)
    __add_methods(attr_name)
  end
  private :__register

  def __add_methods(attribute)
    singleton_class.instance_eval do
      define_method(attribute) { attributes[attribute] }
      define_method("#{attribute}=") { |val| attributes[attribute] = val }
    end
  end
  private :__add_methods

  def __attr_name(attribute)
    str_attr = attribute.to_s

    str_attr.end_with?('=') ? str_attr[0..-2].to_sym : str_attr.to_sym
  end
  private :__attr_name
end
