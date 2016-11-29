function CompletionMessage(props) {
  return (
    <div className="col-md-8 text-center">
      <h1>{props.message}</h1>
      <a className="btn btn-info btn-lg" rel="nofollow" data-method="post" href="/games">Play again?</a>
    </div>
  );
}

class CompletionBanner extends React.Component {
  render () {
    //If the player one render a winning message.
    if (this.props.game.isWinner == "winner") {
      return <CompletionMessage message={`Congrats 🏅 you beat ${this.props.game.opponentName}! 👏`}/>;
    }
    //If they lost render a losing message.
    else if (this.props.game.isWinner == "loser") {
      return <CompletionMessage message={`I'm sorry 😿, but you lost to ${this.props.game.opponentName}. 👎`}/>;
    }
    //If it's a tie render a tie message.
    else {
      return <CompletionMessage message={`Wow 🙃, you tied ${this.props.game.opponentName}! 🤘`}/>; 
    }    
  }
}

