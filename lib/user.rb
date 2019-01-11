require 'httparty'

require_relative 'conversation'

class User < Conversation
  def self.list_endpoint
    return URL_BASE + 'users.list'
  end
end