# Number Guessing Game

## This project uses Bash and SQL to build a simple guessing game and store the data from the games in a database. It's required to obtain the Relational Database certification from [freeCodeCamp](www.freecodecamp.org/).

**The tasks were:**
- Create a `number_guess` database and configure it
- Create `number_guess.sh` and give it executable permissions
- The script should have a shebang at the top of the file that uses `#!/bin/bash`
- The script should randomly generate a number that users have to guess
- When the script is run it should prompt the user for a username with `Enter your username`, and take a username as input. The database should allow username that are 22 characters.
- If the username has been used before, it should print `Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses.`, with `<username>` being a users name from the database, `<games_played>` being the total number of games that user has played, and `<best_game>` being the fewest number of guesses it took that user to win the game
- If the username has not been used before, it should print `Welcome, <username>! It looks like this is your first time here.`
- The next line printed should be `Guess the secret number between 1 and 1000:` and input from the user should be read
- Until they guess the secred number, it should print `It's lower than that, guess again:` if the guess is higher than the secret number, and `It's higher than that, guess again:` if it's lower
- If anything other than an integer is input as a guess, it should print `That is not an integer, guess again:`
- When the secret number is guessed, the script should print `You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job!` and finish running.
