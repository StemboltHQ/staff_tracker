# README

## Development environment notes:
 - We are using the Figaro gem for keeping our ENV file hidden. There is a file called `/config/application.yml` that is not commited. If you are being unboarded onto this project ask someone who has done previous work for the file.
 - The google API key that we are developing with is configured to accept requests from localhost:3000. If you are using another port for development and attempt to sign in you will get an unauthorized redirect URI error. Use port 3000.
