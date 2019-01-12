# Notes

## Authorization

As long as the slackbot is limited to one workspace, you don't need oauth. Go through and add permissions first. Required permissions:
- `chat:write:bot`
- `channels:read`
- `users:read`

Once you've added permissions, you can get an oauth token (top of page).

This needs to be stored in a .env, and not committed to git.

## Debugging

Pry is super useful! Drop a `binding.pry`, and make sure:
- You can read `ENV['SLACK_API_TOKEN']`
- You can send a request, and read a response

Getting error handling working up front is going to be super useful - probably via exception handling?
- Define custom exception type
- Check for error response and raise
- Wrap switch in main w/ begin/rescue

## Endpoints

- `chat.postMessage` works for both channels and users
  - https://api.slack.com/methods/chat.postMessage
- `users.list` https://api.slack.com/methods/users.list
- `channels.list` https://api.slack.com/methods/channels.list

## Gems

Table Print (https://github.com/arches/table_print) is a beautiful tool for printing tables of, say, Slack users

## Open Questions

- Debugging tools, particularly visual tool for network activity
- Testing? VCR / mocking?
- How to introduce / order / structure
  - Query vs command
  - Request/response
- Command line options, configuration, ...

## Topics

- What is an API?
  - Show in browser - get JSON
    - Install browser extension
    - Show network tab?
  - POSTman?
  - Reading docs
  - Requests and responses
  - Commands vs queries, safety & idempotency, REST (?)
- Consuming an API
  - HTTParty, the response object
  - Query parameters
  - POSTing data
- Authentication / tokens
  - .gitignore, .env

