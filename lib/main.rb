require 'table_print'

# require_relative 'channel'
require_relative 'user'

class Main
  def initialize
    puts "Initializing..."

    @users = User.list
    @channels = []
    @selected = nil

    puts "Loaded info on #{@users.length} users and #{@channels.length} channels"
  end

  def select_user
    puts "Who would you like to select? Can be by name or slack_id."
    input = gets.chomp

    user = @users.find do |user|
      user.name == input || user.slack_id == input
    end

    if user
      @selected = user
    else
      puts "No matching user found."
    end
  end

  def show_details
    unless @selected
      puts "You need to select a user or channel first!"
      return
    end

    puts @selected.details
  end

  def send_message
    unless @selected
      puts "You need to select a user or channel first!"
      return
    end

    puts "I will accept messages until you type 'quit'"

    while true
      print "message to #{@selected.name}"
      message = gets.chomp
      if message == 'quit'
        break
      end

      @selected.send_message(message)
    end
  end

  def run
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
          tp @users, :real_name, :name, :slack_id

        when 'select user'
          select_user

        when 'details'
          show_details

        when 'send message'
          send_message

        else
          puts "You said '#{action}', but I don't understand :("
        end
      rescue Conversation::SlackApiError => error
        puts "Encountered a problem communicating with Slack: '#{error}'"
      end
    end
  end
end

if __FILE__ == $0
  driver = Main.new
  driver.run
end