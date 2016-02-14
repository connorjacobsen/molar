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
        action = __attribute?(method) ? :__register : :__method_missing
        send(action, method, *args, &block)
      end
    end
  end
  private_class_method :included

  def __register(method, *args)
    if __setter?(method)
      attr = __attr_name(method)
      __add_setter(attr)
      send(method, *args)
    else
      __add_getter(method)
      send(method)
    end
  end
  private :__register

  def __attribute?(name)
    attributes.key?(__attr_name(name))
  end
  private :__attribute?

  def __setter?(method)
    __attribute?(method) && method.to_s.end_with?('=')
  end
  private :__setter?

  def __attribute(attribute)
    attributes[attribute]
  end
  private :__attribute

  def __add_getter(attribute)
    singleton_class.instance_eval do
      define_method(attribute) { __attribute(attribute) }
    end
  end
  private :__add_getter

  def __add_setter(attribute)
    singleton_class.instance_eval do
      define_method("#{attribute}=") do |value|
        attributes[attribute] = value
      end
    end
  end
  private :__add_setter

  def __attr_name(attribute)
    str_attr = attribute.to_s

    str_attr.end_with?('=') ? str_attr[0..-2].to_sym : str_attr.to_sym
  end
  private :__attr_name
end
