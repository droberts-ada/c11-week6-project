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