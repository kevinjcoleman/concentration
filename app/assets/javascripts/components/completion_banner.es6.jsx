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
    if (this.props.game.isWinner == "winner") {
      return <CompletionMessage message={`Congrats 🏅 you beat ${this.props.opponent.name}! 👏`}/>;
    }
    else if (this.props.game.isWinner == "loser") {
      return <CompletionMessage message={`I'm sorry 😿, but you lost to ${this.props.opponent.name}. 👎`}/>;
    }
    else {
      return <CompletionMessage message={`Wow 🙃, you tied ${this.props.opponent.name}! 🤘`}/>; 
    }    
  }
}

