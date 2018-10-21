# frozen_string_literal: true

node :message do
  locals[:exception].message
end

node :raven_id do
  Raven.last_event_id
end
