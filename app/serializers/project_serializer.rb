class ProjectSerializer
  include JSONAPI::Serializer
  attributes :name, :state, :astimated_cost
  attribute :logo do|object|
    Rails.application.routes.url_helpers.rails_blob_url(object.logo, host: ActiveStorage::Current.url_options[:host]) if object.logo.present?
  end
  attribute :documents do |object|
    if object.documents.attached?
      object.documents.map do |doc|
        Rails.application.routes.url_helpers.rails_blob_url(doc, host: ActiveStorage::Current.url_options[:host])
      end
    end
  end
  
end
