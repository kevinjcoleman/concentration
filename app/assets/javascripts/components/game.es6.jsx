class Game extends React.Component {
  constructor(props) {
    super(props);
    this.loadCardsFromServer = this.loadCardsFromServer.bind(this);
    this.handleClick = this.handleClick.bind(this);
    this.state = { id: this.props.id,
                   current_player: {},
                   opponent: {},
                   cards: [],
                   picks: [],
                   message: {
                    content: '',
                    className: ''
                   }};
  }

  componentDidMount() {
    this.loadCardsFromServer();
    setInterval(this.loadCardsFromServer, 3000);
  }

  loadCardsFromServer() {
    console.log("Loading cards from server.");
    $.ajax({
      url: "/games/"+this.props.id +"/cards",
      dataType: 'json',

      success: function (results) {
        this.setState({cards: results.cards,
                       opponent: results.opponent,
                       current_player: results.current_player});
      }.bind(this),

      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  //Flip cards over after a non-matching pick.
  flipCards(){
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

  //Definitely sleep function
  sleep(time) {
    return new Promise((resolve) => setTimeout(resolve, time));
  }

  //Log bad pick and flip over cards that haven't been guessed.
  logBadPicks() {
    console.log('No matches :(');
    this.setState({picks: []});
    this.flipCards();
  }

  //Log correct answer
  logCorrectPicks(pick) {
    var playerID = this.state.current_player.id;
    this.state.cards.filter(function(card) {
      if (pick.name == card.name){
        card.isGuessed = playerID;
      }
    })   
    this.setState({cards: this.state.cards,
                   picks: [],
                   message: {content: 'We\'ve got a match for ' + pick.name + '! Please select again.',
                   className: 'success'}});   
  } 

  //Raise error on two picks on the same card.
  raiseError() {
    this.setState({message: {content: 'You cannot pick the same card twice!',
                                className: 'danger'}});
    this.flipCards();
  }

  //Handle a pick of a child component card.
  handleClick(pick) {
    this.flipCard(pick);
    if (this.state.picks.length != 0 && this.state.picks[0].name == pick.name) {
      if (this.state.picks[0] != pick) {
        this.logCorrectPicks(pick);
      } else {
        this.raiseError();
      }
    } else if (this.state.picks.length == 1) {
      this.sleep(2000).then (() => {
        this.logBadPicks()
      }
    )} else {
      this.setState({picks: [pick]});
    }
  }

  render() {
    return (
      <div>
        <Header opponent={this.state.opponent}/>
        <Message message={this.state.message} />
        <GameBoard cards={this.state.cards} handleClick={this.handleClick} />
      </div>
    );
  }
}