class ProfileSerializer
  include JSONAPI::Serializer
  attributes :prefix, :first_name, :last_name, :role
  attribute :profile_image do|object|
    Rails.application.routes.url_helpers.rails_blob_url(object.profile_image, host: ActiveStorage::Current.url_options[:host])
  end
end
