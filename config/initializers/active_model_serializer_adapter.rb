class JsonApiDasherized < ActiveModel::Serializer::Adapter::JsonApi
  def resource_identifier_for(serializer)
    type = resource_identifier_type_for(serializer)
    id   = resource_identifier_id_for(serializer)

    { id: id.to_s, type: type.underscore.dasherize }
  end

  def resource_object_for(serializer, options = {})
    options[:fields] = @fieldset && @fieldset.fields_for(serializer)

    cache_check(serializer) do
      result = resource_identifier_for(serializer)
      attributes = serializer.attributes(options).except(:id)

      if attributes.any?
        attributes = attributes.each_with_object({}) do |(name, value), hash|
          hash[name.to_s.downcase.dasherize.to_sym] = value
        end

        result[:attributes] = attributes
      end

      result
    end
  end

  def relationships_for(serializer)
    Hash[
      serializer.associations.map do |association|
        [association.key.to_s.downcase.dasherize.to_sym, {
          data: relationship_value_for(association.serializer, association.options)
        }]
      end
    ]
  end
end

ActiveModelSerializers::Adapter.register(:json_api_dasherized, JsonApiDasherized)
ActiveModel::Serializer.config.adapter = :json_api_dasherized
