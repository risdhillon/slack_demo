module.exports = {
  // your community or team name to display on join page.
  community: 'PSCS Test',
  // your slack team url (ex: socketio.slack.com)
  slackUrl: 'https://pscstest.slack.com',
  // access token of slack
  // You can generate it in https://api.slack.com/web#auth
  slacktoken: 'xoxp-205317946199-204410186291-215003837159-83c5a7b0eafd30bd3b986a2702bcddbc',
  // an optional security measure - if it is set, then that token will be required to get invited.
  inviteToken: null,
  locale: process.env.LOCALE || "en",
};
