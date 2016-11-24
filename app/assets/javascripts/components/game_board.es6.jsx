class GameBoard extends React.Component {
  render() {
    var cardNodes = this.props.cards.map(function (card, index) {
      return (
        <Card card={card} 
              key={card.id}
              isTurn={this.props.isTurn} 
              onClick={() => this.props.handleClick(card)}/>
      );
    }, this);

    return (
      <div className="cards row">
        <React.addons.CSSTransitionGroup
        transitionAppear={true}
        transitionLeave={true}
        transitionEnterTimeout={3000}
        transitionLeaveTimeout={3000}
        transitionAppearTimeout={3000}
        transitionName="example">
          {cardNodes}
        </React.addons.CSSTransitionGroup>
      </div>
    );
  }
}