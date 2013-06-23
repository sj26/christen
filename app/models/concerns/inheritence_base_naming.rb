module InheritenceBaseNaming
  def model_name
    @_model_name ||= super.tap do |name|
      unless self == base_class
        the_base_class = base_class
        %w(param_key singular_route_key route_key).each do |key|
          name.singleton_class.send(:define_method, key) { the_base_class.model_name.public_send(key) }
        end
      end
    end
  end
end
