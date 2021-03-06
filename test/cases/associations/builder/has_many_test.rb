require 'abstract_unit'

require 'fixtures/person'
require 'fixtures/street_address'

class ActiveResource::Associations::Builder::HasManyTest < ActiveSupport::TestCase
  def setup
    @klass = ActiveResource::Associations::Builder::HasMany
  end

  def test_validations_for_instance
    object = @klass.new(Person, :street_address, {})
    assert_equal({}, object.send(:validate_options))
  end

  def test_instance_build
    object = @klass.new(Person, :street_address, {})
    Person.expects(:defines_has_many_finder_method).with(:street_address, StreetAddress, nil, {})
    assert_kind_of ActiveResource::Reflection::AssociationReflection, object.build
  end

  def test_send_foreign_key
    object = @klass.new(Person, :street_address, {foreign_key: :street})
    Person.expects(:defines_has_many_finder_method).with(:street_address, StreetAddress, :street, {})
    assert_kind_of ActiveResource::Reflection::AssociationReflection, object.build
  end

  def test_send_query_params
    object = @klass.new(Person, :street_address, {foreign_key: :street, query: {city: "Minsk"}})
    Person.expects(:defines_has_many_finder_method).with(:street_address, StreetAddress, :street, {query: {city: "Minsk"}})
    assert_kind_of ActiveResource::Reflection::AssociationReflection, object.build
  end
end
