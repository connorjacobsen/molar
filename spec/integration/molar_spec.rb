require 'spec_helper'

class Jedi
  include Molar

  def initialize(attributes = {})
    @attributes = attributes
  end
end

RSpec.describe Molar do
  subject { Jedi.new(first_name: 'Luke', last_name: 'Skywalker') }

  its(:first_name) { should eql 'Luke' }
  its(:last_name) { should eql 'Skywalker' }

  it do
    expect { subject.foo }.to raise_error(NoMethodError)
  end

  it '#first_name=' do
    subject.first_name = 'Anakin'
    puts subject.instance_variable_get(:@attributes).inspect
    expect(subject.first_name).to eql 'Anakin'
  end
end
