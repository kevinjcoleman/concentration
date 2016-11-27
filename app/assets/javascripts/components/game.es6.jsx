class Game extends React.Component {
  constructor(props) {
    super(props);
    this.loadCardsFromServer = this.loadCardsFromServer.bind(this);
    this.reloadCardsFromServer = this.reloadCardsFromServer.bind(this);
    this.handleClick = this.handleClick.bind(this);
    this.state = { id: this.props.id,
                   cards: [],
                   picks: [],
                   message: {content: '', className: ''}, 
                   game: {}};
  }

  //When the component mounts load the data from the server and then poll it if conditions are met.
  componentDidMount() {
    this.loadCardsFromServer();
    setInterval(this.reloadCardsFromServer, 1500);
  }

  //Reload data from the server if the turn is over & there aren't any picks,
  //which means that the cards that were wrongly chosen have been flipped back over.
  reloadCardsFromServer() {
    if (this.state.picks.length == 0 && !this.state.game.isTurn && !this.state.game.isCompleted) {
      this.loadCardsFromServer();
    }
  }

  //Load data from the server.
  loadCardsFromServer() {
    console.log("Loading cards from server.");
    $.ajax({
      url: "/games/"+this.props.id +"/cards",
      dataType: 'json',

      success: function (results) {
        this.setState({cards: results.cards, game: results.game, picks: []});
        if (results.game.isCompleted) {
          this.setState({message: {content: "Game over!", className: 'success'}});         
        }
        else if (results.game.isTurn) {
          this.setState({message: {content: "It's your turn!", className: 'info'}});         
        }
      }.bind(this),

      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  //Post pick to server.
  postPick(pick='') {
    var pickData= {'pick':pick}
    $.ajax({
      url: "/games/"+this.props.id +"/pick",
      data:pickData,
      type:'POST',
      success: function(data) {
        console.log('Successfully logged pick.');
      }
    });    
  }

  //Cover all cards that haven't been guessed over after a non-matching pick.
  coverCards(){
    for (var i = 0; i < this.state.cards.length; i++) {
      this.state.cards[i].isFlipped = false;
    }
    this.setState({cards: this.state.cards})
  }

  //Flip over the card that has been picked.
  flipCard(pick){
    this.state.cards.filter(function(card) {
      if (pick.id == card.id){
        card.isFlipped = true;
      }
    })
    this.setState({cards: this.state.cards});    
  }

  //Define sleep function to keep cards flipped after an incorrect guess.
  sleep(time) {
    return new Promise((resolve) => setTimeout(resolve, time));
  }

  //End the turn for the current player
  endTurn() {
    this.postPick();
    game = this.state.game;
    game.isTurn = false;
    game.currentPlayerPicks = game.currentPlayerPicks + 1;
    this.setState({game: game,
                   message: {content: 'Your turn is over!',
                                className: 'warning'}});
  }

  //Log the bad pick and cover all of the cards that haven't been guessed. 
  logBadPicks() {
    console.log('No matches :(');
    this.setState({picks: []});
    this.coverCards();
  }

  //Count of cards that have been guessed.
  guessedCount() {
    return this.state.cards.filter(function(obj){ if (obj.isGuessed) { return obj; }}).length;
  }

  //Calculate winner for current player.
  completeGame(game) {
    game.isCompleted = true;
    if (game.currentPlayerPicks > 6){
      game.isWinner = "winner";
    } else if (game.currentPlayerPicks < 6){
      game.isWinner = "loser";
    } else if (game.currentPlayerPicks == 6){
      game.isWinner = "tied";
    }
  }

  //Log a correct answer. 
  logCorrectPicks(pick) {
    var playerID = this.state.game.currentPlayerId;
    this.state.cards.filter(function(card) {
      if (pick.name == card.name){
        card.isGuessed = playerID;
        card.pickedByCurrentPlayer = true;
      }
    })
    this.postPick(pick.name); 
    game = this.state.game;
    game.currentPlayerScore = game.currentPlayerScore + 1;
    game.currentPlayerPicks = game.currentPlayerPicks + 1;
    if (this.guessedCount() == 24) {
      this.completeGame(game)
    } 
    normalizedPick = pick.name.replace("_", " ");
    this.setState({game: game,
                   cards: this.state.cards,
                   picks: [],
                   message: {content: 'We\'ve got a match for ' + normalizedPick + '! Please select again.', className: 'success'}}); 
  } 

  //Raise error on two picks on the same card.
  raiseError() {
    this.endTurn();
    this.setState({message: {content: 'You cannot pick the same card twice!', className: 'danger'}});
    this.coverCards();
  }

  //Handle a pick of a child component card.
  handleClick(pick) {
    //Flip the card that was picked.
    this.flipCard(pick);
    //If there's been two picks and the picks names match.
    if (this.state.picks.length != 0 && this.state.picks[0].name == pick.name) {
      if (this.state.picks[0] != pick) {
        //Log a correct pick if the picks aren't the same card.
        this.logCorrectPicks(pick);
      } else {
        //Otherwise raise an error.
        this.raiseError();
      }
    //If there's been two picks and the names didn't match.
    } else if (this.state.picks.length == 1) {
      //End the turn so the player can't flip more cards over.
      this.endTurn();
      //Show the mismatched cards for two seconds and then flip them over.
      this.sleep(2000).then (() => {
        this.logBadPicks()
      }
    //Store the initial pick in an array to compare it to the next pick.
    )} else {
      this.setState({picks: [pick]});
    }
  }

  render() {
    //Render nothing if the game hasn't been loaded yet.
    if (Object.keys(this.state.game).length == 0){
      return null;
    //Otherwise render the game.
    } else {
      return (
        <div>
          <Header game={this.state.game} />
          <ScoreProgress game={this.state.game} />
          <Message message={this.state.message} />
          <GameBoard cards={this.state.cards} handleClick={this.handleClick} isTurn={this.state.game.isTurn} />
        </div>
      );
    }
  }
}