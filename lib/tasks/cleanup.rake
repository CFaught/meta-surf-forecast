# frozen_string_literal: true
namespace :cleanup do
  desc 'Remove forecasts that are in the past'
  task prune_past_forecasts: :environment do
    Surfline.unscoped.where('timestamp < now()').delete_all
    Msw.unscoped.where('timestamp < now()').delete_all
    Spitcast.unscoped.where('timestamp < now()').delete_all
    ApiRequest.where.not(id: Surfline.unscoped.uniq.pluck(:api_request_id) + Msw.unscoped.uniq.pluck(:api_request_id) + Spitcast.unscoped.uniq.pluck(:api_request_id)).delete_all
    WaterQuality.unscoped.where('timestamp < now()').delete_all
  end
end