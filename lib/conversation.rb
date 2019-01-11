require 'httparty'
require 'dotenv/load'
require 'pry'

class Conversation
  class SlackApiError < StandardError; end
  URL_BASE = 'https://slack.com/api/'
  def self.list_endpoint
    raise NotImplementedError, "TODO: where to find the list for this type of conversation"
  end

  def self.list
    url = self.list_endpoint
    response = get(url)

    binding.pry
  end
  
  def self.get(url, params={})
    # params[:token] = ENV['SLACK_API_TOKEN']
    response = HTTParty.get(url, query: params)

    unless response['ok']
      raise SlackApiError, response['error']
    end

    return response
  end

  def self.check_for_error(response)
    
  end
end