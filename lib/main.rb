# require_relative 'channel'
require_relative 'user'

def main
  while true
    puts "What would you like to do?"
    action = gets.chomp

    begin
      case action
      when 'quit'
        puts "Thanks for using the slackbot"
        break
      when 'list channels'
        puts "OK, listing channels"
        # Class method, get list of all channels

      when 'select channel'
        # Create new instance of channel and save in state

      when 'list users'
        # Class method, get list of all users
        puts User.list


      when 'select user'
        # Create new instance of user and save in state

      when 'get info'
        # Call instance method on saved thing to get info
        # Memoization? Possibly as an optional.

      when 'send message'
        # Call instance method on saved thing to send message

      else
        puts "You said '#{action}', but I don't understand :("
      end
    rescue Conversation::SlackApiError => error
      puts "Encountered a problem communicating with Slack: '#{error}'"
    end
  end
end

main if __FILE__ == $0