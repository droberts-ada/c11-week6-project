require 'httparty'

require_relative 'conversation'

class User < Conversation
  attr_reader :real_name, :status_text, :status_emoji
  
  def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    return "User #{@real_name} (@#{@name}) - #{@slack_id}\n#{status_text}"
  end
  
  def self.list_endpoint
    return URL_BASE + 'users.list'
  end

  def self.list
    list_endpoint = URL_BASE + 'users.list'
    
    response = get(list_endpoint)
    
    return response["members"].map do |m|
      from_api_response(m)
    end
  end

  def self.from_api_response(response)
    return self.new(
      slack_id: response['id'],
      name: response['name'],
      real_name: response['real_name'],
      status_text: response['profile']['status_text'],
      status_emoji: response['profile']['status_emoji']
      )
  end
end