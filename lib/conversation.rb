require 'httparty'
require 'dotenv/load'
require 'pry'

# TODO is Conversation the right name for this thing?
class Conversation
  class SlackApiError < StandardError; end
  URL_BASE = 'https://slack.com/api/'

  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    url = URL_BASE + 'chat.postMessage'
    params = {
      token: ENV['SLACK_API_TOKEN'],
      channel: @slack_id,
      text: message 
    }

    response = HTTParty.post(url, query: params)

    unless response['ok']
      raise SlackApiError, response['error']
    end
  end
  
  def self.get(url, params={})
    params[:token] = ENV['SLACK_API_TOKEN']
    response = HTTParty.get(url, query: params)
    
    unless response['ok']
      raise SlackApiError, response['error']
    end
    
    return response
  end
  
  def self.from_api_response(response)
    raise NotImplementedError, "TODO: implement me in a child class"
  end

  def details
    raise NotImplementedError, "TODO: implement me in a child class"
  end
end