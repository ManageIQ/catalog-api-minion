require "rest-client"
require "catalog/api/minion/base"

module Catalog
  module Api
    class Minion
      class Task < Base
        include Logging

        def base_name
          "Catalog API Task Minion"
        end

        def queue_name
          "platform.topological-inventory.task-output-stream".freeze
        end

        def persist_ref
          ENV["TASK_PERSIST_REF"] || "catalog-api-task-minion".freeze
        end

        private

        def post_internal_notify(payload, payload_params, headers)
          RestClient.post(internal_notify_url(payload['id']), payload_params, headers)
        end

        def internal_notify_url(task_id)
          super("/internal/v1.0/notify/task/#{task_id}")
        end
      end
    end
  end
end
