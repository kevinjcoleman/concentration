class HeaderTitle extends React.Component {
  render () {
    return (
      <div className="col-md-8">
        <h1>Play <strong className="text-upper">Concentration</strong> against {this.props.opponent.name}.</h1>
        <h3>{this.props.game.isTurn ? "It's your turn! 😎" : "It's " + this.props.opponent.name +"'s turn. 😓"}</h3>
      </div>
    );
  }
}
