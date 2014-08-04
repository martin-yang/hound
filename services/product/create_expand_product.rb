module Product
  class CreateExpandProduct
    attr_accessor :attribute
    attr_accessor :expand_request

    def initialize(attribute,place_name,expand_request_id)
      attribute["place_id"] = Expand::Place.find_or_create_by(name: place_name,resource_id: attribute[:resource_id]).id
      self.attribute = attribute
      self.expand_request = Merchant::ExpandRequest.find(expand_request_id)
    end

    def execute
      self.expand_request.expand(self.attribute)
    end

  end
end