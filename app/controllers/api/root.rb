module API
  class Root < Grape::API
    prefix    'api'
    format    :json

    namespace 'v1'do
      mount API::V1::Root
    end

    add_swagger_documentation api_version: "v1", mount_path: "/"

  end
end

