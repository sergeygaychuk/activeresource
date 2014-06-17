module ActiveResource::Associations::Builder 
  class HasMany < Association
    self.valid_options += [:foreign_key, :query]
    self.macro = :has_many

    def build
      validate_options
      model.create_reflection(self.class.macro, name, options).tap do |reflection|
        model.defines_has_many_finder_method(reflection.name, reflection.klass,
                                             reflection.options.has_key?(:foreign_key) ? reflection.foreign_key : nil,
                                             reflection.options.delete_if { |key, value| :foreign_key == key })
      end
    end
  end
end
