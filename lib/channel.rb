require_relative 'conversation'

class Channel < Conversation
  attr_reader :topic, :purpose, :member_count, :is_private, :is_archived

  def initialize(slack_id:, name:, topic:, purpose:, member_count:, is_private:, is_archived:)
    super(slack_id, name)
    @topic = topic
    @purpose = purpose
    @member_count = member_count
    @is_private = is_private
    @is_archived = is_archived
  end

  def details
    return "Channel \##{name} - #{slack_id} - #{topic}\n#{purpose}\n#{member_count} members"
  end

  def self.list
    list_endpoint = URL_BASE + 'channels.list'
    
    response = get(list_endpoint)
    
    return response["channels"].map do |m|
      from_api_response(m)
    end
  end

  def self.from_api_response(response)
    return self.new(
      slack_id: response['id'],
      name: response['name'],
      topic: response['topic']['value'],
      purpose: response['topic']['value'],
      member_count: response['members'].length,
      is_private: response['is_private'],
      is_archived: response['is_archived']
    )
  end
end