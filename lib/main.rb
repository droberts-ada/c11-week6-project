require 'table_print'

require_relative 'channel'
require_relative 'user'

class Main
  def initialize
    puts "Initializing..."

    @users = User.list
    @channels = Channel.list
    @selected = nil

    puts "Loaded info on #{@users.length} users and #{@channels.length} channels"
  end

  def select_channel
    puts "Which channel would you like to select? Can be by name or slack_id."
    input = gets.chomp

    select_target(input, @channels)
  end

  def select_user
    puts "Who would you like to select? Can be by name or slack_id."
    input = gets.chomp

    select_target(input, @users)
  end

  def select_target(input, targets)
    target = targets.find do |target|
      target.name == input || target.slack_id == input
    end

    if target
      @selected = target
    else
      puts "No matches found."
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
      print "message to #{@selected.name}> "
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
          tp @channels, :name, :topic, :member_count

        when 'select channel'
          select_channel

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