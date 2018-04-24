class BriefingsController < ApplicationController
  require 'open-uri'

  def show
    client = ParliamentLdaClient::Request.new
    response = client.make_request("resources/#{params[:briefing_id]}")
    raw_briefing = (JSON.parse response.body)['result']['primaryTopic']

    Struct.new('Briefing', :title, :library, :summary, :created, :topics)

    topics = raw_briefing.dig('topic').map! { |topic| topic.dig('prefLabel', '_value') }

    @briefing = Struct::Briefing.new(
                  raw_briefing['title'], # title
                  raw_briefing.dig('publisher', 'prefLabel', '_value'), # library
                  raw_briefing.dig('abstract', '_value') || raw_briefing.dig('description')&.first, #summary
                  raw_briefing.dig('created', '_value'), # created
                  topics
                )
  end
end
