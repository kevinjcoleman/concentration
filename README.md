# Concentration Game

>[Concentration]( https://en.wikipedia.org/wiki/Concentration_(game)), also known as Match Match, Memory, or Pairs, is a card game in which all of the cards are laid face down on a surface and two cards are flipped face up over each turn, the object of the game is to turn over pairs of matching cards.

At the beginning of the game, there are some number of cards on the board that are all face
down, i.e., their symbol is not visible and all the cards look exactly the same.

In a turn:

   - The player turns over one card. The card's symbol is now visible.
   - The player turns over a second card. This card's symbol is now visible.
   - If the two cards' symbols match, the cards remain face up.
   - If the two card's symbols do not match, the player is given some time to observe
them, then they are flipped back over face down.

This test app is a Ruby on Rails application that is hosted on Heroku. It uses `devise` for user authentication and Bootstrap, with [Bootswatch](https://bootswatch.com/) styling for the design. The live updating features of the game board are created using `react.js`, with help from the `react-rails` gem, using ES6 conventions and the Rails app's API. In order to make testing the react components possible, I eschewed the traditional setup for that gem and used `browserify-rails` to load my javascript modules. The Rails specs use `RSPEC` as well as `machinist` for fixtures, and `shoulda-matchers` for easier model/controller testing. For the `react.js` components I used the Facebook's `Jest` testing framework, with Airbnb's `enzyme`'s rendering capabilities. 
