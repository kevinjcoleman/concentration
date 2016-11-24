function CardTile(props) {
  return (
    <div>
      <React.addons.CSSTransitionGroup
        transitionName="example"
        transitionAppear={true}
        transitionAppearTimeout={500}
        transitionEnterTimeout={500}
        transitionLeaveTimeout={500}>
        <div className={"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center "+ props.className} onClick={props.handleClick}>
          {props.unicode ? props.unicode : <img className="diamond" src={props.imageUrl}></img>}
        </div>
      </React.addons.CSSTransitionGroup>
    </div>
  );
}

class Card extends React.Component {
  render() {
    if (!this.props.isTurn && !(this.props.card.isGuessed || this.props.card.isFlipped)) {
      return (
        <CardTile className={`covered ${this.props.order % 2 ? "red-covered" : "blue-covered"}`}
                  imageUrl={this.props.card.coveredImageUrl} /> 
      );
    }
    else if (this.props.card.isGuessed) {
      pickClass = this.props.card.pickedByCurrentPlayer ? "blue" : "red"
      return (
        <CardTile unicode={this.props.card.unicode} 
                  className={"flipped " + pickClass} /> 
      );
    }
    else if (this.props.card.isFlipped) {
      return (
        <CardTile key={`$this.props.card.id-$this.props.card.name-flipped`}
                  unicode={this.props.card.unicode} 
                  className="flipped" /> 
        );
    }
    return (
      <CardTile className={`covered ${this.props.order % 2 ? "red-covered" : "blue-covered"}`}
                handleClick={this.props.onClick}
                imageUrl={this.props.card.coveredImageUrl} />  
    );
  }
}